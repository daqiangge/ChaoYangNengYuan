//
//  LQPostpaidOrderInformationCell.m
//  朝阳能源结算
//
//  Created by admin on 15/9/21.
//  Copyright © 2015年 dieshang. All rights reserved.
//

#import "LQPostpaidOrderInformationCell.h"

@implementation LQPostpaidOrderInformationCell

+ (LQPostpaidOrderInformationCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    UINib *nib = [UINib nibWithNibName:@"LQPostpaidOrderInformationCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:@"LQPostpaidOrderInformationCell"];
    
    LQPostpaidOrderInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LQPostpaidOrderInformationCell"];
    
    return cell;
}

@end
