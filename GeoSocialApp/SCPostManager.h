//
//  SCPostManager.h
//  GeoSocialApp
//
//  Created by song zicheng daily use on 2018/1/21.
//  Copyright © 2018年 Troy Song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class SCPost;
@class CLLocation;

@interface SCPostManager : NSObject

/*
 * Create posts with message and image
 */
+ (void)createPostWithMessage:(NSString *)message imageFile:(UIImage *)image andCompletion:(void(^)(NSError *error))completionBlock;

/*
 * load all posts within a givin location and range
 */
+ (void)getPostsWithLocation:(CLLocation *)location range:(NSInteger)range andCompletion:(void(^)(NSArray <SCPost *>* posts, NSError *error))completionBlock;

@end
