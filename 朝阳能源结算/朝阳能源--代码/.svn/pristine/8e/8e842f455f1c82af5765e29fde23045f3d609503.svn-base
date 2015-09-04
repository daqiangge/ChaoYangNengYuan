//
//  LQPaidChargeModel.m
//  朝阳能源结算
//
//  Created by admin on 15/9/4.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQPaidChargeModel.h"

@implementation LQPaidChargeModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"returns":@"state.return",
             @"info":@"state.info",
             @"code":@"state.code",
             @"items":@"data.items"};
}

+ (NSDictionary *)objectClassInArray
{
    return @{@"items":@"LQPaidChargeItemsModel"};
}

@end
