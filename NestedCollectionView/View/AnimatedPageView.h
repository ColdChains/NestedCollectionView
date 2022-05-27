//
//  AnimatedPageView.h
//  NestedCollectionView
//
//  Created by lax on 2022/5/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnimatedPageView : UIView

// 圆点数组
@property (nonatomic, strong, readonly) NSMutableArray<UIImageView *> *viewArray;

// 当前页
@property (nonatomic, assign, readonly) NSInteger currentPage;

// 总页数
@property (nonatomic, assign) NSInteger numberOfPages;

// 间距
@property (nonatomic, assign) CGFloat itemMargin;

// 正常圆点宽度
@property (nonatomic, assign) CGFloat itemWidth;

// 正常圆点高度
@property (nonatomic, assign) CGFloat itemHeight;

// 当前圆点宽度
@property (nonatomic, assign) CGFloat currentItemWidth;

// 正常圆点颜色
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;

// 当前圆点颜色
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;

// 刷新数据
- (void)reloadData;

// 移动小圆点
- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
