//
//  SCCreatePostViewController.m
//  GeoSocialApp
//
//  Created by song zicheng daily use on 2018/1/21.
//  Copyright © 2018年 Troy Song. All rights reserved.
//

#import "SCCreatePostViewController.h"
#import "SCPostManager.h"
#import "SCPost.h"

static NSString * const SCPostTextPlaceHolder = @"Enter your post here...";

@interface SCCreatePostViewController () <UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *postTextView;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;
@property (strong, nonatomic) UIImage *selectedImage;

@end

@implementation SCCreatePostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}


- (void)setupUI {
    self.title = NSLocalizedString(@"Create Post", nil);
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Select Image", nil) style:UIBarButtonItemStyleDone target:self action:@selector(selecteImageFromPhotoLibrary)];
    self.navigationItem.rightBarButtonItem = barButton;
    
    self.postTextView.delegate = self;
    self.postTextView.text = SCPostTextPlaceHolder;
    self.postTextView.textColor = [UIColor lightGrayColor];
    
    self.selectedImageView.layer.masksToBounds = YES;
    self.selectedImageView.layer.cornerRadius = 5.0;
}


#pragma mark -- action
- (void)createPost {
    __weak typeof(self) weakSelf = self;
    [SCPostManager createPostWithMessage:self.postTextView.text imageFile:self.selectedImage andCompletion:^(NSError *error) {
        if (error) {
            NSLog(@"%@", error);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"Please try again later.", nil) preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okButton = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:okButton];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        else {
            NSLog(@"Post created");
            [weakSelf.navigationController popViewControllerAnimated:YES];
            if ([weakSelf.delegate respondsToSelector:@selector(didCreatePost)]) {
                [weakSelf.delegate didCreatePost];
            }
        }
    }];
}

- (void)selecteImageFromPhotoLibrary {
    // show photo library
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
}


#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:SCPostTextPlaceHolder]) {
        textView.text = @"";
        textView.textColor = [UIColor darkTextColor];
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length == 0) {
        textView.text = SCPostTextPlaceHolder;
        textView.textColor = [UIColor lightGrayColor];
    }
    [textView resignFirstResponder];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    self.selectedImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    self.selectedImageView.image = self.selectedImage;
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Post", nil) style:UIBarButtonItemStyleDone target:self action:@selector(createPost)];
    self.navigationItem.rightBarButtonItem = barButton;
    [picker dismissViewControllerAnimated:YES completion:nil];
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
