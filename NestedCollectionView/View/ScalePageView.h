//
//  ScalePageView.h
//  QL
//
//  Created by lax on 2021/6/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PageScrollDirection) {
    PageScrollDirectionNone,
    PageScrollDirectionLeft,
    PageScrollDirectionRight,
};

@interface ScalePageView : UIView

// 圆点数组
@property (nonatomic, strong, readonly) NSMutableArray<UIImageView *> *viewArray;

// 总页数
@property (nonatomic, assign) NSInteger numberOfPages;

// 间距
@property (nonatomic, assign) CGFloat itemMargin;

// 正常圆点宽度
@property (nonatomic, assign) CGFloat itemWidth;

// 当前圆点宽度
@property (nonatomic, assign) CGFloat currentItemWidth;

// 正常圆点颜色
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;

// 当前圆点颜色
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;

// 刷新数据
- (void)reloadData;

// 移动小圆点
- (void)scrollWithDirection:(PageScrollDirection)direction animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
