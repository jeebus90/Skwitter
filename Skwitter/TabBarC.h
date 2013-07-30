//
//  TabBarC.h
//  Twitter-copy
//
//  Created by Slagkryssaren on 7/11/13.
//  Copyright (c) 2013 Slagkryssaren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "NSDictionary+Tweet.h"
#import "NavViewC.h"

@interface TabBarC : UITabBarController

@property NSString *sessionKey;
@property NSArray *tweets;
@property NSArray *tweetSizes;
@property NSMutableArray *favourites;
@property AFHTTPClient *client;
@property NSDictionary *profile;

- (void)login;
- (void)fetchTweets;
- (void)fetchFavourites;
- (NSArray *)fetchFavIDs;
- (void)updateProfileView;
- (void)postTweet:(NSString *)text;
- (void)postTweet:(NSString *)text latitude:(id)lat longitude:(id)lon;
- (void)addFavourite:(NSDictionary *)tweet;
- (void)removeFavourite:(NSDictionary *)tweet;

@end
