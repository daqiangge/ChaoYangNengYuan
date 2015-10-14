//
//  LQUrlString.h
//  朝阳能源结算
//
//  Created by admin on 15/10/14.
//  Copyright © 2015年 dieshang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQUrlString : NSObject

@property (nonatomic, copy) NSString *urlStr;

+ (LQUrlString *)shareInstance;//实例化--单例模式

@end
