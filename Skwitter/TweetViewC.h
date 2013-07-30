//
//  TweetView.h
//  Twitter-copy
//
//  Created by Slagkryssaren on 6/27/13.
//  Copyright (c) 2013 Slagkryssaren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "NSDictionary+Tweet.h"
#import "UIImageView+AFNetworking.h"

@interface TweetViewC : UIViewController

@property (strong, nonatomic) NSDictionary *content;
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextView *tweetText;
@property (strong, nonatomic) IBOutlet MKMapView *map;

- (void)initiateTweet;

@end
