//
//  LQAccountItemModel.h
//  朝阳能源结算
//
//  Created by admin on 15/9/2.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQAccountItemModel : NSObject

@property (nonatomic, copy) NSString *metermodelid;
@property (nonatomic, copy) NSString *accountcode;
@property (nonatomic, copy) NSString *linkaddress;
@property (nonatomic, copy) NSString *epropid;
@property (nonatomic, assign) int rechmodle;
@property (nonatomic, copy) NSString *monthrecvalues;
@property (nonatomic, copy) NSString *yearrecvalues;
@property (nonatomic, copy) NSString *isfreezes;
@property (nonatomic, copy) NSString *etypename;
@property (nonatomic, copy) NSString *etypecode;
@property (nonatomic, copy) NSString *eunit;
@property (nonatomic, copy) NSString *accountid;
@property (nonatomic, copy) NSString *metermodel;
@property (nonatomic, copy) NSString *runstate;
@property (nonatomic, copy) NSString *meterno;
@property (nonatomic, copy) NSString *meterid;
@property (nonatomic, copy) NSString *currentamount;
@property (nonatomic, copy) NSString *surplusamount;

@end
