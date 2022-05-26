//
//  CirclePageView.m
//  QL
//
//  Created by lax on 2021/6/16.
//

#import "CirclePageView.h"

@interface CirclePageView ()

// 当前页数
//@property (nonatomic, assign) NSInteger currentPage;

// 圆点数组
@property (nonatomic, strong) NSMutableArray<UIImageView *> *viewArray;

// 缩放大小
@property (nonatomic, copy) NSArray *scaleData;

@end

@implementation CirclePageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        
        self.numberOfPages = 4;
        self.viewArray = [NSMutableArray array];
        
        self.itemMargin = 6;
        self.itemWidth = 6;
        self.currentItemWidth = 16;
        self.pageIndicatorTintColor = [UIColor whiteColor];
        self.currentPageIndicatorTintColor = [UIColor blackColor];
        
        // 最多展示7个 后期可扩展
        self.scaleData = @[
            @[@1],
            @[@1, @0.7],
            @[@0.7, @1, @0.7],
            @[@0.7, @1, @0.7, @0.4],
            @[@0.4, @0.7, @1, @0.7, @0.4],
            @[@0.4, @0.7, @1, @0.9, @0.7, @0.4],
            @[@0.4, @0.7, @0.9, @1, @0.9, @0.7, @0.4]
        ];
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
    NSInteger count = self.numberOfPages > 7 ? 7 : self.numberOfPages;
    for (int i = 0; i < count; i++) {
        UIImageView *view = [[UIImageView alloc] init];
        view.layer.cornerRadius = self.itemWidth / 2;
        [self addSubview:view];
        [self.viewArray addObject:view];
    }
    
    [self initWithDirection:PageScrollDirectionNone];
    
}

// 朝某个方向滚动
- (void)initWithDirection:(PageScrollDirection)direction {
    
    NSInteger count = self.numberOfPages > 7 ? 7 : self.numberOfPages;
    NSMutableArray<NSNumber *> *arr = [NSMutableArray arrayWithArray:self.scaleData[count - 1]];
    
    CGFloat totalWidth = 0;
    for (NSNumber *num in arr) {
        totalWidth += num.floatValue * self.itemWidth + self.itemMargin;
    }
    totalWidth -= self.itemMargin + self.itemWidth;
    totalWidth += self.currentItemWidth;
    
    CGFloat x = (self.bounds.size.width - totalWidth) / 2;
    CGFloat w = self.itemWidth;
    CGFloat y = (self.bounds.size.height - w) / 2;
    
    // 左移需要调整x 第一个左移后会移出起始位置
    if (direction == PageScrollDirectionLeft) {
        [arr insertObject:@0.1 atIndex:0];
        x -= self.itemMargin + self.itemWidth * arr[0].floatValue;
    } else if (direction == PageScrollDirectionRight) {
        [arr insertObject:@0.1 atIndex:0];
    }
    
    for (int i = 0; i < self.viewArray.count; i++) {
        //初始化的样式与左移样式相同
        NSInteger index;
        if (direction == PageScrollDirectionNone) {
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

// 移动小圆点
- (void)scrollWithDirection:(PageScrollDirection)direction animated:(BOOL)animated {
    
    // 增加新的
    if (direction == PageScrollDirectionLeft) {
        UIImageView *view = [[UIImageView alloc] init];
        [self addSubview:view];
        CGFloat w = self.itemWidth * 0.1;
        view.frame = CGRectMake(0, 0, w, w);
        view.center = self.viewArray.lastObject.center;
        view.layer.cornerRadius = w / 2;
        [self.viewArray addObject:view];
    } else if (direction == PageScrollDirectionRight) {
        UIImageView *view = [[UIImageView alloc] init];
        [self addSubview:view];
        CGFloat w = self.itemWidth * 0.1;
        view.frame = CGRectMake(0, 0, w, w);
        view.center = self.viewArray.firstObject.center;
        view.layer.cornerRadius = w / 2;
        [self.viewArray insertObject:view atIndex:0];
    }
    
    // 做移动动画 然后移除旧的
    [self layoutIfNeeded];
    [UIView animateWithDuration:animated ? 0.25 : 0 animations:^{
        [self initWithDirection:direction];
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

@end
