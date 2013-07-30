//
//  Container.m
//  Twitter-copy
//
//  Created by Slagkryssaren on 7/10/13.
//  Copyright (c) 2013 Slagkryssaren. All rights reserved.
//

#import "Container.h"

@interface Container ()

@end

@implementation Container

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Profile";

    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateTopView
{
    self.topC.view.frame = self.topView.bounds;
    [self.topView addSubview:self.topC.view];
}

- (void)setTopController:(ProfileTopViewC *)topC
{
    self.topC = topC;
    
    // handle view controller hierarchy
    [self addChildViewController:self.topC];
    [self.topC didMoveToParentViewController:self];
    
    if ([self isViewLoaded]) {
        [self updateTopView];
    }
}

- (void)updateBotView
{
    self.botC.view.frame = self.botView.bounds;
    [self.botView addSubview:self.botC.view];
}

- (void)setBotController:(ProfileTableC *)botC
{
    self.botC = botC;
    
    // handle view controller hierarchy
    [self addChildViewController:self.botC];
    [self.botC didMoveToParentViewController:self];
    
    if ([self isViewLoaded]) {
        [self updateBotView];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self updateTopView];
    [self updateBotView];
}

- (void)viewDidUnload
{
    [self setTopController:nil];
    [self setBotController:nil];
    [self setTopView:nil];
    [self setBotView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)reloadData:(NSArray *)tweets sizes:(NSArray *)tweetSizes
        favourites:(NSArray *)favourites profile:(NSDictionary *)prof;
{
    [self.topC reloadData:prof];
    [self.botC reloadData:tweets sizes:tweetSizes favourites:favourites profile:(NSDictionary *)prof];
    [self updateTopView];
}

@end
