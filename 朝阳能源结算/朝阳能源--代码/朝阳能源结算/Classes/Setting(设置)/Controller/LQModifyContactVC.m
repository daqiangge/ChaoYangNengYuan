//
//  LQModifyContactVC.m
//  朝阳能源结算
//
//  Created by admin on 15/9/21.
//  Copyright © 2015年 dieshang. All rights reserved.
//

#import "LQModifyContactVC.h"
#import "LQContactModel.h"
#import "LQModifyContactModel.h"

@interface LQModifyContactVC ()<UITextFieldDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet LQNoCopyTextField *emailTextField;
@property (weak, nonatomic) IBOutlet LQNoCopyTextField *telNumTextFIeld;
@property (weak, nonatomic) IBOutlet UIButton *determineBtn;

@end

@implementation LQModifyContactVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"修改联系方式";
    
    [self doLoading];
    [self requestGetContact];
    
}

- (void)doLoading
{
    self.determineBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.determineBtn.layer.borderWidth = Layer_BorderWidth;
    self.determineBtn.layer.cornerRadius = Layer_CornerRadius;
    self.determineBtn.layer.masksToBounds = YES;
}

- (IBAction)clickDetermineBtn:(UIButton *)sender
{
    [self.view endEditing:YES];
    
    if (self.telNumTextFIeld.text.length == 0)
    {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"请填写联系电话"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles: nil];
        [alterView show];
        
        return;
    }
    
    if (self.emailTextField.text.length != 0 && ![[Regex shareInstance] judgeEmail:self.emailTextField.text])
    {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"请填写正确的邮箱地址"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles: nil];
        [alterView show];
        
        return;
    }
    
    [self doRequestUpdateContact];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - 网络请求
- (void)requestGetContact
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] animated:YES];
    hud.mode           = MBProgressHUDModeIndeterminate;
    hud.labelText      = @"正在加载...";
    
    NSMutableDictionary *accountDic = [NSMutableDictionary dictionaryWithDictionary:[[LQKeyValueStore shareInstance].keyValueStore getObjectById:SQL_Account_Key fromTable:SQL_Account_TableName]];
    NSString *sessionid = accountDic[@"sessionid"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr                       = [NSString stringWithFormat:@"%@getsingleuser.do;sessionid=%@",[LQUrlString shareInstance].urlStr,sessionid];
    
    LQLog(@"%@",urlStr);
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         LQLog(@"%@",operation.responseString);
         
         [hud hide:YES];
         
         LQContactModel *contactModel = [LQContactModel objectWithKeyValues:operation.responseString];
         
         if (contactModel.returns)
         {
             self.emailTextField.text = contactModel.linkemail;
             self.telNumTextFIeld.text = contactModel.linkmobile;
         }
         else
         {
             if ([contactModel.code isEqualToString:@"1006"])
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
                                                                 message:contactModel.info
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


- (void)doRequestUpdateContact
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] animated:YES];
    hud.mode           = MBProgressHUDModeIndeterminate;
    hud.labelText      = @"正在修改...";
    
    NSMutableDictionary *accountDic = [NSMutableDictionary dictionaryWithDictionary:[[LQKeyValueStore shareInstance].keyValueStore getObjectById:SQL_Account_Key fromTable:SQL_Account_TableName]];
    NSString *sessionid = accountDic[@"sessionid"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr                       = [NSString stringWithFormat:@"%@updatecontact.do;sessionid=%@",[LQUrlString shareInstance].urlStr,sessionid];
    NSDictionary *parameters = @{@"LinkMobile":self.telNumTextFIeld.text,@"LinkEMail":self.emailTextField.text};
    
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         LQLog(@"%@",operation.responseString);
         
         LQModifyContactModel *model = [LQModifyContactModel objectWithKeyValues:operation.responseString];
         
         if (model.returns)
         {
             accountDic[@"loginSuccess"] = [NSNumber numberWithBool:NO];
             [[LQKeyValueStore shareInstance].keyValueStore putObject:accountDic withId:SQL_Account_Key intoTable:SQL_Account_TableName];
             
             hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
             hud.mode = MBProgressHUDModeCustomView;
             hud.labelText = @"修改成功";
             [hud hide:YES afterDelay:1.5];
         }
         else
         {
             [hud hide:YES];
             
             if ([model.code isEqualToString:@"1006"])
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
                                                                 message:model.info
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

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSMutableDictionary *accountDic = [NSMutableDictionary dictionaryWithDictionary:[[LQKeyValueStore shareInstance].keyValueStore getObjectById:SQL_Account_Key fromTable:SQL_Account_TableName]];
    accountDic[@"loginSuccess"] = [NSNumber numberWithBool:NO];
    [[LQKeyValueStore shareInstance].keyValueStore putObject:accountDic withId:SQL_Account_Key intoTable:SQL_Account_TableName];
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if (self.emailTextField == textField)
    {
        if ([toBeString length] > 128)
        {
            textField.text = [toBeString substringToIndex:128];
            
            return NO;
        }
    }
    else if (self.telNumTextFIeld == textField)
    {
        if ([toBeString length] > 11)
        {
            textField.text = [toBeString substringToIndex:11];
            
            return NO;
        }
        
        return [[Regex shareInstance] isTelNum:toBeString];
    }
    
    return YES;
}


@end
