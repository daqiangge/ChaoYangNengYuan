//
//  ContactSettingViewController.m
//  PUER
//
//  Created by admin on 14-8-14.
//  Copyright (c) 2014年 com.dieshang.PUER. All rights reserved.
//
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-----------------------修改联系方式--------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------

#import "ContactSettingViewController.h"

@interface ContactSettingViewController ()

@end

@implementation ContactSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //防止键盘遮挡住输入框
    _keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
    
    self.navigationItem.title = @"修改联系方式";
    
    [self doLoading];
    [self doRequest];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - 加载视图控件
- (void)doLoading
{
    UILabel *emailLable                = [[UILabel alloc] init];
    UILabel *smsLable                  = [[UILabel alloc] init];
    _emailTextField                    = [[LQNoCopyTextField alloc] init];
    _smsTextField                      = [[LQNoCopyTextField alloc] init];
    
    emailLable.frame                  = CGRectMake(10, 20+64, 200, 20);
    self.emailTextField.frame          = CGRectMake(emailLable.frame.origin.x, emailLable.frame.origin.y+emailLable.frame.size.height+5, LQScreen_Width-20, TextField_height);
    smsLable.frame                     = CGRectMake(emailLable.frame.origin.x, self.emailTextField.frame.origin.y+self.emailTextField.frame.size.height+20, emailLable.frame.size.width, emailLable.frame.size.height);
    self.smsTextField.frame            = CGRectMake(emailLable.frame.origin.x, smsLable.frame.origin.y+smsLable.frame.size.height+5, self.emailTextField.frame.size.width, TextField_height);
    
    self.emailTextField.backgroundColor        = TextField_backgroundCollor;
    self.smsTextField.backgroundColor          = TextField_backgroundCollor;
    
    //画框
    self.emailTextField.layer.cornerRadius        = Layer_CornerRadius;
    self.emailTextField.layer.borderWidth         = Layer_BorderWidth;
    self.emailTextField.layer.borderColor         = Layer_BorderColor;
    self.smsTextField.layer.cornerRadius          = Layer_CornerRadius;
    self.smsTextField.layer.borderWidth           = Layer_BorderWidth;
    self.smsTextField.layer.borderColor           = Layer_BorderColor;
    
    //设置邮箱和联系方式的lable
    emailLable.text                       = @"邮箱：";
    smsLable.text                         = @"联系电话：";
    
    //向左对其
    emailLable.textAlignment              = NSTextAlignmentLeft;
    smsLable.textAlignment                = NSTextAlignmentLeft;
    
    //字体大小
    emailLable.font                       = [UIFont systemFontOfSize:15];
    smsLable.font                         = [UIFont systemFontOfSize:15];
    
    //textfield的回调方法
    self.emailTextField.delegate          = self;
    self.smsTextField.delegate            = self;
    
    //向左对其
    self.emailTextField.textAlignment     = NSTextAlignmentLeft;
    self.smsTextField.textAlignment       = NSTextAlignmentLeft;
    
    //输入框的键盘样式
    self.emailTextField.keyboardType      = UIKeyboardTypeASCIICapable;
    self.smsTextField.keyboardType        = UIKeyboardTypeASCIICapable;
    
    [self.view addSubview:emailLable];
    [self.view addSubview:smsLable];
    [self.view addSubview:self.emailTextField];
    [self.view addSubview:self.smsTextField];
    
    //确定按钮
    UIButton *saveButton               = [[UIButton alloc] init];
    saveButton.frame                   = CGRectMake(emailLable.frame.origin.x, self.smsTextField.frame.origin.y+self.smsTextField.frame.size.height+35, self.smsTextField.frame.size.width, 40);
    saveButton.layer.cornerRadius      = 2;
    saveButton.layer.borderColor       = [UIColor clearColor].CGColor;
    saveButton.backgroundColor         = [UIColor colorWithRed:92/255.0 green:184/255.0 blue:92/255.0 alpha:1];
    [saveButton setTitle:@"确定" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveEmailandTel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
}

#pragma mark - 网络请求
- (void)doRequest
{
    
}

#pragma mark - 保存操作
- (void)saveEmailandTel
{
    [self.view endEditing:YES];
    
    if (![self.emailTextField.text isEqualToString:@""])
    {
        if (![[Regex shareInstance] judgeEmail:self.emailTextField.text])
        {
            return;
        }
    }
    
    if (![self.smsTextField.text isEqualToString:@""])
    {
        if (![[Regex shareInstance] judgeTelNumAndLandlineNum:self.smsTextField.text])
        {
            return;
        }
    }
    
}

#pragma mark - Textfield Delegate
//释放键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

//限制输入框字符串长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"])  //按会车可以改变
        
    {
        return YES;
    }
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if (self.emailTextField == textField)
    {
        if ([toBeString length] > 128)
        {
            //如果粘贴内容大于128，将只截取前128的字符
            textField.text = [toBeString substringToIndex:128];
            
            return NO;
            
        }
    }
    else if (self.smsTextField == textField)
    {
        for (int i = 0; i<[toBeString length]; i++)
        {
        //截取字符串中的每一个字符
        NSString *s = [toBeString substringWithRange:NSMakeRange(i, 1)];
        if (![[Regex shareInstance] judgeContactSettingViewTel:s])
        {
            return NO;
        }
    }
        if ([toBeString length] > 20)
        {
            //如果粘贴内容大于11，将只截取前11的字符
            textField.text = [toBeString substringToIndex:20];
            
            return NO;
        }

    }
    
    //判读是是否有中文
    for (int i = 0; i<[toBeString length]; i++) {
        //截取字符串中的每一个字符
        NSString *s = [toBeString substringWithRange:NSMakeRange(i, 1)];
        if ([[Regex shareInstance] judgeChinese:s]) {
            return NO;
        }
    }
    
    return YES;
}

@end
