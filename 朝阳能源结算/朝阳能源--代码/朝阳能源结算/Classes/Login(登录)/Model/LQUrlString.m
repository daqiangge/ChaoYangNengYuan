//
//  LQUrlString.m
//  朝阳能源结算
//
//  Created by admin on 15/10/14.
//  Copyright © 2015年 dieshang. All rights reserved.
//

#import "LQUrlString.h"

static LQUrlString *sigleton = nil;

@implementation LQUrlString

+ (LQUrlString *)shareInstance {
    if (sigleton == nil) {
        @synchronized(self){
            sigleton = [[LQUrlString alloc] init];
        }
    }
    return sigleton;
}

- (id)init {
    self = [super init];
    
    if (self) {
        //初始化一些参数
    }
    
    return self;
}

//限制当前对象创建多实例
#pragma mark - sengleton setting
+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (sigleton == nil) {
            sigleton = [super allocWithZone:zone];
        }
    }
    return sigleton;
}

+ (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (NSString *)urlStr
{
    NSDictionary *dic       = [[LQKeyValueStore shareInstance].keyValueStore getObjectById:SQL_IP_Key fromTable:SQL_Account_TableName];
    NSString *name = dic[@"name"];
    NSString *accountid = dic[@"accountid"];
    
    _urlStr = [NSString stringWithFormat:@"%@/%@/energy/do/chargeapp/%@/",IP,name,accountid];
    
    return _urlStr;
}

@end
