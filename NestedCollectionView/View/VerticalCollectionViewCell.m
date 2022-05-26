//
//  VerticalCollectionViewCell.m
//  QL
//
//  Created by lax on 2021/6/12.
//

#import "VerticalCollectionViewCell.h"
#import "HorizontalCollectionView.h"
#import "CirclePageView.h"

@interface VerticalCollectionViewCell() <HorizontalCollectionViewDelegate>

@property(nonatomic, assign) NSInteger direction;

//轮播图
@property(nonatomic, strong) HorizontalCollectionView * collectionView;

//小圆点
@property(nonatomic, strong) CirclePageView * pageView;

@end

@implementation VerticalCollectionViewCell

- (void)setDataArray:(NSArray<UIColor *> *)dataArray {
    _dataArray = dataArray;
    
    self.collectionView.dataArray = dataArray;
    [self.collectionView reloadData];
    
    NSLog(@"zzzz %ld %ld", self.currentIndex, self.direction);
    self.pageView.numberOfPages = dataArray.count;
    [self.pageView reloadData];
    [self.pageView scrollWithDirection:self.direction animated:NO];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.collectionView = [[HorizontalCollectionView alloc] init];
    self.collectionView.horizontalDelegate = self;
    [self.contentView addSubview:self.collectionView];
        
    self.pageView = [[CirclePageView alloc] init];
    [self addSubview:self.pageView];
    self.pageView.frame = CGRectMake(0, 100, UIScreen.mainScreen.bounds.size.width, 20);
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

- (void)horizontalCollectionViewDidScrollAtIndex:(NSInteger)index direction:(HorizontalScrollDirection)direction {
    NSLog(@"%ld %ld", index, direction);
    self.direction = direction;
    [self.pageView scrollWithDirection:direction animated:YES];
}

@end
