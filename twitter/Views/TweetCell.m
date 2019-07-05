//
//  TweetCell.m
//  twitter
//
//  Created by mariobaxter on 7/2/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@implementation TweetCell

- (void)initWithTweet:(Tweet*)tweet {
    
    // Store constraints
//    self.retweetImageConstraints = self.retweetedImage.constraints;
//    self.retweetLabelConstraints = self.retweetedMessageLabel.constraints;
    
    self.tweet = tweet;
    
    self.postLabel.text = self.tweet.text;
    
    NSURL *profilePictureURL = [NSURL URLWithString:self.tweet.user.profilePictureURLString];
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
        // Call the API Manager to POST the update to Twitter
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error) {
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else {
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    } else {
        [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
        self.tweet.favoriteCount -= 1;
        // Call the API Manager to POST the update to Twitter
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error) {
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else {
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.tweet.favorited = !self.tweet.favorited;
}

- (IBAction)didRetweet:(id)sender {
    if (!self.tweet.retweeted) {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
        self.tweet.retweetCount += 1;
        // Call the API Manager to POST the update to Twitter
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error) {
                NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else {
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];
    } else {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
        self.tweet.retweetCount -= 1;
        // Call the API Manager to POST the update to Twitter
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error) {
                NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else {
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.tweet.retweeted = !self.tweet.retweeted;
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
