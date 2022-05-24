//
//  CirclePageView.h
//  QL
//
//  Created by lax on 2021/6/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PageScrollDirection) {
    PageScrollDirectionUnknow = -1,
    PageScrollDirectionLeft = 1,
    PageScrollDirectionRight = 0,
};//1左 0右 -1初始化

@interface CirclePageView : UIView
{
    NSArray *locationData;
}
//总数量
@property (nonatomic, assign) NSInteger numberOfPages;
@property (nonatomic, assign) NSInteger currentPage;
//最多显示数量
@property (nonatomic, assign) NSInteger maxPage;
//间距
@property (nonatomic, assign) CGFloat itemMargin;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat currentItemWidth;
//颜色
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;

@property (nonatomic, strong) NSMutableArray<UIImageView *> *viewArray;

// 滚动到第几页
- (void)scrollToCurrentPage:(NSInteger)currentPage direction:(PageScrollDirection)direction animated:(BOOL)animated;

// 恢复状态
- (void)setupView;

@end

NS_ASSUME_NONNULL_END
