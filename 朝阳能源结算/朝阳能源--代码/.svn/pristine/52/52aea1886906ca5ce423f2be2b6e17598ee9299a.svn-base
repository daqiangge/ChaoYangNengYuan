//
//  LQCalendarFooterView.m
//  朝阳能源结算
//
//  Created by admin on 15/8/13.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQCalendarFooterView.h"

@implementation LQCalendarFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self doLoading];
    }
    
    return self;
}

- (void)doLoading
{
    UILabel *lable1 = [[UILabel alloc] init];
    lable1.text = @"本月使用：2333.99吨";
    lable1.font = [UIFont systemFontOfSize:15];
    lable1.textColor = [UIColor blackColor];
    [self addSubview:lable1];
    [lable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(20);
        make.top.and.bottom.equalTo(self);
        make.width.equalTo(@180);
    }];
}



@end
