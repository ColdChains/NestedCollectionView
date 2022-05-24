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


@property (weak, nonatomic) IBOutlet UIButton *commitButton;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;

@end

@implementation VerticalCollectionViewCell

- (void)setDataArray:(NSArray<UIColor *> *)dataArray {
    _dataArray = dataArray;
    
    self.collectionView.dataArray = dataArray;
    [self.collectionView reloadData];
    
    NSLog(@"zzzz %d %d", self.currentPage, self.direction);
    self.pageView.numberOfPages = dataArray.count;
    [self.pageView setupView];
    [self.pageView scrollToCurrentPage:self.currentPage direction:self.direction animated:NO];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.collectionView = [[HorizontalCollectionView alloc] init];
    self.collectionView.horizontalDelegate = self;
    [self.contentView addSubview:self.collectionView];
        
    self.pageView = [[CirclePageView alloc] initWithFrame:CGRectMake(0, 100, self.frame.size.width, 20)];
    [self addSubview:self.pageView];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    self.pageView.frame = CGRectMake(0, 100, self.frame.size.width, 20);
//    self.pageView.numberOfPages = self.dataArray.count;
//    [self.pageView setupView];
//    NSLog(@"zzzz %d %d", self.currentPage, self.direction);
//    [self.pageView scrollToCurrentPage:self.currentPage direction:self.direction animated:NO];
    self.collectionView.frame = self.bounds;
}

- (void)horizontalCollectionViewDidScrollAtIndex:(NSInteger)index direction:(HorizontalScrollDirection)direction {
    //0 1左 2右//1左 0右 -1初始化
    if (direction == 0) {
        direction = -1;
    } else if (direction == 2) {
        direction = 0;
    }
    NSLog(@"%d %d", index, direction);
    self.direction = direction;
    [self.pageView scrollToCurrentPage:index direction:direction animated:YES];
}

@end
