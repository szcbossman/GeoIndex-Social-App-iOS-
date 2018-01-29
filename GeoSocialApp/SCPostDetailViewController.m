//
//  SCPostDetailViewController.m
//  GeoSocialApp
//
//  Created by song zicheng daily use on 2018/1/28.
//  Copyright © 2018年 Troy Song. All rights reserved.
//

#import "SCPostDetailViewController.h"
#import "SCPost.h"
#import "UIImageView+AFNetworking.h"


@interface SCPostDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UITextView *postView;
@property (strong, nonatomic) SCPost *post;


@end

@implementation SCPostDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUI];
    self.postView.text = self.post.message;
    self.usernameLabel.text = self.post.name;
    [self.postImageView setImageWithURL:[NSURL URLWithString:self.post.imageURL]];
}

- (void)setupUI
{
    self.title = NSLocalizedString(@"Detail", nil); //(Localization Optimize)
    self.postImageView.layer.masksToBounds = YES;
    self.postImageView.layer.cornerRadius = 5.0;
    
}

- (void) loadDetailViewWithPost:(SCPost *)post {
    self.post = post;
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
