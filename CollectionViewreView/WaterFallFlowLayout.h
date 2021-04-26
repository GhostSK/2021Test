//
//  WaterFallFlowLayout.h
//  CollectionViewreView
//
//  Created by 胡杨林 on 2021/4/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CollwctionWaterFallLayoutProtocol;

@interface WaterFallFlowLayout : UICollectionViewFlowLayout


@property (nonatomic, weak) id<CollwctionWaterFallLayoutProtocol> delegate;
@property (nonatomic, assign) NSUInteger columns;
@property (nonatomic, assign) CGFloat columnSpacing;
@property (nonatomic, assign) CGFloat itemSpacing;
@property (nonatomic, assign) UIEdgeInsets insets;

@end


@protocol CollwctionWaterFallLayoutProtocol <NSObject>
//- (CGFloat)collectionViewLayout:(CollectionWaterfallLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath;
//
@optional
- (CGFloat)collectionViewLayout:(WaterFallFlowLayout *)layout heightForSupplementaryViewAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat) collectionViewLayout:(WaterFallFlowLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath;


@end


NS_ASSUME_NONNULL_END
