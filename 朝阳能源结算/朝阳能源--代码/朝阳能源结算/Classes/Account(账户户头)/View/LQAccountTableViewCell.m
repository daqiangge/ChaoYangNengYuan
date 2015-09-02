//
//  LQAccountTableViewCell.m
//  朝阳能源结算
//
//  Created by admin on 15/8/5.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------户头列表----------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------

#import "LQAccountTableViewCell.h"
#import "LQAccountItemModel.h"

@interface LQAccountTableViewCell()

/**
 *  背景view
 */
@property (nonatomic, weak) UIView *backGroundView;

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

@property (nonatomic, weak) UIActivityIndicatorView *currentReadingsAct;

/**
 *  本月使用
 */
@property (nonatomic, weak) UILabel *monthUseLable;

/**
 *  表具型号
 */
@property (nonatomic, weak) UILabel *modelLable;

/**
 *  安装地址
 */
@property (nonatomic, weak) UILabel *installationAddressLable;

/**
 *  剩余用量
 */
@property (nonatomic, weak) UILabel *surplusAmountLable;

@property (nonatomic, weak) UIActivityIndicatorView *surplusAmountAct;

@end


@implementation LQAccountTableViewCell

- (UILabel *)nameLable
{
    if (_nameLable == nil)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.font = [UIFont boldSystemFontOfSize:16];
        lable.textColor = [UIColor blackColor];
        [self.backGroundView addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backGroundView.mas_left).with.offset(15);
            make.top.equalTo(self.backGroundView.mas_top).with.offset(0);
            make.bottom.equalTo(self.lineView.mas_top).with.offset(0);
            make.width.equalTo(@110);
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
        [self.backGroundView addSubview:lable];
        
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
        [button setTitleColor:[UIColor colorWithHex:@"#3498DB"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHex:@"#2980B9"] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(recharge:) forControlEvents:UIControlEventTouchUpInside];
        button.hidden = YES;
        [self.backGroundView addSubview:button];
        button.layer.borderColor = [UIColor colorWithHex:@"#3498DB"].CGColor;
        button.layer.borderWidth = 3.0;
        button.layer.cornerRadius = 5;
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.backGroundView.mas_right).with.offset(-10);
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
        [self.backGroundView addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.backGroundView.mas_right).with.offset(-10);
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
        [self.backGroundView addSubview:nameLable];
        
        [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLable.mas_left).with.offset(0);
            make.top.equalTo(self.lineView.mas_bottom).with.offset(15);
            make.size.mas_equalTo(CGSizeMake(65, 13));
        }];
        
        UILabel *currentReadingsLable = [[UILabel alloc] init];
        currentReadingsLable.font = nameLable.font;
        currentReadingsLable.textAlignment = nameLable.textAlignment;
        [self.backGroundView addSubview:currentReadingsLable];
        
        [currentReadingsLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLable.mas_right).with.offset(0);
            make.centerY.equalTo(nameLable.mas_centerY).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(100, 13));
        }];
        
        _currentReadingsLable = currentReadingsLable;
    }
    
    return _currentReadingsLable;
}

- (UIActivityIndicatorView *)currentReadingsAct
{
    if (!_currentReadingsAct)
    {
        UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc] init];
        [act startAnimating];
        [act setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        [self.backGroundView addSubview:act];
        
        [act mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.currentReadingsLable.mas_left).with.offset(0);
            make.centerY.equalTo(self.currentReadingsLable);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        _currentReadingsAct = act;
    }
    
    return _currentReadingsAct;
}

