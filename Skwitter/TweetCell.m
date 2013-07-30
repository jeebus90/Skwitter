//
//  TweetCell.m
//  Twitter-copy
//
//  Created by Slagkryssaren on 7/10/13.
//  Copyright (c) 2013 Slagkryssaren. All rights reserved.
//

#import "TweetCell.h"
#define PHOTO_TAG 1
#define TEXT_TAG 2
#define ACCESSORY_TAG 3

@implementation TweetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.isFavourite = FALSE;
        
        self.photo = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 45.0, 45.0)];
        self.photo.tag = PHOTO_TAG;
        
        self.text = [[UILabel alloc] init];
        self.text.tag = TEXT_TAG;
        self.text.font = [UIFont systemFontOfSize:11.0];
        self.text.textColor = [UIColor blackColor];
        self.text.numberOfLines = 0;
        //self.text.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        
        self.accessory = [UIButton buttonWithType:UIButtonTypeCustom];
        self.accessory.tag = ACCESSORY_TAG;
        self.accessory.frame = CGRectMake(275.0, 5.0, 35.0, 35.0);
        self.accessory.adjustsImageWhenHighlighted = NO;
        self.accessory.userInteractionEnabled = YES;
        [self.accessory addTarget:self action:@selector(didTapStar)
                 forControlEvents:UIControlEventTouchUpInside];
    } else {
        self.photo = (UIImageView *)[self.contentView viewWithTag:PHOTO_TAG];
        self.text = (UILabel *)[self.contentView viewWithTag:TEXT_TAG];
        self.accessory = (UIButton *)[self.contentView viewWithTag:ACCESSORY_TAG];
    }
    
    return self;
}

- (void)activate
{
    /*
    UITextView *tmp = [[UITextView alloc] init];
    tmp.text = self.text.text;
    tmp.font = [UIFont systemFontOfSize:11];
    tmp.frame = CGRectMake(0.0, 0.0, 220.0, CGFLOAT_MAX);
    [tmp sizeToFit];   // Shrinks the height to fit all the text
    
    if (tmp.frame.size.height > 45.0){
        self.text.frame = CGRectMake(50.0, 0.0, 220.0, tmp.frame.size.height);
    }
     */
    if (!self.isFavourite) {
        [self.accessory setImage:[UIImage imageNamed:@"nstar.png"] forState:UIControlStateNormal];
    }
    else {
        [self.accessory setImage:[UIImage imageNamed:@"ystar.png"] forState:UIControlStateNormal];
    }
    self.text.frame = CGRectMake(50.0, 0.0, 220.0, [self.height floatValue]);
    [self.contentView addSubview:self.photo];
    [self.contentView addSubview:self.text];
    [self.contentView addSubview:self.accessory];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) didTapStar
{
    if (!self.isFavourite) {
        [self.accessory setImage:[UIImage imageNamed:@"ystar.png"] forState:UIControlStateNormal];
        [self.contentView.subviews[2] removeFromSuperview];
        [self.contentView addSubview:self.accessory];
        self.isFavourite = TRUE;
        [self.tabBarC addFavourite:self.tweet];
    }
    else {
        [self.accessory setImage:[UIImage imageNamed:@"nstar.png"] forState:UIControlStateNormal];
        [self.contentView.subviews[2] removeFromSuperview];
        [self.contentView addSubview:self.accessory];
        self.isFavourite = FALSE;
        [self.tabBarC removeFavourite:self.tweet];
    }
}
@end
