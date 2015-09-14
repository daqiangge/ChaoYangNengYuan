//
//  Regex.m
//  GOBO
//
//  Created by admin on 14/11/12.
//  Copyright (c) 2014年 蝶尚软件. All rights reserved.
//

#import "Regex.h"

#define NON_Chinese_RE @"[\u4e00-\u9fa5]+"//判断中文
#define Number_RE      @"[0-9]+"//判断数字
#define IPAndURL @"^((25[0-5])|(2[0-4]\\d)|(1\\d\\d)|([1-9]\\d)|\\d)(\\.((25[0-5])|(2[0-4]\\d)|(1\\d\\d)|([1-9]\\d)|\\d)){3}$|^([a-zA-Z0-9]([a-zA-Z0-9\\-]{0,61}[a-zA-Z0-9])?\\.)+[a-zA-Z]{2,6}$"
#define EMAIL_RE  @"^(([a-zA-Z0-9]+([._\\-]*[a-zA-Z0-9])*@([a-zA-Z0-9]+[-a-zA-Z0-9]*[a-zA-Z0-9]+\\.){1,63}[a-zA-Z0-9]+)|.{0})$"//邮箱的判断
#define TelNum_RE @"^(((\\+?\\d{1,20})|(\\d{3}-\\d{8}|\\d{4}-\\d{7,8}))|.{0})$"//联系电话可以填写座机或手机
#define ContactSettingViewTel_RE @"[0-9]|-"
#define NumberAndEnglishLetters @"^[A-Za-z0-9_\\-]+$"
#define SMTP      @"^((([0-9a-z_!~*''()-]+.)?([0-9a-z][0-9a-z-]{0,61})?[0-9a-z].[a-z]{2,6})|.{0})$"
#define USERNAME  @"^[0-9A-Za-z_]+$"
#define ConnName @"[^<>?\":|*\\\\]"
#define FromURL @"^(((\\/(([^\\/\\s][^\\/]*[^\\/\\s])|([^\\/\\s]+)))+\\/?)|.{0})$"


static Regex *sigleton = nil;

@implementation Regex

+ (Regex *)shareInstance {
    if (sigleton == nil) {
        @synchronized(self){
            sigleton = [[Regex alloc] init];
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



#pragma mark - 正则判断
- (BOOL)judgeText:(NSString *)text Regex:(NSString *)RE
{
    //正则表达式判断IP地址是否符合规范
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:RE options:0 error:&error];
    
    NSTextCheckingResult *firstMatch = [regex firstMatchInString:text options:0 range:NSMakeRange(0, [text length])];
    NSTextCheckingResult *secondMatch = [regex firstMatchInString:text options:0 range:NSMakeRange(0, [text length])];
    if (firstMatch || secondMatch) {
        return YES;
    }else{
        return NO;
    }
}

//判断是否是中文
- (BOOL)judgeChinese:(NSString *)string
{
    if ([self judgeText:string Regex:NON_Chinese_RE]) {
        return YES;
    }else {
        return NO;
    }
}

//判读是否为数字
- (BOOL)judgeNumber:(NSString *)string
{
    if ([self judgeText:string Regex:Number_RE]) {
        return YES;
    }else {
        return NO;
    }
}


//用于判断不能出现中文,用于自定义弹出框
- (BOOL)judgeNonChinese:(NSString *)string CustomAlterView:(NSString *)alterViewTitle
{
    if ([self judgeText:string Regex:NON_Chinese_RE]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:alterViewTitle delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return NO;
    }else {
        return YES;
    }
}

//判断IP和域名
- (BOOL)judgeIPAndURL:(NSString *)string
{
    
    if ([self judgeText:string Regex:IPAndURL]) {
        return YES;
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的服务器地址" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
}

//邮箱的判断
- (BOOL)judgeEmail:(NSString *)email
{
    if ([self judgeText:email Regex:EMAIL_RE]) {
        return YES;
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的邮箱" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
}

//判断SMTP
- (BOOL)judgeSmtp:(NSString *)smtp
{
    if ([self judgeText:smtp Regex:SMTP]) {
        return YES;
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的Smtp地址" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
}

//判断用户名格式
- (BOOL)judgeUserName:(NSString *)username
{
    if ([self judgeText:username Regex:USERNAME]) {
        return YES;
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的用户名" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
}

//联系电话可以填写座机或手机
- (BOOL)judgeTelNumAndLandlineNum:(NSString *)TelNum
{
    if ([self judgeText:TelNum Regex:TelNum_RE]) {
        return YES;
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的电话号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
}

//修改联系方式的号码控制
- (BOOL)judgeContactSettingViewTel:(NSString *)string
{
    
    if ([self judgeText:string Regex:ContactSettingViewTel_RE]) {
        return YES;
    }else {
        return NO;
    }
}

//判读是否为数字+字母+下划线+减号
- (BOOL)judgeNumberAndEnglishLtters:(NSString *)string
{
    if ([self judgeText:string Regex:NumberAndEnglishLetters]) {
        return YES;
    }else {
        return NO;
    }
}

//判断是否为整形：
- (BOOL)isPureInt:(NSString*)string
{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return[scan scanInt:&val] && [scan isAtEnd];
    
}

//判断是否为浮点形：
- (BOOL)isPureFloat:(NSString*)string
{
    for (int i = 0; i<[string length]; i++) {
        //截取字符串中的每一个字符
        NSString *s = [string substringWithRange:NSMakeRange(i, 1)];
        if (i == 0) {
            
            if ([s isEqualToString:@"."]) {
                return NO;
            }
            
        }else if (i == [string length]-1){
            
            if ([s isEqualToString:@"."]) {
                return NO;
            }
            
        }
    }
    
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    float val;
    
    return[scan scanFloat:&val] && [scan isAtEnd];
    
}

//判断是否为bool型（数字+true+false）
- (BOOL)isPureBool:(NSString *)string
{
    BOOL result1 = [string caseInsensitiveCompare:@"true"]  == NSOrderedSame;
    BOOL result2 = [string caseInsensitiveCompare:@"false"] == NSOrderedSame;
    if (result1 || result2) {
        return YES;
    }else if ([self judgeText:string Regex:Number_RE]) {
        return YES;
    }else {
        return NO;
    }
}

//判断修改数据连接池中的连接名称
- (BOOL)judgeConnName:(NSString *)string
{
    if ([self judgeText:string Regex:ConnName]) {
        return YES;
    }else {
        return NO;
    }
}

//判断代理标记
- (BOOL)judgeFromURL:(NSString *)string
{
    
    if ([self judgeText:string Regex:FromURL]) {
        return YES;
    }else {
        return NO;
    }
}

//判断过滤器名称
- (BOOL)judgeFilterName:(NSString *)string
{
    return [self judgeFromURL:string];
}

@end
