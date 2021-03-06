//
//  LQPostpaidOrderInformationCell.m
//  朝阳能源结算
//
//  Created by admin on 15/9/21.
//  Copyright © 2015年 dieshang. All rights reserved.
//

#import "LQPostpaidOrderInformationCell.h"
#import "LQPostPaidNotCheckBillsModel.h"

@implementation LQPostpaidOrderInformationCell

+ (LQPostpaidOrderInformationCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    UINib *nib = [UINib nibWithNibName:@"LQPostpaidOrderInformationCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:@"LQPostpaidOrderInformationCell"];
    
    LQPostpaidOrderInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LQPostpaidOrderInformationCell"];
    
    return cell;
}

- (void)setPostPaidNotCheckBillsDataModel:(LQPostPaidNotCheckBillsDataModel *)postPaidNotCheckBillsDataModel
{
    _postPaidNotCheckBillsDataModel = postPaidNotCheckBillsDataModel;
    
    NSString *accountperiodStr = @"";
    NSString *moneyStr = @"";
    for (LQPostPaidNotCheckBillsModel * postPaidNotCheckBillsModel in postPaidNotCheckBillsDataModel.billsArray)
    {
        accountperiodStr = [NSString stringWithFormat:@"%@，%@",accountperiodStr,postPaidNotCheckBillsModel.accountperiod];
        moneyStr = [NSString stringWithFormat:@"%f",[moneyStr floatValue] + [postPaidNotCheckBillsModel.moneyofamount floatValue]];
    }
    
    self.accountperiodLable.text = [accountperiodStr isEqualToString:@""]?accountperiodStr:[accountperiodStr substringFromIndex:1];
    self.moneyLable.text = [NSString stringWithFormat:@"%.2f 元",[moneyStr floatValue]];
    
}

@end
