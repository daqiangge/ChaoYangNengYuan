//
//  LQAccountDetailsView.h
//  朝阳能源结算
//
//  Created by admin on 15/8/11.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LQAccountItemModel;

typedef enum {
    accountSatateNormal,//正常使用
    accountSatateFrozen,//冻结
}accountSatate;//户头状态


@class LQAccountDetailsView;

@protocol LQAccountDetailsViewDelegate <NSObject>

- (void)accountDetailsViewDidClickRechargeButtonWith:(LQAccountDetailsView *)view;

@end

@interface LQAccountDetailsView : UIView

@property (nonatomic, weak) UILabel *nameLable;
@property (nonatomic, weak) UILabel *accountStateLable;
@property (nonatomic) accountSatate accountSatate;
@property (nonatomic, weak) UIButton *rechargeButton;
@property (nonatomic, weak) id<LQAccountDetailsViewDelegate> delegate;
@property (nonatomic, strong) LQAccountItemModel *accountItemModel;

+ (instancetype)accountDetailsViewWithFrame:(CGRect)frame;

@end
