//
//  LQAccountBillView.h
//  朝阳能源结算
//
//  Created by admin on 15/8/11.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LQAccountItemModel;

@interface LQAccountBillView : UIView

+ (instancetype)accountBillViewWithFrame:(CGRect)frame accountID:(NSString *)accountID accountItemModel:(LQAccountItemModel *)accountItemModel;

@end
