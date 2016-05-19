//
//  ViewController.m
//  BackgroundFetchDemo
//
//  Created by ap2 on 16/5/19.
//  Copyright © 2016年 ap2. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewContent
{
    NSString *date = [NSString stringWithFormat:@"%@", [NSDate date]];
    _label.text = date;
    _imgView.image = [UIImage imageNamed:@"0504首页.jpg"];
    
    AppDelegate *appDelegate = [AppDelegate sharedDelegate];
    if (appDelegate.completionHandler != NULL) {
        CompletionHandler handler = appDelegate.completionHandler;
        handler(UIBackgroundFetchResultNewData);
        appDelegate.completionHandler = NULL;
    }

}

@end
