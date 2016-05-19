//
//  AppDelegate.m
//  BackgroundFetchByPush
//
//  Created by ap2 on 16/5/19.
//  Copyright © 2016年 ap2. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+(instancetype)sharedDelegate
{
    return [UIApplication sharedApplication].delegate;
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound
                                                                                                                          | UIUserNotificationTypeAlert
                                                                                                                          | UIUserNotificationTypeBadge)
                                                                                                              categories:nil]];
        
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        UIRemoteNotificationType remoteType = (UIRemoteNotificationType)(UIRemoteNotificationTypeSound
                                                                         | UIRemoteNotificationTypeAlert
                                                                         | UIRemoteNotificationTypeBadge);
        
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:remoteType];
    }
    
    return YES;
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)pToken{
    NSLog(@"---Token--%@", pToken);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    NSLog(@"userInfo == %@",userInfo);
    NSString *message = [[userInfo objectForKey:@"aps"]objectForKey:@"alert"];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
    NSLog(@"Regist fail%@",error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    //静默推送，唤醒
     NSLog(@"wake");
    application.applicationIconBadgeNumber += 1;
    
    self.completionHandler = completionHandler;
    
    ViewController *naviController = (ViewController *)self.window.rootViewController;
    [naviController updateContent];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