- (UILabel *)monthUseLable
{
    if (_monthUseLable == nil)
    {
        UILabel *nameLable = [[UILabel alloc] init];
        nameLable.font = self.currentReadingsLable.font;
        nameLable.textAlignment = self.currentReadingsLable.textAlignment;
        nameLable.text = @"本月使用：";
        [self.backGroundView addSubview:nameLable];
        
        [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLable.mas_left).with.offset(0);
            make.top.equalTo(self.currentReadingsLable.mas_bottom).with.offset(15);
            make.size.mas_equalTo(CGSizeMake(65, 13));
        }];
        
        UILabel *monthUseLable = [[UILabel alloc] init];
        monthUseLable.font = nameLable.font;
        monthUseLable.textAlignment = nameLable.textAlignment;
        [self.backGroundView addSubview:monthUseLable];
        
        [monthUseLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLable.mas_right).with.offset(0);
            make.centerY.equalTo(nameLable.mas_centerY).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(100, 13));
        }];
        
        _monthUseLable = monthUseLable;
    }
    
    return _monthUseLable;
}

- (UILabel *)modelLable
{
    if (_modelLable == nil)
    {
        UILabel *nameLable = [[UILabel alloc] init];
        nameLable.font = self.currentReadingsLable.font;
        nameLable.textAlignment = self.currentReadingsLable.textAlignment;
        nameLable.text = @"表具型号：";
        [self.backGroundView addSubview:nameLable];
        
        [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLable.mas_left).with.offset(0);
            make.top.equalTo(self.monthUseLable.mas_bottom).with.offset(15);
            make.size.mas_equalTo(CGSizeMake(65, 13));
        }];
        
        UILabel *modelLable = [[UILabel alloc] init];
        modelLable.font = nameLable.font;
        modelLable.textAlignment = nameLable.textAlignment;
        [self.backGroundView addSubview:modelLable];
        
        [modelLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLable.mas_right).with.offset(0);
            make.centerY.equalTo(nameLable.mas_centerY).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(100, 13));
        }];
        
        _modelLable = modelLable;
    }
    
    return _modelLable;
}

- (UILabel *)installationAddressLable
{
    if (_installationAddressLable == nil)
    {
        UILabel *nameLable = [[UILabel alloc] init];
        nameLable.font = self.currentReadingsLable.font;
        nameLable.textAlignment = self.currentReadingsLable.textAlignment;
        nameLable.text = @"安装地址：";
        [self.backGroundView addSubview:nameLable];
        
        [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLable.mas_left).with.offset(0);
            make.top.equalTo(self.modelLable.mas_bottom).with.offset(15);
            make.size.mas_equalTo(CGSizeMake(65, 13));
        }];
        
        UILabel *installationAddressLable = [[UILabel alloc] init];
        installationAddressLable.font = nameLable.font;
        installationAddressLable.textAlignment = nameLable.textAlignment;
        [self.backGroundView addSubview:installationAddressLable];
        
        [installationAddressLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLable.mas_right).with.offset(0);
            make.centerY.equalTo(nameLable.mas_centerY).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(220, 13));
        }];
        
        _installationAddressLable = installationAddressLable;
    }
    
    return _installationAddressLable;
}

- (UILabel *)surplusAmountLable
{
    if (_surplusAmountLable == nil)
    {
        UILabel *nameLable = [[UILabel alloc] init];
        nameLable.font = [UIFont systemFontOfSize:13];
        nameLable.textAlignment = NSTextAlignmentRight;
        nameLable.text = @"剩余用量";
        [self.backGroundView addSubview:nameLable];
        
        [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.rechargeButton.mas_right).with.offset(0);
            make.centerY.equalTo(self.currentReadingsLable.mas_centerY).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(70, 13));
        }];
        
        UILabel *surplusAmountLable = [[UILabel alloc] init];
        surplusAmountLable.font = [UIFont boldSystemFontOfSize:25];
        surplusAmountLable.textAlignment = nameLable.textAlignment;
        [self.backGroundView addSubview:surplusAmountLable];
        
        [surplusAmountLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(nameLable.mas_right).with.offset(0);
            make.top.equalTo(nameLable.mas_bottom).with.offset(15);
            make.size.mas_equalTo(CGSizeMake(150, 25));
        }];
        
        _surplusAmountLable = surplusAmountLable;
    }
    
    return _surplusAmountLable;
}

