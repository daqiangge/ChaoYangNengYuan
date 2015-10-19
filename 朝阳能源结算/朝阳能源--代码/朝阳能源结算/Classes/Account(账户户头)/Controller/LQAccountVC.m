//
//  LQAccountVC.m
//  朝阳能源结算
//
//  Created by admin on 15/8/7.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-----------------------户头列表------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------

#import "LQAccountVC.h"
#import "RSKImageCropper.h"
#import "LQAccountInformationView.h"
#import "LQAccountTableViewCell.h"
#import "LQAccountDetailsVC.h"
#import "LQLoginModel.h"
#import "LQLoginVC.h"
#import "AppDelegate.h"
#import "LQAccountListModel.h"
#import "LQLoginModel.h"
#import "LQAccountItemModel.h"
#import "LQMeterDataModel.h"
#import "LQSettingVC.h"
#import "LQRechargeMoneyVC.h"
#import "LQRechargeAmountVC.h"
#import "LQOrderVC.h"
#import "LQOrderModel.h"

#define HMEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]

@interface LQAccountVC ()<LQAccountInformationViewDelegate,RSKImageCropViewControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate,LQAccountTableViewCellDelegate,UIAlertViewDelegate>

@property (nonatomic, weak  ) UIImageView              *imageView;
@property (nonatomic, weak  ) LQAccountInformationView *accountInformationView;
@property (nonatomic, weak  ) UITableView              *tableView;
@property (nonatomic, strong) NSMutableDictionary      *accountDic;
@property (nonatomic, strong) YTKKeyValueStore         *store;
@property (nonatomic, strong) NSMutableArray           *accountItemsArray;
@property (nonatomic, copy  ) NSString                 *sessionid;
@property (nonatomic, strong) UIAlertView              *showErrorAlterView;
@property (nonatomic, strong) UIImagePickerController *picker;

@end

@implementation LQAccountVC

- (UIAlertView *)showErrorAlterView
{
    if (!_showErrorAlterView)
    {
        _showErrorAlterView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                         message:nil
                                                        delegate:nil
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil];
    }
    
    return _showErrorAlterView;
}

- (void)setLoginModel:(LQLoginModel *)loginModel
{
    _loginModel = loginModel;
}

- (NSMutableArray *)accountItemsArray
{
    if (!_accountItemsArray)
    {
        _accountItemsArray = [NSMutableArray array];
    }
    
    return _accountItemsArray;
}

#pragma mark -
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGB(236, 236, 236);
    
    self.navigationItem.title = @"朝阳自助收费";
    
    self.navigationItem.rightBarButtonItems = [UIBarButtonItem barbarButtonItemWithImageName:@"settings" selectedImageName:@"settings-按下" target:self action:@selector(setting) space:-10];
    
    self.store      = [LQKeyValueStore shareInstance].keyValueStore;
    self.accountDic = [NSMutableDictionary dictionaryWithDictionary:[self.store getObjectById:SQL_Account_Key fromTable:SQL_Account_TableName]];
    self.sessionid  = [self.accountDic valueForKey:@"sessionid"];
    
    [self doLoading];
    [self requestGetUserPhoto];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = HTTPRequestLoding_Text;
    hud.mode = MBProgressHUDModeIndeterminate;
    [self requestAccountListWithSessionid:self.sessionid];
}

- (void)doLoading
{
    CGRect frame = CGRectMake(0, NavigationBar_Height, LQScreen_Width, AccountInformationView_Height);
    LQAccountInformationView *accountInformationView = [LQAccountInformationView viewWithFrame:frame];
    accountInformationView.delegate = self;
    accountInformationView.loginModel = self.loginModel;
    [self.view addSubview:accountInformationView];
    self.accountInformationView = accountInformationView;
    
    //户头列表
    CGFloat tableViewX = 0;
    CGFloat tableViewY = CGRectGetMaxY(accountInformationView.frame) + 5;
    CGFloat tableViewW = LQScreen_Width;
    CGFloat tableViewH = LQScreen_Height - tableViewY;
    CGRect  tableViewF = CGRectMake(tableViewX, tableViewY, tableViewW, tableViewH);
    
    UITableView *tableView    = [[UITableView alloc] init];
    tableView.frame           = tableViewF;
    tableView.delegate        = self;
    tableView.dataSource      = self;
    tableView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:tableView];
    self.tableView            = tableView;
    
    tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshingTableView)];
}

/**
 *  刷新列表
 */
- (void)refreshingTableView
{
    [self requestAccountListWithSessionid:self.sessionid];
}

