//
//  LQMonthAnalysisView.h
//  朝阳能源结算
//
//  Created by admin on 15/8/17.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LQAccountItemModel;

@class LQMonthAnalysisView;

@protocol LQMonthAnalysisViewDelegate <NSObject>

- (void)showAccountTimeOutAlterViewWithMonthAnalysisView:(LQMonthAnalysisView *)view;
- (void)showOtherRequestReturnFalseAlterViewWithMonthAnalysisView:(LQMonthAnalysisView *)view message:(NSString *)message;

@end

@interface LQMonthAnalysisView : UIView

@property (nonatomic, weak) id<LQMonthAnalysisViewDelegate> delegate;

+ (instancetype)monthAnalysisViewWithFrame:(CGRect)frame accountItemModel:(LQAccountItemModel *)accountItemModel;

@end
