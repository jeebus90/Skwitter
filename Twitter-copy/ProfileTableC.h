//
//  TableViewC1.h
//  Twitter-copy
//
//  Created by Slagkryssaren on 6/27/13.
//  Copyright (c) 2013 Slagkryssaren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TweetViewC.h"
#import "NewTweetViewC.h"
#import "TweetCell.h"
#import "TabBarC.h"
#import "NSDictionary+Tweet.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileTableC : UITableViewController

@property (nonatomic, retain) NSArray *tweets;
@property (nonatomic, retain) NSArray *tweetSizes;
@property (nonatomic, retain) NSArray *favourites;
@property (nonatomic, retain) NSDictionary *profile;
@property (nonatomic, retain) TweetViewC *tweetViewC;
@property (nonatomic, retain) NavViewC *superNavController;

- (void)reloadData:(NSArray *)tweets sizes:(NSArray *)tweetSizes
        favourites:(NSArray *)favourites profile:(NSDictionary *)prof;
@end
