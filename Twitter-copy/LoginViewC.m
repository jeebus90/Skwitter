//
//  ViewController.m
//  Twitter-copy
//
//  Created by Slagkryssaren on 6/26/13.
//  Copyright (c) 2013 Slagkryssaren. All rights reserved.
//

#import "LoginViewC.h"


@interface LoginViewC ()

@end

@implementation LoginViewC

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickedLogin:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
