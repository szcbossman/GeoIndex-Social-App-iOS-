//
//  SCPostDetailViewController.h
//  GeoSocialApp
//
//  Created by song zicheng daily use on 2018/1/28.
//  Copyright © 2018年 Troy Song. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCPost;

@interface SCPostDetailViewController : UIViewController

- (void)loadDetailViewWithPost:(SCPost *)post;

@end
