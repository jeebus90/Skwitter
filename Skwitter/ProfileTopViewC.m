//
//  TopViewC.m
//  Twitter-copy
//
//  Created by Slagkryssaren on 7/10/13.
//  Copyright (c) 2013 Slagkryssaren. All rights reserved.
//

#import "ProfileTopViewC.h"

@interface ProfileTopViewC ()

@end

@implementation ProfileTopViewC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.profileName = [[UITextField alloc] init];
        self.profilePicture = [[UIImageView alloc] init];
        self.profileSet = FALSE;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadData:(NSDictionary *)profile
{
    if (!self.profileSet && profile) {
        self.profile = profile;
        self.profileName.text = [self.profile objectForKey:@"name"];
        
        [self.profilePicture setImageWithURL:
                        [NSURL URLWithString:[self.profile objectForKey:@"photo"]]
                            placeholderImage:(UIImage *)[UIImage imageNamed:@"black-background.png"]];
        
        self.profileSet = TRUE;
    }
}

@end
