//
//  LQLoginModel.h
//  朝阳能源结算
//
//  Created by admin on 15/9/1.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQLoginModel : NSObject

@property (nonatomic, assign) BOOL returns;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *linkname;
@property (nonatomic, copy) NSString *sessionid;
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *accountamount;
@property (nonatomic, copy) NSString *userphoto;
@property (nonatomic, copy) NSString *linkMobile;//手机号

@end
