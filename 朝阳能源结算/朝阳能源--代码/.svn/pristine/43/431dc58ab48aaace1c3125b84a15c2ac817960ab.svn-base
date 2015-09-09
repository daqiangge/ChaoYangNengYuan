//
//  PwdSettingViewController.m
//  PUER
//
//  Created by admin on 14-8-14.
//  Copyright (c) 2014年 com.dieshang.PUER. All rights reserved.
//

#import "PwdSettingViewController.h"

#define TextField_backgroundCollor [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1]
#define PWDSTRENGTH_COLOR	 [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]

@interface PwdSettingViewController ()

@property (nonatomic,weak) LQNoCopyTextField *oldPassword;
@property (nonatomic,weak) LQNoCopyTextField *theNewPwdOne;
@property (nonatomic,weak) LQNoCopyTextField *theNewPwdTwo;

@property (nonatomic,retain) UIView *pwdStrength1;
@property (nonatomic,retain) UIView *pwdStrength2;
@property (nonatomic,retain) UIView *pwdStrength3;
@property (nonatomic,retain) UIView *pwdStrength4;
@property (nonatomic,retain) UIView *pwdStrength5;
@property (nonatomic,retain) UIView *pwdStrength6;
@property (nonatomic,retain) UILabel *pwdStrengthLable;

@end

@implementation PwdSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"修改密码";
    
    //防止键盘遮挡住输入框
    _keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
    
    //监控密码输入框
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(judgePasswordStrength) name:UITextFieldTextDidChangeNotification object:nil];
    
    _judgeBack                 = NO;
    
    [self doLoading];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    if (self.view.window == nil) {
        self.view = nil;
    }
}

- (void)setUrlStr:(NSString *)urlStr
{
    _urlStr = urlStr;
}

