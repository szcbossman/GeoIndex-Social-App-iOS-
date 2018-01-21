//
//  SCPostManager.m
//  GeoSocialApp
//
//  Created by song zicheng daily use on 2018/1/21.
//  Copyright © 2018年 Troy Song. All rights reserved.
//

#import "SCPostManager.h"
#import "SCPost.h"
#import "AFNetworking.h"
#import "SCUserManager.h"
#import "SCUser.h"
#import <CoreLocation/CoreLocation.h>

static NSString * const SCBaseURLString = @"https://around-75015.appspot.com";

@implementation SCPostManager

+ (void)createPostWithMessage:(NSString *)message imageFile:(UIImage *)image andCompletion:(void(^)(NSError *error))completionBlock
{
    // POST url
    NSString *urlString = [SCBaseURLString stringByAppendingString:@"/post"];
    
    NSString *userName = [SCUserManager sharedUserManager].currentUser.userName;
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:37.441883 longitude:-122.143019];
    NSMutableDictionary *body = [@{@"user" : userName,
                                   @"message" : message,
                                   @"lat" : @(currentLocation.coordinate.latitude),
                                   @"lon" : @(currentLocation.coordinate.longitude)
                                   } mutableCopy];
    
    NSData *fileData = image?UIImageJPEGRepresentation(image, 0.5):nil;
    
    NSError *error;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:body constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        if(fileData){
            [formData appendPartWithFileData:fileData
                                        name:@"image"
                                    fileName:@"img.jpeg"
                                    mimeType:@"multipart/form-data"];
        }
    } error:&error];
    [request setValue:[SCUserManager sharedUserManager].currentUser.token forHTTPHeaderField:@"Authorization"];
    //    [request setValue:@"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1MDk5NDY0NzMsInVzZXJuYW1lIjoiamFjazExIn0.HXzJLfSTYPcXLWsOhXstI-acFHggQgddYKInHdobLvo" forHTTPHeaderField:@"Authorization"];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"Wrote %f", uploadProgress.fractionCompleted);
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"create post fail: %@", error);
        }
        else {
            NSLog(@"success fully created post");
        }
        if (completionBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(error);
            });
        }
    }] resume];
    
}

+ (void)getPostsWithLocation:(CLLocation *)location range:(NSInteger)range andCompletion:(void(^)(NSArray <SCPost *>* posts, NSError *error))completionBlock
{
    // ignore edge case
    if (!location) {
        return;
    }
    
    // construct url
    NSString *locationString = [NSString stringWithFormat:@"/search?lat=%@&lon=%@", @(location.coordinate.latitude), @(location.coordinate.longitude)];
    if (range != 0) {
        locationString = [locationString stringByAppendingString:[NSString stringWithFormat:@"&range=%@", @(fabs(range/1000.0))]];
    }
    NSString *urlString = [SCBaseURLString stringByAppendingString:locationString];
    NSLog(@"load posts with url: %@", urlString);
    
    // API call with completion success and failure block
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:[SCUserManager sharedUserManager].currentUser.token forHTTPHeaderField:@"Authorization"];
    //    [manager.requestSerializer setValue:@"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1MDk5NDY0NzMsInVzZXJuYW1lIjoiamFjazExIn0.HXzJLfSTYPcXLWsOhXstI-acFHggQgddYKInHdobLvo" forHTTPHeaderField:@"Authorization"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *result = [NSMutableArray new];
        NSError *error;
        id data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        if ([data isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dict in data) {
                SCPost *post = [[SCPost alloc] initWithDictionary:dict];
                if (post.message) {
                    [result addObject:post];
                }
            }
        }
        NSLog(@"posts: %@", result);
        if (completionBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(result.copy, nil);
            });
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completionBlock) {
            completionBlock(nil, error);
        }
    }];
}


@end
