//
//  HorizontalCollectionViewCell.m
//  QL
//
//  Created by lax on 2021/6/12.
//

#import "HorizontalCollectionViewCell.h"

@interface HorizontalCollectionViewCell()

@end

@implementation HorizontalCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.tag = 100;
    [self.bgImageView addSubview:effectView];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self viewWithTag:100].frame = self.bounds;
}

@end
