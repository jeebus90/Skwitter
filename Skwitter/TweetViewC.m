//
//  TweetView.m
//  Twitter-copy
//
//  Created by Slagkryssaren on 6/27/13.
//  Copyright (c) 2013 Slagkryssaren. All rights reserved.
//

#import "TweetViewC.h"
#define MAINLABEL_TAG 1
#define SECONDLABEL_TAG 2
#define PHOTO_TAG 3

@implementation TweetViewC
- (void)viewDiLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self initiateTweet];
    
}

- (void)setMapPosition
{
    NSString *latitude = self.content.latitude;
    NSString *longitude = self.content.longitude;
    if(![[NSNull null] isEqual:(latitude)] && ![[NSNull null] isEqual:longitude]){
        CLLocationCoordinate2D annotationCoord;
        annotationCoord.latitude = [latitude doubleValue];
        annotationCoord.longitude = [longitude doubleValue];
        
        MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
        annotationPoint.coordinate = annotationCoord;
        [self.map addAnnotation:annotationPoint];
        
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance (
                                        annotationCoord, 1000, 1000);
        [self.map setRegion:region animated:NO];
    }
}

- (void)initiateTweet
{
    self.title = self.content.tweetText;
    [self.image setImageWithURL:self.content.userImage
               placeholderImage:(UIImage *)[UIImage imageNamed:@"black-background.png"]];
    self.userName.text = self.content.userName;
    self.tweetText.text = self.content.tweetText;
    [self setMapPosition];

}

@end
