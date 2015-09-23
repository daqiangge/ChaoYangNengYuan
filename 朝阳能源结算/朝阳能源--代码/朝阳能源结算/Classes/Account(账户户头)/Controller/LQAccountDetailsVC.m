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
#import "LQAccountItemModel.h"
#import "LQSettingVC.h"
#import "LQRechargeAmountVC.h"
#import "LQRechargeMoneyVC.h"
#import "LQOrderVC.h"

#define AccountDetailsView_Height 171
#define AccountBillView_Height (LQScreen_Height-AccountDetailsView_Height-NavigationBar_Height)

@interface LQAccountDetailsVC ()<LQAccountDetailsViewDelegate,UIAlertViewDelegate,LQAccountBillViewDelegate>

@property (nonatomic, strong) UIAlertView *showErrorAlterView;

@end

@implementation LQAccountDetailsVC

- (void)setAccountitemModel:(LQAccountItemModel *)accountitemModel
{
    _accountitemModel = accountitemModel;
}

- (UIAlertView *)showErrorAlterView
{
    if (!_showErrorAlterView)
    {
        _showErrorAlterView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                     message:nil
                                                                    delegate:nil
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles: nil];
    }
    
    return _showErrorAlterView;
}

#pragma mark -
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //取出数据库中的用户名
    NSMutableDictionary *accountDic = [NSMutableDictionary dictionaryWithDictionary:[[LQKeyValueStore shareInstance].keyValueStore getObjectById:SQL_Account_Key fromTable:SQL_Account_TableName]];
    NSString *accountName  = [accountDic valueForKey:@"accountName"];
    
    self.navigationItem.title = accountName;
    
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
    accountBillView.delegate = self;
    [self.view addSubview:accountBillView];
}

/**
 *  前往设置界面
 */
- (void)setting
{
    LQSettingVC *settingVC = [[LQSettingVC alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

/**
 *  退出操作界面，回到登陆界面
 */
- (void)dismissViewControllerAnimated:(BOOL)animated
{
    YTKKeyValueStore *store      = [[YTKKeyValueStore alloc] initDBWithName:SQL_Name];
    NSMutableDictionary *accountDic = [NSMutableDictionary dictionaryWithDictionary:[store getObjectById:SQL_Account_Key fromTable:SQL_Account_TableName]];
    accountDic[@"loginSuccess"] = [NSNumber numberWithBool:NO];
    [store putObject:accountDic withId:SQL_Account_Key intoTable:SQL_Account_TableName];
    
    [self dismissViewControllerAnimated:animated completion:nil];
}

- (void)showAccountTimeOutAlterView
{
    self.showErrorAlterView.message = @"当前用户不存在或者已经超时，请重新登陆";
    self.showErrorAlterView.delegate = self;
    [self.showErrorAlterView show];
}

- (void)showOtherRequestReturnFalseAlterViewWithMessage:(NSString *)message
{
    self.showErrorAlterView.message = message;
    self.showErrorAlterView.delegate = nil;
    [self.showErrorAlterView show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    YTKKeyValueStore *store      = [[YTKKeyValueStore alloc] initDBWithName:SQL_Name];
    NSMutableDictionary *accountDic = [NSMutableDictionary dictionaryWithDictionary:[store getObjectById:SQL_Account_Key fromTable:SQL_Account_TableName]];
    accountDic[@"loginSuccess"] = [NSNumber numberWithBool:NO];
    [store putObject:accountDic withId:SQL_Account_Key intoTable:SQL_Account_TableName];
    
    [self dismissViewControllerAnimated:NO];
}

#pragma mark - LQAccountDetailsViewDelegate
- (void)accountDetailsViewDidClickRechargeButtonWith:(LQAccountDetailsView *)view
{
    
    if (self.accountitemModel.rechmodle == 1)
    {
        if (self.accountitemModel.rechargestype == 1)
        {
            LQRechargeAmountVC *vc = [[LQRechargeAmountVC alloc] init];
            vc.accountItemModel = self.accountitemModel;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            LQRechargeMoneyVC *vc = [[LQRechargeMoneyVC alloc] init];
            vc.accountItemModel = self.accountitemModel;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else
    {
        LQOrderVC *vc = [[LQOrderVC alloc] init];
        vc.accountItemModel = self.accountitemModel;
        vc.rechargeMoney = self.accountitemModel.moneyofamount;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - LQAccountBillViewDelegate
- (void)showAccountTimeOutAlterViewWithRechargeRecordView:(LQRechargeRecordView *)rechargeRecordView inBillView:(LQAccountBillView *)billView
{
    [self showAccountTimeOutAlterView];
}

- (void)showOtherRequestReturnFalseAlterViewWithRechargeRecordView:(LQRechargeRecordView *)rechargeRecordView message:(NSString *)message inBillView:(LQAccountBillView *)billView
{
    [self showOtherRequestReturnFalseAlterViewWithMessage:message];
}

- (void)showAccountTimeOutAlterViewWithYearAnalysisView:(LQYearAnalysisView *)yearAnalysisView inBillView:(LQAccountBillView *)billView
{
    [self showAccountTimeOutAlterView];
}

- (void)showOtherRequestReturnFalseAlterViewWithYearAnalysisView:(LQYearAnalysisView *)yearAnalysisView message:(NSString *)message inBillView:(LQAccountBillView *)billView
{
    [self showOtherRequestReturnFalseAlterViewWithMessage:message];
}

- (void)showAccountTimeOutAlterViewWithMonthAnalysisView:(LQMonthAnalysisView *)view inBillView:(LQAccountBillView *)billView
{
    [self showAccountTimeOutAlterView];
}

- (void)showOtherRequestReturnFalseAlterViewWithMonthAnalysisView:(LQMonthAnalysisView *)view message:(NSString *)message inBillView:(LQAccountBillView *)billView
{
    [self showOtherRequestReturnFalseAlterViewWithMessage:message];
}

#pragma mark - dealloc
- (void)dealloc
{
    LQLog(@"#$#$#$$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$");
}

@end
