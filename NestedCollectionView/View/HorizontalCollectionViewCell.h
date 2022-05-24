//
//  HorizontalCollectionViewCell.h
//  QL
//
//  Created by lax on 2021/6/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HorizontalCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIImageView *fanshionImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fanshionImageViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fanshionImageViewHeight;

@end

NS_ASSUME_NONNULL_END
