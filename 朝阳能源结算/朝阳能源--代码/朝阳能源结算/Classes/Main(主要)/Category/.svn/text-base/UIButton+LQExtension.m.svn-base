//
//  UIButton+LQExtension.m
//  美发沙龙网
//
//  Created by admin on 15/7/24.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "UIButton+LQExtension.h"

@implementation UIButton (LQExtension)

/**
 *  设置背景图和文字的上下位置关系
 */
- (void)setBackgroundImageAndTitlePositionRelationWithUpDownSpace:(CGFloat)space
{

    CGPoint buttonBoundsCenter  = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    // 找出imageView最终的center
    CGPoint endImageViewCenter  = CGPointMake(buttonBoundsCenter.x, CGRectGetMidY(self.imageView.bounds));
    
    // 找出titleLabel最终的center
    CGPoint endTitleLabelCenter = CGPointMake(buttonBoundsCenter.x, CGRectGetHeight(self.bounds)-CGRectGetMaxY(self.titleLabel.bounds));
    
    // 取得imageView最初的center
    CGPoint startImageViewCenter  = self.imageView.center;
    
    // 取得titleLabel最初的center
    CGPoint startTitleLabelCenter = self.titleLabel.center;
    
    // 设置imageEdgeInsets
    CGFloat imageEdgeInsetsTop    = - CGRectGetHeight(self.titleLabel.bounds) * 0.5;
    CGFloat imageEdgeInsetsLeft   = endImageViewCenter.x - startImageViewCenter.x;
    CGFloat imageEdgeInsetsBottom = - imageEdgeInsetsTop;
    CGFloat imageEdgeInsetsRight  = - imageEdgeInsetsLeft;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(imageEdgeInsetsTop, imageEdgeInsetsLeft, imageEdgeInsetsBottom, imageEdgeInsetsRight);
    
    // 设置titleEdgeInsets
    CGFloat titleEdgeInsetsTop    = CGRectGetHeight(self.imageView.bounds) * 0.5 + space * 0.5;
//    CGFloat titleEdgeInsetsLeft   = - (startImageViewCenter.x + CGRectGetMidY(self.imageView.bounds));
    CGFloat titleEdgeInsetsLeft    = endTitleLabelCenter.x - startTitleLabelCenter.x;
    CGFloat titleEdgeInsetsBottom = -titleEdgeInsetsTop;
    CGFloat titleEdgeInsetsRight  = -titleEdgeInsetsLeft;
    
    self.titleEdgeInsets = UIEdgeInsetsMake(titleEdgeInsetsTop, titleEdgeInsetsLeft, titleEdgeInsetsBottom, titleEdgeInsetsRight);
}

/**
 *  设置背景图和文字的左右位置关系
 */
- (void)setBackgroundImageAndTitlePositionRelationWithLeftRightSpace:(CGFloat)space
{
    // 设置imageEdgeInsets
    CGFloat imageEdgeInsetsTop    = 0;
    CGFloat imageEdgeInsetsLeft   = - space * 0.5;
    CGFloat imageEdgeInsetsBottom = 0;
    CGFloat imageEdgeInsetsRight  = space * 0.5;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(imageEdgeInsetsTop, imageEdgeInsetsLeft, imageEdgeInsetsBottom, imageEdgeInsetsRight);
    
    // 设置titleEdgeInsets
    CGFloat titleEdgeInsetsTop    = 0;
    CGFloat titleEdgeInsetsLeft   = space * 0.5;
    CGFloat titleEdgeInsetsBottom = 0;
    CGFloat titleEdgeInsetsRight  = - space * 0.5;
    
    self.titleEdgeInsets = UIEdgeInsetsMake(titleEdgeInsetsTop, titleEdgeInsetsLeft, titleEdgeInsetsBottom, titleEdgeInsetsRight);
}

@end
