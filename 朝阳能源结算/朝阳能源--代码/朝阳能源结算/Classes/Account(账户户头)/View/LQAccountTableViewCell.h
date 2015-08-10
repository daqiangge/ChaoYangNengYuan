//
//  LQAccountTableViewCell.h
//  朝阳能源结算
//
//  Created by admin on 15/8/5.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Cell_Height 180.0

typedef enum {
    accountSatateNormal,//正常使用
    accountSatateFrozen,//冻结
}accountSatate;//户头状态

@interface LQAccountTableViewCell : UITableViewCell

@property (nonatomic, weak) UILabel *nameLable;
@property (nonatomic, weak) UILabel *accountStateLable;
@property (nonatomic) accountSatate accountSatate;
@property (nonatomic, weak) UIButton *rechargeButton;

+ (LQAccountTableViewCell *)cellWithTableView:(UITableView *)tableView;

@end
