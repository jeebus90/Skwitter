//
//  AppDelegate.m
//  Twitter-copy
//
//  Created by Slagkryssaren on 6/26/13.
//  Copyright (c) 2013 Slagkryssaren. All rights reserved.
//

#import "AppDelegate.h"
#import "NavViewC.h"
#import "MainTableC.h"
#import "ProfileTableC.h"
#import "FavouritesTableC.h"
#import "LoginViewC.h"
#import "Container.h"
#import "ProfileTopViewC.h"


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:self.session];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    self.tabController = [[TabBarC alloc] init];
    self.tabController.viewControllers = [self initializeTabBarItems];
    self.window.rootViewController = self.tabController;
    [self.tabController fetchTweets];
    
    LoginViewC *loginC = [[LoginViewC alloc] init];
    [self.window makeKeyAndVisible];
    [self.tabController presentViewController:loginC animated:NO completion:nil];
    
    return (YES);
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"Ending sequence 1");

    
    NSString *error;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"FavouriteList.plist"];
    NSLog(@"%@", plistPath);
    NSArray *favouriteIDs = [self.tabController fetchFavIDs];
    NSData *plistXML = [NSPropertyListSerialization dataFromPropertyList:favouriteIDs
                                                                  format:NSPropertyListXMLFormat_v1_0
                                                        errorDescription:&error];

    if(plistXML) {
        for (NSString *tmp in favouriteIDs){
            NSLog(@"%@", tmp);
        }
        NSLog(@"Ending sequence 2");
        BOOL didWrite = [plistXML writeToFile:plistPath options:0 error:nil];
        if(didWrite) NSLog(@"Yes!");
        else NSLog(@"No!");
    }
    else {
        NSLog(@"Error writing to plist: %@", error);
        
    }
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    
    // FBSample logic
    // We need to properly handle activation of the application with regards to SSO
    //  (e.g., returning from iOS 6.0 authorization dialog or from fast app switching).
    [FBAppCall handleDidBecomeActiveWithSession:self.session];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
    [self.session close];
}

- (NSArray *)initializeTabBarItems
{
    /* Initialize view controllers */
    
    MainTableC *table1 = [[MainTableC alloc] initWithNibName:@"MainTableC" bundle:nil];
    NavViewC *navController1 = [[[NavViewC alloc] init] initWithRootViewController:table1];
    UIImage *tabIcon1 = [UIImage imageNamed:@"twitter-bird-silhouette.jpg"];
    navController1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Tweets" image:tabIcon1 tag:0];
    
    Container *container = [[Container alloc] initWithNibName:@"Container" bundle:nil];
    ProfileTopViewC *topC = [[ProfileTopViewC alloc] initWithNibName:@"ProfileTopViewC" bundle:nil];
    ProfileTableC *botC = [[ProfileTableC alloc] initWithNibName:@"ProfileTableC" bundle:nil];
    container.topC = topC;
    container.botC = botC;
    NavViewC *navController2 = [[[NavViewC alloc] init] initWithRootViewController:container];
    botC.superNavController = navController2;
    UIImage *tabIcon2 = [UIImage imageNamed:@"twitter-bird-silhouette.jpg"];
    navController2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Profile" image:tabIcon2 tag:0];

    FavouritesTableC *table3 = [[FavouritesTableC alloc] initWithNibName:@"FavouritesTableC" bundle:nil];
    NavViewC *navController3 = [[[NavViewC alloc] init] initWithRootViewController:table3];
    UIImage *tabIcon3 = [UIImage imageNamed:@"twitter-bird-silhouette.jpg"];
    navController3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Favourites" image:tabIcon3 tag:0];
    
    NSArray *retval = [NSArray arrayWithObjects:navController1, navController2, navController3, nil];

    
    return (retval);
}

@end
