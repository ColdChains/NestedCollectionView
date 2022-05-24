//
//  VerticalCollectionViewCell.h
//  QL
//
//  Created by lax on 2021/6/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VerticalCollectionViewCell : UICollectionViewCell

@property(nonatomic, assign) NSInteger currentPage;
@property(nonatomic, copy) NSArray<UIColor *> *dataArray;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewBottom;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commitButtonWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectButtonWidth;

@end

NS_ASSUME_NONNULL_END
