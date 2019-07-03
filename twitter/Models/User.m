//
//  User.m
//  twitter
//
//  Created by mariobaxter on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        // Initialize any other properties
        self.profilePictureURLString = dictionary[@"profile_image_url_https"];
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
    }
    return self;
}

@end
