//
//  LQAnalyzeForYearUseItemModel.h
//  朝阳能源结算
//
//  Created by admin on 15/9/4.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQAnalyzeForYearUseItemModel : NSObject

@property (nonatomic, copy  ) NSString *accountId;
@property (nonatomic, copy  ) NSString *recvalues;
@property (nonatomic, assign) int      recyear;
@property (nonatomic, assign) int      recmonth;

@end
