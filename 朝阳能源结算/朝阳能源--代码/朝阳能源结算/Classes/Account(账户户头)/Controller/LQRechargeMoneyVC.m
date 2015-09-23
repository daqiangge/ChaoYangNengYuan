//
//  LQRechargeMoneyVC.m
//  朝阳能源结算
//
//  Created by admin on 15/9/18.
//  Copyright © 2015年 dieshang. All rights reserved.
//

#import "LQRechargeMoneyVC.h"
#import "LQAccountItemModel.h"
#import "LQMeterDataModel.h"
#import "LQOrderVC.h"

@interface LQRechargeMoneyVC ()<UITextFieldDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *currentamountTextField;//当前示数输入框
@property (weak, nonatomic) IBOutlet UILabel     *currentAmonutUnitLabel;//当前示数单位

@property (weak, nonatomic) IBOutlet UITextField *surplusamountTextField;//剩余量输入框

@property (weak, nonatomic) IBOutlet LQNoCopyTextField *rechargeMoneyTextFIeld;//充值金额输入框

@property (weak, nonatomic) IBOutlet UIButton    *fiftyYuanBtn;//50
@property (weak, nonatomic) IBOutlet UIButton    *hundredYuanBtn;//100
@property (weak, nonatomic) IBOutlet UIButton    *twoHundredYuanBtn;//200

@property (weak, nonatomic) IBOutlet UIButton    *rechargeBtn;//充值按钮

@end

@implementation LQRechargeMoneyVC

- (void)setAccountItemModel:(LQAccountItemModel *)accountItemModel
{
    _accountItemModel = accountItemModel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@(充值)",self.accountItemModel.accountcode];
    
    NSMutableDictionary *accountDic = [NSMutableDictionary dictionaryWithDictionary:[[LQKeyValueStore shareInstance].keyValueStore getObjectById:SQL_Account_Key fromTable:SQL_Account_TableName]];
    NSString *sessionid  = [accountDic valueForKey:@"sessionid"];
    
    [self doLoading];
    [self requestMeterdataWithSessionid:sessionid itemModel:self.accountItemModel];
}

- (void)doLoading
{
    [self setBtnLayerWithBtn:self.fiftyYuanBtn       borderColor:[UIColor lightGrayColor]];
    [self setBtnLayerWithBtn:self.hundredYuanBtn     borderColor:[UIColor lightGrayColor]];
    [self setBtnLayerWithBtn:self.twoHundredYuanBtn  borderColor:[UIColor lightGrayColor]];
    [self setBtnLayerWithBtn:self.rechargeBtn        borderColor:[UIColor clearColor]];
    self.rechargeBtn.layer.masksToBounds = YES;
    
    self.currentAmonutUnitLabel.text = self.accountItemModel.eunit;
}

- (void)reloadView
{
    self.rechargeMoneyTextFIeld.text = @"50.00";
    
    self.currentamountTextField.text = self.accountItemModel.currentamount;
    self.surplusamountTextField.text = self.accountItemModel.surplusmoney;
}

- (void)setBtnLayerWithBtn:(UIButton *)btn borderColor:(UIColor *)color
{
    btn.layer.cornerRadius = 5;
    btn.layer.borderColor  = color.CGColor;
    btn.layer.borderWidth  = 1;
}

/**
 *  点击了“元”按钮
 */
- (IBAction)clickYuanBtn:(UIButton *)sender
{
    [self.view endEditing:YES];
    
    self.rechargeMoneyTextFIeld.text = [NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%ld",sender.tag] floatValue]];
}

- (IBAction)clickRechargeBtn:(UIButton *)sender
{
    if (self.rechargeMoneyTextFIeld.text.length == 0)
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请填写充值金额"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil];
        [alter show];
        
        return;
    }
    
    LQOrderVC *vc = [[LQOrderVC alloc] init];
    vc.accountItemModel = self.accountItemModel;
    vc.rechargeMoney = self.rechargeMoneyTextFIeld.text;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - 网络请求
/**
 *  获取表具当前示数
 */
- (void)requestMeterdataWithSessionid:(NSString *)sessionid itemModel:(LQAccountItemModel *)itemModel
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
    hud.labelText = HTTPRequestLoding_Text;
    hud.mode = MBProgressHUDModeIndeterminate;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"%@/energy/do/chargeapp/getmeterdata.do?;sessionid=%@",IP,sessionid];
    NSDictionary *parameters = @{@"Accountid":itemModel.accountid,@"MeterId":itemModel.meterid};
    
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         LQLog(@"%@",operation.responseString);
         
         [hud hide:YES];
         
         LQMeterDataModel *meterDataModel = [LQMeterDataModel objectWithKeyValues:operation.responseString];
         
         if (meterDataModel.returns)
         {
             self.accountItemModel.currentamount = meterDataModel.currentamount;
             self.accountItemModel.surplusamount = meterDataModel.surplusamount;
             self.accountItemModel.surplusmoney  = meterDataModel.surplusmoney;
             self.accountItemModel.price         = meterDataModel.price;
             
             if (meterDataModel.currentamount == nil)
             {
                 self.accountItemModel.currentamount = @"(未知)";
             }
             
             if (meterDataModel.surplusamount == nil)
             {
                 self.accountItemModel.surplusamount = @"(未知)";
             }
             
             if (meterDataModel.surplusmoney == nil)
             {
                 self.accountItemModel.surplusmoney = @"(未知)";
             }
             
             if (meterDataModel.price == nil)
             {
                 self.accountItemModel.price = @"(未知)";
             }
             
         }
         else
         {
             self.accountItemModel.currentamount = @"(未知)";
             self.accountItemModel.surplusamount = @"(未知)";
             self.accountItemModel.surplusmoney  = @"(未知)";
             self.accountItemModel.price         = @"(未知)";
             
             if ([meterDataModel.code isEqualToString:@"1006"])
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
                                                                 message:meterDataModel.info
                                                                delegate:nil
                                                       cancelButtonTitle:@"确定"
                                                       otherButtonTitles: nil];
                 [alter show];
             }
         }
         
         [self reloadView];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         LQLog(@"%@",error);
         
         self.accountItemModel.currentamount = @"(未知)";
         self.accountItemModel.surplusamount = @"(未知)";
         self.accountItemModel.surplusmoney  = @"(未知)";
         self.accountItemModel.price         = @"(未知)";
         
         [hud hide:YES];
         
         MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
         hud.labelText = HTTPRequestErrer_Text;
         hud.mode = MBProgressHUDModeText;
         [hud hide:YES afterDelay:1.5];
         
         [self reloadView];
     }];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSMutableDictionary *accountDic = [NSMutableDictionary dictionaryWithDictionary:[[LQKeyValueStore shareInstance].keyValueStore getObjectById:SQL_Account_Key fromTable:SQL_Account_TableName]];
    accountDic[@"loginSuccess"] = [NSNumber numberWithBool:NO];
    [[LQKeyValueStore shareInstance].keyValueStore putObject:accountDic withId:SQL_Account_Key intoTable:SQL_Account_TableName];
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if (toBeString.length>0)
    {
        if ([toBeString length] > 10)
        {
            textField.text = [toBeString substringToIndex:10];
            return NO;
        }
        
        if ([[Regex shareInstance] judgeNumber:toBeString])
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    return YES;
}

@end
