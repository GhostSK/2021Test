//
//  TestCollectionViewCell.m
//  CollectionViewreView
//
//  Created by 胡杨林 on 2021/4/26.
//

#import "TestCollectionViewCell.h"

@implementation TestCollectionViewCell

- (instancetype)init {
    if (self = [super init]) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        [self addSubview:self.label];
        self.iamgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 160, 240)];
        [self addSubview:self.iamgeView];
    }
    NSLog(@"cell初始化方法被调用");
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.iamgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 160, 240)];
        [self addSubview:self.iamgeView];
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        [self addSubview:self.label];
    }
    
    NSLog(@"cellFrame初始化方法被调用");
    return self;
}



@end
