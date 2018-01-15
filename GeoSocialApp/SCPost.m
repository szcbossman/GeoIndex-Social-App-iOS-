//
//  SCPost.m
//  GeoSocialApp
//
//  Created by song zicheng daily use on 2018/1/14.
//  Copyright © 2018年 Troy Song. All rights reserved.
//

#import "SCPost.h"

@implementation SCPost

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        self.name = dict[@"user"];
        self.message = dict[@"message"];
        CLLocationDegrees latitude = [dict[@"location"][@"lat"] doubleValue];
        CLLocationDegrees longtitude = [dict[@"location"][@"lon"] doubleValue];
        self.location = [[CLLocation alloc] initWithLatitude:latitude longitude:longtitude];
        self.imageURL = dict[@"url"];
    }
    return self;
}

@end
