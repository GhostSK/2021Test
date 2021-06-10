//
//  ThreeViewController.m
//  CollectionViewreView
//
//  Created by 胡杨林 on 2021/6/10.
//

#import "ThreeViewController.h"

@interface ThreeViewController ()<CAAnimationDelegate>

@property (nonatomic, strong) UIView *navigationBarView;
@property (nonatomic, strong) NSMutableArray *navigationBtnArr;
@property (nonatomic, strong) NSArray *navigationtitleArr;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIView *navigationBarBottomLineView;
@property (nonatomic, assign) CGPoint AnimationEndPoint;
@property (nonatomic, strong) UIButton *nowSelectedNavigationBtn;

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.navigationBarView];

}


#pragma mark - React

- (void)navigationBarBtnAction:(UIButton *)btn {
    self.nowSelectedNavigationBtn.selected = false;
    btn.selected = true;
    self.nowSelectedNavigationBtn = btn;
    NSLog(@"btn.tag = %ld",(long)btn.tag);
    float btnWidth = (self.view.frame.size.width - 40 - 20 * (self.navigationtitleArr.count-1)) / (self.navigationtitleArr.count);
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"position"];
    anima.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.navigationBarBottomLineView.frame.origin.x+self.navigationBarBottomLineView.frame.size.width/2, self.navigationBarBottomLineView.frame.origin.y+self.navigationBarBottomLineView.frame.size.height/2)];
    CGPoint toPoint = CGPointMake(20+(btn.tag-5000)*(btnWidth+20) + btnWidth / 2, 47.5);
    anima.toValue = [NSValue valueWithCGPoint:toPoint];
    self.AnimationEndPoint = toPoint;
    anima.duration = 0.5;
    anima.removedOnCompletion = NO;
    anima.delegate = self;
    anima.fillMode = kCAFillModeForwards;
    anima.beginTime = CACurrentMediaTime();
    anima.timingFunction =
    [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
    [self.navigationBarBottomLineView.layer addAnimation:anima forKey:@"positionAnimation"];
    [self.navigationBarBottomLineView setFrame:CGRectMake(20+(btn.tag-5000)*(btnWidth+20), 45, btnWidth, 5)];
}

#pragma mark - delegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
}


#pragma mark - get/set

- (UIView *)navigationBarView {
    if (_navigationBarView == nil) {
        _navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 50)];
        for (UIButton *btn in self.navigationBtnArr) {
            [_navigationBarView addSubview:btn];
        }
    }
    return _navigationBarView;
}

- (NSMutableArray *)navigationBtnArr {
    if (_navigationBtnArr == nil) {
        _navigationBtnArr = [NSMutableArray array];
        float btnWidth = (self.view.frame.size.width - 40 - 20 * (self.navigationtitleArr.count-1)) / (self.navigationtitleArr.count);
//        NSLog(@"btnWidth = %f",btnWidth);
        for (int i = 0; i < self.navigationtitleArr.count; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20+i*(btnWidth+20), 0, btnWidth, 40)];
//            NSLog(@"这是第%d个btn，x = %f, y = %f, width = %f, height = %f",i+1,20+i*(btnWidth+10),0.0,btnWidth,40.0);
            [btn setBackgroundColor:UIColor.whiteColor];
            btn.tag = 5000+i;
            [btn addTarget:self action:@selector(navigationBarBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            NSString *titleStr = self.navigationtitleArr[i];
            [btn setTitle:titleStr forState:UIControlStateNormal];
            [btn setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
            [btn setTitleColor:UIColor.redColor forState:UIControlStateSelected];
            if (i == 0) {
                btn.selected = true;
                self.nowSelectedNavigationBtn = btn;
            }
            else {
                btn.selected = false;
            }
            [btn setTitle:titleStr forState:UIControlStateSelected];
            	
            [_navigationBtnArr addObject:btn];
        }
        self.navigationBarBottomLineView = [[UIView alloc] initWithFrame:CGRectMake(20, 45, btnWidth, 5)];
        self.navigationBarBottomLineView.backgroundColor = UIColor.redColor;
        [self.navigationBarView addSubview:self.navigationBarBottomLineView];
    }
    return _navigationBtnArr;
}

- (NSArray *)navigationtitleArr {
    if (_navigationtitleArr == nil) {
        _navigationtitleArr = @[@"直播",@"热门",@"番剧",@"影视",@"萌宠"];
    }
    return _navigationtitleArr;
}

@end
