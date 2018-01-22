//
//  SCHomeViewController.m
//  GeoSocialApp
//
//  Created by song zicheng daily use on 2018/1/14.
//  Copyright © 2018年 Troy Song. All rights reserved.
//

#import "SCHomeViewController.h"
#import "SCPost.h"
#import "SCHomeTableViewCell.h"
#import "SCUserManager.h"
#import "SCSignInViewController.h"
#import "SCCreatePostViewController.h"
#import "SCPostManager.h"

static NSString * const SCHomeCellIdentifier = @"homeCellIdentifier";

@interface SCHomeViewController () <UITableViewDataSource, UITableViewDelegate, SCSignInViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray<SCPost *> *posts;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end


@implementation SCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // check user login or not
    [self userLoginIfRequire];
}


- (void)setupTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SCHomeTableViewCell class]) bundle:nil] forCellReuseIdentifier:SCHomeCellIdentifier];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SCHomeTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:SCHomeCellIdentifier forIndexPath:indexPath];
    //customize cell
    [cell loadCellWithPost:self.posts[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [SCHomeTableViewCell cellHeight];
}


#pragma mark - SCSignInViewControllerDelegate
- (void)loginSuccess {
    [self loadPosts];
}


#pragma mark - API
- (void)loadPosts
{
    __weak typeof(self) weakSelf = self;
    CLLocation *location = [[CLLocation alloc] initWithLatitude:37.441883 longitude:-122.143019];
    NSInteger range = 300000;
    [SCPostManager getPostsWithLocation:location range:range andCompletion:^(NSArray<SCPost *> *posts, NSError *error) {
        if (posts) {
            weakSelf.posts = posts;
            [weakSelf.tableView reloadData];
            NSLog(@"get posts count:%ld", (long)posts.count);
        }
        else {
            NSLog(@"error: %@", error);
        }
    }];
    [self.refreshControl endRefreshing];
}


#pragma mark - private
- (void)userLoginIfRequire {
    if(![[SCUserManager sharedUserManager] isUserLogin]) {
        SCSignInViewController *signInViewController = [[SCSignInViewController alloc] initWithNibName:NSStringFromClass([SCSignInViewController class]) bundle:nil];
        [self presentViewController:signInViewController animated:YES completion:nil];
    }
    else {
        [self loadPosts];
    }
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
