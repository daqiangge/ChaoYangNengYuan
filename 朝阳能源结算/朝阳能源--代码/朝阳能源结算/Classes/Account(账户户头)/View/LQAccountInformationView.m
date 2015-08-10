//
//  LQAccountInformationView.m
//  朝阳能源结算
//
//  Created by admin on 15/8/8.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQAccountInformationView.h"

#define HeadPortraitBtn_Height 57
#define HeadPortraitBtn_Width (HeadPortraitBtn_Height)
#define NameLable_Width 200

@interface LQAccountInformationView()

@end

@implementation LQAccountInformationView

/**
 *  头像按钮
 */
- (UIButton *)headPortraitBtn
{
    if (_headPortraitBtn == nil)
    {
        UIButton *headPortraitBtn = [[UIButton alloc] init];
        headPortraitBtn.backgroundColor = [UIColor clearColor];
        [headPortraitBtn setBackgroundImage:[UIImage iconWithimageNamed:@"123"] forState:UIControlStateNormal];
        [headPortraitBtn addTarget:self action:@selector(replaceHeadPortrait) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:headPortraitBtn];
        headPortraitBtn.layer.cornerRadius = 28.5;
        
        [headPortraitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).with.offset(25);
            make.size.mas_equalTo(CGSizeMake(HeadPortraitBtn_Width, HeadPortraitBtn_Height));
        }];
        
        _headPortraitBtn = headPortraitBtn;
    }
    
    return _headPortraitBtn;
}

- (UILabel *)numberLable
{
    if (_numberLable == nil)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.font = [UIFont boldSystemFontOfSize:16];
        lable.textColor = [UIColor blackColor];
        [self addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headPortraitBtn.mas_right).with.offset(20);
            make.top.equalTo(self.headPortraitBtn.mas_top).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(NameLable_Width, HeadPortraitBtn_Height * 0.5));
            
        }];
        
        _numberLable = lable;
    }
    
    return _numberLable;
}

- (UILabel *)nameLable
{
    if (_nameLable == nil)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.font = [UIFont systemFontOfSize:15];
        lable.textColor = [UIColor blackColor];
        [self addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.numberLable.mas_left).with.offset(0);
            make.top.equalTo(self.numberLable.mas_bottom).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(NameLable_Width, HeadPortraitBtn_Height * 0.5));
            
        }];
        
        _nameLable = lable;
    }
    
    return _nameLable;
}

- (UILabel *)accountNumLable
{
    
    if (_accountNumLable == nil)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.font = [UIFont boldSystemFontOfSize:18];
        lable.textColor = [UIColor blackColor];
        lable.textAlignment = NSTextAlignmentRight;
        [self addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.numberLable.mas_centerY).with.offset(0);
            make.right.equalTo(self.mas_right).with.offset(-20);
            make.size.mas_equalTo(CGSizeMake(100, HeadPortraitBtn_Height/2));
        }];
        
        _accountNumLable = lable;
    }
    
    return _accountNumLable;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self doLoading];
    }
    
    return self;
}

+ (instancetype)viewWithFrame:(CGRect)frame
{
    return [[self alloc] initWithFrame:frame];
}

- (void)doLoading
{
    self.backgroundColor = [UIColor whiteColor];
    self.headPortraitBtn.hidden = NO;
    
    self.numberLable.text = @"12345678901";
    self.nameLable.text = @"xiaodoutiao";
    self.accountNumLable.text = @"户头：2";
}

/**
 *  更换头像
 */
- (void)replaceHeadPortrait
{
    if ([self.delegate respondsToSelector:@selector(accountInformationViewDidreplaceHeadPortraitWithView:)])
    {
        [self.delegate accountInformationViewDidreplaceHeadPortraitWithView:self];
    }
}

@end
