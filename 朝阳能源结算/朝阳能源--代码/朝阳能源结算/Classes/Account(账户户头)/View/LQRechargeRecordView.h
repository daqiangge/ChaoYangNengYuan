//
//  LQRechargeRecordView.h
//  朝阳能源结算
//
//  Created by admin on 15/9/4.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-----------------------充值/账单记录模块---------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------

#import <UIKit/UIKit.h>

@class LQAccountItemModel;

@interface LQRechargeRecordView : UIView

+ (instancetype)rechargeRecordViewWithFrame:(CGRect)frame accountid:(NSString *)accountid sessionid:(NSString *)sessionid accountItemModel:(LQAccountItemModel *)accountItemModel;

@end
