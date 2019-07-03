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
    
    // Store constraints
//    self.retweetImageConstraints = self.retweetedImage.constraints;
//    self.retweetLabelConstraints = self.retweetedMessageLabel.constraints;
    
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
    NSLog(@"%d", tweet.retweeted);
    
    // Check if tweet is a retweet
    if (tweet.isRetweet) {
        self.retweetedMessageLabel.text = [tweet.retweetedByUser.name stringByAppendingString:@" Retweeted"];
//        [self.retweetedImage addConstraints:self.retweetImageConstraints];
//        [self.retweetedMessageLabel addConstraints:self.retweetLabelConstraints];
        self.retweetedImage.hidden = NO;
        self.retweetedMessageLabel.hidden = NO;
    } else {
//        [self.retweetedImage removeConstraints:[self.retweetedImage constraints]];
//        [self.retweetedMessageLabel removeConstraints:[self.retweetedMessageLabel constraints]];
        self.retweetedImage.hidden = YES;
        self.retweetedMessageLabel.hidden = YES;
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
