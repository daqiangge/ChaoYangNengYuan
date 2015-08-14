//
//  LQChooseMonthBtnGroup.h
//  朝阳能源结算
//
//  Created by admin on 15/8/13.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LQChooseMonthBtnGroup;

@protocol LQChooseMonthBtnGroupDelegate <NSObject>

- (void)chooseMonthBtnGroupDidClickBtnWithView:(LQChooseMonthBtnGroup *)view button:(UIButton *)btn;


@end

@interface LQChooseMonthBtnGroup : UIView

@property (nonatomic, weak) id<LQChooseMonthBtnGroupDelegate> delegate;

+ (instancetype)chooseMonthBtnGroupWithFrame:(CGRect)frame;

@end
