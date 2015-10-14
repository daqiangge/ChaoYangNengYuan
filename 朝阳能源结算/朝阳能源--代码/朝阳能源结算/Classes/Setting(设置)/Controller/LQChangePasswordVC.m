//
//  LQChangePasswordVC.m
//  朝阳能源结算
//
//  Created by admin on 15/8/5.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQChangePasswordVC.h"
#import "LQChangePasswordModel.h"

#define StrengthView_Nomer_Color [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]
#define StrengthView_StrengthWeak_Color [UIColor colorWithRed:177/255.0 green:76/255.0 blue:4/255.0 alpha:1]
#define StrengthView_StrengthMedium_Color [UIColor colorWithRed:255/255.0 green:255/255.0 blue:11/255.0 alpha:1]
#define StrengthView_StrengthStrong_Color [UIColor colorWithRed:35/255.0 green:255/255.0 blue:6/255.0 alpha:1]

@interface LQChangePasswordVC ()<UITextFieldDelegate,UIKeyboardViewControllerDelegate,UIAlertViewDelegate>

@property (nonatomic,retain) UIKeyboardViewController *keyBoardController;

@property (weak, nonatomic) IBOutlet LQNoCopyTextField *oldPasswordTextField;
@property (weak, nonatomic) IBOutlet LQNoCopyTextField *confirmNewPasswordTextField;
@property (weak, nonatomic) IBOutlet LQNoCopyTextField *myNewPasswordTextField;
@property (weak, nonatomic) IBOutlet UIView      *strength1;
@property (weak, nonatomic) IBOutlet UIView      *strength2;
@property (weak, nonatomic) IBOutlet UIView      *strength3;
@property (weak, nonatomic) IBOutlet UIView      *strength4;
@property (weak, nonatomic) IBOutlet UIView      *strength5;
@property (weak, nonatomic) IBOutlet UIView      *strength6;
@property (weak, nonatomic) IBOutlet UIButton *determineBtn;

@end

@implementation LQChangePasswordVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"修改密码";
    
    self.keyBoardController = [[UIKeyboardViewController alloc] initWithControllerDelegate:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(judgePasswordStrength) name:UITextFieldTextDidChangeNotification object:nil];
    
    [self doLoading];
}

- (void)doLoading
{
    self.determineBtn.layer.borderColor   = [UIColor clearColor].CGColor;
    self.determineBtn.layer.borderWidth   = Layer_BorderWidth;
    self.determineBtn.layer.cornerRadius  = Layer_CornerRadius;
    self.determineBtn.layer.masksToBounds = YES;
    
    self.strength1.backgroundColor = StrengthView_Nomer_Color;
    self.strength2.backgroundColor = StrengthView_Nomer_Color;
    self.strength3.backgroundColor = StrengthView_Nomer_Color;
    self.strength4.backgroundColor = StrengthView_Nomer_Color;
    self.strength5.backgroundColor = StrengthView_Nomer_Color;
    self.strength6.backgroundColor = StrengthView_Nomer_Color;
}

