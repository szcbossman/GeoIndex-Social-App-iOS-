//
//  SCHomeTableViewCell.h
//  GeoSocialApp
//
//  Created by song zicheng daily use on 2018/1/14.
//  Copyright © 2018年 Troy Song. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SCPost;

@interface SCHomeTableViewCell : UITableViewCell

+ (CGFloat)cellHeight;
- (void)loadCellWithPost:(SCPost *)post;

@end