- (void)setting
{
    LQSettingVC *settingVC = [[LQSettingVC alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

#pragma mark - 网络请求
/**
 *  获取户头列表
 */
- (void)requestAccountListWithSessionid:(NSString *)sessionid
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"%@getaccountlist.do;sessionid=%@",[LQUrlString shareInstance].urlStr,sessionid];
    LQLog(@"%@",urlStr);
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         LQLog(@"%@",operation.responseString);
         
         LQAccountListModel *accountListModel = [LQAccountListModel objectWithKeyValues:operation.responseString];
         self.accountItemsArray = [NSMutableArray arrayWithArray:accountListModel.items];
         
         if (accountListModel.returns)
         {
             for (LQAccountItemModel *itemModel in self.accountItemsArray)
             {
                 itemModel.currentamount = nil;
                 itemModel.surplusamount = nil;
                 itemModel.surplusmoney  = nil;
                 itemModel.price         = nil;
                 
                 //如果运行状态是“通讯异常”，就不必要再去获取，当前示数和当前剩余了，注意是预付费的户头
                 if (itemModel.runstate == 5 && itemModel.rechmodle == 1)
                 {
                     itemModel.currentamount = @"(未知)";
                     itemModel.surplusamount = @"(未知)";
                     itemModel.surplusmoney  = @"(未知)";
                     itemModel.price         = @"(未知)";
                 }
                 else
                 {
                     [self requestMeterdataWithSessionid:sessionid itemModel:itemModel];
                 }
             }
         }
         else
         {
             if ([accountListModel.code isEqualToString:@"1006"])
             {
                 self.showErrorAlterView.delegate = self;
                 self.showErrorAlterView.message = @"当前用户不存在或者已经超时，请重新登录";
                 [self.showErrorAlterView show];
             }
             else
             {
                 self.showErrorAlterView.delegate = nil;
                 self.showErrorAlterView.message = accountListModel.info;
                 [self.showErrorAlterView show];
             }
         }
         
         [self.tableView reloadData];
         
         [self.tableView.header endRefreshing];
         
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [self.tableView.header endRefreshing];
         [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
         
         MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
         hud.labelText = HTTPRequestErrer_Text;
         hud.mode = MBProgressHUDModeText;
         [hud hide:YES afterDelay:1.5];
     }];
}

/**
 *  获取表具当前示数
 */
- (void)requestMeterdataWithSessionid:(NSString *)sessionid itemModel:(LQAccountItemModel *)itemModel
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"%@getmeterdata.do?;sessionid=%@",[LQUrlString shareInstance].urlStr,sessionid];
    NSDictionary *parameters = @{@"MeterId":itemModel.meterid,@"Accountid":itemModel.accountid};
    
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
//         LQLog(@"%@",operation.responseString);
         
         LQMeterDataModel *meterDataModel = [LQMeterDataModel objectWithKeyValues:operation.responseString];
         
         if (meterDataModel.returns)
         {
             itemModel.currentamount = meterDataModel.currentamount;
             itemModel.surplusamount = meterDataModel.surplusamount;
             itemModel.surplusmoney  = meterDataModel.surplusmoney;
             itemModel.price         = meterDataModel.price;
             
             if (meterDataModel.currentamount == nil)
             {
                 itemModel.currentamount = @"(未知)";
             }
             
             if (meterDataModel.surplusamount == nil)
             {
                 itemModel.surplusamount = @"(未知)";
             }
             
             if (meterDataModel.surplusmoney == nil)
             {
                 itemModel.surplusmoney = @"(未知)";
             }
             
             if (meterDataModel.price == nil)
             {
                 itemModel.price = @"(未知)";
             }
             
         }
         else
         {
             itemModel.currentamount = @"(未知)";
             itemModel.surplusamount = @"(未知)";
             itemModel.surplusmoney  = @"(未知)";
             itemModel.price         = @"(未知)";
         }
         
         [self.tableView reloadData];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         LQLog(@"%@",error);
         
         itemModel.currentamount = @"(未知)";
         itemModel.surplusamount = @"(未知)";
         itemModel.surplusmoney  = @"(未知)";
         itemModel.price         = @"(未知)";
         
         [self.tableView reloadData];
     }];
}

- (void)requestGetUserPhoto
{
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSString *urlStr = [NSString stringWithFormat:@"%@getuserphoto.do;sessionid=%@",[LQUrlString shareInstance].urlStr,self.sessionid];
    NSMutableURLRequest *request =[serializer requestWithMethod:@"GET" URLString:urlStr parameters:nil error:nil];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [NSString stringWithFormat:@"%@/userphoto.png",[paths objectAtIndex:0]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:path append:NO]];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSData *data = [NSData dataWithContentsOfFile:path];
        UIImage *image = [UIImage imageWithData:data];
        if (image == nil)
        {
            image = [UIImage imageNamed:@"默认头像"];
        }
        
        [self.accountInformationView.headPortraitBtn setBackgroundImage:image forState:UIControlStateNormal];
        [self.accountInformationView.headPortraitBtn setBackgroundImage:image forState:UIControlStateHighlighted];
        
        LQLog(@"下载成功");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        LQLog(@"下载失败");
    }];
    
    [operation start];
}

/**
 *  请求修改用户头像
 */
