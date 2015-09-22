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
    return @{@"items":@"data.items"};
}

+ (NSDictionary *)objectClassInArray
{
    return @{@"items":@"LQAnalyzeForMonthsUseItemModel"};
}

@end
