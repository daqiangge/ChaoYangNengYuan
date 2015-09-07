//
//  LQBillsCell.m
//  朝阳能源结算
//
//  Created by admin on 15/9/7.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQBillsCell.h"

#define Label_Height 12
#define Label_Font ([UIFont systemFontOfSize:Label_Height])

@interface LQBillsCell()

/**
 *  账期
 */
@property (nonatomic, weak) UILabel *accountperiodLable;

/**
 *  范围
 */
@property (nonatomic, weak) UILabel *rangeLable;

/**
 *  金额
 */
@property (nonatomic, weak) UILabel *moneyofamountLable;

/**
 *  结算按钮
 
 */
@property (nonatomic, weak) UIButton *settlementBtn;

/**
 *  note
 */
@property (nonatomic, weak) UILabel *noteLable;

@property (nonatomic, copy) NSString *unit;

@end

@implementation LQBillsCell

+ (instancetype)cellWithTableView:(UITableView *)tableView  cellForRowAtIndexPath:(NSIndexPath *)indexPath unit:(NSString *)unit
{
    static NSString *idenifier = @"LQBillsCell";
    LQBillsCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier unit:unit];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier unit:(NSString *)unit
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.unit = unit;
        self.settlementBtn.hidden = NO;
        self.accountperiodLable.text = @"1";
        self.moneyofamountLable.text = @"99999999元";
        self.rangeLable.text = @"2019-12-12～2013-12-32";
    }
    
    return self;
}

- (UILabel *)accountperiodLable
{
    if (!_accountperiodLable)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.font = Label_Font;
        lable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(10);
            make.top.equalTo(self.mas_top).with.offset((30-Label_Height)*0.5);
            make.size.mas_equalTo(CGSizeMake(35, Label_Height));
        }];
        
        _accountperiodLable = lable;
    }
    
    return _accountperiodLable;
}

- (UILabel *)rangeLable
{
    if (!_rangeLable)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.font = Label_Font;
        lable.textColor = [UIColor blueColor];
        lable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.accountperiodLable.mas_top);
            make.left.equalTo(self.accountperiodLable.mas_right).with.offset(2);
            make.right.equalTo(self.moneyofamountLable.mas_left).with.offset(-2);
            make.height.equalTo(self.accountperiodLable.mas_height);
        }];
        
        _rangeLable = lable;
    }
    
    return _rangeLable;
}

- (UILabel *)moneyofamountLable
{
    if (!_moneyofamountLable)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.font = Label_Font;
        lable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.accountperiodLable.mas_top);
            make.right.equalTo(self.settlementBtn.mas_left).with.offset(-2);
            make.height.equalTo(self.accountperiodLable.mas_height);
            make.width.mas_equalTo(70);
        }];
        
        _moneyofamountLable = lable;
    }
    
    return _moneyofamountLable;
}

- (UIButton *)settlementBtn
{
    if (!_settlementBtn)
    {
        UIButton *btn = [[UIButton alloc] init];
        btn.backgroundColor = [UIColor blueColor];
        [btn setTitle:@"结算" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor colorWithHex:@"#3498DB"];
        btn.titleLabel.font = Label_Font;
        [self addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-10);
            make.top.equalTo(self.mas_top).with.offset(5);
            make.bottom.equalTo(self.mas_bottom).with.offset(-5);
            make.width.mas_equalTo(35);
        }];
        
        _settlementBtn = btn;
    }
    
    return _settlementBtn;
}


@end
