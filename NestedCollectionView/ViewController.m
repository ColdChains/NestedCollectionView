//
//  ViewController.m
//  NestedCollectionView
//
//  Created by lax on 2022/5/23.
//

#import "ViewController.h"
#import "VerticalCollectionView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    VerticalCollectionView *collectionView = [[VerticalCollectionView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [self.view addSubview:collectionView];
    
    collectionView.dataArray = @[
    @[[UIColor greenColor], [UIColor yellowColor], [UIColor blueColor], [UIColor redColor]],
    @[[UIColor blueColor], [UIColor redColor]],
    @[[UIColor orangeColor], [UIColor darkTextColor], [UIColor grayColor]],
    ];
    [collectionView reloadData];
    
}


@end
