//
//  LQNoCopyTextField.m
//  朝阳能源结算
//
//  Created by admin on 15/8/18.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQNoCopyTextField.h"

@implementation LQNoCopyTextField

- (id)initWithFrame:(CGRect)frame
{
    if (self  = [super initWithFrame:frame])
    {
        // Initialization code
    }
    return self;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}

@end
