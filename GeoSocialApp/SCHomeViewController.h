//
//  SCHomeViewController.h
//  GeoSocialApp
//
//  Created by song zicheng daily use on 2018/1/14.
//  Copyright © 2018年 Troy Song. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SCPost;

@interface SCHomeViewController : UIViewController

- (void)loadResultPageWithPosts:(NSArray <SCPost *>*)posts;

@end
