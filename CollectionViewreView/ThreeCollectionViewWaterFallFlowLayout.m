//
//  ThreeCollectionViewWaterFallFlowLayout.m
//  CollectionViewreView
//
//  Created by 胡杨林 on 2021/4/27.
//

#import "ThreeCollectionViewWaterFallFlowLayout.h"

@interface ThreeCollectionViewWaterFallFlowLayout ()

@property (nonatomic, strong) NSMutableArray <UICollectionViewLayoutAttributes *> *attributesArray;
@property (nonatomic, strong) NSMutableArray <NSNumber *> *heightArr;

@end


@implementation ThreeCollectionViewWaterFallFlowLayout


- (instancetype)init {
    if (self = [super init]) {
        _attributesArray = [NSMutableArray array];
        _heightArr = [NSMutableArray array];
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    [self.heightArr removeAllObjects];
    for (NSInteger column = 0; column < self.columnCount; column++) {
        [self.heightArr addObject:[NSNumber numberWithFloat:0]];
    }
    
    
    NSInteger sectionNum = [self.collectionView numberOfSections];
    [self.attributesArray removeAllObjects];
    for (int i = 0; i < sectionNum; i++) {
        NSInteger itemNums = [self.collectionView numberOfItemsInSection:i];
        for (int j = 0; j < itemNums; j++) {
            UICollectionViewLayoutAttributes *attri = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
            [self.attributesArray addObject:attri];
        }
    }
}


/*根据indexPath 计算对应的LayoutAttributes*/
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//    CGFloat itemHeight = [self.delegate collectionViewLayout:self heightForItemAtIndexPath:indexPath];
//    NSInteger columnIndexLess = [self columnOfLessHeight];
//    CGFloat lessHeight = self.columnHeights[columnIndexLess].floatValue;
//    CGFloat width = (self.collectionView.bounds.size.width - _insets.left - _insets.right - _columnSpacing * (_columns - 1)) / _columns;
//    CGFloat height = itemHeight;
//    CGFloat x = _insets.left + (width + _columnSpacing) * columnIndexLess;
//    CGFloat y = lessHeight == 0 ? _insets.top : lessHeight + _itemSpacing;
//    attributes.frame = CGRectMake(x, y, width, height);
//    self.columnHeights[columnIndexLess] = @(y+height);
    return attributes;;
}


#pragma mark - Tools

- (NSInteger)LeastHeightIndex {
    if (self.heightArr.count <= 1 ) {
        return 0;
    }
    NSInteger k = 0;
    CGFloat minHeight = CGFLOAT_MAX;
    for (int i = 0; i < self.heightArr.count; i++) {
        if (self.heightArr[i].floatValue < minHeight) {
            minHeight = self.heightArr[i].floatValue;
            k = i;
        }
    }
    return k;
}

- (NSInteger)MaxHeightIndex {
    if (self.heightArr.count <= 1 ) {
        return 0;
    }
    NSInteger k = 0;
    CGFloat maxHeight = 0;
    for (int i = 0; i < self.heightArr.count; i++) {
        if (self.heightArr[i].floatValue > maxHeight) {
            maxHeight = self.heightArr[i].floatValue;
            k = i;
        }
    }
    return k;
}

- (void)setColumnCount:(NSInteger)columnCount {
    _columnCount = columnCount;
    [self prepareLayout];
}

@end
