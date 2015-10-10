//
//  LQPostPaidNotCheckBillDataModel.m
//  朝阳能源结算
//
//  Created by admin on 15/10/10.
//  Copyright © 2015年 dieshang. All rights reserved.
//

#import "LQPostPaidNotCheckBillsDataModel.h"

@implementation LQPostPaidNotCheckBillsDataModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"returns":@"state.return",
             @"info":@"state.info",
             @"code":@"state.code",
             @"billsArray":@"data"};
}

+ (NSDictionary *)objectClassInArray
{
    return @{@"billsArray":@"LQPostPaidNotCheckBillsModel"};
}

@end
