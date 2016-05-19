//
//  ViewController.m
//  BackgroundDownloadDemo
//
//  Created by ap2 on 16/5/19.
//  Copyright © 2016年 ap2. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

static NSString *DownloadURLString = @"http://10.18.204.59:1234/download/test2.pdf";

@interface ViewController ()< NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDownloadDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic) NSURLSession *session;
@property (nonatomic) NSURLSessionDownloadTask *downloadTask;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.session = [self backgroundSession];
    self.progressView.progress = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startDownload:(UIButton *)sender {
    
    if (self.downloadTask) {
        return;
    }
    NSURL *downloadURL = [NSURL URLWithString:DownloadURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:downloadURL];
    self.downloadTask = [self.session downloadTaskWithRequest:request];
    [self.downloadTask resume];
    self.progressView.hidden = NO;
}

- (NSURLSession *)backgroundSession {
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
         NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.example.apple-samplecode.SimpleBackgroundTransfer.BackgroundSession"];
        
        session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    });
    return session;
}

#pragma mark - delegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)downloadURL {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *URLs              = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsDirectory  = [URLs objectAtIndex:0];
    NSURL *originalURL         = [[downloadTask originalRequest] URL];
    NSURL *destinationURL      = [documentsDirectory URLByAppendingPathComponent:[originalURL lastPathComponent]];
    NSError *errorCopy;
    // For the purposes of testing, remove any esisting file at the destination.
    [fileManager removeItemAtURL:destinationURL error:NULL];
    BOOL success = [fileManager copyItemAtURL:downloadURL toURL:destinationURL error:&errorCopy];
    if (success) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSData *data = [NSData dataWithContentsOfURL:destinationURL];
            [_webview loadData:data MIMEType:@"application/pdf" textEncodingName:@"UTF-8" baseURL:nil];
            
        });
    } else {
        NSLog(@"Error during the copy: %@", [errorCopy localizedDescription]);
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error == nil) {
        NSLog(@"Task: %@ completed successfully", task);
    } else {
        NSLog(@"Task: %@ completed with error: %@", task, [error localizedDescription]);
    }
    double progress = (double)task.countOfBytesReceived / (double)task.countOfBytesExpectedToReceive;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.progressView.progress = progress;
    });
    self.downloadTask = nil;
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.backgroundSessionCompletionHandler) {
        void (^completionHandler)() = appDelegate.backgroundSessionCompletionHandler;
        appDelegate.backgroundSessionCompletionHandler = nil;
        completionHandler();
    }
    NSLog(@"All tasks are finished");
}


@end
