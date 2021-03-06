//
//  LQChooseYearBtnGroup.h
//  朝阳能源结算
//
//  Created by admin on 15/8/17.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-----------------------年份选取按钮组------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------

#import <UIKit/UIKit.h>

#define space  (10)
#define Button_Width (LQScreen_Width-space*6)/5


@class LQChooseYearBtnGroup;

@protocol LQChooseYearBtnGroupDelegate <NSObject>

- (void)chooseYearBtnGroupDidClickBtnWithView:(LQChooseYearBtnGroup *)view button:(UIButton *)btn;


@end

@interface LQChooseYearBtnGroup : UIView

@property (nonatomic, weak) id<LQChooseYearBtnGroupDelegate> delegate;

+ (instancetype)chooseYearBtnGroupWithFrame:(CGRect)frame;

@end
