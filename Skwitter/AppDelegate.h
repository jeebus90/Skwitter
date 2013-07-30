//
//  AppDelegate.h
//  Twitter-copy
//
//  Created by Slagkryssaren on 6/26/13.
//  Copyright (c) 2013 Slagkryssaren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "TabBarC.h"

@class TabBarC;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) TabBarC *tabController;

@property (strong, nonatomic) FBSession *session;

@end
