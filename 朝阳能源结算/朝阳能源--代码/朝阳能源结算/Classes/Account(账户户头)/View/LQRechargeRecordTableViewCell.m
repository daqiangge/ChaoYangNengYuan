//
//  LQRechargeRecordTableViewCell.m
//  朝阳能源结算
//
//  Created by admin on 15/8/11.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQRechargeRecordTableViewCell.h"

@interface LQRechargeRecordTableViewCell()

@property (nonatomic, weak) UILabel *contentLable;
@property (nonatomic, weak) UILabel *paymentMethodLable;
@property (nonatomic, weak) UILabel *moneyLable;
@property (nonatomic, weak) UILabel *dateLable;

@end

@implementation LQRechargeRecordTableViewCell

- (UILabel *)contentLable
{
    if (_contentLable == nil)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.numberOfLines = 3;
        lable.textColor = [UIColor blackColor];
        lable.font = [UIFont systemFontOfSize:13];
        [self addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(self);
            make.right.equalTo(self.paymentMethodLable.mas_left).with.offset(-10);
            make.left.equalTo(self.mas_left).with.offset(15);
        }];
        
        _contentLable = lable;
        
    }
    
    return _contentLable;
}

- (UILabel *)paymentMethodLable
{
    if (_paymentMethodLable == nil)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.textColor = [UIColor blackColor];
        lable.font = [UIFont systemFontOfSize:13];
        lable.textAlignment = NSTextAlignmentLeft;
        [self addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(10);
            make.right.equalTo(self.moneyLable.mas_left);
            make.size.mas_equalTo(CGSizeMake(30, 14));
        }];
        
        
        _paymentMethodLable = lable;
    }
    
    return _paymentMethodLable;
}

- (UILabel *)moneyLable
{
    if (_moneyLable == nil)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.textColor = RGB(202, 108, 25);
        lable.font = [UIFont systemFontOfSize:13];
        lable.textAlignment = NSTextAlignmentRight;
        [self addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(10);
            make.right.equalTo(self.mas_right).with.offset(-15);
            make.size.mas_equalTo(CGSizeMake(42, 14));
        }];
        
        _moneyLable = lable;
    }
    
    return _moneyLable;
}

- (UILabel *)dateLable
{
    if (_dateLable == nil)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.textColor = [UIColor blackColor];
        lable.font = [UIFont systemFontOfSize:13];
        lable.textAlignment = NSTextAlignmentRight;
        [self addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).with.offset(-10);
            make.right.equalTo(self.mas_right).with.offset(-15);
            make.size.mas_equalTo(CGSizeMake(80, 14));
        }];
        
        _dateLable = lable;
    }
    
    return _dateLable;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self doLoading];
    }
    
    return self;
}

- (void)doLoading
{
    self.contentLable.text =@"充值前示数12.33度，充值前剩余金额23.00元，充值后剩余金额123.00元";
    self.paymentMethodLable.text = @"自助";
    self.moneyLable.text = @"￥100";
    self.dateLable.text = @"2015-07-09";
}

@end
