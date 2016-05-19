//
//  AppDelegate.h
//  BackgroundFetchDemo
//
//  Created by ap2 on 16/5/19.
//  Copyright © 2016年 ap2. All rights reserved.
//

/**
 *  1、选中target-》capablities > Background modes 勾选Background fetch
 *
 *  2、实现
 *  - (void)application:(UIApplication *)application performFetchWithCompletionHandler:(CompletionHandler)completionHandler
 *  3、在performFetchWithCompletionHandler方法中调用更新方法
 *  
 *  调试：xcode ->Debug-> simuraltor Background fetch
 * 注意：Background fetch是由系统去调用performFetchWithCompletionHandler，但并不会像定时器一样定期执行，只会在某个时段调用一下，时长30S
 */


#import <UIKit/UIKit.h>

typedef void (^CompletionHandler)(UIBackgroundFetchResult);

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (copy, nonatomic) CompletionHandler completionHandler;
+(instancetype)sharedDelegate;
@end

