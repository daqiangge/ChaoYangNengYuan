//
//  LQPaidChargeCellFrameModel.m
//  朝阳能源结算
//
//  Created by admin on 15/9/8.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQPaidChargeCellFrameModel.h"

@implementation LQPaidChargeCellFrameModel

- (void)setItemsModel:(LQPaidChargeItemsModel *)itemsModel
{
    _itemsModel = itemsModel;
    
    if (itemsModel.note != nil)
    {
        self.cellHeight = 30 + Label_Height + (30 - Label_Height) * 0.5;
    }
    else
    {
        self.cellHeight = 30;
    }
}

@end
