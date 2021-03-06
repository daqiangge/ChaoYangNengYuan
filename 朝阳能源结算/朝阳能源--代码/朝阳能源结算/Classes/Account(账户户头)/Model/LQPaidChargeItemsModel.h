//
//  LQPaidChargeItemsModel.h
//  朝阳能源结算
//
//  Created by admin on 15/9/4.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQPaidChargeItemsModel : NSObject

@property (nonatomic, copy) NSString *note;

/**
 *  单价
 */
@property (nonatomic, copy) NSString *price;

/**
 *  结束日期
 */
@property (nonatomic, copy) NSString *enddatetime;

/**
 *  开始日期
 */
@property (nonatomic, copy) NSString *begindatetime;

/**
 *  帐期
 */
@property (nonatomic, copy) NSString *accountperiod;

/**
 *  日期
 */
@property (nonatomic, copy) NSString *operatdatetime;

/**
 *  金额
 */
@property (nonatomic, copy) NSString *moneyofamount;

/**
 *  充值前剩余金额
 */
@property (nonatomic, copy) NSString *chargebefmoney;

/**
 *  充值后剩余金额
 */
@property (nonatomic, copy) NSString *chargeaftmoney;

/**
 *  充值前剩余电量
 */
@property (nonatomic, copy) NSString *chargebefvalue;

/**
 *  充值后剩余电量
 */
@property (nonatomic, copy) NSString *chargeaftvalue;

/**
 *  动作类型(1:开户结算; 2:在线充值; 3:在线退费; 4:离线充值; 5:离线退费; 6:撤销充值; 7:自助充值)
 */
@property (nonatomic, assign) int actiontype;

/**
 *   初始值(账单记录)
 */
@property (nonatomic, copy) NSString *initializevalues;

/**
 *   结束值(账单记录)
 */
@property (nonatomic, copy) NSString *endvalues;

/**
 *  是否已结(-1:无状态; 0:未结; 1:已结; 2:反结)
 */
@property (nonatomic, assign) int isover;

@end
