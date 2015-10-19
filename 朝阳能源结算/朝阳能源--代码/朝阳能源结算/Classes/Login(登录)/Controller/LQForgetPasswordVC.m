//
//  LQForgetPasswordVC.m
//  朝阳能源结算
//
//  Created by admin on 15/9/15.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQForgetPasswordVC.h"
#import "LQForgetPasswordModel.h"

@interface LQForgetPasswordVC ()<UITextFieldDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn1;
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn2;
@property (weak, nonatomic) IBOutlet LQNoCopyTextField *accountNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *determineBtn;

@end

@implementation LQForgetPasswordVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"忘记密码";
    
    [self doLoading];
}

- (void)doLoading
{
    self.determineBtn.layer.borderColor   = [UIColor clearColor].CGColor;
    self.determineBtn.layer.borderWidth   = Layer_BorderWidth;
    self.determineBtn.layer.cornerRadius  = Layer_CornerRadius;
    self.determineBtn.layer.masksToBounds = YES;
}

- (IBAction)clickChooseBtn1:(UIButton *)sender
{
    self.chooseBtn1.selected = YES;
    self.chooseBtn2.selected = NO;
}

- (IBAction)clickChooseBtn2:(UIButton *)sender
{
    self.chooseBtn2.selected = YES;
    self.chooseBtn1.selected = NO;
    
}

- (IBAction)clickDetermineBtn:(UIButton *)sender
{
    [self.view endEditing:YES];
    
    //获取上一次存入的IP数据
    NSMutableDictionary *ipDic = [[LQKeyValueStore shareInstance].keyValueStore getObjectById:SQL_IP_Key fromTable:SQL_Account_TableName];
    NSString *name = ipDic[@"name"];
    NSString *accountid = ipDic[@"accountid"];
    NSString *note = ipDic[@"note"];
    
    if (name == nil || accountid == nil || note == nil)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"未选择接入点，请返回登录进行选择。"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"确定", nil];
        [alertView show];
        
        return;
    }
    
    if ([self.accountNameTextField.text isEqualToString:@""])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"请输入您的用户名"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];
        
        return;
    }
    
    if (self.chooseBtn1.selected)
    {
        [self doRequest:@"sendtotel"];
    }
    else if (self.chooseBtn2.selected)
    {
        [self doRequest:@"sendtoemail"];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - 发起网络请求
- (void)doRequest:(NSString *)string
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"正在发送...";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@.do",[LQUrlString shareInstance].urlStr,string];
    NSDictionary *parameters = @{@"LinkMobile":self.accountNameTextField.text};
    
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        LQForgetPasswordModel *model = [LQForgetPasswordModel objectWithKeyValues:operation.responseString];
        
        if (model.returns)
        {
            hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
            hud.mode = MBProgressHUDModeCustomView;
            hud.labelText = @"发送成功";
            [hud hide:YES afterDelay:1.5];
        }
        else
        {
            [hud  hide:YES];
            
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"发送失败，请稍后重试"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles: nil];
            [alter show];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        LQLog(@"%@",error);
        
        [hud  hide:YES];
        
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"发送失败，请稍后重试"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil];
        [alter show];
    }];
}


#pragma mark -
#pragma mark ==============UIAlertViewDelegate==============
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Textfield Delegate
//限制textfield字符长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if ([toBeString length] > 11)
    {
        textField.text = [toBeString substringToIndex:11];
        
        return NO;
    }
    
    return [[Regex shareInstance] isTelNum:toBeString];
}


@end
