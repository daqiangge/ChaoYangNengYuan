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

#define AccountDetailsView_Height 171
#define AccountBillView_Height (LQScreen_Height-AccountDetailsView_Height-NavigationBar_Height)

@interface LQAccountDetailsVC ()

@end

@implementation LQAccountDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self doLoading];
}

- (void)doLoading
{
    CGRect accountDetailsViewF = CGRectMake(0, NavigationBar_Height, LQScreen_Width, AccountDetailsView_Height);
    LQAccountDetailsView *accountDetailsView = [LQAccountDetailsView accountDetailsViewWithFrame:accountDetailsViewF];
    [self.view addSubview:accountDetailsView];
    
    CGRect accountBillViewF = CGRectMake(0, CGRectGetMaxY(accountDetailsView.frame), LQScreen_Width, AccountBillView_Height);
    LQAccountBillView *accountBillView = [LQAccountBillView accountBillViewWithFrame:accountBillViewF];
    [self.view addSubview:accountBillView];
}

@end
