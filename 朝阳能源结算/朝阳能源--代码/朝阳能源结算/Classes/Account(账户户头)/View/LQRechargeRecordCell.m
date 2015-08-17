//
//  LQRechargeRecordCell.m
//  朝阳能源结算
//
//  Created by admin on 15/8/17.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQRechargeRecordCell.h"

@implementation LQRechargeRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
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
        CGFloat y = 0;
        CGFloat width = 70;
        CGFloat height = Cell_Height;
        CGRect frame = CGRectMake(x, y, width, height);
        
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = frame;
        lable.font = [UIFont systemFontOfSize:12];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = [UIColor blackColor];
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
        CGFloat height = Cell_Height;
        CGRect frame = CGRectMake(x, y, width, height);
        
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = frame;
        lable.font = [UIFont boldSystemFontOfSize:12];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = [UIColor blueColor];
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
        CGFloat height = Cell_Height;
        CGFloat x = LQScreen_Width * 0.5 - width * 0.5;
        CGFloat y = CGRectGetMinY(self.dateLabel.frame);
        CGRect frame = CGRectMake(x, y, width, height);
        
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = frame;
        lable.font = self.dateLabel.font;
        lable.textColor = [UIColor blackColor];
        lable.textAlignment = NSTextAlignmentCenter;
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
        CGFloat height = Cell_Height;
        CGRect frame = CGRectMake(x, y, width, height);
        
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = frame;
        lable.font = self.dateLabel.font;
        lable.textColor = [UIColor blackColor];
        lable.textAlignment = NSTextAlignmentCenter;
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
        CGFloat height = Cell_Height;
        CGRect frame = CGRectMake(x, y, width, height);
        
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = frame;
        lable.font = self.dateLabel.font;
        lable.textColor = [UIColor blackColor];
        lable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lable];
        
        _afterMoneyLabel = lable;
    }
    
    return _afterMoneyLabel;
}

- (void)doLoading
{
    self.dateLabel.text = @"2015-07-10";
    self.rechargeMoneyLabel.text = @"￥100.00";
    self.rechargeWayLable.text = @"自助";
    self.beforeMoneyLabel.text = @"23.00元";
    self.afterMoneyLabel.text = @"123.00元";
}

@end
