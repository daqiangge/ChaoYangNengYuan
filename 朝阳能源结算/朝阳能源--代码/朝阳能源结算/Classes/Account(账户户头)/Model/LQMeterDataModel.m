//
//  LQMeterDataModel.m
//  朝阳能源结算
//
//  Created by admin on 15/9/2.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQMeterDataModel.h"

@implementation LQMeterDataModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"returns":@"state.return",
             @"info":@"state.info",
             @"code":@"state.code",
             @"surplusamount":@"data.meterdata.surplusamount",
             @"currentamount":@"data.meterdata.currentamount",
             @"price":@"data.meterdata.price",
             @"surplusmoney":@"data.meterdata.surplusmoney"};
}

@end
