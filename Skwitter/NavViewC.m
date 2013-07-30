//
//  NavView2.m
//  Twitter-copy
//
//  Created by Slagkryssaren on 6/26/13.
//  Copyright (c) 2013 Slagkryssaren. All rights reserved.
//

#import "NavViewC.h"
#import "MainTableC.h"
#import "Container.h"
#import "FavouritesTableC.h"
#import "UIImageView+AFNetworking.h"

@interface NavViewC ()

@end

@implementation NavViewC

-(void)reloadData:(NSArray *) tweets sizes:(NSArray *)tweetSizes
       favourites:(NSArray *)favList profile:(NSDictionary *)prof
{
    [self.viewControllers[0] reloadData:tweets sizes:tweetSizes favourites:favList profile:prof];
}

@end
