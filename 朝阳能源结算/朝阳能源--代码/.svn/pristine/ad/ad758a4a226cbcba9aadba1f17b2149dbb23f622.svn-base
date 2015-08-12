//
//  LQAccountDetailsView.m
//  朝阳能源结算
//
//  Created by admin on 15/8/11.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------户头详情界面的上半部分--------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------

#import "LQAccountDetailsView.h"

@interface LQAccountDetailsView()

/**
 *  分割线
 */
@property (nonatomic, weak) UIView *lineView;

/**
 *  冻结提示：“请柜台办理本账户相关业务”
 */
@property (nonatomic, weak) UILabel *frozenPromptLable;

/**
 *  当前示数
 */
@property (nonatomic, weak) UILabel *currentReadingsLable;

/**
 *  本月使用
 */
@property (nonatomic, weak) UILabel *monthUseLable;

/**
 *  本年累计
 */
@property (nonatomic, weak) UILabel *yearCumulativeLable;

/**
 *  表具编号
 */
@property (nonatomic, weak) UILabel *meterNumberLable;

/**
 *  表具型号
 */
@property (nonatomic, weak) UILabel *meterModelLable;

/**
 *  安装地址
 */
@property (nonatomic, weak) UILabel *installationAddressLable;

/**
 *  剩余用量
 */
@property (nonatomic, weak) UILabel *remainingAmountLable;

@end


@implementation LQAccountDetailsView

- (UILabel *)nameLable
{
    if (_nameLable == nil)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.font = [UIFont boldSystemFontOfSize:16];
        lable.textColor = [UIColor blackColor];
        [self addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(15);
            make.top.equalTo(self.mas_top).with.offset(0);
            make.bottom.equalTo(self.lineView.mas_top).with.offset(0);
            make.width.equalTo(@100);
        }];
        
        _nameLable = lable;
    }
    
    return _nameLable;
}

- (UILabel *)accountStateLable
{
    if (_accountStateLable == nil)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.font = [UIFont systemFontOfSize:13];
        lable.textColor = [UIColor whiteColor];
        lable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLable.mas_right).with.offset(0);
            make.centerY.equalTo(self.nameLable.mas_centerY).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(60, 20));
        }];
        
        _accountStateLable = lable;
    }
    
    return _accountStateLable;
}

- (UIButton *)rechargeButton
{
    if (_rechargeButton == nil)
    {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:@"充值" forState:UIControlStateNormal];
        [button setTitleColor:RGB(83, 146, 236) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(recharge:) forControlEvents:UIControlEventTouchUpInside];
        button.hidden = YES;
        [self addSubview:button];
        button.layer.borderColor = button.titleLabel.textColor.CGColor;
        button.layer.borderWidth = 3.0;
        button.layer.cornerRadius = 5;
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-15);
            make.centerY.equalTo(self.nameLable.mas_centerY).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(60, 30));
        }];
        
        _rechargeButton = button;
    }
    
    return _rechargeButton;
}

- (UILabel *)frozenPromptLable
{
    if (_frozenPromptLable == nil)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.font = [UIFont systemFontOfSize:13];
        lable.textAlignment = NSTextAlignmentRight;
        lable.text = @"请柜台办理相关业务";
        lable.hidden = YES;
        [self addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-10);
            make.centerY.equalTo(self.nameLable.mas_centerY).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(180, 30));
        }];
        
        _frozenPromptLable = lable;
    }
    
    return _frozenPromptLable;
}

- (UILabel *)currentReadingsLable
{
    if (_currentReadingsLable == nil)
    {
        UILabel *nameLable = [[UILabel alloc] init];
        nameLable.font = [UIFont systemFontOfSize:13];
        nameLable.textAlignment = NSTextAlignmentLeft;
        nameLable.text = @"当前示数：";
        [self addSubview:nameLable];
        
        [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLable.mas_left).with.offset(0);
            make.top.equalTo(self.lineView.mas_bottom).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(65, 13));
        }];
        
        UILabel *currentReadingsLable = [[UILabel alloc] init];
        currentReadingsLable.font = nameLable.font;
        currentReadingsLable.textAlignment = nameLable.textAlignment;
        [self addSubview:currentReadingsLable];
        
        [currentReadingsLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLable.mas_right).with.offset(0);
            make.centerY.equalTo(nameLable.mas_centerY).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(60, 13));
        }];
        
        _currentReadingsLable = currentReadingsLable;
    }
    
    return _currentReadingsLable;
}

