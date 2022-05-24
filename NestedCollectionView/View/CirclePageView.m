//
//  CirclePageView.m
//  QL
//
//  Created by lax on 2021/6/16.
//

#import "CirclePageView.h"

@implementation CirclePageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.numberOfPages = 4;
        self.currentPage = -1;
        self.maxPage = 7;
        self.itemMargin = 6;
        self.itemWidth = 6;
        self.currentItemWidth = 16;
        self.pageIndicatorTintColor = [UIColor whiteColor];
        self.currentPageIndicatorTintColor = [UIColor blackColor];
        self.viewArray = [NSMutableArray array];
        self.userInteractionEnabled = NO;
        
        locationData = @[
        @[@1],
        @[@1, @0.7],
        @[@0.7, @1, @0.7],
        @[@0.7, @1, @0.7, @0.4],
        @[@0.4, @0.7, @1, @0.7, @0.4],
        @[@0.4, @0.7, @1, @0.9, @0.7, @0.4],
        @[@0.4, @0.7, @0.9, @1, @0.9, @0.7, @0.4]];
    }
    return self;
}

- (void)setupView {
    
    for (UIView *view in self.viewArray) {
        [view removeFromSuperview];
    }
    [self.viewArray removeAllObjects];
    if (self.numberOfPages <= 1) { return; }
    
    //初始化
    NSInteger count = self.numberOfPages > 7 ? 7 : self.numberOfPages;
    for (int i = 0; i < count; i++) {
        UIImageView *view = [[UIImageView alloc] init];
        view.layer.cornerRadius = self.itemWidth / 2;
//        [view addShadow:Color_Shadow offset:CGSizeMake(0, 2)];
        [self addSubview:view];
        [self.viewArray addObject:view];
    }
    
    [self scrollWithDirection:PageScrollDirectionUnknow];
}

- (void)scrollWithDirection:(PageScrollDirection)direction {
    NSInteger count = self.numberOfPages > 7 ? 7 : self.numberOfPages;
    NSMutableArray<NSNumber *> *arr = [NSMutableArray arrayWithArray:locationData[count - 1]];
    //初始位置
    CGFloat x = 0;
    for (NSNumber *num in arr) {
        x += num.floatValue * self.itemWidth + self.itemMargin;
    }
    x -= self.itemMargin + self.itemWidth;
    x += self.currentItemWidth;
    x = (self.bounds.size.width - x) / 2;
    
    CGFloat w = self.itemWidth;
    CGFloat y = (self.bounds.size.height - w) / 2;
    
    if (direction != PageScrollDirectionUnknow) {
        [arr insertObject:@0.1 atIndex:0];
    }
    //左移调整 左侧多一个
    if (direction == PageScrollDirectionLeft) {
        x -= direction * (self.itemMargin + self.itemWidth * arr[0].floatValue);
    }
    
    for (int i = 0; i < self.viewArray.count; i++) {
        //初始化的样式与左移样式相同
        NSInteger index;
        if (direction == PageScrollDirectionUnknow) {
            index = i;
        } else if (direction == PageScrollDirectionRight) {
            index = self.viewArray.count - 1 - i;
        } else {
            index = i;
        }
        if (index >= arr.count) { return; }
        CGFloat s = arr[index].floatValue;
        
        self.viewArray[i].layer.cornerRadius = w / 2 * s;
        if (s == 1) {
            self.viewArray[i].frame = CGRectMake(x, y, self.currentItemWidth, w);
            self.viewArray[i].backgroundColor = self.currentPageIndicatorTintColor;
        } else {
            self.viewArray[i].backgroundColor = self.pageIndicatorTintColor;
            self.viewArray[i].frame = CGRectMake(x, y + (w - w * s) / 2, w * s, w * s);
        }
        x += self.viewArray[i].frame.size.width + self.itemMargin;
    }
    
}

//1左 0右 -1初始化
- (void)setPositionWithDirection:(PageScrollDirection)direction animated:(BOOL)animated {
    
    //移动小圆点 增加新的 移除旧的
    if (direction == PageScrollDirectionLeft) {
        UIImageView *view = [[UIImageView alloc] init];
//        [view addShadow:Color_Shadow offset:CGSizeMake(0, 2)];
        [self addSubview:view];
        CGFloat w = self.itemWidth * 0.1;
        view.frame = CGRectMake(0, 0, w, w);
        view.center = self.viewArray.lastObject.center;
        view.layer.cornerRadius = w / 2;
        [self.viewArray addObject:view];
    } else if (direction == PageScrollDirectionRight) {
        UIImageView *view = [[UIImageView alloc] init];
//        [view addShadow:Color_Shadow offset:CGSizeMake(0, 2)];
        [self addSubview:view];
        CGFloat w = self.itemWidth * 0.1;
        view.frame = CGRectMake(0, 0, w, w);
        view.center = self.viewArray.firstObject.center;
        view.layer.cornerRadius = w / 2;
        [self.viewArray insertObject:view atIndex:0];
    }
    
    [self layoutIfNeeded];
    [UIView animateWithDuration:animated ? 0.25 : 0 animations:^{
        [self scrollWithDirection:direction];
    } completion:^(BOOL finished) {
        if (self.viewArray.count == 0) {
            return;
        }
        if (direction == PageScrollDirectionLeft) {
            UIImageView *view = self.viewArray.firstObject;
            [view removeFromSuperview];
            [self.viewArray removeObjectAtIndex:0];
        } else if (direction == PageScrollDirectionRight) {
            UIImageView *view = self.viewArray.lastObject;
            [view removeFromSuperview];
            [self.viewArray removeLastObject];
        }
    }];
    
}

//移动
- (void)scrollToCurrentPage:(NSInteger)currentPage direction:(PageScrollDirection)direction animated:(BOOL)animated {
    if (currentPage >= 0 && currentPage < self.numberOfPages) {
        _currentPage = currentPage;
        [self setPositionWithDirection:direction animated:animated];
    }
}

@end
