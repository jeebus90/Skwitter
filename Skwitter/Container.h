//
//  Container.h
//  Twitter-copy
//
//  Created by Slagkryssaren on 7/10/13.
//  Copyright (c) 2013 Slagkryssaren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileTableC.h"
#import "ProfileTopViewC.h"

@interface Container : UIViewController

@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *botView;

@property (strong, nonatomic) ProfileTopViewC *topC;
@property (strong, nonatomic) ProfileTableC *botC;

- (void)reloadData:(NSArray *)tweets sizes:(NSArray *)tweetSizes
    favourites:(NSArray *)favourites profile:(NSDictionary *)prof;

@end
