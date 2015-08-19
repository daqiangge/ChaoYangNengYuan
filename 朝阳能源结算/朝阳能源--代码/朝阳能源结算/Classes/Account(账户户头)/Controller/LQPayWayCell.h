//
//  LQPayWayCell.h
//  朝阳能源结算
//
//  Created by admin on 15/8/19.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQPayWayCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *choosePayBtn;

+ (LQPayWayCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
