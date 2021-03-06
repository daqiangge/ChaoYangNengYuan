//
//  LQAnalyzeForMonthsUseModel.m
//  朝阳能源结算
//
//  Created by admin on 15/9/22.
//  Copyright © 2015年 dieshang. All rights reserved.
//

#import "LQAnalyzeForMonthsUseModel.h"

@implementation LQAnalyzeForMonthsUseModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"returns":@"state.return",
             @"info":@"state.info",
             @"code":@"state.code",
             @"items":@"data.items",
             @"monthrecvalue":@"data.total.monthrecvalue"};
}

+ (NSDictionary *)objectClassInArray
{
    return @{@"items":@"LQAnalyzeForMonthsUseItemModel"};
}

@end