#pragma mark - 加载视图控件
- (void)doLoading
{
    
    //----------------------------------------旧----密----码----------------------------------------
    
    //旧密码的Lable标签
    UILabel *oldPwdLable                 = [[UILabel alloc] init];
    oldPwdLable.frame                    = CGRectMake(10, 20+64, 200, 20);
    oldPwdLable.font                     = [UIFont systemFontOfSize:15];
    oldPwdLable.text                     = @"旧密码：";
    [self.view addSubview:oldPwdLable];
    
    //旧密码的输入框
    LQNoCopyTextField *oldPassword  = [[LQNoCopyTextField alloc] init];
    oldPassword.frame               = CGRectMake(oldPwdLable.frame.origin.x, oldPwdLable.frame.origin.y+oldPwdLable.frame.size.height+5, LQScreen_Width-20, 35);
    oldPassword.delegate            = self;
    oldPassword.secureTextEntry     = YES;
    oldPassword.textAlignment       = NSTextAlignmentLeft;
    oldPassword.backgroundColor     = TextField_backgroundCollor;
    oldPassword.layer.cornerRadius  = Layer_CornerRadius;
    oldPassword.layer.borderWidth   = Layer_BorderWidth;
    oldPassword.layer.borderColor   = Layer_BorderColor;
    oldPassword.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    oldPassword.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:oldPassword];
    self.oldPassword = oldPassword;
    
    
    //----------------------------------------新----密----码----------------------------------------
    
    //新密码1的Leble的标签
    UILabel *newPwdLableOne             = [[UILabel alloc] init];
    newPwdLableOne.frame                = CGRectMake(oldPwdLable.frame.origin.x, self.oldPassword.frame.origin.y+self.oldPassword.frame.size.height+20, oldPwdLable.frame.size.width, oldPwdLable.frame.size.height);
    newPwdLableOne.font                 = oldPwdLable.font;
    newPwdLableOne.textAlignment        = oldPwdLable.textAlignment;
    newPwdLableOne.text                 = @"新密码：";
    [self.view addSubview:newPwdLableOne];
    
    //新密码输入框
    LQNoCopyTextField *theNewPwdOne                        = [[LQNoCopyTextField alloc] init];
    theNewPwdOne.frame              = CGRectMake(newPwdLableOne.frame.origin.x, newPwdLableOne.frame.origin.y+newPwdLableOne.frame.size.height+5, self.oldPassword.frame.size.width, self.oldPassword.frame.size.height);
    theNewPwdOne.delegate           = self;
    theNewPwdOne.secureTextEntry    = YES;
    theNewPwdOne.textAlignment      = NSTextAlignmentLeft;
    theNewPwdOne.backgroundColor     = TextField_backgroundCollor;
    theNewPwdOne.layer.cornerRadius  = Layer_CornerRadius;
    theNewPwdOne.layer.borderWidth   = Layer_BorderWidth;
    theNewPwdOne.layer.borderColor   = Layer_BorderColor;
    theNewPwdOne.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    theNewPwdOne.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:theNewPwdOne];
    self.theNewPwdOne = theNewPwdOne;
    
    
    //----------------------------------------密----码----强----度----------------------------------------
    
    _pwdStrength1                        = [[UIView alloc] init];
    _pwdStrength2                        = [[UIView alloc] init];
    _pwdStrength3                        = [[UIView alloc] init];
    _pwdStrength4                        = [[UIView alloc] init];
    _pwdStrength5                        = [[UIView alloc] init];
    _pwdStrength6                        = [[UIView alloc] init];
    
    self.pwdStrength1.frame                   = CGRectMake(self.theNewPwdOne.frame.origin.x+10, self.theNewPwdOne.frame.origin.y+self.theNewPwdOne.frame.size.height+10, 39, 5);
    self.pwdStrength2.frame                   = CGRectMake(self.pwdStrength1.frame.origin.x+self.pwdStrength1.frame.size.width+5, self.pwdStrength1.frame.origin.y, 39, 5);
    self.pwdStrength3.frame                   = CGRectMake(self.pwdStrength2.frame.origin.x+self.pwdStrength2.frame.size.width+5, self.pwdStrength1.frame.origin.y, 39, 5);
    self.pwdStrength4.frame                   = CGRectMake(self.pwdStrength3.frame.origin.x+self.pwdStrength3.frame.size.width+5, self.pwdStrength1.frame.origin.y, 39, 5);
    self.pwdStrength5.frame                   = CGRectMake(self.pwdStrength4.frame.origin.x+self.pwdStrength4.frame.size.width+5, self.pwdStrength1.frame.origin.y, 39, 5);
    self.pwdStrength6.frame                   = CGRectMake(self.pwdStrength5.frame.origin.x+self.pwdStrength5.frame.size.width+5, self.pwdStrength1.frame.origin.y, 39, 5);
    
    self.pwdStrength1.backgroundColor = PWDSTRENGTH_COLOR;
    self.pwdStrength2.backgroundColor = PWDSTRENGTH_COLOR;
    self.pwdStrength3.backgroundColor = PWDSTRENGTH_COLOR;
    self.pwdStrength4.backgroundColor = PWDSTRENGTH_COLOR;
    self.pwdStrength5.backgroundColor = PWDSTRENGTH_COLOR;
    self.pwdStrength6.backgroundColor = PWDSTRENGTH_COLOR;
    
    [self.view addSubview:self.pwdStrength1];
    [self.view addSubview:self.pwdStrength2];
    [self.view addSubview:self.pwdStrength3];
    [self.view addSubview:self.pwdStrength4];
    [self.view addSubview:self.pwdStrength5];
    [self.view addSubview:self.pwdStrength6];
    
    _pwdStrengthLable             = [[UILabel alloc] init];
    self.pwdStrengthLable.frame                = CGRectMake(self.pwdStrength6.frame.origin.x+self.pwdStrength6.frame.size.width+5, self.pwdStrength6.frame.origin.y-4, 15, 13);
    self.pwdStrengthLable.font                 = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    [self.view addSubview:self.pwdStrengthLable];
    
    
    //----------------------------------------确----定----新----密----码----------------------------------------
    
    //新密码1的Leble的标签
    UILabel *newPwdLableTwo             = [[UILabel alloc] init];
    newPwdLableTwo.frame                = CGRectMake(oldPwdLable.frame.origin.x, self.pwdStrength1.frame.origin.y+self.pwdStrength1.frame.size.height+20, newPwdLableOne.frame.size.width, newPwdLableOne.frame.size.height);
    newPwdLableTwo.font                 = oldPwdLable.font;
    newPwdLableTwo.textAlignment        = oldPwdLable.textAlignment;
    newPwdLableTwo.text                 = @"确认新密码：";
    [self.view addSubview:newPwdLableTwo];
    
    //新密码输入框
    LQNoCopyTextField *theNewPwdTwo       = [[LQNoCopyTextField alloc] init];
    theNewPwdTwo.frame               = CGRectMake(newPwdLableTwo.frame.origin.x, newPwdLableTwo.frame.origin.y+newPwdLableTwo.frame.size.height+5,  self.theNewPwdOne.frame.size.width,  self.theNewPwdOne.frame.size.height);
    theNewPwdTwo.delegate            = self;
    theNewPwdTwo.secureTextEntry     = YES;
    theNewPwdTwo.textAlignment       = NSTextAlignmentLeft;
    theNewPwdTwo.backgroundColor     = TextField_backgroundCollor;
    theNewPwdTwo.layer.cornerRadius  = Layer_CornerRadius;
    theNewPwdTwo.layer.borderWidth   = Layer_BorderWidth;
    theNewPwdTwo.layer.borderColor   = Layer_BorderColor;
    theNewPwdTwo.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    theNewPwdTwo.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:theNewPwdTwo];
    self.theNewPwdTwo = theNewPwdTwo;
    
    
    //----------------------------------------确----定----按----钮----------------------------------------
    
    //保存按钮
    //用于保存修改后的新密码
    UIButton *saveButton                 = [[UIButton alloc] init];
    saveButton.frame                     = CGRectMake(oldPwdLable.frame.origin.x, self.theNewPwdTwo.frame.origin.y+self.theNewPwdTwo.frame.size.height+35, self.theNewPwdTwo.frame.size.width, 40);
    saveButton.layer.cornerRadius        = 2;
    saveButton.layer.borderColor         = [UIColor clearColor].CGColor;
    saveButton.backgroundColor           = [UIColor colorWithRed:92/255.0 green:184/255.0 blue:92/255.0 alpha:1];
    [saveButton setTitle:@"确定" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveNewPasswoed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    
    
    //----------------------------------------Tap----点----击----事----件----------------------------------------
    
    //设置点击空白处释放键盘
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(releaseKeyBoard)];
    tapGestureRecognizer.numberOfTapsRequired    = 1; // * 点击空白处几下
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

