//
//  LQAccountDetailsVC.m
//  朝阳能源结算
//
//  Created by admin on 15/8/11.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-----------------------户头详情------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------

#import "LQAccountDetailsVC.h"
#import "LQAccountDetailsView.h"
#import "LQAccountBillView.h"
#import "LQRechargeVC.h"
#import "LQAccountItemModel.h"
#import "LQSettingVC.h"

#define AccountDetailsView_Height 171
#define AccountBillView_Height (LQScreen_Height-AccountDetailsView_Height-NavigationBar_Height)

@interface LQAccountDetailsVC ()<LQAccountDetailsViewDelegate>

@end

@implementation LQAccountDetailsVC

- (void)setAccountitemModel:(LQAccountItemModel *)accountitemModel
{
    _accountitemModel = accountitemModel;
}

#pragma mark -
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"12345678987";
    
    self.navigationItem.rightBarButtonItems = [UIBarButtonItem barbarButtonItemWithImageName:@"settings" selectedImageName:@"settings-按下" target:self action:@selector(setting) space:-10];
    
    [self doLoading];
}

- (void)doLoading
{
    CGRect accountDetailsViewF = CGRectMake(0, NavigationBar_Height, LQScreen_Width, AccountDetailsView_Height);
    LQAccountDetailsView *accountDetailsView = [LQAccountDetailsView accountDetailsViewWithFrame:accountDetailsViewF];
    accountDetailsView.accountItemModel = self.accountitemModel;
    accountDetailsView.delegate = self;
    [self.view addSubview:accountDetailsView];
    
    CGRect accountBillViewF = CGRectMake(0, CGRectGetMaxY(accountDetailsView.frame), LQScreen_Width, AccountBillView_Height);
    LQAccountBillView *accountBillView = [LQAccountBillView accountBillViewWithFrame:accountBillViewF accountID:self.accountitemModel.accountid accountItemModel:self.accountitemModel];
    [self.view addSubview:accountBillView];
}

- (void)setting
{
    LQSettingVC *settingVC = [[LQSettingVC alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

#pragma mark - LQAccountDetailsViewDelegate
- (void)accountDetailsViewDidClickRechargeButtonWith:(LQAccountDetailsView *)view
{
    LQRechargeVC *rechargeVC = [[LQRechargeVC alloc] init];
    rechargeVC.accountItemModel = self.accountitemModel;
    [self.navigationController pushViewController:rechargeVC animated:YES];
}

@end
