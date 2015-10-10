//
//  LQOrderVC.m
//  朝阳能源结算
//
//  Created by admin on 15/8/19.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-----------------------支付宝付款界面------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------

#import "LQOrderVC.h"
#import "LQAccountItemModel.h"
#import "LQOrderModel.h"
#import "LQOrderInformationCell.h"
#import "LQPayWayCell.h"
#import "LQSettingVC.h"
#import "LQPostpaidOrderInformationCell.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"
#import "LQPostPaidNotCheckBillsDataModel.h"\


@interface LQOrderVC ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic, weak) UIButton *btn;
@property (nonatomic, weak) UITableView *tableView;

/**
 *  未结账期
 */
@property (nonatomic, strong) LQPostPaidNotCheckBillsDataModel *postPaidNotCheckBillsDataModel;

@end

@implementation LQOrderVC

- (void)setOrderModel:(LQOrderModel *)orderModel
{
    _orderModel = orderModel;
}

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

#pragma mark -
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"确认支付";
    
    self.view.backgroundColor = RGB(237, 237, 237);
    
    [self doLoading];
    
    if (self.orderModel.rechmodle != 1 && self.orderModel.accountperiod == nil)
    {
        [self requestGetNotCheckBills];
    }
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
        make.top.equalTo(self.tableView.mas_top).with.offset(self.orderModel.rechmodle == 1?325:355);
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

- (void)setting
{
    LQSettingVC *settingVC = [[LQSettingVC alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

#pragma mark -
#pragma mark   ==============UITableViewDataSource==============
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
        if (self.orderModel.rechmodle == 1)
        {
            LQOrderInformationCell *cell = [LQOrderInformationCell cellWithTableView:tableView indexPath:indexPath];
            cell.accountCodeLable.text = self.orderModel.accountcode;
            cell.moneyLable.text = [NSString stringWithFormat:@"%.2f 元",[self.orderModel.money floatValue]];
            
            return cell;
        }
        else
        {
            LQPostpaidOrderInformationCell *cell = [LQPostpaidOrderInformationCell cellWithTableView:tableView indexPath:indexPath];
            cell.accountCodeLable.text = self.orderModel.accountcode;
            
            if (self.orderModel.accountperiod == nil)
            {
                cell.postPaidNotCheckBillsDataModel = self.postPaidNotCheckBillsDataModel;
            }
            else
            {
                cell.accountperiodLable.text = self.orderModel.accountperiod;
                cell.moneyLable.text = [NSString stringWithFormat:@"%.2f 元",[self.orderModel.money floatValue]];
            }
            
            return cell;
        }
        
    }
    else
    {
        LQPayWayCell *cell = [LQPayWayCell cellWithTableView:tableView indexPath:indexPath];
        
        if (indexPath.row == 0)
        {
            self.btn = cell.choosePayBtn;
        }
        
        return cell;
    }
}

#pragma mark   -
#pragma mark   ==============UITableViewDelegate==============
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
        {
            return self.orderModel.rechmodle == 1?75:105;
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
    }
    else
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

#pragma mark -
#pragma mark   ==============网络请求==============
/**
 *  获取未结账期
 */
- (void)requestGetNotCheckBills
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
    hud.labelText = HTTPRequestLoding_Text;
    hud.mode = MBProgressHUDModeIndeterminate;
    
    NSDictionary *accountDic = [NSMutableDictionary dictionaryWithDictionary:[[LQKeyValueStore shareInstance].keyValueStore getObjectById:SQL_Account_Key fromTable:SQL_Account_TableName]];
    NSString *sessionid  = [accountDic valueForKey:@"sessionid"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/energy/do/chargeapp/getnotcheckbills.do?;sessionid=%@",IP,sessionid];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"AccountId":self.orderModel.accountid};
    
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        LQLog(@"----------------%@",operation.responseString);
        
        [hud hide:YES];
        
        self.postPaidNotCheckBillsDataModel = [LQPostPaidNotCheckBillsDataModel objectWithKeyValues:operation.responseString];
        
        if (self.postPaidNotCheckBillsDataModel.returns)
        {
            [self.tableView reloadData];
        }
        else
        {
            if ([self.postPaidNotCheckBillsDataModel.code isEqualToString:@"1006"])
            {
                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"当前用户不存在或者已经超时，请重新登录"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles: nil];
                [alter show];
            }
            else
            {
                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:self.postPaidNotCheckBillsDataModel.info
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles: nil];
                [alter show];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        LQLog(@"%@",error);
        
        [hud hide:YES];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = HTTPRequestErrer_Text;
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.5];
    }];
}

#pragma mark   -
#pragma mark   ==============UIAlertViewDelegate==============
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSMutableDictionary *accountDic = [NSMutableDictionary dictionaryWithDictionary:[[LQKeyValueStore shareInstance].keyValueStore getObjectById:SQL_Account_Key fromTable:SQL_Account_TableName]];
    accountDic[@"loginSuccess"] = [NSNumber numberWithBool:NO];
    [[LQKeyValueStore shareInstance].keyValueStore putObject:accountDic withId:SQL_Account_Key intoTable:SQL_Account_TableName];
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark -
#pragma mark   ==============产生随机订单号==============
/**
 *  生成订单号
 */
- (NSString *)generateTradeNO
{
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return sourceStr;
}

#pragma mark -
#pragma mark   ==============点击订单模拟支付行为==============
/**
 *  点击支付按钮进行支付操作
 */
- (void)pay
{
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    /*============================================================================*/
    /*=======================需要填写商户app申请的================================*/
    /*============================================================================*/
    NSString *partner = @"";
    NSString *seller = @"";
    NSString *privateKey = @"";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.productName = @"09月用电结算"; //商品标题
    order.productDescription = @"09月用电结算"; //商品描述
    order.amount = @"100.00"; //商品价格
    order.notifyURL =  @"http://www.xxx.com"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"alisdkdemo";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
    
}

@end
