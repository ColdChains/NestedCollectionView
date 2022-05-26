//
//  VerticalCollectionViewCell.h
//  QL
//
//  Created by lax on 2021/6/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VerticalCollectionViewCell : UICollectionViewCell

@property(nonatomic, assign) NSInteger currentIndex;

@property(nonatomic, copy) NSArray<UIColor *> *dataArray;

@end

NS_ASSUME_NONNULL_END
