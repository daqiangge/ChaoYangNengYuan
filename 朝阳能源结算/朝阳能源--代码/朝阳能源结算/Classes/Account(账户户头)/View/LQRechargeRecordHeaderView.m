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
        UILabel *lable = [[UILabel alloc] init];
        lable.font = [UIFont systemFontOfSize:12];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = [UIColor blackColor];
        lable.backgroundColor = RGB(236, 236, 236);
        [self addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(10);
            make.top.equalTo(self.mas_top).with.offset(5);
            make.bottom.equalTo(self.mas_bottom).with.offset(-5);
            make.width.equalTo(@70);
        }];
        
        _dateLabel = lable;
    }
    
    return _dateLabel;
}

- (UILabel *)rechargeMoneyLabel
{
    if (_rechargeMoneyLabel == nil)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.font = self.dateLabel.font;
        lable.textAlignment = NSTextAlignmentCenter;
        lable.backgroundColor = self.dateLabel.backgroundColor;
        [self addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.dateLabel.mas_right);
            make.right.equalTo(self.rechargeWayLable.mas_left);
            make.top.equalTo(self.dateLabel.mas_top);
            make.bottom.equalTo(self.dateLabel.mas_bottom);
        }];
        
        _rechargeMoneyLabel = lable;
    }
    
    return _rechargeMoneyLabel;
}

- (UILabel *)rechargeWayLable
{
    if (_rechargeWayLable == nil)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.font = self.dateLabel.font;
        lable.textColor = [UIColor blackColor];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.backgroundColor = self.dateLabel.backgroundColor;
        [self addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.dateLabel.mas_top);
            make.bottom.equalTo(self.dateLabel.mas_bottom);
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(@55);
        }];
        
        _rechargeWayLable = lable;
    }
    
    return _rechargeWayLable;
}

- (UILabel *)beforeMoneyLabel
{
    if (_beforeMoneyLabel == nil)
    {
        UILabel *lable = [[UILabel alloc] init];
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
        
        UILabel *lable = [[UILabel alloc] init];
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
    
    [self.beforeMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rechargeWayLable.mas_right);
        make.right.equalTo(self.afterMoneyLabel.mas_left);
        make.top.equalTo(self.dateLabel.mas_top);
        make.bottom.equalTo(self.dateLabel.mas_bottom);
        make.width.equalTo(self.afterMoneyLabel);
    }];
    
    [self.afterMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.top.equalTo(self.dateLabel.mas_top);
        make.bottom.equalTo(self.dateLabel.mas_bottom);
        make.left.equalTo(self.beforeMoneyLabel.mas_right);
        make.width.equalTo(self.beforeMoneyLabel);
    }];
}

@end
