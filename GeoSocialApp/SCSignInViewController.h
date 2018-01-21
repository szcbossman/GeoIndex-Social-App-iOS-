//
//  SCSignInViewController.h
//  GeoSocialApp
//
//  Created by song zicheng daily use on 2018/1/20.
//  Copyright © 2018年 Troy Song. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCSignInViewControllerDelegate <NSObject>

- (void)loginSuccess;

@end

@interface SCSignInViewController : UIViewController

@property (nonatomic, weak) id<SCSignInViewControllerDelegate> delegate;

@end
