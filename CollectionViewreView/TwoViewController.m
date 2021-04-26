//
//  TwoViewController.m
//  CollectionViewreView
//
//  Created by 胡杨林 on 2021/4/26.
//

#import "TwoViewController.h"
#import "TestCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface TwoViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *urlArr;
@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i = 0; i < 49; i++) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://tjg.hywly.com/a/1/8280/%d.jpg",i+1]];
        [self.urlArr addObject:url];
    }
    [self.view addSubview:self.collectionView];
}


#pragma mark - delegate

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return [UICollectionViewCell new];
    TestCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[TestCollectionViewCell alloc] init];
    }
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
    cell.label.text = [NSString stringWithFormat:@"这是第%ld个cell",indexPath.row];
    [cell.iamgeView sd_setImageWithURL:self.urlArr[indexPath.row] placeholderImage:[UIImage imageNamed:@"443.png"]];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

#pragma mark - get/set

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[TestCollectionViewCell class] forCellWithReuseIdentifier:@"reuse"];
    }
    
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake(160, 240);
//        _flowLayout.
    }
    return _flowLayout;
}

- (NSMutableArray *)urlArr {
    if (!_urlArr) {
        _urlArr = [NSMutableArray array];
    }
    return _urlArr;
}

@end
