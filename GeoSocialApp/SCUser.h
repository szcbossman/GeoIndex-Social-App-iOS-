//
//  SCUser.h
//  GeoSocialApp
//
//  Created by song zicheng daily use on 2018/1/20.
//  Copyright © 2018年 Troy Song. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCUser : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *token;

- (instancetype)initWithUsername:(NSString *)username andPassword:(NSString *)password;

@end
