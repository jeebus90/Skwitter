//
//  TweetCell.h
//  Twitter-copy
//
//  Created by Slagkryssaren on 7/10/13.
//  Copyright (c) 2013 Slagkryssaren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
#import "TabBarC.h"

@interface TweetCell : UITableViewCell

@property (nonatomic) BOOL isFavourite;
@property (nonatomic) UIImageView *photo;
@property (nonatomic) UILabel *text;
@property (nonatomic) UIButton *accessory;
@property (nonatomic) NSNumber *height;
@property (nonatomic) NSDictionary *tweet;
@property (weak, nonatomic) TabBarC *tabBarC;

- (void) activate;

@end