- (UIActivityIndicatorView *)surplusAmountAct
{
    if (!_surplusAmountAct)
    {
        UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc] init];
        [act startAnimating];
        [act setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        [self.backGroundView addSubview:act];
        
        [act mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.surplusAmountLable.mas_right).with.offset(-10);
            make.centerY.equalTo(self.surplusAmountLable);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        _surplusAmountAct = act;
    }
    
    return _surplusAmountAct;
}

- (void)setAccountSatate:(accountSatate)accountSatate
{
    if (accountSatate == accountSatateNormal)
    {
        self.accountStateLable.backgroundColor = RGB(108, 187, 156);
        self.accountStateLable.text = @"正常运行";
        self.surplusAmountLable.textColor = [UIColor blackColor];
        self.rechargeButton.hidden = NO;
        self.frozenPromptLable.hidden = YES;
    }else
    {
        self.accountStateLable.backgroundColor = RGB(206, 98, 84);
        self.frozenPromptLable.textColor = self.accountStateLable.backgroundColor;
        self.accountStateLable.text = @"已冻结";
        self.surplusAmountLable.textColor = self.accountStateLable.backgroundColor;
        self.rechargeButton.hidden = YES;
        self.frozenPromptLable.hidden = NO;
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor clearColor];
        [self doLoading];
    }
    
    return self;
}

- (void)doLoading
{
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.frame = CGRectMake(5, 5, LQScreen_Width - 10, Cell_Height);
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backgroundView];
    self.backGroundView = backgroundView;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, 50, CGRectGetWidth(backgroundView.frame), 1);
    lineView.backgroundColor = RGB(236, 236, 236);
    [backgroundView addSubview:lineView];
    self.lineView = lineView;
    
}


+ (LQAccountTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    LQAccountTableViewCell *cell = [[LQAccountTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)recharge:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(accountTableViewCellDidClickRechargeButtonWith:)])
    {
        [self.delegate accountTableViewCellDidClickRechargeButtonWith:self];
    }
}

- (void)setAccountItemModel:(LQAccountItemModel *)accountItemModel
{
    _accountItemModel                  = accountItemModel;

    self.currentReadingsAct.hidden     = NO;
    self.surplusAmountAct.hidden       = NO;

    self.nameLable.text                = [NSString stringWithFormat:@"%@  %@",accountItemModel.etypename,accountItemModel.accountcode];
    self.accountSatate                 = accountSatateFrozen;
    self.monthUseLable.text            = [NSString stringWithFormat:@"%@ %@",accountItemModel.monthrecvalues,accountItemModel.eunit];
    self.modelLable.text               = accountItemModel.metermodel;
    self.installationAddressLable.text = accountItemModel.linkaddress;
    self.currentReadingsLable.text     = accountItemModel.currentamount;
    
    //判断“当前示数”是否有值
    if (accountItemModel.currentamount)
    {
        self.currentReadingsAct.hidden = YES;
        [self.currentReadingsAct stopAnimating];
    }
    else
    {
        self.currentReadingsAct.hidden = NO;
    }
    
    //判断“剩余用量”是否有值
    if (accountItemModel.surplusamount)
    {
        self.surplusAmountAct.hidden = YES;
        [self.surplusAmountAct stopAnimating];
        self.surplusAmountLable.text = [NSString stringWithFormat:@"%@ 吨",accountItemModel.surplusamount];
    }
    else
    {
        self.surplusAmountAct.hidden = NO;
        self.surplusAmountLable.text = accountItemModel.surplusamount;
    }
    
    //判断当前是“充值”状态还是“缴费”状态
    if (accountItemModel.rechmodle == 1)
    {
        [self.rechargeButton setTitle:@"充值" forState:UIControlStateNormal];
    }
    else
    {
        [self.rechargeButton setTitle:@"缴费" forState:UIControlStateNormal];
    }
}

@end
