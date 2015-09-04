//
//  LQPaidChargeModel.h
//  朝阳能源结算
//
//  Created by admin on 15/9/4.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQPaidChargeModel : NSObject

@property (nonatomic, assign) BOOL returns;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *code;

@property (nonatomic, strong) NSArray *items;

@end
