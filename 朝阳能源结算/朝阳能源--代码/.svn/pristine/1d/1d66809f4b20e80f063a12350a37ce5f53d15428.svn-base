//
//  LQAccountInformationView.m
//  朝阳能源结算
//
//  Created by admin on 15/8/8.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQAccountInformationView.h"

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
            make.size.mas_equalTo(CGSizeMake(57, 57));
        }];
        
        _headPortraitBtn = headPortraitBtn;
    }
    
    return _headPortraitBtn;
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
    self.backgroundColor = [UIColor grayColor];
    self.headPortraitBtn.hidden = NO;
}

- (void)replaceHeadPortrait
{
    if ([self.delegate respondsToSelector:@selector(accountInformationViewDidreplaceHeadPortraitWithView:)])
    {
        [self.delegate accountInformationViewDidreplaceHeadPortraitWithView:self];
    }
}

@end
