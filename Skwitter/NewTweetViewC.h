//
//  NewTweetViewC.h
//  Twitter-copy
//
//  Created by Slagkryssaren on 7/8/13.
//  Copyright (c) 2013 Slagkryssaren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarC.h"

@interface NewTweetViewC : UIViewController

@property (strong, nonatomic) IBOutlet UITextView *tweetText;

- (void)closeWindow;
- (IBAction)clickedSave:(id)sender;

@end
