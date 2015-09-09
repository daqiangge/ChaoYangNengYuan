//
//  LQSettingVC.m
//  朝阳能源结算
//
//  Created by admin on 15/9/9.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQSettingVC.h"
#import "PwdSettingViewController.h"
#import "LQAboutAppVC.h"

@interface LQSettingVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation LQSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"设置";
    
    [self doLoading];
}

- (void)doLoading
{
    UITableView *settingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LQScreen_Width, LQScreen_Height) style:UITableViewStyleGrouped];
    settingTableView.delegate     = self;
    settingTableView.dataSource   = self;
    [settingTableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    settingTableView.delaysContentTouches = NO;
    [self.view addSubview:settingTableView];
    
    UIButton *logOutButton  = [[UIButton alloc] init];
    logOutButton.frame      = CGRectMake(10, 20*2+40*2+20, LQScreen_Width-20, 40);
    logOutButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [logOutButton setBackgroundImage:[UIImage imageNamed:@"logoutbg"] forState:UIControlStateNormal];
    [logOutButton setTitle:@"退出系统" forState:UIControlStateNormal];
    [logOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logOutButton addTarget:self action:@selector(doLogOut) forControlEvents:UIControlEventTouchUpInside];
    [settingTableView addSubview:logOutButton];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    switch (indexPath.section)
    {
        case 0:
            cell.textLabel.text = @"修改密码";
            break;
            
        case 1:
            cell.textLabel.text = @"关于朝阳自助收费";
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section)
    {
        case 0:
        {
            PwdSettingViewController *vc = [[PwdSettingViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 1:
        {
            LQAboutAppVC *vc = [[LQAboutAppVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
    }
}

#pragma mark - 退出登录操作
- (void)doLogOut
{
    
}

@end
