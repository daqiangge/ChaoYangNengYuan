//
//  LQYearAnalysisView.m
//  朝阳能源结算
//
//  Created by admin on 15/8/14.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQYearAnalysisView.h"
#import "LQChartView.h"
#import "LQEveryYearUesView.h"
#import "LQChooseYearBtnGroup.h"


@interface LQYearAnalysisView()<LQChooseYearBtnGroupDelegate>

@property (nonatomic, weak) UIScrollView *scrollview;

@end

@implementation LQYearAnalysisView

- (UIScrollView *)scrollview
{
    if (_scrollview == nil)
    {
        UIScrollView *scrollview = [[UIScrollView alloc] init];
        scrollview.contentSize = CGSizeMake(LQScreen_Width, BtnGroupView_Height+ChartView_Height+EveryYearUseView_Height+10);
        [self addSubview:scrollview];
        
        [scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.and.right.equalTo(self);
        }];
        
        _scrollview = scrollview;
    }
    
    return _scrollview;
}

+ (instancetype)yearAnalysisViewWithFrame:(CGRect)frame
{
    return [[self alloc] initWithFrame:frame];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self doLoading];
    }
    
    return self;
}

- (void)doLoading
{
    LQChooseYearBtnGroup *btnGroupView = [LQChooseYearBtnGroup chooseYearBtnGroupWithFrame:CGRectMake(0, 0, LQScreen_Width, BtnGroupView_Height)];
    btnGroupView.delegate = self;
    [self.scrollview addSubview:btnGroupView];
    
    LQChartView *chartView = [LQChartView chartViewWithFrame:CGRectMake(0, BtnGroupView_Height, LQScreen_Width, ChartView_Height)];
    [self.scrollview addSubview:chartView];
    
    LQEveryYearUesView *everyYearUseView = [LQEveryYearUesView everyYearUesViewWithFrame:CGRectMake(0, CGRectGetMaxY(chartView.frame), LQScreen_Width, EveryYearUseView_Height)];
    [self.scrollview addSubview:everyYearUseView];
}

#pragma mark - LQChooseYearBtnGroupDelegate
- (void)chooseYearBtnGroupDidClickBtnWithView:(LQChooseYearBtnGroup *)view button:(UIButton *)btn
{
    
}

@end
