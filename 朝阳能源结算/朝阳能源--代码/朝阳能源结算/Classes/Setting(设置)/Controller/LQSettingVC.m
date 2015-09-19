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
#import "ContactSettingViewController.h"
#import "LQChangePasswordVC.h"

@interface LQSettingVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation LQSettingVC
- (void)viewDidLoad
{
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
    logOutButton.frame      = CGRectMake(10, 20*2+40*3+20, LQScreen_Width-20, 40);
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
    if (section == 0)
    {
        return 2;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    switch (indexPath.section)
    {
        case 0:
        {
            switch (indexPath.row)
            {
                case 0:
                    cell.textLabel.text = @"联系方式";
                    break;
                    
                case 1:
                    cell.textLabel.text = @"修改密码";
                    break;
            }
        }
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
            switch (indexPath.row)
            {
                case 0:
                {
                    ContactSettingViewController *vc = [[ContactSettingViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 1:
                {
//                    PwdSettingViewController *vc = [[PwdSettingViewController alloc] init];
                    LQChangePasswordVC *vc = [[LQChangePasswordVC alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
            }
            
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
    //退出等待指示器
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode           = MBProgressHUDModeIndeterminate;
    hud.labelText      = @"正在退出...";
    
    YTKKeyValueStore *store      = [[YTKKeyValueStore alloc] initDBWithName:SQL_Name];
    NSMutableDictionary *accountDic = [NSMutableDictionary dictionaryWithDictionary:[store getObjectById:SQL_Account_Key fromTable:SQL_Account_TableName]];
    NSString *sessionid = accountDic[@"sessionid"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr                       = [NSString stringWithFormat:@"%@/energy/do/chargeapp/signoff.do?;sessionid=%@",IP,sessionid];
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         LQLog(@"%@",operation.responseString);
         
         accountDic[@"loginSuccess"] = [NSNumber numberWithBool:NO];
         [store putObject:accountDic withId:SQL_Account_Key intoTable:SQL_Account_TableName];
         
         [self dismissViewControllerAnimated:YES completion:nil];
         
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        LQLog(@"%@",error);
        
        accountDic[@"loginSuccess"] = [NSNumber numberWithBool:NO];
        [store putObject:accountDic withId:SQL_Account_Key intoTable:SQL_Account_TableName];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
         [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
         
     }];
}

@end
