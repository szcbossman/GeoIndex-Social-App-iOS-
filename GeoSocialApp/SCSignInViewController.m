//
//  SCSignInViewController.m
//  GeoSocialApp
//
//  Created by song zicheng daily use on 2018/1/20.
//  Copyright © 2018年 Troy Song. All rights reserved.
//

#import "SCSignInViewController.h"
#import "SCUser.h"
#import "SCUserManager.h"
#import "UIColor+colorExtension.h"

@interface SCSignInViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;

@end

@implementation SCSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}


#pragma mark - UI

- (void)setupUI
{
    [self.signInButton addTarget:self action:@selector(userLogin) forControlEvents:UIControlEventTouchUpInside];
    self.signInButton.layer.contentsScale = 5;
    [self.signInButton setTitle:@"Sign in" forState:UIControlStateNormal];
    self.signInButton.backgroundColor = [UIColor SCColor];
    [self.signInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.nameField.delegate = self;
    self.passwordField.delegate = self;
    
    [self.signupButton addTarget:self action:@selector(userSignup) forControlEvents:UIControlEventTouchUpInside];
    self.signupButton.layer.contentsScale = 5;
    [self.signupButton setTitle:@"Sign up" forState:UIControlStateNormal];
    self.signupButton.backgroundColor = [UIColor SCColor];
    [self.signupButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}


// sign up and login

- (void)userSignup {
    __weak typeof(self) weakSelf = self;
    [[SCUserManager sharedUserManager] signupWithUsername:self.nameField.text password:self.passwordField.text andCompletionBlock:^(NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Please sign up with another name." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                    NSLog(@"OK");
                }];
                [alert addAction:okAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
            else {
                if ([self.delegate respondsToSelector:@selector(loginSuccess)]) {
                    [self.delegate loginSuccess];
                }
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            }
        });
    }];
}


- (void)userLogin
{
    __weak typeof(self) weakSelf = self;
    [[SCUserManager sharedUserManager] loginWithUsername:self.nameField.text password:self.passwordField.text andCompletionBlock:^(NSError * _Nullable error) {
        if (error) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Please sign up" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                NSLog(@"OK");
            }];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else {
            if ([self.delegate respondsToSelector:@selector(loginSuccess)]) {
                [self.delegate loginSuccess];
            }
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }
    }];
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
