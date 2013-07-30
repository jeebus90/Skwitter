//
//  ViewController.m
//  Twitter-copy
//
//  Created by Slagkryssaren on 6/26/13.
//  Copyright (c) 2013 Slagkryssaren. All rights reserved.
//

#import "NewTweetViewC.h"


@interface NewTweetViewC ()

@end

@implementation NewTweetViewC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Add Tweet";
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                      target:self
                                      action:@selector(closeWindow)];
    
    self.navigationItem.leftBarButtonItem = cancelButton;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)closeWindow
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickedSave:(id)sender
{
    NSString *tweetText = self.tweetText.text;
    [((TabBarC *)self.presentingViewController) postTweet:tweetText
                                                 latitude:[[NSNumber alloc] initWithDouble:40.748342]
                                                 longitude:[[NSNumber alloc] initWithDouble:73.984606]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
