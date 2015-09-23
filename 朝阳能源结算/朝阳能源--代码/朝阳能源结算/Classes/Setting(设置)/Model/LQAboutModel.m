//
//  LQAboutModel.m
//  朝阳能源结算
//
//  Created by admin on 15/9/23.
//  Copyright © 2015年 dieshang. All rights reserved.
//

#import "LQAboutModel.h"

@implementation LQAboutModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"returns":@"state.return",
             @"info":@"state.info",
             @"code":@"state.code",
             @"copyright":@"data.copyright",
             @"contact":@"data.contact",
             @"email":@"data.email",
             @"technicalsupport":@"data.technicalsupport"};
}

@end
