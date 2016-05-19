//
//  AppDelegate.h
//  BackgroundFetchByPush
//
//  Created by ap2 on 16/5/19.
//  Copyright © 2016年 ap2. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 推送的消息体
 *  {
	"aps":{
 "        content-available":1
          }
    }
 *
 *  “Silent Remote Notifications”是在 Apple 的限制下有一定的频率控制，但具体频率不详。所以并不是所有的 “Silent Remote Notifications” 都能按照预期到达客户端触发函数。
 “Background”下提供给应用的运行时间窗是有限制的，如果需要下载较大的文件请参考 Apple 的 NSURLSession 的介绍。
 “Background  Remote Notification”  的前提是要求客户端处于Background 或 Suspended 状态，如果用户通过 App Switcher 将应用从后台 Kill 掉应用将不会唤醒应用处理 background 代码。
 */


typedef void (^CompletionHandler)(UIBackgroundFetchResult);

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (copy, nonatomic) CompletionHandler completionHandler;
+(instancetype)sharedDelegate;

@end

