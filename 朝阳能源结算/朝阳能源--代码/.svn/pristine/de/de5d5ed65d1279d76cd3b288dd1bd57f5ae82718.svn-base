//
//  LQForgetPasswordVC.m
//  朝阳能源结算
//
//  Created by admin on 15/9/15.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQForgetPasswordVC.h"

@interface LQForgetPasswordVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn1;
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn2;

@end

@implementation LQForgetPasswordVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"忘记密码";
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
    if (self.chooseBtn1.selected)
    {
        [self doRequest:@"fromTel"];
    }
    else if (self.chooseBtn2.selected)
    {
        [self doRequest:@"fromEmail"];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - 发起网络请求
- (void)doRequest:(NSString *)string
{
    
}

#pragma mark - Textfield Delegate
//限制textfield字符长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"])  //按会车可以改变
    {
        return YES;
    }
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if ([toBeString length] > 11)
    {
        textField.text = [toBeString substringToIndex:11];
        
        return NO;
    }
    return YES;
}


@end
