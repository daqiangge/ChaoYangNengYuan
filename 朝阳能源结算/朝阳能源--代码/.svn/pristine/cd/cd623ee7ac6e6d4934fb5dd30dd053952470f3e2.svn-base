//
//  Regex.h
//  GOBO
//
//  Created by admin on 14/11/12.
//  Copyright (c) 2014年 蝶尚软件. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Regex : NSObject

+ (Regex *)shareInstance;//实例化--单例模式

//用于判断不能出现中文,用于自定义弹出框
- (BOOL)judgeNonChinese:(NSString *)string CustomAlterView:(NSString *)alterViewTitle;

//判断是否是中文
- (BOOL)judgeChinese:(NSString *)string;

//判读是否为数字
- (BOOL)judgeNumber:(NSString *)string;

//判断IP和域名
- (BOOL)judgeIPAndURL:(NSString *)string;

//邮箱的判断
- (BOOL)judgeEmail:(NSString *)email;

//联系电话可以填写座机或手机
- (BOOL)judgeTelNumAndLandlineNum:(NSString *)TelNum;

//修改联系方式的号码控制
- (BOOL)judgeContactSettingViewTel:(NSString *)string;

//判读是否为数字+字母
- (BOOL)judgeNumberAndEnglishLtters:(NSString *)string;

//判断是否为整形：
- (BOOL)isPureInt:(NSString*)string;

//判断是否为浮点形：
- (BOOL)isPureFloat:(NSString*)string;

//判断是否为bool型（数字+true+false）
- (BOOL)isPureBool:(NSString *)string;

//判断SMTP
- (BOOL)judgeSmtp:(NSString *)smtp;

//判断用户名格式
- (BOOL)judgeUserName:(NSString *)username;

//判断修改数据连接池中的连接名称
- (BOOL)judgeConnName:(NSString *)string;

//判断过滤器名称
- (BOOL)judgeFilterName:(NSString *)string;

//判断代理标记
- (BOOL)judgeFromURL:(NSString *)string;

@end
