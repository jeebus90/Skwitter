//
//  NavView2.h
//  Twitter-copy
//
//  Created by Slagkryssaren on 6/26/13.
//  Copyright (c) 2013 Slagkryssaren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavViewC : UINavigationController

- (void)reloadData:(NSArray *)tweets sizes:(NSArray *)tweetSizes
        favourites:(NSArray *)favList profile:(NSDictionary *)prof;

@end
