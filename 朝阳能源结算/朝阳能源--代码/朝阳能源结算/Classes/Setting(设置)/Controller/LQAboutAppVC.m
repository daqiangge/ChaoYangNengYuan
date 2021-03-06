//
//  LQAboutAppVC.m
//  朝阳能源结算
//
//  Created by admin on 15/9/15.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQAboutAppVC.h"
#import "LQAboutModel.h"

@interface LQAboutAppVC ()
@property (weak, nonatomic) IBOutlet UILabel *authorLable;
@property (weak, nonatomic) IBOutlet UILabel *telLable;
@property (weak, nonatomic) IBOutlet UILabel *emailLable;
@property (weak, nonatomic) IBOutlet UILabel *copyrightLable;
@property (weak, nonatomic) IBOutlet UILabel *versionLable;

@end

@implementation LQAboutAppVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"关于";
    
    [self doLoading];
    [self requestAbout];
    
}

- (void)doLoading
{
    //查询当前版本号
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version        = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    self.versionLable.text       = [NSString stringWithFormat:@"v %@",app_Version];
}

#pragma mark - 网路请求
- (void)requestAbout
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] animated:YES];
    hud.mode           = MBProgressHUDModeIndeterminate;
    hud.labelText      = @"正在加载...";
    
    NSString *urlStr = [NSString stringWithFormat:@"%@about.do",[LQUrlString shareInstance].urlStr];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        LQLog(@"%@",operation.responseString);
        
        [hud hide:YES];
        
        LQAboutModel *model = [LQAboutModel objectWithKeyValues:operation.responseString];
        
        if (model.returns)
        {
            self.authorLable.text = model.technicalsupport;
            self.telLable.text = model.contact;
            self.emailLable.text = model.email;
            self.copyrightLable.text = model.copyright;
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
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [hud hide:YES];
         
         MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
         hud.labelText = HTTPRequestErrer_Text;
         hud.mode = MBProgressHUDModeText;
         [hud hide:YES afterDelay:1.5];
    }];
}

@end