- (void)requestChangeUserPhoto:(UIImage *)image
{
    image = [image imageScaledToSize:CGSizeMake(120, 120)];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] animated:YES];
    hud.labelText = @"正在修改...";
    hud.mode = MBProgressHUDModeIndeterminate;
    
    NSString *urlStr = [NSString stringWithFormat:@"%@updateuserphoto.do;sessionid=%@",[LQUrlString shareInstance].urlStr,self.sessionid];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    /**
     *  appendPartWithFileURL   //  指定上传的文件
     *  name                    //  指定在服务器中获取对应文件或文本时的key
     *  fileName                //  指定上传文件的原始文件名
     *  mimeType                //  指定商家文件的MIME类型
     */
    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:UIImagePNGRepresentation(image)
                                    name:@"userphoto"
                                fileName:@"userphoto.png"
                                mimeType:@"image/png"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
        LQBaseModel *model = [LQBaseModel objectWithKeyValues:operation.responseString];
         
        if (model.returns)
        {
            [self.accountInformationView.headPortraitBtn setBackgroundImage:image forState:UIControlStateNormal];
            [self.accountInformationView.headPortraitBtn setBackgroundImage:image forState:UIControlStateHighlighted];
            
            hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark"]];
            hud.mode = MBProgressHUDModeCustomView;
            hud.labelText = @"修改成功";
            [hud hide:YES afterDelay:0.5];
        }
        else
        {
            [hud hide:YES];
            
            if ([model.code isEqualToString:@"1006"])
            {
                self.showErrorAlterView.delegate = self;
                self.showErrorAlterView.message = @"当前用户不存在或者已经超时，请重新登录";
                [self.showErrorAlterView show];
            }
            else
            {
                self.showErrorAlterView.delegate = nil;
                self.showErrorAlterView.message = model.info;
                [self.showErrorAlterView show];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        LQLog(@"Error: %@", error);
        
        hud.labelText = HTTPRequestErrer_Text;
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.5];
    }];
}


#pragma mark - LQAccountInformationViewDelegate
- (void)accountInformationViewDidreplaceHeadPortraitWithView:(LQAccountInformationView *)view
{
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    [choiceSheet showInView:self.view];
}

#pragma mark - RSKImageCropViewControllerDelegate
- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imageCropViewController:(RSKImageCropViewController *)controller
                   didCropImage:(UIImage *)croppedImage
                  usingCropRect:(CGRect)cropRect
{
    UIImage *image = [UIImage iconWithimage:croppedImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self requestChangeUserPhoto:image];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 2)
    {
        return;
    }
    
    self.picker = [[UIImagePickerController alloc] init];
    self.picker.delegate = self;
    
    if (buttonIndex == 0)
    {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        self.picker.sourceType = sourceType;
        self.picker.allowsEditing = NO;
        
    }
    else if (buttonIndex == 1)
    {
        // 从相册中选取
        self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:self.picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
/**
 *  从相册获取照片的回掉
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)aImage editingInfo:(NSDictionary *)editingInfo
{
    RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:aImage];
    imageCropVC.delegate = self;
    
    [picker dismissModalViewControllerAnimated:YES];
    
    [self presentViewController:imageCropVC animated:NO completion:nil];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.accountDic[@"loginSuccess"] = [NSNumber numberWithBool:NO];
    [self.store putObject:self.accountDic withId:SQL_Account_Key intoTable:SQL_Account_TableName];
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - TableViewDelegate&DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.accountItemsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQAccountTableViewCell *cell = [LQAccountTableViewCell cellWithTableView:tableView ForRowAtIndexPath:indexPath];
    cell.delegate = self;
    cell.accountItemModel = self.accountItemsArray[indexPath.section];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    LQAccountDetailsVC *accountDetailVC = [[LQAccountDetailsVC alloc] init];
    accountDetailVC.accountitemModel = self.accountItemsArray[indexPath.section];
    [self.navigationController pushViewController:accountDetailVC animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Cell_Height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0;
}

#pragma mark - LQAccountTableViewCellDelegate
- (void)accountTableViewCellDidClickRechargeButtonWith:(LQAccountTableViewCell *)cell btn:(UIButton *)btn
{
    NSInteger section = [self.tableView indexPathForCell:((LQAccountTableViewCell *)[[btn superview] superview])].section;
    
    LQAccountItemModel *accountItemModel = self.accountItemsArray[section];
    
    if (accountItemModel.rechmodle == 1)
    {
        if (accountItemModel.rechargestype == 1)
        {
            LQRechargeAmountVC *vc = [[LQRechargeAmountVC alloc] init];
            vc.accountItemModel = accountItemModel;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            LQRechargeMoneyVC *vc = [[LQRechargeMoneyVC alloc] init];
            vc.accountItemModel = accountItemModel;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else
    {
        LQOrderModel *orderModel = [[LQOrderModel alloc] init];
        orderModel.accountcode = accountItemModel.accountcode;
        orderModel.rechmodle = accountItemModel.rechmodle;
        orderModel.accountid = accountItemModel.accountid;
        
        LQOrderVC *vc = [[LQOrderVC alloc] init];
        vc.orderModel = orderModel;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
