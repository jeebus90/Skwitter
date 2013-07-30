//
//  TableViewC1.m
//  Twitter-copy
//
//  Created by Slagkryssaren on 6/27/13.
//  Copyright (c) 2013 Slagkryssaren. All rights reserved.
//

#import "ProfileTableC.h"

@implementation ProfileTableC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	TweetViewC *tweetC = [[TweetViewC alloc] initWithNibName:@"TweetViewC" bundle:nil];
	self.tweetViewC = tweetC;
    
    //self.title = @"Profile";
	/* NSArray *array = [[NSArray alloc] initWithObjects:
     @"Chocolate rain",
     @"Team Rocket has arrived!",
     @"I'm twelve and what is this?",
     nil]; */
    
	//self.tweets = array;
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // return [self.tweets count];
    if(!self.tweets)
    {
        return 0;
    }
    else
    {
        return [self.tweets count];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.tweetSizes objectAtIndex:indexPath.row] floatValue];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"TweetCell";
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TweetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.tabBarC = (TabBarC *) self.superNavController.tabBarController;
    }
    NSDictionary *currentTweet = [self.tweets objectAtIndex:indexPath.row];
    NSArray *tweetSizes = [(TabBarC *) self.superNavController.tabBarController tweetSizes];
    
    cell.tweet = currentTweet;
    cell.text.text = currentTweet.tweetText;
    cell.height = [tweetSizes objectAtIndex:indexPath.row];
    if ([self.favourites containsObject:currentTweet]){
        cell.isFavourite = TRUE;
    }
    else {
        cell.isFavourite = FALSE;
    }
    [cell.photo setImageWithURL:currentTweet.userImage
               placeholderImage:(UIImage *)[UIImage imageNamed:@"black-background.png"]];
    [cell activate];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    self.tweetViewC.content = [self.tweets objectAtIndex:indexPath.row];
	[self.superNavController pushViewController:self.tweetViewC animated:YES];
    
}

- (void)reloadData:(NSArray *)tweets sizes:(NSArray *)tweetSizes
        favourites:(NSArray *)favourites profile:(NSDictionary *)prof;
{
    self.tweets = tweets;
    self.tweetSizes = tweetSizes;
    self.favourites = favourites;
    self.profile = prof;
    [self.tableView reloadData];
}

@end
