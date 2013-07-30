//
//  TopViewC.h
//  Twitter-copy
//
//  Created by Slagkryssaren on 7/10/13.
//  Copyright (c) 2013 Slagkryssaren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"

@interface ProfileTopViewC : UIViewController

@property (nonatomic) NSDictionary *profile;
@property (strong, nonatomic) IBOutlet UITextField *profileName;
@property (strong, nonatomic) IBOutlet UIImageView *profilePicture;
@property (nonatomic) BOOL profileSet;

- (void)reloadData:(NSDictionary *)prof;
@end
