//
//  SCUser.m
//  GeoSocialApp
//
//  Created by song zicheng daily use on 2018/1/20.
//  Copyright © 2018年 Troy Song. All rights reserved.
//

#import "SCUser.h"

@implementation SCUser

- (instancetype)initWithUsername:(NSString *)username andPassword:(NSString *)password
{
    if (self = [super init]) {
        self.userName = username;
        self.password = password;
    }
    return self;
}

@end
