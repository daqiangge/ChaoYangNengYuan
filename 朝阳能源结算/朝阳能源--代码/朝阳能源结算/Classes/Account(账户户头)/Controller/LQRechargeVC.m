//
//  LQRechargeVC.m
//  朝阳能源结算
//
//  Created by admin on 15/8/18.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//
//
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//------------------------充值界面-----------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------

#import "LQRechargeVC.h"
#import "LQOrderVC.h"
#import "LQSettingVC.h"
#import "LQAccountItemModel.h"

@interface LQRechargeVC ()<UITextFieldDelegate>

@property (nonatomic, weak) UIView *backgroundView;

/**
 *  当前示数
 */
@property (nonatomic, weak) LQNoCopyTextField *currentDigitalTextField;

/**
 *  剩余量
 */
@property (nonatomic, weak) LQNoCopyTextField *remainingAmountTextField;

/**
 *  充值金额
 */
@property (nonatomic, weak) LQNoCopyTextField *rechargeMoneyTextField;

/**
 *  充值用量
 */
@property (nonatomic, weak) LQNoCopyTextField *rechargeAmountTextField;

/**
 *  充值按钮
 */
@property (nonatomic, weak) UIButton *rechargeBtn;

@end

@implementation LQRechargeVC

- (void)setAccountItemModel:(LQAccountItemModel *)accountItemModel
{
    _accountItemModel = accountItemModel;
}

- (UIView *)backgroundView
{
    if (_backgroundView == nil)
    {
        UIView *backgroundview = [[UIView alloc] init];
        backgroundview.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:backgroundview];
        
        [backgroundview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).with.offset(64);
            make.left.and.right.equalTo(self.view);
//            make.height.equalTo(@188);
            make.bottom.equalTo(self.rechargeMoneyTextField.mas_bottom).with.offset(-10);
        }];
        
        _backgroundView = backgroundview;
    }
    
    return _backgroundView;
}

- (UILabel *)setNameLableWithText:(NSString *)text
{
    UILabel *nameLable = [[UILabel alloc] init];
    nameLable.text = text;
    nameLable.textAlignment = NSTextAlignmentCenter;
    nameLable.font = [UIFont systemFontOfSize:15];
    [self.backgroundView addSubview:nameLable];
    
    return nameLable;
}

- (UILabel *)setUnitLableWithText:(NSString *)text
{
    UILabel *unitLable = [[UILabel alloc] init];
    unitLable.text = text;
    unitLable.textAlignment = NSTextAlignmentCenter;
    unitLable.font = [UIFont systemFontOfSize:15];
    [self.backgroundView addSubview:unitLable];
    
    return unitLable;
}

- (LQNoCopyTextField *)setTextField
{
    LQNoCopyTextField *textField = [[LQNoCopyTextField alloc] init];
    textField.font = [UIFont systemFontOfSize:15];
    textField.textColor = [UIColor blackColor];
    textField.backgroundColor = RGB(237, 237, 237);
    textField.userInteractionEnabled = NO;
    textField.layer.borderColor = Layer_BorderColor;
    textField.layer.borderWidth = Layer_BorderWidth;
    textField.layer.cornerRadius = Layer_CornerRadius;
    textField.keyboardType = UIKeyboardTypeNumberPad;
    [self.backgroundView addSubview:textField];
    
    UIView *leftView = [[UIView alloc] init];
    leftView.width = 5;
    leftView.contentMode      = UIViewContentModeCenter;
    textField.leftView        = leftView;
    textField.leftViewMode    = UITextFieldViewModeAlways;
    
    return textField;
}

- (LQNoCopyTextField *)currentDigitalTextField
{
    if (_currentDigitalTextField == nil)
    {
        UILabel *nameLable = [self setNameLableWithText:@"当前示数："];
        [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.backgroundView.mas_top).with.offset(23);
            make.left.equalTo(self.backgroundView.mas_left).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(80, 34));
        }];
        
        UILabel *unitLable = [self setUnitLableWithText:[NSString stringWithFormat:@"%@",self.accountItemModel.eunit]];
        [unitLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameLable.mas_top);
            make.right.equalTo(self.backgroundView.mas_right).with.offset(-10);
            make.height.equalTo(nameLable.mas_height);
            make.width.equalTo(@20);
        }];
        
        LQNoCopyTextField *textField = [self setTextField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameLable.mas_top);
            make.left.equalTo(nameLable.mas_right);
            make.right.equalTo(unitLable.mas_left);
            make.height.equalTo(nameLable.mas_height);
        }];
        
        _currentDigitalTextField = textField;
    }
    
    return _currentDigitalTextField;
}

