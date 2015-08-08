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

@interface LQAccountVC ()<LQAccountInformationViewDelegate,RSKImageCropViewControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) LQAccountInformationView *accountInformationView;

@end

@implementation LQAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self doLoading];
}

- (void)doLoading
{
    CGRect frame = CGRectMake(0, NavigationBar_Height, LQScreen_Width, AccountInformationView_Height);
    LQAccountInformationView *accountInformationView = [LQAccountInformationView viewWithFrame:frame];
    accountInformationView.delegate = self;
    [self.view addSubview:accountInformationView];
    self.accountInformationView = accountInformationView;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:imageView];
    self.imageView = imageView;
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
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)imageCropViewController:(RSKImageCropViewController *)controller
                   didCropImage:(UIImage *)croppedImage
                  usingCropRect:(CGRect)cropRect
{
    UIImage *image = [UIImage iconWithimage:croppedImage];
    [self.accountInformationView.headPortraitBtn setBackgroundImage:image forState:UIControlStateNormal];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
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
    
    [self.navigationController pushViewController:imageCropVC animated:NO];
}

@end
