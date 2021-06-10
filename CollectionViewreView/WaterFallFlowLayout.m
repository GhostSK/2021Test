//
//  WaterFallFlowLayout.m
//  CollectionViewreView
//
//  Created by 胡杨林 on 2021/4/26.
//

#import "WaterFallFlowLayout.h"

NSString *const kSupplementaryViewKindHeader = @"Header";
CGFloat const kSupplementaryViewKindHeaderPinnedHeight = 44.f;

@interface WaterFallFlowLayout()

/** 保存所有Item的LayoutAttributes */
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *attributesArray;
/** 保存所有列的当前高度 */
@property (nonatomic, strong) NSMutableArray<NSNumber *> *columnHeights;

@end



@implementation WaterFallFlowLayout

- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (instancetype)init {
    if (self = [super init]) {
        _columns = 1;
        _columnSpacing = 10;
        _itemSpacing = 10;
        _insets = UIEdgeInsetsZero;
    }
    return self;
}

#pragma mark - UICollectionViewLayout (UISubclassingHooks)
/**
 *  1、
 *  collectionView初次显示或者调用invalidateLayout方法后会调用此方法
 *  触发此方法会重新计算布局，每次布局也是从此方法开始
 *  在此方法中需要做的事情是准备后续计算所需的东西，以得出后面的ContentSize和每个item的layoutAttributes
 */

- (void)prepareLayout {
    [super prepareLayout];
    self.columnHeights = [NSMutableArray array];
    for (NSInteger column = 0; column < _columns; column++) {
        self.columnHeights[column] = @(0);
    }
    
    self.attributesArray = [NSMutableArray array];
    NSInteger numSections = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger section = 0; section < numSections; section++) {
        NSInteger numItems = [self.collectionView numberOfItemsInSection:section];
        for (NSInteger item = 0; item < numItems; item++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:item inSection:section];
            //计算LayoutAttributes
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.attributesArray addObject:attributes];
        }
    }
}
/* 找到高度最大的哪一行的下标*/
- (NSInteger)columnOfMostHeight {
    if (self.columnHeights.count == 0 || self.columnHeights.count == 0) {
        return 0;
    }
    __block NSInteger mostIndex = 0;
    [self.columnHeights enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.floatValue > self.columnHeights[mostIndex].floatValue) {
            mostIndex = idx;
        }
    }];
    return mostIndex;;
}

- (NSInteger)columnOfLessHeight {
    if (self.columnHeights.count == 0 || self.columnHeights.count == 0) {
        return 0;
    }
    __block NSInteger lessIndex = 0;
    [self.columnHeights enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.floatValue < self.columnHeights[lessIndex].floatValue) {
            lessIndex = idx;
        }
    }];
    return lessIndex;
}


- (CGSize)collectionViewContentSize {
    NSInteger mostColumn = [self columnOfMostHeight];
    CGFloat mostHeight = self.columnHeights[mostColumn].floatValue;
//    return CGSizeMake(20, 20);
    return CGSizeMake(self.collectionView.bounds.size.width, mostHeight + _insets.top + _insets.bottom);
}



/**
 *  3、
 *  当CollectionView开始刷新后，会调用此方法并传递rect参数（即当前可视区域）
 *  我们需要利用rect参数判断出在当前可视区域中有哪几个indexPath会被显示（无视rect而全部计算将会带来不好的性能）
 *  最后计算相关indexPath的layoutAttributes，加入数组中并返回
 */


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attributesArray = self.attributesArray;
    NSArray <NSIndexPath *> *indexPaths = [NSMutableArray array];
    for (NSIndexPath *indexPath in indexPaths) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [attributesArray addObject:attributes];
    }
    //2、计算rect中出现的SupplementaryViews
    //这里只计算了kSupplementaryViewKindHeader
//    indexPaths = [self indexPathForSupplementaryViewsOfKind:kSupplementaryViewKindHeader InRect:rect];
//    for(NSIndexPath *indexPath in indexPaths){
//        //计算对应的LayoutAttributes
//        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:kSupplementaryViewKindHeader atIndexPath:indexPath];
//        [attributesArray addObject:attributes];
//    }
//
    return attributesArray;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
//    return [super shouldInvalidateLayoutForBoundsChange:newBounds];
    return true;
}

/*根据indexPath 计算对应的LayoutAttributes*/
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat itemHeight = [self.delegate collectionViewLayout:self heightForItemAtIndexPath:indexPath];
    NSInteger columnIndexLess = [self columnOfLessHeight];
    CGFloat lessHeight = self.columnHeights[columnIndexLess].floatValue;
    CGFloat width = (self.collectionView.bounds.size.width - _insets.left - _insets.right - _columnSpacing * (_columns - 1)) / _columns;
    CGFloat height = itemHeight;
    CGFloat x = _insets.left + (width + _columnSpacing) * columnIndexLess;
    CGFloat y = lessHeight == 0 ? _insets.top : lessHeight + _itemSpacing;
    attributes.frame = CGRectMake(x, y, width, height);
    self.columnHeights[columnIndexLess] = @(y+height);
    return attributes;;
}


/**
 *  计算目标rect中含有的某类SupplementaryView
 */
//- (NSMutableArray<NSIndexPath *> *)indexPathForSupplementaryViewsOfKind:(NSString *)kind InRect:(CGRect)rect
//{
//    NSMutableArray<NSIndexPath *> *indexPaths = [NSMutableArray array];
//    if([kind isEqualToString:kSupplementaryViewKindHeader]){
//        //在这个瀑布流自定义布局中，只有一个位于列表顶部的SupplementaryView
//        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
//        
//        //如果当前区域可以看到SupplementaryView，则返回
//        //CGFloat height = [self.delegate collectionViewLayout:self heightForSupplementaryViewAtIndexPath:indexPath];
//        //if(CGRectGetMinY(rect) <= height + _insets.top){
//        //Header默认总是需要显示
//        [indexPaths addObject:indexPath];
//        //}
//    }
//    
//    
//    return indexPaths;
//}


/**
 *  根据kind、indexPath，计算对应的LayoutAttributes
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    
    //计算LayoutAttributes
    if([elementKind isEqualToString:kSupplementaryViewKindHeader]){
        CGFloat width = self.collectionView.bounds.size.width;
        CGFloat height = [self.delegate collectionViewLayout:self heightForSupplementaryViewAtIndexPath:indexPath];
        CGFloat x = 0;
        //根据offset计算kSupplementaryViewKindHeader的y
        //y = offset.y-(header高度-固定高度)
        CGFloat offsetY = self.collectionView.contentOffset.y;
        CGFloat y = MAX(0,
                        offsetY-(height-kSupplementaryViewKindHeaderPinnedHeight));
        attributes.frame = CGRectMake(x, y, width, height);
        attributes.zIndex = 1024;
    }
    return attributes;
}


@end