- (IBAction)clickDetermineBtn:(UIButton *)sender
{
    [self.view endEditing:YES];
    
    if ([self.oldPasswordTextField.text isEqualToString: @""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"旧密码不能为空"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    if ([self.myNewPasswordTextField.text isEqualToString: @""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"新密码不能为空"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    if ([self.confirmNewPasswordTextField.text isEqualToString: @""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"确认新密码不能为空"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    if (self.oldPasswordTextField.text.length < 6 || self.myNewPasswordTextField.text.length < 6 || self.confirmNewPasswordTextField.text.length < 6)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请检查您的密码，密码长度为6～20之间"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    if (![self.myNewPasswordTextField.text isEqualToString:self.confirmNewPasswordTextField.text])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"两次新密码不相同，请检查您的密码"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    [self doRequest];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - 网络请求
- (void)doRequest
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] animated:YES];
    hud.mode           = MBProgressHUDModeIndeterminate;
    hud.labelText      = @"正在修改...";
    
    YTKKeyValueStore *store      = [[YTKKeyValueStore alloc] initDBWithName:SQL_Name];
    NSMutableDictionary *accountDic = [NSMutableDictionary dictionaryWithDictionary:[store getObjectById:SQL_Account_Key fromTable:SQL_Account_TableName]];
    NSString *sessionid = accountDic[@"sessionid"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr                       = [NSString stringWithFormat:@"%@updatepwd.do;sessionid=%@",[LQUrlString shareInstance].urlStr,sessionid];
    NSDictionary *parameters = @{@"OldPwd":self.oldPasswordTextField.text,@"NewPwd":self.confirmNewPasswordTextField.text};
    
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         LQLog(@"%@",operation.responseString);
         
         LQChangePasswordModel *model = [LQChangePasswordModel objectWithKeyValues:operation.responseString];
         
         if (model.returns)
         {
             hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
             hud.mode = MBProgressHUDModeCustomView;
             hud.labelText = @"修改成功";
             [hud hide:YES afterDelay:1.5];
             
             [self.navigationController popViewControllerAnimated:YES];
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

#pragma mark - Textfield Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    
    return YES;
}

//限制输入框字符串长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if ([toBeString length] > 20)
    {
        textField.text = [toBeString substringToIndex:20];
        return NO;
    }
    
    return YES;
}

#pragma mark - dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 密码强度的判断
//判断输入框的字符种类
- (BOOL) judgeRange:(NSArray*) _termArray Password:(NSString*) _password
{
    NSRange range;
    BOOL result =NO;
    for(int i=0; i<[_termArray count]; i++)
    {
        range = [_password rangeOfString:[_termArray objectAtIndex:i]];
        if(range.location != NSNotFound)
        {
            result =YES;
        }
    }
    return result;
}

//条件
- (void)judgePasswordStrength
{
    NSString *_password =self.myNewPasswordTextField.text;
    
    NSMutableArray* resultArray = [[NSMutableArray alloc] init];
    NSArray* termArray1 = [[NSArray alloc] initWithObjects:@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z", nil];
    NSArray* termArray2 = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", nil];
    NSArray* termArray3 = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    NSArray* termArray4 = [[NSArray alloc] initWithObjects:@"~",@"`",@"@",@"#",@"$",@"%",@"^",@"&",@"*",@"(",@")",@"-",@"_",@"+",@"=",@"{",@"}",@"[",@"]",@"|",@":",@";",@"“",@"'",@"‘",@"<",@",",@".",@">",@"?",@"/",@"、", nil];
    
    NSString* result1 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray1 Password:_password]];
    NSString* result2 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray2 Password:_password]];
    NSString* result3 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray3 Password:_password]];
    NSString* result4 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray4 Password:_password]];
    
    [resultArray addObject:[NSString stringWithFormat:@"%@",result1]];
    [resultArray addObject:[NSString stringWithFormat:@"%@",result2]];
    [resultArray addObject:[NSString stringWithFormat:@"%@",result3]];
    [resultArray addObject:[NSString stringWithFormat:@"%@",result4]];
    
    int intResult=0;
    
    for (int j=0; j<[resultArray count]; j++)
    {
        if ([[resultArray objectAtIndex:j] isEqualToString:@"1"])
        {
            intResult++;
        }
    }
    
    NSString* resultString = [[NSString alloc] init];
    if ([_password length] == 0)
    {
        resultString = @"空";
        [self showPasswordStrength:resultString];
    }
    else if (intResult <2 && [_password length]<6 && [_password length]>0)
    {
        resultString = @"弱1";
        [self showPasswordStrength:resultString];
    }
    else if (intResult < 2 && [_password length]>=6)
    {
        resultString = @"弱2";
        [self showPasswordStrength:resultString];
    }
    else if (intResult == 2 && [_password length]>=6 && [_password length]<8)
    {
        resultString = @"中1";
        [self showPasswordStrength:resultString];
    }
    else if (intResult == 2 && [_password length]>=8 && [_password length]<12)
    {
        resultString = @"中2";
        [self showPasswordStrength:resultString];
    }
    else if (intResult > 2&&[_password length]>=12 && [_password length]<15)
    {
        resultString = @"强1";
        [self showPasswordStrength:resultString];
    }else if (intResult > 2&&[_password length]>=15)
    {
        resultString = @"强2";
        [self showPasswordStrength:resultString];
    }
}

