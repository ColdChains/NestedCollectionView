//
//  HorizontalCollectionView.m
//  QL
//
//  Created by lax on 2021/6/12.
//

#import "HorizontalCollectionView.h"
#import "HorizontalCollectionViewCell.h"

@interface HorizontalCollectionView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, assign) CGFloat beginOffset;

@property(nonatomic, assign) NSInteger currentIndex;

@end

@implementation HorizontalCollectionView

- (void)setDataArray:(NSMutableArray<UIColor *> *)dataArray {
    _dataArray = dataArray;
    // 只有一个不滑动
    self.scrollEnabled = dataArray.count > 1;
}

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = [UIColor clearColor];
        self.pagingEnabled = YES;
        self.scrollsToTop = NO;
        
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        [self registerNib:[UINib nibWithNibName: NSStringFromClass([HorizontalCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier: NSStringFromClass([HorizontalCollectionViewCell class])];
        
    }
    return self;
}

// 获取真实位置
- (NSInteger)realIndexWithCurrentIndex:(NSInteger)currentIndex {
    NSInteger index;
    if (currentIndex == 0) {
        index = self.dataArray.count - 1;
    } else if (currentIndex == self.dataArray.count + 1) {
        index = 0;
    } else {
        index = currentIndex - 1;
    }
    return index;
}

// 滚动到指定位置
- (void)scrollToItemAtIndex:(NSInteger)index {
    if (index < 0 || index >= self.dataArray.count) {
        index = 0;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index + 1 inSection:0];
    [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

- (void)reloadData {
    [super reloadData];
    [self scrollToItemAtIndex:0];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count ? self.dataArray.count + 2 : 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HorizontalCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HorizontalCollectionViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor = self.dataArray[[self realIndexWithCurrentIndex:indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.horizontalDelegate respondsToSelector:@selector(horizontalCollectionViewDidSelectItemAtIndex:)]) {
        [self.horizontalDelegate horizontalCollectionViewDidSelectItemAtIndex:indexPath.item];
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.frame.size;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.x <= 0) {
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width * self.dataArray.count, 0) animated:NO];
    } else if (scrollView.contentOffset.x >= scrollView.frame.size.width * (self.dataArray.count + 1)) {
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0) animated:NO];
    }
    
    HorizontalScrollDirection direction = scrollView.contentOffset.x > self.beginOffset ? HorizontalScrollDirectionLeft : HorizontalScrollDirectionRight;
    self.beginOffset = scrollView.contentOffset.x;
    NSInteger index = (scrollView.contentOffset.x + scrollView.frame.size.width / 2) / scrollView.frame.size.width;
    index = [self realIndexWithCurrentIndex:index];
    if (index != self.currentIndex) {
        self.currentIndex = index;
        if ([self.horizontalDelegate respondsToSelector:@selector(horizontalCollectionViewDidScrollAtIndex:direction:)]) {
            [self.horizontalDelegate horizontalCollectionViewDidScrollAtIndex:index direction:direction];
        }
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.beginOffset = scrollView.contentOffset.x;
}

@end
