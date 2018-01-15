//
//  SCPost.h
//  GeoSocialApp
//
//  Created by song zicheng daily use on 2018/1/14.
//  Copyright © 2018年 Troy Song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface SCPost : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) NSDate *postDate;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, copy) NSString *imageURL;

- (instancetype) initWithDictionary:(NSDictionary *)dict;

@end
