//
//  LQChooseIPArrayModel.m
//  朝阳能源结算
//
//  Created by admin on 15/10/13.
//  Copyright © 2015年 dieshang. All rights reserved.
//

#import "LQChooseIPArrayModel.h"

@implementation LQChooseIPArrayModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"chooseIPArray":@"data"};
}

+ (NSDictionary *)objectClassInArray
{
    return @{@"chooseIPArray":@"LQChooseIPModel"};
}

@end
