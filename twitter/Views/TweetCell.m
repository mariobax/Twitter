//
//  TweetCell.m
//  twitter
//
//  Created by mariobaxter on 7/2/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"

@implementation TweetCell

- (void)initWithTweet:(Tweet*)tweet {
    self.postLabel.text = tweet.text;
    
    NSURL *profilePictureURL = [NSURL URLWithString:tweet.user.profilePictureURLString];
    NSLog(@"%@", tweet.user.profilePictureURLString);
    [self.profilePicture setImageWithURL:profilePictureURL];
    self.userLabel.text = tweet.user.name;
    self.usernameLabel.text = [@"@" stringByAppendingString:tweet.user.screenName];
    self.dateLabel.text = tweet.createdAtString;
    self.retweetCountLabel.text = [@(tweet.retweetCount) stringValue];
    if (tweet.retweeted) {
        self.retweetButton.imageView.image = [UIImage imageNamed:@"retweet-icon-green"];
    } else {
        self.retweetButton.imageView.image = [UIImage imageNamed:@"retweet-icon"];
    }
    self.favoriteCountLabel.text = [@(tweet.favoriteCount) stringValue];
    if (tweet.favorited) {
        self.favoriteButton.imageView.image = [UIImage imageNamed:@"favor-icon-red"];
    } else {
        self.favoriteButton.imageView.image = [UIImage imageNamed:@"favor-icon"];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
