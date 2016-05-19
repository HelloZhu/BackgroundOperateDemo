//
//  ViewController.m
//  BackgroundFetchByPush
//
//  Created by ap2 on 16/5/19.
//  Copyright © 2016年 ap2. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

static int i = 0;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
     [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)updateContent
{
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
     //完成后需要执行CompletionHandler
    //AppDelegate *appDelegate = [AppDelegate sharedDelegate];
    //if (appDelegate.completionHandler != NULL) {
        //CompletionHandler handler = appDelegate.completionHandler;
        //handler(UIBackgroundFetchResultNewData);
        //appDelegate.completionHandler = NULL;
    //}
}

- (void)timerAction
{
    i+=1;
    NSLog(@"%d", i);
   
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    _label.text = [format stringFromDate:[NSDate date]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
