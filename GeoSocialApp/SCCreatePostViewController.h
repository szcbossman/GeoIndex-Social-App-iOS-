//
//  SCCreatePostViewController.h
//  GeoSocialApp
//
//  Created by song zicheng daily use on 2018/1/21.
//  Copyright © 2018年 Troy Song. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCCreatePostViewControllerDelegate <NSObject>

- (void)didCreatePost;

@end

@interface SCCreatePostViewController : UIViewController

@property (nonatomic, weak) id<SCCreatePostViewControllerDelegate> delegate;

@end
