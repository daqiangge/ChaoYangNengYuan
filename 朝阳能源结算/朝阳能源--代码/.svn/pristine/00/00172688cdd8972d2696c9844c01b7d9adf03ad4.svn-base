//
//  LQAccountInformationView.h
//  朝阳能源结算
//
//  Created by admin on 15/8/8.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define AccountInformationView_Height 94

@class LQAccountInformationView;

@protocol LQAccountInformationViewDelegate <NSObject>

- (void)accountInformationViewDidreplaceHeadPortraitWithView:(LQAccountInformationView *)view;

@end


@interface LQAccountInformationView : UIView

@property (nonatomic, weak) UIButton *headPortraitBtn;
@property (nonatomic, weak) id<LQAccountInformationViewDelegate> delegate;

+ (instancetype)viewWithFrame:(CGRect)frame;

@end
