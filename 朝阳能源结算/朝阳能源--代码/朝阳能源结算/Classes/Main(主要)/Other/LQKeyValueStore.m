//
//  LQKeyValueStore.m
//  朝阳能源结算
//
//  Created by admin on 15/9/21.
//  Copyright © 2015年 dieshang. All rights reserved.
//

#import "LQKeyValueStore.h"

static LQKeyValueStore *sigleton = nil;

@implementation LQKeyValueStore

+ (LQKeyValueStore *)shareInstance {
    if (sigleton == nil) {
        @synchronized(self){
            sigleton = [[LQKeyValueStore alloc] init];
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

#pragma mark -
- (YTKKeyValueStore *)keyValueStore
{
    if (!_keyValueStore)
    {
        _keyValueStore = [[YTKKeyValueStore alloc] initDBWithName:SQL_Name];
    }
    
    return _keyValueStore;
}

@end
