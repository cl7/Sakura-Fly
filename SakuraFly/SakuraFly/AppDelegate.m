//
//  AppDelegate.m
//  SakuraFly
//
//  Created by Chenglin on 15-10-1.
//  Copyright (c) 2015年 Chenglin. All rights reserved.
//

#import "AppDelegate.h"
#import "InitialViewController.h"
#import <AVFoundation/AVFoundation.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    InitialViewController *mainViewCon = [[InitialViewController alloc] init];
    self.window.rootViewController = mainViewCon;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
