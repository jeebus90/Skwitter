//
//  NSDictionary+Tweet.h
//  Twitter-copy
//
//  Created by Slagkryssaren on 7/11/13.
//  Copyright (c) 2013 Slagkryssaren. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSDictionary (tweet)

-(NSNumber *)tweetID;
-(NSString *)tweetText;
-(NSString *)latitude;
-(NSString *)longitude;
-(NSNumber *)userID;
-(NSString *)userName;
-(NSString *)userEmail;
-(NSURL *)userImage;


@end
