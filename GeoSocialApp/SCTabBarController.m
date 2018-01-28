//
//  SCTabBarController.m
//  GeoSocialApp
//
//  Created by song zicheng daily use on 2018/1/13.
//  Copyright © 2018年 Troy Song. All rights reserved.
//

#import "SCTabBarController.h"
#import "SCHomeViewController.h"

@interface SCTabBarController ()

@end

@implementation SCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.viewControllers = [self viewControllerArray];
    self.selectedIndex = 0;
}

- (NSArray <UIViewController *> *)viewControllerArray {
    UIViewController *homeController = [self homeViewController];
    UIViewController *exploreController = [self exploreViewController];
    NSArray<UIViewController *> *array = @[homeController, exploreController];
    return array;
}

- (UIViewController *)homeViewController {
    SCHomeViewController *homeController = [[SCHomeViewController alloc] init];
    UIImage *image = [UIImage imageNamed:@"Events"];
    UIImage *selectedImage = [UIImage imageNamed:@"Events_selected"];
    homeController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:image selectedImage:selectedImage];
    //homeController.tabBarItem.tag = 0;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:homeController];
    return navigationController;

}

- (UIViewController *)exploreViewController {
    UIViewController *exploreController = [[UIViewController alloc] init];
    UIImage *image = [UIImage imageNamed:@"Explore"];
    UIImage *selectedImage = [UIImage imageNamed:@"Explore_selected"];
    exploreController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Explore" image:image selectedImage:selectedImage];
    //exploreController.tabBarItem.tag = 1;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:exploreController];
    return navigationController;
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