#pragma mark - 确定按钮的保存操作
- (void)saveNewPasswoed
{
    if ([self.oldPassword.text isEqualToString: @""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"旧密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    if ([self.theNewPwdOne.text isEqualToString: @""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"新密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    if ([self.theNewPwdTwo.text isEqualToString: @""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认新密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    if (self.oldPassword.text.length < 6 || self.theNewPwdOne.text.length < 6 || self.theNewPwdTwo.text.length < 6) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请检查您的密码，密码长度为6～20之间" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    if (![self.theNewPwdOne.text isEqualToString:self.theNewPwdTwo.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"两次新密码不相同，请检查您的密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    [self doRequest];
}

#pragma mark - 网络请求
- (void)doRequest
{
    //等待指示器
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"正在修改...";
    
    [hud hide:YES afterDelay:1.0];
}

#pragma mark - Textfield Delegate
//释放键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self releaseKeyBoard];
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
    
    if (self.oldPassword == textField)
    {
        if ([toBeString length] > 20)
        {
            textField.text = [toBeString substringToIndex:20];
            
            return NO;
            
        }
    }
    else if (self.theNewPwdOne == textField)
    {
        if ([toBeString length] > 20)
        { //如果输入框内容大于20则弹出警告
            //如果粘贴内容大于24，将只截取前24的字符
            textField.text = [toBeString substringToIndex:20];
            
            return NO;
        }
    }
    else if (self.theNewPwdTwo == textField)
    {
        if ([toBeString length] > 20)
        { //如果输入框内容大于20则弹出警告
            //如果粘贴内容大于24，将只截取前24的字符
            textField.text = [toBeString substringToIndex:20];
            
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - 点击空白释放键盘
- (void)releaseKeyBoard
{
    [self.oldPassword  resignFirstResponder];
    [self.theNewPwdOne resignFirstResponder];
    [self.theNewPwdTwo resignFirstResponder];
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
    NSString *_password =self.theNewPwdOne.text;
    
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
    if ([_password length] == 0) {
        resultString = @"空";
        [self showPasswordStrength:resultString];
    }else if (intResult <2 && [_password length]<6 && [_password length]>0)
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
    if ([string isEqualToString:@"弱1"]) {
        self.pwdStrength1.backgroundColor = [UIColor colorWithRed:177/255.0 green:76/255.0 blue:4/255.0 alpha:1];
        self.pwdStrength2.backgroundColor = PWDSTRENGTH_COLOR;
        self.pwdStrength3.backgroundColor = PWDSTRENGTH_COLOR;
        self.pwdStrength4.backgroundColor = PWDSTRENGTH_COLOR;
        self.pwdStrength5.backgroundColor = PWDSTRENGTH_COLOR;
        self.pwdStrength6.backgroundColor = PWDSTRENGTH_COLOR;
        
        self.pwdStrengthLable.text        = @"弱";
        
    }else if ([string isEqualToString:@"弱2"]) {
        self.pwdStrength1.backgroundColor = [UIColor colorWithRed:177/255.0 green:76/255.0 blue:4/255.0 alpha:1];
        self.pwdStrength2.backgroundColor = [UIColor colorWithRed:177/255.0 green:76/255.0 blue:4/255.0 alpha:1];
        self.pwdStrength3.backgroundColor = PWDSTRENGTH_COLOR;
        self.pwdStrength4.backgroundColor = PWDSTRENGTH_COLOR;
        self.pwdStrength5.backgroundColor = PWDSTRENGTH_COLOR;
        self.pwdStrength6.backgroundColor = PWDSTRENGTH_COLOR;
        
        self.pwdStrengthLable.text        = @"弱";
        
    }else if ([string isEqualToString:@"中1"]) {
        self.pwdStrength1.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:11/255.0 alpha:1];
        self.pwdStrength2.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:11/255.0 alpha:1];
        self.pwdStrength3.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:11/255.0 alpha:1];;
        self.pwdStrength4.backgroundColor = PWDSTRENGTH_COLOR;
        self.pwdStrength5.backgroundColor = PWDSTRENGTH_COLOR;
        self.pwdStrength6.backgroundColor = PWDSTRENGTH_COLOR;
        
        self.pwdStrengthLable.text        = @"中";
        
    }else if ([string isEqualToString:@"中2"]) {
        self.pwdStrength1.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:11/255.0 alpha:1];
        self.pwdStrength2.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:11/255.0 alpha:1];
        self.pwdStrength3.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:11/255.0 alpha:1];
        self.pwdStrength4.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:11/255.0 alpha:1];;
        self.pwdStrength5.backgroundColor = PWDSTRENGTH_COLOR;
        self.pwdStrength6.backgroundColor = PWDSTRENGTH_COLOR;
        
        self.pwdStrengthLable.text        = @"中";
        
    }else if ([string isEqualToString:@"强1"]) {
        self.pwdStrength1.backgroundColor = [UIColor colorWithRed:35/255.0 green:255/255.0 blue:6/255.0 alpha:1];
        self.pwdStrength2.backgroundColor = [UIColor colorWithRed:35/255.0 green:255/255.0 blue:6/255.0 alpha:1];
        self.pwdStrength3.backgroundColor = [UIColor colorWithRed:35/255.0 green:255/255.0 blue:6/255.0 alpha:1];
        self.pwdStrength4.backgroundColor = [UIColor colorWithRed:35/255.0 green:255/255.0 blue:6/255.0 alpha:1];
        self.pwdStrength5.backgroundColor = [UIColor colorWithRed:35/255.0 green:255/255.0 blue:6/255.0 alpha:1];
        self.pwdStrength6.backgroundColor = PWDSTRENGTH_COLOR;
        
        self.pwdStrengthLable.text        = @"强";
        
    }else if ([string isEqualToString:@"强2"]) {
        self.pwdStrength1.backgroundColor = [UIColor colorWithRed:35/255.0 green:255/255.0 blue:6/255.0 alpha:1];
        self.pwdStrength2.backgroundColor = [UIColor colorWithRed:35/255.0 green:255/255.0 blue:6/255.0 alpha:1];
        self.pwdStrength3.backgroundColor = [UIColor colorWithRed:35/255.0 green:255/255.0 blue:6/255.0 alpha:1];
        self.pwdStrength4.backgroundColor = [UIColor colorWithRed:35/255.0 green:255/255.0 blue:6/255.0 alpha:1];
        self.pwdStrength5.backgroundColor = [UIColor colorWithRed:35/255.0 green:255/255.0 blue:6/255.0 alpha:1];
        self.pwdStrength6.backgroundColor = [UIColor colorWithRed:35/255.0 green:255/255.0 blue:6/255.0 alpha:1];
        
        self.pwdStrengthLable.text        = @"强";
        
    }
    
    if ([string isEqualToString:@"空"]) {
        self.pwdStrength1.backgroundColor = PWDSTRENGTH_COLOR;
        self.pwdStrength2.backgroundColor = PWDSTRENGTH_COLOR;
        self.pwdStrength3.backgroundColor = PWDSTRENGTH_COLOR;
        self.pwdStrength4.backgroundColor = PWDSTRENGTH_COLOR;
        self.pwdStrength5.backgroundColor = PWDSTRENGTH_COLOR;
        self.pwdStrength6.backgroundColor = PWDSTRENGTH_COLOR;
        
        self.pwdStrengthLable.text        = @"";
    }
}

#pragma mark - view即将移除时
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.judgeBack = YES;
}

@end
