//
//  VerticalCollectionViewCell.m
//  QL
//
//  Created by lax on 2021/6/12.
//

#import "VerticalCollectionViewCell.h"
#import "HorizontalCollectionView.h"
#import "ScalePageView.h"
#import "AnimatedPageView.h"

@interface VerticalCollectionViewCell() <HorizontalCollectionViewDelegate>

@property(nonatomic, assign) NSInteger direction;

//轮播图
@property(nonatomic, strong) HorizontalCollectionView * collectionView;

//小圆点
@property(nonatomic, strong) ScalePageView * scalePageView;
@property(nonatomic, strong) AnimatedPageView * animatedPageView;

@end

@implementation VerticalCollectionViewCell

- (void)setDataArray:(NSArray<UIColor *> *)dataArray {
    _dataArray = dataArray;
    
    self.collectionView.dataArray = dataArray;
    [self.collectionView reloadData];
    
    self.scalePageView.numberOfPages = dataArray.count;
    [self.scalePageView reloadData];
    [self.scalePageView scrollWithDirection:self.direction animated:NO];
    
    self.animatedPageView.numberOfPages = dataArray.count;
    [self.animatedPageView reloadData];
    [self.animatedPageView scrollToIndex:self.currentIndex animated:NO];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.collectionView = [[HorizontalCollectionView alloc] init];
    self.collectionView.horizontalDelegate = self;
    [self.contentView addSubview:self.collectionView];
    
    // 样式一
    self.scalePageView = [[ScalePageView alloc] init];
    [self addSubview:self.scalePageView];
    self.scalePageView.frame = CGRectMake(0, 100, UIScreen.mainScreen.bounds.size.width, 20);
    
    // 样式二
//    self.animatedPageView = [[AnimatedPageView alloc] init];
//    [self addSubview:self.animatedPageView];
//    self.animatedPageView.frame = CGRectMake(0, 100, UIScreen.mainScreen.bounds.size.width, 20);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

- (void)horizontalCollectionViewDidScrollAtIndex:(NSInteger)index direction:(HorizontalScrollDirection)direction {
    self.direction = direction;
    [self.scalePageView scrollWithDirection:direction animated:YES];
    
    self.currentIndex = index;
    [self.animatedPageView scrollToIndex:index animated:YES];
}

@end