- (UILabel *)monthUseLable
{
    if (_monthUseLable == nil)
    {
        UILabel *nameLable = [[UILabel alloc] init];
        nameLable.font = self.currentReadingsLable.font;
        nameLable.textAlignment = self.currentReadingsLable.textAlignment;
        nameLable.text = @"本月使用：";
        [self addSubview:nameLable];
        
        [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLable.mas_left).with.offset(0);
            make.top.equalTo(self.currentReadingsLable.mas_bottom).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(65, 13));
        }];
        
        UILabel *monthUseLable = [[UILabel alloc] init];
        monthUseLable.font = nameLable.font;
        monthUseLable.textAlignment = nameLable.textAlignment;
        [self addSubview:monthUseLable];
        
        [monthUseLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLable.mas_right).with.offset(0);
            make.centerY.equalTo(nameLable.mas_centerY).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(60, 13));
        }];
        
        _monthUseLable = monthUseLable;
    }
    
    return _monthUseLable;
}

- (UILabel *)yearCumulativeLable
{
    if (_yearCumulativeLable == nil)
    {
        
        UILabel *nameLable = [[UILabel alloc] init];
        nameLable.font = self.currentReadingsLable.font;
        nameLable.textAlignment = self.currentReadingsLable.textAlignment;
        nameLable.text = @"本年累计：";
        [self addSubview:nameLable];
        
        [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLable.mas_left).with.offset(0);
            make.top.equalTo(self.monthUseLable.mas_bottom).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(65, 13));
        }];
        
        UILabel *yearCumulativeLable = [[UILabel alloc] init];
        yearCumulativeLable.font = nameLable.font;
        yearCumulativeLable.textAlignment = nameLable.textAlignment;
        [self addSubview:yearCumulativeLable];
        
        [yearCumulativeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLable.mas_right).with.offset(0);
            make.centerY.equalTo(nameLable.mas_centerY).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(60, 13));
        }];
        
        _yearCumulativeLable = yearCumulativeLable;
    }
    
    return _yearCumulativeLable;
}

- (UILabel *)meterNumberLable
{
    if (_meterNumberLable == nil)
    {
        UILabel *nameLable = [[UILabel alloc] init];
        nameLable.font = self.currentReadingsLable.font;
        nameLable.textAlignment = self.currentReadingsLable.textAlignment;
        nameLable.text = @"表具编号：";
        [self addSubview:nameLable];
        
        [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLable.mas_left).with.offset(0);
            make.top.equalTo(self.yearCumulativeLable.mas_bottom).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(65, 13));
        }];
        
        UILabel *meterNumberLable = [[UILabel alloc] init];
        meterNumberLable.font = nameLable.font;
        meterNumberLable.textAlignment = nameLable.textAlignment;
        [self addSubview:meterNumberLable];
        
        [meterNumberLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLable.mas_right).with.offset(0);
            make.centerY.equalTo(nameLable.mas_centerY).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(60, 13));
        }];
        
        _meterNumberLable = meterNumberLable;
    }
    
    return _meterNumberLable;
}

- (UILabel *)meterModelLable
{
    if (_meterModelLable == nil)
    {
        UILabel *nameLable = [[UILabel alloc] init];
        nameLable.font = self.currentReadingsLable.font;
        nameLable.textAlignment = self.currentReadingsLable.textAlignment;
        nameLable.text = @"表具型号：";
        [self addSubview:nameLable];
        
        [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.meterNumberLable.mas_right).with.offset(10);
            make.centerY.equalTo(self.meterNumberLable.mas_centerY).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(65, 13));
        }];
        
        UILabel *meterModelLable = [[UILabel alloc] init];
        meterModelLable.font = nameLable.font;
        meterModelLable.textAlignment = nameLable.textAlignment;
        [self addSubview:meterModelLable];
        
        [meterModelLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLable.mas_right).with.offset(0);
            make.centerY.equalTo(nameLable.mas_centerY).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(60, 13));
        }];
        
        _meterModelLable = meterModelLable;
    }
    
    return _meterModelLable;
}

