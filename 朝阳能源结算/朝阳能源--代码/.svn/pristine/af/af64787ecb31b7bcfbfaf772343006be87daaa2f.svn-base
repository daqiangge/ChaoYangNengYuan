//
//  LQYearAnalysisView.m
//  朝阳能源结算
//
//  Created by admin on 15/8/14.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQYearAnalysisView.h"
#import "LQChartView.h"

@implementation LQYearAnalysisView

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
    LQChartView *chartView = [LQChartView chartViewWithFrame:CGRectMake(0, 0, LQScreen_Width, 180)];
    [self addSubview:chartView];
}

@end
