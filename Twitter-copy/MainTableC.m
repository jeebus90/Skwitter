//
//  TableViewC1.m
//  Twitter-copy
//
//  Created by Slagkryssaren on 6/27/13.
//  Copyright (c) 2013 Slagkryssaren. All rights reserved.
//

#import "MainTableC.h"

@implementation MainTableC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	TweetViewC *tweetC = [[TweetViewC alloc] initWithNibName:@"TweetViewC" bundle:nil];
	self.tweetViewC = tweetC;
    
    NewTweetViewC *nTweetC = [[NewTweetViewC alloc] initWithNibName:@"NewTweetViewC" bundle:nil];
    self.nTweetC = nTweetC;
    
    UINavigationController *nTweetNav = [[UINavigationController alloc]
                                         initWithRootViewController:self.nTweetC];
    
    self.nTweetNav = nTweetNav;
    
    self.title = @"Tweets";
	/* NSArray *array = [[NSArray alloc] initWithObjects:
                      @"Chocolate rain",
                      @"Team Rocket has arrived!",
                      @"I'm twelve and what is this?",
                      nil]; */
    
	//self.tweets = array;
    UIBarButtonItem *newTweetButton = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem: UIBarButtonSystemItemAdd
                                       target:self
                                       action:@selector(clickedPlus)];
    self.navigationItem.rightBarButtonItem = newTweetButton;
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
        cell.tabBarC = (TabBarC *) self.tabBarController;
    }
    
    NSDictionary *currentTweet = [self.tweets objectAtIndex:indexPath.row];
    NSArray *tweetSizes = [(TabBarC *) self.tabBarController tweetSizes];
    
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
    self.tweetViewC.content = [self.tweets objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:self.tweetViewC animated:YES];
    
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

- (void)clickedPlus
{
    [self.tabBarController presentViewController:self.nTweetNav animated:YES completion:nil];
}

@end
