//
//  AppDelegate.h
//  BackgroundDownloadDemo
//
//  Created by ap2 on 16/5/19.
//  Copyright © 2016年 ap2. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompletionHandler)();
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (copy, nonatomic) CompletionHandler backgroundSessionCompletionHandler;

@end

