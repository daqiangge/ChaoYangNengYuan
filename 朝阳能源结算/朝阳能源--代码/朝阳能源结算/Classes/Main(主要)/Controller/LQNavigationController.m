//
//  LQNavigationController.m
//  朝阳能源结算
//
//  Created by admin on 15/8/8.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQNavigationController.h"

@interface LQNavigationController ()

@end

@implementation LQNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar_background"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    [super pushViewController:viewController animated:animated];
}


@end