#pragma mark - 密码强度的展现
- (void)showPasswordStrength:(NSString *)string
{
    if ([string isEqualToString:@"弱1"])
    {
        self.strength1.backgroundColor = StrengthView_StrengthWeak_Color;
        self.strength2.backgroundColor = StrengthView_Nomer_Color;
        self.strength3.backgroundColor = StrengthView_Nomer_Color;
        self.strength4.backgroundColor = StrengthView_Nomer_Color;
        self.strength5.backgroundColor = StrengthView_Nomer_Color;
        self.strength6.backgroundColor = StrengthView_Nomer_Color;
    }
    else if ([string isEqualToString:@"弱2"])
    {
        self.strength1.backgroundColor = StrengthView_StrengthWeak_Color;
        self.strength2.backgroundColor = StrengthView_StrengthWeak_Color;
        self.strength3.backgroundColor = StrengthView_Nomer_Color;
        self.strength4.backgroundColor = StrengthView_Nomer_Color;
        self.strength5.backgroundColor = StrengthView_Nomer_Color;
        self.strength6.backgroundColor = StrengthView_Nomer_Color;
    }
    else if ([string isEqualToString:@"中1"])
    {
        self.strength1.backgroundColor = StrengthView_StrengthMedium_Color;
        self.strength2.backgroundColor = StrengthView_StrengthMedium_Color;
        self.strength3.backgroundColor = StrengthView_StrengthMedium_Color;
        self.strength4.backgroundColor = StrengthView_Nomer_Color;
        self.strength5.backgroundColor = StrengthView_Nomer_Color;
        self.strength6.backgroundColor = StrengthView_Nomer_Color;
    }
    else if ([string isEqualToString:@"中2"])
    {
        self.strength1.backgroundColor = StrengthView_StrengthMedium_Color;
        self.strength2.backgroundColor = StrengthView_StrengthMedium_Color;
        self.strength3.backgroundColor = StrengthView_StrengthMedium_Color;
        self.strength4.backgroundColor = StrengthView_StrengthMedium_Color;
        self.strength5.backgroundColor = StrengthView_Nomer_Color;
        self.strength6.backgroundColor = StrengthView_Nomer_Color;
    }
    else if ([string isEqualToString:@"强1"])
    {
        self.strength1.backgroundColor = StrengthView_StrengthStrong_Color;
        self.strength2.backgroundColor = StrengthView_StrengthStrong_Color;
        self.strength3.backgroundColor = StrengthView_StrengthStrong_Color;
        self.strength4.backgroundColor = StrengthView_StrengthStrong_Color;
        self.strength5.backgroundColor = StrengthView_StrengthStrong_Color;
        self.strength6.backgroundColor = StrengthView_Nomer_Color;
    }
    else if ([string isEqualToString:@"强2"])
    {
        self.strength1.backgroundColor = StrengthView_StrengthStrong_Color;
        self.strength2.backgroundColor = StrengthView_StrengthStrong_Color;
        self.strength3.backgroundColor = StrengthView_StrengthStrong_Color;
        self.strength4.backgroundColor = StrengthView_StrengthStrong_Color;
        self.strength5.backgroundColor = StrengthView_StrengthStrong_Color;
        self.strength6.backgroundColor = StrengthView_StrengthStrong_Color;
    }
    
    if ([string isEqualToString:@"空"])
    {
        self.strength1.backgroundColor = StrengthView_Nomer_Color;
        self.strength2.backgroundColor = StrengthView_Nomer_Color;
        self.strength3.backgroundColor = StrengthView_Nomer_Color;
        self.strength4.backgroundColor = StrengthView_Nomer_Color;
        self.strength5.backgroundColor = StrengthView_Nomer_Color;
        self.strength6.backgroundColor = StrengthView_Nomer_Color;
    }
}

@end
