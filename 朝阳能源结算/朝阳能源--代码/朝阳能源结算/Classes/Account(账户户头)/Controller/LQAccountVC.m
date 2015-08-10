//
//  LQAccountVC.m
//  朝阳能源结算
//
//  Created by admin on 15/8/7.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQAccountVC.h"
#import "RSKImageCropper.h"
#import "LQAccountInformationView.h"
#import "LQAccountTableViewCell.h"

@interface LQAccountVC ()<LQAccountInformationViewDelegate,RSKImageCropViewControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) LQAccountInformationView *accountInformationView;
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation LQAccountVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGB(236, 236, 236);
    
    self.navigationItem.title = @"朝阳自助收费";
    
    [self doLoading];
}

- (void)doLoading
{
    CGRect frame = CGRectMake(0, NavigationBar_Height, LQScreen_Width, AccountInformationView_Height);
    LQAccountInformationView *accountInformationView = [LQAccountInformationView viewWithFrame:frame];
    accountInformationView.delegate = self;
    [self.view addSubview:accountInformationView];
    self.accountInformationView = accountInformationView;
    
    //户头列表
    CGFloat tableViewX = 0;
    CGFloat tableViewY = CGRectGetMaxY(accountInformationView.frame) + 5;
    CGFloat tableViewW = LQScreen_Width;
    CGFloat tableViewH = LQScreen_Height - tableViewY;
    CGRect  tableViewF = CGRectMake(tableViewX, tableViewY, tableViewW, tableViewH);
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = tableViewF;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:tableView];
    self.tableView = tableView;
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

#pragma mark - TableViewDelegate&DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQAccountTableViewCell *cell = [[LQAccountTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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

@end