- (UILabel *)installationAddressLable
{
    if (_installationAddressLable == nil)
    {
        UILabel *nameLable = [[UILabel alloc] init];
        nameLable.font = self.currentReadingsLable.font;
        nameLable.textAlignment = self.currentReadingsLable.textAlignment;
        nameLable.text = @"安装地址：";
        [self addSubview:nameLable];
        
        [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLable.mas_left).with.offset(0);
            make.top.equalTo(self.meterNumberLable.mas_bottom).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(65, 13));
        }];
        
        UILabel *installationAddressLable = [[UILabel alloc] init];
        installationAddressLable.font = nameLable.font;
        installationAddressLable.textAlignment = nameLable.textAlignment;
        [self addSubview:installationAddressLable];
        
        [installationAddressLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLable.mas_right).with.offset(0);
            make.centerY.equalTo(nameLable.mas_centerY).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(220, 13));
        }];
        
        _installationAddressLable = installationAddressLable;
    }
    
    return _installationAddressLable;
}

- (UILabel *)remainingAmountLable
{
    if (_remainingAmountLable == nil)
    {
        UILabel *nameLable = [[UILabel alloc] init];
        nameLable.font = [UIFont systemFontOfSize:13];
        nameLable.textAlignment = NSTextAlignmentRight;
        nameLable.text = @"剩余用量";
        [self addSubview:nameLable];
        
        [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.rechargeButton.mas_right).with.offset(0);
            make.centerY.equalTo(self.currentReadingsLable.mas_centerY).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(70, 13));
        }];
        
        UILabel *remainingAmountLable = [[UILabel alloc] init];
        remainingAmountLable.font = [UIFont boldSystemFontOfSize:25];
        remainingAmountLable.textAlignment = nameLable.textAlignment;
        [self addSubview:remainingAmountLable];
        
        [remainingAmountLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(nameLable.mas_right).with.offset(0);
            make.top.equalTo(nameLable.mas_bottom).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(100, 25));
        }];
        
        _remainingAmountLable = remainingAmountLable;
    }
    
    return _remainingAmountLable;
}

- (void)setAccountSatate:(accountSatate)accountSatate
{
    if (accountSatate == accountSatateNormal)
    {
        self.accountStateLable.backgroundColor = RGB(108, 187, 156);
        self.accountStateLable.text = @"正常运行";
        self.remainingAmountLable.textColor = [UIColor blackColor];
        self.rechargeButton.hidden = NO;
        self.frozenPromptLable.hidden = YES;
    }else
    {
        self.accountStateLable.backgroundColor = RGB(206, 98, 84);
        self.frozenPromptLable.textColor = self.accountStateLable.backgroundColor;
        self.accountStateLable.text = @"已冻结";
        self.remainingAmountLable.textColor = self.accountStateLable.backgroundColor;
        self.rechargeButton.hidden = YES;
        self.frozenPromptLable.hidden = NO;
    }
}

+ (instancetype)accountDetailsViewWithFrame:(CGRect)frame
{
    return [[self alloc] initWithFrame:frame];
}

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
    self.backgroundColor = RGB(245, 245, 245);
    
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, 45, CGRectGetWidth(self.frame), 1);
    lineView.backgroundColor = RGB(236, 236, 236);
    [self addSubview:lineView];
    self.lineView = lineView;
    
    self.nameLable.text = @"水 SY00038";
    self.accountSatate = accountSatateNormal;
    self.currentReadingsLable.text = @"728.74吨";
    self.monthUseLable.text = @"30.76吨";
    self.yearCumulativeLable.text = @"900.76吨";
    self.meterNumberLable.text = @"CY0001";
    self.meterModelLable.text = @"普通水表";
    self.installationAddressLable.text = @"江苏无锡朝阳农贸市场海鲜摊位2-101";
    self.remainingAmountLable.text = @"52.94吨";

}

- (void)recharge:(UIButton *)btn
{
    LQLog(@"--充值--");
}

@end
