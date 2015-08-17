//
//  LQRechargeRecordHeaderView.m
//  朝阳能源结算
//
//  Created by admin on 15/8/17.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQRechargeRecordHeaderView.h"

@interface LQRechargeRecordHeaderView()

/**
 *  日期
 */
@property (nonatomic, weak) UILabel *dateLabel;

/**
 *  充值金额
 */
@property (nonatomic, weak) UILabel *rechargeMoneyLabel;

/**
 *  冲前剩余
 */
@property (nonatomic, weak) UILabel *beforeMoneyLabel;

/**
 *  冲后剩余
 */
@property (nonatomic, weak) UILabel *afterMoneyLabel;

/**
 *  充值方式
 */
@property (nonatomic, weak) UILabel *rechargeWayLable;

@end


@implementation LQRechargeRecordHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self doLoading];
    }
    
    return self;
}

- (UILabel *)dateLabel
{
    if (_dateLabel == nil)
    {
        CGFloat x = 10;
        CGFloat y = 10;
        CGFloat width = 70;
        CGFloat height = self.height - 1.5*y;
        CGRect frame = CGRectMake(x, y, width, height);
        
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = frame;
        lable.font = [UIFont systemFontOfSize:12];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = [UIColor blackColor];
        lable.backgroundColor = RGB(236, 236, 236);
        [self addSubview:lable];
        
        _dateLabel = lable;
    }
    
    return _dateLabel;
}

- (UILabel *)rechargeMoneyLabel
{
    if (_rechargeMoneyLabel == nil)
    {
        CGFloat x = CGRectGetMaxX(self.dateLabel.frame);
        CGFloat y = CGRectGetMinY(self.dateLabel.frame);
        CGFloat width = LQScreen_Width * 0.5 - x - self.rechargeWayLable.width * 0.5;
        CGFloat height = self.dateLabel.height;
        CGRect frame = CGRectMake(x, y, width, height);
        
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = frame;
        lable.font = self.dateLabel.font;
        lable.textAlignment = NSTextAlignmentCenter;
        lable.backgroundColor = self.dateLabel.backgroundColor;
        [self addSubview:lable];
        
        _rechargeMoneyLabel = lable;
    }
    
    return _rechargeMoneyLabel;
}

- (UILabel *)rechargeWayLable
{
    if (_rechargeWayLable == nil)
    {
        CGFloat width = 30;
        CGFloat height = self.dateLabel.height;
        CGFloat x = LQScreen_Width * 0.5 - width * 0.5;
        CGFloat y = CGRectGetMinY(self.dateLabel.frame);
        CGRect frame = CGRectMake(x, y, width, height);
        
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = frame;
        lable.font = self.dateLabel.font;
        lable.textColor = [UIColor blackColor];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.backgroundColor = self.dateLabel.backgroundColor;
        [self addSubview:lable];
        
        _rechargeWayLable = lable;
    }
    
    return _rechargeWayLable;
}

- (UILabel *)beforeMoneyLabel
{
    if (_beforeMoneyLabel == nil)
    {
        CGFloat x = CGRectGetMaxX(self.rechargeWayLable.frame);
        CGFloat y = CGRectGetMinY(self.dateLabel.frame);
        CGFloat width = (LQScreen_Width - CGRectGetMaxX(self.rechargeWayLable.frame) - 10)/2;
        CGFloat height = self.dateLabel.height;
        CGRect frame = CGRectMake(x, y, width, height);
        
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = frame;
        lable.font = self.dateLabel.font;
        lable.textColor = [UIColor blackColor];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.backgroundColor = self.dateLabel.backgroundColor;
        [self addSubview:lable];
        
        _beforeMoneyLabel = lable;
    }
    
    return _beforeMoneyLabel;
}

- (UILabel *)afterMoneyLabel
{
    if (_afterMoneyLabel == nil)
    {
        CGFloat x = CGRectGetMaxX(self.beforeMoneyLabel.frame);
        CGFloat y = CGRectGetMinY(self.dateLabel.frame);
        CGFloat width = (LQScreen_Width - 20)/5;
        CGFloat height = self.dateLabel.height;
        CGRect frame = CGRectMake(x, y, width, height);
        
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = frame;
        lable.font = self.dateLabel.font;
        lable.textColor = [UIColor blackColor];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.backgroundColor = self.dateLabel.backgroundColor;
        [self addSubview:lable];
        
        _afterMoneyLabel = lable;
    }
    
    return _afterMoneyLabel;
}

- (void)doLoading
{
    self.dateLabel.text = @"日期";
    self.rechargeMoneyLabel.text = @"金额";
    self.rechargeWayLable.text = @"方式";
    self.beforeMoneyLabel.text = @"充前剩余";
    self.afterMoneyLabel.text = @"充后剩余";
}

@end
