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
    
    self.tweet = tweet;
    
    self.postLabel.text = self.tweet.text;
    
    NSURL *profilePictureURL = [NSURL URLWithString:self.tweet.user.profilePictureURLString];
    NSLog(@"%@", self.tweet.user.profilePictureURLString);
    [self.profilePicture setImageWithURL:profilePictureURL];
    self.userLabel.text = self.tweet.user.name;
    self.usernameLabel.text = [@"@" stringByAppendingString:self.tweet.user.screenName];
    self.dateLabel.text = self.tweet.createdAtString;
    self.retweetCountLabel.text = [@(self.tweet.retweetCount) stringValue];
    if (self.tweet.retweeted) {
        self.retweetButton.imageView.image = [UIImage imageNamed:@"retweet-icon-green"];
    } else {
        self.retweetButton.imageView.image = [UIImage imageNamed:@"retweet-icon"];
    }
    self.favoriteCountLabel.text = [@(self.tweet.favoriteCount) stringValue];
    if (self.tweet.favorited) {
        self.favoriteButton.imageView.image = [UIImage imageNamed:@"favor-icon-red"];
    } else {
        self.favoriteButton.imageView.image = [UIImage imageNamed:@"favor-icon"];
    }
    NSLog(@"%d", self.tweet.retweeted);
    
    // Check if tweet is a retweet
    if (self.tweet.isRetweet) {
        self.retweetedMessageLabel.text = [self.tweet.retweetedByUser.name stringByAppendingString:@" Retweeted"];
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
- (IBAction)didFavorite:(id)sender {
    if (!self.tweet.favorited) {
        [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
        self.tweet.favoriteCount += 1;
    } else {
        [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
        self.tweet.favoriteCount -= 1;
    }
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.tweet.favorited = !self.tweet.favorited;
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
