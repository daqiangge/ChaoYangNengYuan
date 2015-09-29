//
//  LQOrderVC.h
//  朝阳能源结算
//
//  Created by admin on 15/8/19.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LQOrderModel;
@class LQAccountItemModel;

@interface LQOrderVC : UIViewController

@property (nonatomic, strong) LQOrderModel *orderModel;

@property (nonatomic, strong) LQAccountItemModel *accountItemModel;

@end
