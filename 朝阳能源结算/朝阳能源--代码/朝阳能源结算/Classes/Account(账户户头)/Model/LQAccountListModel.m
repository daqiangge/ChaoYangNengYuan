//
//  LQAccountListModel.m
//  朝阳能源结算
//
//  Created by admin on 15/9/1.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQAccountListModel.h"

@implementation LQAccountListModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"returns":@"state.return",
             @"info":@"state.info",
             @"code":@"state.code"};
}

@end
