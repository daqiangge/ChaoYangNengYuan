//
//  LQMeterDataModel.h
//  朝阳能源结算
//
//  Created by admin on 15/9/2.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQMeterDataModel : NSObject

@property (nonatomic, assign) BOOL returns;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *code;

/**
 *  剩余用量
 */
@property (nonatomic, copy) NSString *surplusamount;

/**
 *  剩余金额
 */
@property (nonatomic, copy) NSString *surplusmoney;

/**
 *  当前示数
 */
@property (nonatomic, copy) NSString *currentamount;

/**
 *  单价
 */
@property (nonatomic, copy  ) NSString *price;

@end
