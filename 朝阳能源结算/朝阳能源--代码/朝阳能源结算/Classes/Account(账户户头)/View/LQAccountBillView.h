//
//  LQAccountBillView.h
//  朝阳能源结算
//
//  Created by admin on 15/8/11.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQRechargeRecordView.h"
#import "LQYearAnalysisView.h"
#import "LQMonthAnalysisView.h"

@class LQAccountItemModel;

@interface LQAccountBillView : UIView

@property (nonatomic, weak  ) LQRechargeRecordView  *rechargeRecordView;
@property (nonatomic, weak  ) LQYearAnalysisView    *yearAnalysisView;
@property (nonatomic, weak  ) LQMonthAnalysisView   *monthAnalysisView;

+ (instancetype)accountBillViewWithFrame:(CGRect)frame accountID:(NSString *)accountID accountItemModel:(LQAccountItemModel *)accountItemModel;

@end
