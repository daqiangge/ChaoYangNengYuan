//
//  LQRechargeRecordView.h
//  朝阳能源结算
//
//  Created by admin on 15/9/4.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQRechargeRecordView : UIView

+ (instancetype)rechargeRecordViewWithFrame:(CGRect)frame accountid:(NSString *)accountid sessionid:(NSString *)sessionid rechmodle:(int)rechmodle unit:(NSString *)unit;

@end
