//
//  LQAccountItemModel.h
//  朝阳能源结算
//
//  Created by admin on 15/9/2.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQAccountItemModel : NSObject

@property (nonatomic, copy  ) NSString *metermodelid;
@property (nonatomic, copy  ) NSString *accountcode;
@property (nonatomic, copy  ) NSString *linkaddress;
@property (nonatomic, copy  ) NSString *epropid;

/**
 *  剩余用量、用能
 */
@property (nonatomic, copy  ) NSString *amountforrecharges;


/**
 *  累计未结金额
 */
@property (nonatomic, copy  ) NSString *moneyofamount;

/**
 *  预付费和后付费判断
 */
@property (nonatomic, assign) int      rechmodle;

/**
 *  本月使用
 */
@property (nonatomic, copy  ) NSString *monthrecvalues;

/**
 *  本年累计
 */
@property (nonatomic, copy  ) NSString *yearrecvalues;

/**
 *  是否冻结(1:未冻结; 2:已冻结)
 */
@property (nonatomic, assign) int      isfreezes;

/**
 *  电水气标识
 */
@property (nonatomic, copy  ) NSString *etypename;

@property (nonatomic, copy  ) NSString *etypecode;
@property (nonatomic, copy  ) NSString *eunit;
@property (nonatomic, copy  ) NSString *accountid;
@property (nonatomic, copy  ) NSString *metermodel;

/**
 *   运行状态(1.正常运行, 2.低量报警, 3.欠费运行, 4.欠费关断, 5.通讯异常)
 */
@property (nonatomic, assign) int      runstate;

/**
 *  表具编号
 */
@property (nonatomic, copy  ) NSString *meterno;

/**
 *  表具ID
 */
@property (nonatomic, copy  ) NSString *meterid;

/**
 *  当前值
 */
@property (nonatomic, copy  ) NSString *currentamount;

/**
 *  剩余值
 */
@property (nonatomic, copy  ) NSString *surplusamount;

/**
 *  剩余金额
 */
@property (nonatomic, copy) NSString *surplusmoney;

/**
 *  单价
 */
@property (nonatomic, copy  ) NSString *price;

/**
 *  判断剩余用量还是剩余金额 1.充用量   2.充金额
 */
@property (nonatomic, assign) int rechargestype;

@end
