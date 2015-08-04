//
//  UIBarButtonItem+LQExtension.m
//  美发沙龙网
//
//  Created by admin on 15/7/23.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "UIBarButtonItem+LQExtension.h"

@implementation UIBarButtonItem (LQExtension)

+ (UIBarButtonItem *)barButtonItemWithImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
