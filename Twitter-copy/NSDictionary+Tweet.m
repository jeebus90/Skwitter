//
//  NSDictionary+Tweet.m
//  Twitter-copy
//
//  Created by Slagkryssaren on 7/11/13.
//  Copyright (c) 2013 Slagkryssaren. All rights reserved.
//

#import "NSDictionary+Tweet.h"

@implementation NSDictionary (tweet)

-(NSNumber *)tweetID
{
    NSString *tmpS = [self objectForKey:@"id"];
    return [NSNumber numberWithInt:[tmpS intValue]];
}
-(NSString *)tweetText
{
    return [self objectForKey:@"text"];
}
-(NSString *)latitude
{
    return [self objectForKey:@"latitude"];
}
-(NSString *)longitude
{
    return [self objectForKey:@"longitude"];
}
-(NSNumber *)userID
{
    NSDictionary *tmpD = [self objectForKey:@"user"];
    NSString *tmpS = [tmpD objectForKey:@"id"];
    return [NSNumber numberWithInt:[tmpS intValue]];
}
-(NSString *)userName
{
    NSDictionary *tmpD = [self objectForKey:@"user"];
    return [tmpD objectForKey:@"name"];
}
-(NSString *)userEmail
{
    NSDictionary *tmpD = [self objectForKey:@"user"];
    return [tmpD objectForKey:@"email"];
}
-(NSURL *)userImage
{
    NSDictionary *tmpD = [self objectForKey:@"user"];
    return [NSURL URLWithString:[tmpD objectForKey:@"photo"]];
}

@end
