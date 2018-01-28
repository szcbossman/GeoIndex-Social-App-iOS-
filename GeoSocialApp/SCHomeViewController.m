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
#import "SCLocationManager.h"

static NSString * const SCHomeCellIdentifier = @"homeCellIdentifier";

@interface SCHomeViewController () <UITableViewDataSource, UITableViewDelegate, SCSignInViewControllerDelegate, SCCreatePostViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray<SCPost *> *posts;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (assign, nonatomic) BOOL resultMode;

@end


@implementation SCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // show post list for SCExploreViewController
    if (self.resultMode) {
        [self setupTableView];
        return;
    }
    // load data
    [self loadPosts];
    // load UI
    [self setupUI];
    //Location service notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadPosts) name:SCLocationUpdateNotification object:nil];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // check user login or not
    [self userLoginIfRequire];
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


#pragma mark - SCCreatePostViewControllerDelegate
- (void)didCreatePost {
    [self loadPosts];
}

#pragma mark - API
- (void)loadPosts
{
    if (self.resultMode) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    CLLocation *location = [[SCLocationManager sharedManager] getUserCurrentLocation];
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


#pragma mark - UI
- (void)setupUI
{
    [self setupTableView];
    [self setupNavigationBarUI];
    [self setupRefreshControlUI];
}

- (void)setupTableView
{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SCHomeTableViewCell class]) bundle:nil] forCellReuseIdentifier:SCHomeCellIdentifier];
}

- (void)setupNavigationBarUI
{
    self.title = NSLocalizedString(@"Home", nil);
    self.navigationController.navigationBar.tintColor = [UIColor darkTextColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"PostEvents"] style:UIBarButtonItemStyleDone target:self action:@selector(showCreatePostPage)];
}

- (void)setupRefreshControlUI
{
    self.refreshControl = [UIRefreshControl new];
    self.refreshControl.tintColor = [UIColor blackColor];
    [self.refreshControl addTarget:self action:@selector(loadPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}


#pragma mark - action
- (void)showCreatePostPage {
    SCCreatePostViewController *createPostViewController = [[SCCreatePostViewController alloc] initWithNibName:NSStringFromClass([SCCreatePostViewController class]) bundle:nil];
    createPostViewController.delegate = self;
    [self.navigationController pushViewController:createPostViewController animated:YES];
}


#pragma mark -- public
- (void)loadResultPageWithPosts:(NSArray <SCPost *>*)posts
{
    self.posts = posts;
    self.resultMode = YES;
    [self.tableView reloadData];
}

#pragma mark - private
- (void)userLoginIfRequire
{
    if (![[SCUserManager sharedUserManager] isUserLogin]) {
        SCSignInViewController *signInViewController = [[SCSignInViewController alloc] initWithNibName:NSStringFromClass([SCSignInViewController class]) bundle:nil];
        signInViewController.delegate = self;
        [self presentViewController:signInViewController animated:YES completion:nil];
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
