//
//  AnimatedPageView.m
//  NestedCollectionView
//
//  Created by lax on 2022/5/27.
//

#import "AnimatedPageView.h"

@interface AnimatedPageView ()

// 当前页
@property (nonatomic, assign) NSInteger currentPage;

// 圆点数组
@property (nonatomic, strong) NSMutableArray<UIImageView *> *viewArray;

@end

@implementation AnimatedPageView

- (void)setNumberOfPages:(NSInteger)numberOfPages {
    _numberOfPages = numberOfPages;
    _currentPage = 0;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        
        self.viewArray = [NSMutableArray array];
        self.itemMargin = 6;
        self.itemWidth = 6;
        self.itemHeight = 6;
        self.currentItemWidth = 16;
        self.pageIndicatorTintColor = [UIColor whiteColor];
        self.currentPageIndicatorTintColor = [UIColor blackColor];
        
    }
    return self;
}

// 刷新数据
- (void)reloadData {

    for (UIView *view in self.viewArray) {
        [view removeFromSuperview];
    }
    [self.viewArray removeAllObjects];
    if (self.numberOfPages <= 1) { return; }
    
    //初始化
    for (int i = 0; i < self.numberOfPages; i++) {
        UIImageView *view = [[UIImageView alloc] init];
        view.layer.cornerRadius = self.itemWidth / 2;
        [self addSubview:view];
        [self.viewArray addObject:view];
    }
    
    [self initViewWithAnimated:NO];
    
}

- (void)initViewWithAnimated:(BOOL)animated {
    [UIView animateWithDuration:animated ? 0.25 : 0 animations:^{
        CGFloat totalWidth = (self.itemWidth + self.itemMargin) * (self.numberOfPages - 1) + self.currentItemWidth;
        CGFloat x = (self.bounds.size.width - totalWidth) / 2;
        CGFloat y = (self.bounds.size.height - self.itemHeight) / 2;
        for (int i = 0; i < self.viewArray.count; i++) {
            UIImageView *view = [self.viewArray objectAtIndex:i];
            CGFloat w = i == self.currentPage ? self.currentItemWidth : self.itemWidth;
            view.frame = CGRectMake(x, y, w, self.itemHeight);
            view.backgroundColor = i == self.currentPage ? self.currentPageIndicatorTintColor : self.pageIndicatorTintColor;
            x += w + self.itemMargin;
        }
    }];
}

// 移动小圆点
- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated {
    self.currentPage = index;
    [self initViewWithAnimated:animated];
}

@end
