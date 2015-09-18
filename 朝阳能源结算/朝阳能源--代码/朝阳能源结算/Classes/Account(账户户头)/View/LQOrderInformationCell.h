//
//  LQOrderInformationCell.h
//  朝阳能源结算
//
//  Created by admin on 15/8/19.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQOrderInformationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *accountCodeLable;
@property (weak, nonatomic) IBOutlet UILabel *moneyLable;

+ (LQOrderInformationCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
