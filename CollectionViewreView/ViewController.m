//
//  ViewController.m
//  CollectionViewreView
//
//  Created by 胡杨林 on 2021/4/19.
//

#import "ViewController.h"
#import <SDWebImage/SDWebImageManager.h>
#import "UIImageView+WebCache.h"
#import "WaterFallFlowLayout.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource,CollwctionWaterFallLayoutProtocol>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) WaterFallFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) NSMutableArray *urlArr;
@property (nonatomic, strong) UICollectionView *imageCollec;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 300, 450)];
    [self.view addSubview:imageView];
    NSMutableArray *urlArr = [NSMutableArray array];
    for (int i = 0; i < 49; i++) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://tjg.hywly.com/a/1/8280/%d.jpg",i+1]];
        [urlArr addObject:url];
    }
    self.urlArr = urlArr;
    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://tjg.hywly.com/a/1/8280/2.jpg"]] placeholderImage:[UIImage imageNamed:@"443.png"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"图片加载完成");
    }];
    [self setupDataList];
    [self.view addSubview:self.collectionView];
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

//    layout.itemSize = CGSizeMake(160, 240);
//    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
//    collection.delegate = self;
//    collection.dataSource = self;
//    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"reuse"];
//    collection.backgroundColor = UIColor.whiteColor;
//    [self.view addSubview:collection];
//    self.imageCollec = collection;

    
}

#pragma mark - Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 40;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cell方法被调用");
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UICollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, 160, 240)];
        NSLog(@"cell == nil  新cell建立");
    }
    cell.frame = CGRectMake(0, 0, 160, 240);
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 40)];
    label.text = [NSString stringWithFormat:@"这是第%ld个cell",(long)indexPath.row];
    [cell addSubview:label];
//    if (cell.subviews.count > 0) {
//        [cell willRemoveSubview:cell.subviews[0]];
//    }
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 160, 240)];
//    [cell addSubview:imageView];
//    [imageView sd_setImageWithURL:self.urlArr[indexPath.row] placeholderImage:[UIImage imageNamed:@"443.png"]];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.imageCollec) {
        [collectionView reloadData];
    }
}


- (void)setupDataList
{
    _dataList = [NSMutableArray array];
    NSInteger dataCount = arc4random()%25+50;
    for(NSInteger i=0; i<dataCount; i++){
        NSInteger rowHeight = arc4random()%100+200;
        [_dataList addObject:@(rowHeight)];
    }
    
}


- (CGFloat) collectionViewLayout:(WaterFallFlowLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return arc4random()%200 + 50;
}

#pragma mark - get/set

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"reuse"];
    }
    return _collectionView;;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[WaterFallFlowLayout alloc] init];
        _flowLayout.delegate = self;
        _flowLayout.columns = 2;
        _flowLayout.columnSpacing = 10;
        _flowLayout.insets = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return _flowLayout;
}

@end
