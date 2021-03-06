//
//  LQYearAnalysisView.h
//  朝阳能源结算
//
//  Created by admin on 15/8/14.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-----------------------年用能分析模块------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------

#import <UIKit/UIKit.h>

#define ChartView_Height 180
#define BtnGroupView_Height 40

@class LQYearAnalysisView;

@protocol LQYearAnalysisViewDelegate <NSObject>

- (void)showAccountTimeOutAlterViewWithYearAnalysisView:(LQYearAnalysisView *)view;
- (void)showOtherRequestReturnFalseAlterViewWithYearAnalysisView:(LQYearAnalysisView *)view message:(NSString *)message;

@end

@interface LQYearAnalysisView : UIView

@property (nonatomic, weak) id<LQYearAnalysisViewDelegate> delegate;

+ (instancetype)yearAnalysisViewWithFrame:(CGRect)frame accountid:(NSString *)accountid sessionid:(NSString *)sessionid unit:(NSString *)unit;

@end
