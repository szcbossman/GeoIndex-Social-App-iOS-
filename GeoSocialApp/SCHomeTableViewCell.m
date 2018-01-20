//
//  SCHomeTableViewCell.m
//  GeoSocialApp
//
//  Created by song zicheng daily use on 2018/1/14.
//  Copyright © 2018年 Troy Song. All rights reserved.
//

#import "SCHomeTableViewCell.h"
#import "SCPost.h"
#import "UIImageView+AFNetWorking.h"

@interface SCHomeTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (strong, nonatomic ) SCPost *post;

@end



@implementation SCHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadCellWithPost:(SCPost *)post {
    self.post = post;
    self.titleLabel.text = post.name;
    self.messageLabel.text = post.message;
    //[self.postImage setImageWithURL:[NSURL URLWithString:self.post.imageURL] placeholderImage:[UIImage imageNamed:@"loading"]];
}

+ (CGFloat)cellHeight {
    return 120.0;
}

@end
