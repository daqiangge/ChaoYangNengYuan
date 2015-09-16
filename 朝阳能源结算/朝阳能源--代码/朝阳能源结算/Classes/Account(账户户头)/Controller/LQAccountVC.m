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
#import "LQPayVC.h"

#define HMEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]

@interface LQAccountVC ()<LQAccountInformationViewDelegate,RSKImageCropViewControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate,LQAccountTableViewCellDelegate,UIAlertViewDelegate>

@property (nonatomic, weak  ) UIImageView              *imageView;
@property (nonatomic, weak  ) LQAccountInformationView *accountInformationView;
@property (nonatomic, weak  ) UITableView              *tableView;
@property (nonatomic, strong) NSMutableDictionary      *accountDic;
@property (nonatomic, strong) YTKKeyValueStore         *store;
@property (nonatomic, strong) NSMutableArray           *accountItemsArray;
@property (nonatomic, copy  ) NSString                 *sessionid;

@end

@implementation LQAccountVC

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
    
    self.store      = [[YTKKeyValueStore alloc] initDBWithName:SQL_Name];
    self.accountDic = [NSMutableDictionary dictionaryWithDictionary:[self.store getObjectById:SQL_Account_Key fromTable:SQL_Account_TableName]];
    self.sessionid  = [self.accountDic valueForKey:@"sessionid"];
    
    [self doLoading];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = HTTPRequestLoding_Text;
    hud.mode = MBProgressHUDModeIndeterminate;
    [self requestAccountListWithSessionid:self.sessionid];
    [self requestUserPhoto];
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/energy/do/chargeapp/getaccountlist.do?;sessionid=%@",IP,sessionid];
    
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
                 
                 //如果运行状态是“通讯异常”，就不必要再去获取，当前示数和当前剩余了，注意是预付费的户头
                 if (itemModel.runstate == 5 && itemModel.rechmodle == 1)
                 {
                     itemModel.currentamount = @"--.--";
                     itemModel.surplusamount = @"--.--";
                 }
                 else
                 {
                     [self requestMeterdataWithSessionid:sessionid itemModel:itemModel];
                 }
             }
             
             [self.tableView reloadData];
         }
         else
         {
             if ([accountListModel.code isEqualToString:@"1006"])
             {
                 UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil
                                                                 message:@"当前用户不存在或者已经超时，请重新登陆"
                                                                delegate:self
                                                       cancelButtonTitle:nil
                                                       otherButtonTitles:@"确定", nil];
                 [alter show];
             }
             else
             {
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                 message:accountListModel.info
                                                                delegate:nil
                                                       cancelButtonTitle:@"确定"
                                                       otherButtonTitles: nil];
                 [alert show];
             }
         }
         
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
    NSString *urlStr = [NSString stringWithFormat:@"%@/energy/do/chargeapp/getmeterdata.do?Accountid=%@&MeterId=%@;sessionid=%@",IP,itemModel.accountid,itemModel.meterid,sessionid];
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         LQLog(@"%@",operation.responseString);
         
         LQMeterDataModel *meterDataModel = [LQMeterDataModel objectWithKeyValues:operation.responseString];
         
         if (meterDataModel.returns)
         {
             itemModel.currentamount = meterDataModel.currentamount;
             itemModel.surplusamount = meterDataModel.surplusamount;
             itemModel.price = meterDataModel.price;
             
         }
         else
         {
             itemModel.currentamount = @"--.--";
             itemModel.surplusamount = @"--.--";
         }
         
         [self.tableView reloadData];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         LQLog(@"%@",error);
         
         itemModel.currentamount = @"--.--";
         itemModel.surplusamount = @"--.--";
         
         [self.tableView reloadData];
     }];
}

/**
 *  请求用户头像
 */
- (void)requestUserPhoto
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/energy/do/chargeapp/updateuserphoto.do?;sessionid=%@",IP,self.sessionid];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    UIImage *image = [UIImage imageNamed:@"123.png"];
    
    /**
     *  appendPartWithFileURL   //  指定上传的文件
     *  name                    //  指定在服务器中获取对应文件或文本时的key
     *  fileName                //  指定上传文件的原始文件名
     *  mimeType                //  指定商家文件的MIME类型
     */
    
    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:UIImagePNGRepresentation(image)
                                    name:@"avatar"
                                fileName:@"123.png"
                                mimeType:@"image/png"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"--------------Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"--------------Error: %@", error);
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
    [self.accountInformationView.headPortraitBtn setBackgroundImage:image forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 2)
    {
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    if (buttonIndex == 0)
    {
        // 拍照
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        picker.allowsEditing = YES;
        
    } else if (buttonIndex == 1)
    {
        // 从相册中选取
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:picker animated:YES completion:nil];
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
    
    LQPayVC *vc = [[LQPayVC alloc] init];
    vc.accountItemModel = accountItemModel;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
