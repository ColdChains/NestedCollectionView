//
//  HorizontalCollectionView.h
//  QL
//
//  Created by lax on 2021/6/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, HorizontalScrollDirection) {
    HorizontalScrollDirectionUnknow,
    HorizontalScrollDirectionLeft,
    HorizontalScrollDirectionRight,
};

@protocol HorizontalCollectionViewDelegate <NSObject>

@optional

- (void)horizontalCollectionViewDidSelectItemAtIndex:(NSInteger)index;

- (void)horizontalCollectionViewDidScrollAtIndex:(NSInteger)index direction:(HorizontalScrollDirection)direction;

@end

@interface HorizontalCollectionView : UICollectionView

@property (nonatomic, weak) id<HorizontalCollectionViewDelegate> horizontalDelegate;

@property (nonatomic, copy) NSArray<UIColor *> *dataArray;

- (void)scrollToItemAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
