//
//  LQOrderVC.m
//  朝阳能源结算
//
//  Created by admin on 15/8/19.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQOrderVC.h"
#import "LQOrderInformationCell.h"
#import "LQPayWayCell.h"

@interface LQOrderVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UIButton *btn;
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation LQOrderVC

- (UITableView *)tableView
{
    if (_tableView == nil)
    {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.and.bottom.equalTo(self.view);
        }];
        
        _tableView = tableView;
        
    }
    
    return _tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"确认支付";
    
    self.view.backgroundColor = RGB(237, 237, 237);
    
    [self doLoading];
}

- (void)doLoading
{
    UIButton *determinePayBtn = [[UIButton alloc] init];
    [determinePayBtn setBackgroundImage:[UIImage imageNamed:@"按钮-黄"] forState:UIControlStateNormal];
    [determinePayBtn setBackgroundImage:[UIImage imageNamed:@"按钮-黄-按下"] forState:UIControlStateHighlighted];
    [determinePayBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    [determinePayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    determinePayBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    determinePayBtn.layer.borderColor = [UIColor clearColor].CGColor;
    determinePayBtn.layer.borderWidth = Layer_BorderWidth;
    determinePayBtn.layer.cornerRadius = Layer_CornerRadius;
    determinePayBtn.layer.masksToBounds = YES;
    [determinePayBtn addTarget:self action:@selector(determinePay:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:determinePayBtn];
    
    [determinePayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.mas_top).with.offset(325);
        make.left.equalTo(self.tableView.mas_left).with.offset(10);
        make.width.equalTo([NSNumber numberWithFloat:LQScreen_Width-20]);
        make.height.equalTo(@40);
    }];
}

- (void)determinePay:(UIButton *)sender
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"正在支付...";
    
    
    [MBProgressHUD showSuccessHUD:hud lableText:@"支付成功" waitTime:3.0];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return 1;
            break;
            
        case 1:
            return 3;
            break;
    }
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        LQOrderInformationCell *cell = [LQOrderInformationCell cellWithTableView:tableView indexPath:indexPath];
        
        return cell;
    }else
    {
        LQPayWayCell *cell = [LQPayWayCell cellWithTableView:tableView indexPath:indexPath];
        
        if (indexPath.row == 0)
        {
            self.btn = cell.choosePayBtn;
        }
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
        {
            return 75;
        }
            break;
            
        case 1:
        {
            return 60;
        }
            break;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0.01;
    }else
    {
        return 40;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view.size = CGSizeMake(LQScreen_Width, 40);
        
        UILabel *lable = [[UILabel alloc] init];
        lable.text = @"选择支付方式：";
        lable.font = [UIFont systemFontOfSize:15];
        lable.textColor = [UIColor grayColor];
        [view addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.and.right.equalTo(view);
            make.left.equalTo(view.mas_left).with.offset(10);
        }];
        
        return view;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return;
    }
    
    self.btn.selected = NO;
    LQPayWayCell *cell = (LQPayWayCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.choosePayBtn.selected = YES;
    self.btn = cell.choosePayBtn;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