- (LQNoCopyTextField *)remainingAmountTextField
{
    if (_remainingAmountTextField == nil)
    {
        NSString *nameLableText;
        NSString *unit;
        if (self.accountItemModel.rechargestype == 1)
        {
            nameLableText = [NSString stringWithFormat:@"剩余%@量：",self.accountItemModel.etypename];
            unit = self.accountItemModel.eunit;
        }
        else
        {
            nameLableText = @"剩余金额：";
            unit = @"元";
        }
        
        UILabel *nameLable = [self setNameLableWithText:nameLableText];
        [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.currentDigitalTextField.mas_bottom).with.offset(23);
            make.left.equalTo(self.backgroundView.mas_left).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(80, 34));
        }];
        
        UILabel *unitLable = [self setUnitLableWithText:unit];
        [unitLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameLable.mas_top);
            make.right.equalTo(self.backgroundView.mas_right).with.offset(-10);
            make.height.equalTo(nameLable.mas_height);
            make.width.equalTo(@20);
        }];
        
        LQNoCopyTextField *textField = [self setTextField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameLable.mas_top);
            make.left.equalTo(nameLable.mas_right);
            make.right.equalTo(unitLable.mas_left);
            make.height.equalTo(nameLable.mas_height);
        }];
        
        _remainingAmountTextField = textField;
    }
    
    return _remainingAmountTextField;
}

- (LQNoCopyTextField *)rechargeAmountTextField
{
    if (_rechargeAmountTextField == nil)
    {
        UILabel *nameLable = [self setNameLableWithText:[NSString stringWithFormat:@"充值%@量：",self.accountItemModel.etypename]];
        [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.remainingAmountTextField.mas_bottom).with.offset(23);
            make.left.equalTo(self.backgroundView.mas_left).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(80, 34));
        }];
        
        UILabel *unitLable = [self setUnitLableWithText:self.accountItemModel.eunit];
        [unitLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameLable.mas_top);
            make.right.equalTo(self.backgroundView.mas_right).with.offset(-10);
            make.height.equalTo(nameLable.mas_height);
            make.width.equalTo(@20);
        }];
        
        LQNoCopyTextField *textField = [self setTextField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameLable.mas_top);
            make.left.equalTo(nameLable.mas_right);
            make.right.equalTo(unitLable.mas_left);
            make.height.equalTo(nameLable.mas_height);
        }];
        
        _rechargeAmountTextField = textField;
    }
    
    return _rechargeAmountTextField;
}

- (LQNoCopyTextField *)rechargeMoneyTextField
{
    if (_rechargeMoneyTextField == nil)
    {
        UILabel *nameLable = [self setNameLableWithText:@"充值金额："];
        [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rechargeAmountTextField.mas_bottom).with.offset(23);
            make.left.equalTo(self.backgroundView.mas_left).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(80, 34));
        }];
        
        UILabel *unitLable = [self setUnitLableWithText:@"元"];
        [unitLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameLable.mas_top);
            make.right.equalTo(self.backgroundView.mas_right).with.offset(-10);
            make.height.equalTo(nameLable.mas_height);
            make.width.equalTo(@20);
        }];
        
        LQNoCopyTextField *textField = [self setTextField];
        textField.textColor = [UIColor blueColor];
        textField.backgroundColor = [UIColor whiteColor];
        textField.userInteractionEnabled = YES;
        textField.delegate = self;
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameLable.mas_top);
            make.left.equalTo(nameLable.mas_right);
            make.right.equalTo(unitLable.mas_left);
            make.height.equalTo(nameLable.mas_height);
        }];
    }
    
    return _rechargeMoneyTextField;
}

- (UIButton *)rechargeBtn
{
    if (_rechargeBtn == nil)
    {
        UIButton *btn = [[UIButton alloc] init];
        [btn setBackgroundImage:[UIImage imageNamed:@"按钮-黄"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"按钮-黄-按下"] forState:UIControlStateHighlighted];
        [btn setTitle:@"充值" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.layer.borderColor = [UIColor clearColor].CGColor;
        btn.layer.borderWidth = Layer_BorderWidth;
        btn.layer.cornerRadius = Layer_CornerRadius;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(recharge) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.backgroundView.mas_bottom).with.offset(13);
            make.left.equalTo(self.view.mas_left).with.offset(10);
            make.right.equalTo(self.view.mas_right).with.offset(-10);
            make.height.equalTo(@40);
        }];
        
        _rechargeBtn = btn;
    }
    
    return _rechargeBtn;
}

#pragma mark -
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGB(237, 237, 237);
    self.navigationItem.title = [NSString stringWithFormat:@"%@(充值)",self.accountItemModel.accountcode];
    
    self.navigationItem.rightBarButtonItems = [UIBarButtonItem barbarButtonItemWithImageName:@"settings" selectedImageName:@"settings-按下" target:self action:@selector(setting) space:-10];
    
    [self doLoading];
}

- (void)doLoading
{
    self.currentDigitalTextField.text = self.accountItemModel.currentamount;
    self.remainingAmountTextField.text = self.accountItemModel.amountforrecharges;
    self.rechargeMoneyTextField.text = @"10000";
    self.rechargeBtn.hidden = NO;
}

- (void)recharge
{
    LQOrderVC *orderVC = [[LQOrderVC alloc] init];
    [self.navigationController pushViewController:orderVC animated:YES];
}

- (void)setting
{
    LQSettingVC *settingVC = [[LQSettingVC alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - Textfield Delegate
//释放键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    
    return YES;
}

//限制textfield字符长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"])  //按会车可以改
    {
        return YES;
    }
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if ([toBeString length] > 6)
    {
        textField.text = [toBeString substringToIndex:6];
        return NO;
    }
    
    return YES;
}

@end
