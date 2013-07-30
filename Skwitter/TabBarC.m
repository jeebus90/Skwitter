//
//  TabBarC.m
//  Twitter-copy
//
//  Created by Slagkryssaren on 7/11/13.
//  Copyright (c) 2013 Slagkryssaren. All rights reserved.
//

#import "TabBarC.h"

@interface TabBarC ()

@end

@implementation TabBarC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.favourites = [[NSMutableArray alloc] init];
        self.client = [[AFHTTPClient alloc] initWithBaseURL:
                       [NSURL URLWithString:@"http://skwitter.herokuapp.com/api/"]];
        [self.client registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self.client setDefaultHeader: @"Accept" value:@"application/json"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view

   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)login
{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *fbKey = appDelegate.session.accessTokenData.accessToken;
    NSString *urlExtensionPart1 = @"auth/login?fb_access_token=";
    NSString *urlExtensionPart2 = @"&client_token=";
    NSString *SKapi = @"OfnPezCJkMdylfOn89vXKmgdwbrTaeR1LBEfCuxii7I";
    
    NSString *urlExtension = [NSString stringWithFormat:@"%@%@%@%@",
                              urlExtensionPart1,fbKey,urlExtensionPart2,SKapi];
    [self.client postPath:urlExtension
               parameters:nil
     
                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                      NSDictionary *user = responseObject;
                      NSDictionary *tmpD = [user objectForKey:@"api_key"];
                      NSString *api_key = [tmpD objectForKey:@"token"];
                      [self authorizationCall:[NSString stringWithFormat:@"%@&%@",SKapi, api_key]
                          performWhenFinished:^{
                              [self updateProfileView];
                          }];
                  }
     
                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Logging In"                                                              message:[NSString stringWithFormat:@"%@",error]                                                             delegate:nil                                                    cancelButtonTitle:@"OK" otherButtonTitles:nil];
                      [av show];
                      
                  }
     ];
}

- (void)authorizationCall:(NSString *)token performWhenFinished:(dispatch_block_t)block
{
    [self.client setAuthorizationHeaderWithToken:token];
    dispatch_async(dispatch_get_main_queue(), block);
}

- (void)updateProfileView
{
    [self.client getPath:@"users/me"
               parameters:NULL
                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                      self.profile = responseObject;
                      [self updateAllSubviews];
                  }
                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Fetching Profile"                                                              message:[NSString stringWithFormat:@"%@",error]                                                             delegate:nil                                                    cancelButtonTitle:@"OK" otherButtonTitles:nil];
                      [av show];

                  }
     ];
}

- (void)fetchTweets
{
    [self.client getPath:@"tweets"
            parameters:NULL
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                self.tweets = responseObject;
                self.tweetSizes = [self getTweetSizes];
                [self updateAllSubviews];
                [self fetchFavourites];
            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Tweets"                                                          message:[NSString stringWithFormat:@"%@",error]                                                            delegate:nil                                                   cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [av show];
                
            }
     ];
}

- (void)updateAllSubviews
{
    [self.viewControllers[0] reloadData:self.tweets
                                  sizes:self.tweetSizes
                             favourites:self.favourites
                                profile:self.profile];
    [self.viewControllers[1] reloadData:self.tweets
                                  sizes:self.tweetSizes
                             favourites:self.favourites
                                profile:self.profile];
    [self.viewControllers[2] reloadData:self.tweets
                                  sizes:[self getFavTweetSizes]
                             favourites:self.favourites
                                profile:self.profile];
}


- (NSArray *)getTweetSizes
{
    NSNumber *num;
    NSMutableArray *tweetSizes = [[NSMutableArray alloc] init];
    UITextView *tmp = [[UITextView alloc] init];
    tmp.font = [UIFont systemFontOfSize:11];
    CGRect standardFrame = CGRectMake(0.0, 0.0, 220.0, CGFLOAT_MAX);
    for (NSDictionary *tweet in self.tweets) {
        tmp.text = tweet.tweetText;
        tmp.frame = standardFrame;
        [tmp sizeToFit];   // Shrinks the height to fit all the text
        
        if (tmp.frame.size.height > 45.0){
            num = [[NSNumber alloc] initWithFloat:tmp.frame.size.height];
            
        }
        else {
            num = [[NSNumber alloc]initWithFloat:45.0];
        }
        [tweetSizes addObject:num];
    }
    return tweetSizes;
}

- (void)postTweet:(NSString *)text
{
    [self postTweet:text latitude:[NSNull null] longitude:[NSNull null]];
}

- (void)postTweet:(NSString *)text latitude:(id)lat longitude:(id)lon
{
    NSDictionary *tweet = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObjects:
                           [[NSArray alloc] initWithObjects:
                            text,
                            lat,
                            lon,
                            nil]
                           forKeys:
                           [[NSArray alloc] initWithObjects:
                            @"text",
                            @"latitude",
                            @"longitude",
                            nil]
                           ]
                           forKey:@"tweet"
                           ];
                           
    [self.client postPath:@"tweets"
          parameters:tweet
                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                      [self fetchTweets];
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Posting Tweet"                                                              message:[NSString stringWithFormat:@"%@",error]                                                             delegate:nil                                                    cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [av show];
                 
             }
     ];
}

- (void)fetchFavourites
{
    
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *plistPath;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:@"FavouriteList.plist"];
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSArray *temp = (NSArray *)[NSPropertyListSerialization
                                          propertyListFromData:plistXML
                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                          format:&format
                                          errorDescription:&errorDesc];
    if (!temp) {
        NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    }
    else {
        for (NSString *favTweetID in temp) {
            NSNumber *IDasNumber = [NSNumber numberWithInt:[favTweetID integerValue]];
            for (NSDictionary * tweet in self.tweets) {
                if ([tweet.tweetID isEqual:IDasNumber]) {
                    [self.favourites addObject:tweet];
                }
            }
        }
    }
}

- (NSArray *)getFavTweetSizes
{
    int i;
    int tmp1 = [self.favourites count];
    NSMutableArray *favTweetSizes = [[NSMutableArray alloc] initWithCapacity:tmp1];
    for(i = 0; i<tmp1; i++) {
        [favTweetSizes addObject:[NSNull null]];
    }
    NSNumber *size;
    int j, tmp2;
    for (j = 0; j<[self.tweets count]; j++) {
        if ([self.favourites containsObject:self.tweets[j]]) {
            size = self.tweetSizes[j];
            tmp2 = [self.favourites indexOfObject:self.tweets[j]];
            //            NSLog(@"%d", tmp2);
            favTweetSizes[tmp2] = size;
        }
    }
    return favTweetSizes;
}

- (void)addFavourite:(NSDictionary *)tweet
{
    [self.favourites addObject:tweet];
    //[self.favouriteDictionary setObject:@"lol" forKey:tweetID];
    [self updateAllSubviews];
}

- (void)removeFavourite:(NSDictionary *)tweet
{
    [self.favourites removeObject:tweet];
    //[self.favouriteDictionary removeObjectForKey:tweetID];
    [self updateAllSubviews];
}

- (NSArray *)fetchFavIDs
{
    NSMutableArray *favTweetIDs = [[NSMutableArray alloc] init];
    for (NSDictionary *favTweet in self.favourites) {
        [favTweetIDs addObject:[favTweet.tweetID stringValue]];
    }
    return favTweetIDs;
    
}

@end