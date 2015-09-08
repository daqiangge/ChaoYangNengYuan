//
//  LQRechargeRecordCell.m
//  朝阳能源结算
//
//  Created by admin on 15/8/17.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQRechargeRecordCell.h"
#import "LQPaidChargeItemsModel.h"

@interface LQRechargeRecordCell()

@property (nonatomic, assign) int rechmodle;
@property (nonatomic, copy) NSString *unit;

@end


@implementation LQRechargeRecordCell

/**
 *  @param rechmodle 判断是充值还是缴费
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView rechmodle:(int)rechmodle unit:(NSString *)unit
{
    return [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil rechmodle:rechmodle unit:unit];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier  rechmodle:(int)rechmodle unit:(NSString *)unit
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.unit = unit;
        self.rechmodle = rechmodle;
    }
    
    return self;
}

- (void)setCellFrameModel:(LQPaidChargeCellFrameModel *)cellFrameModel
{
    _cellFrameModel = cellFrameModel;
    
    self.paidChargeItemModel = cellFrameModel.itemsModel;
}


- (UILabel *)dateLabel
{
    if (_dateLabel == nil)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.font = [UIFont systemFontOfSize:12];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = [UIColor blackColor];
        [self addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(10);
            make.top.equalTo(self.mas_top).with.offset(5);
            make.bottom.equalTo(self.mas_bottom).with.offset(-5);
            make.width.equalTo(@70);
        }];
        
        _dateLabel = lable;
    }
    
    return _dateLabel;
}

- (UILabel *)rechargeMoneyLabel
{
    if (_rechargeMoneyLabel == nil)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.font = [UIFont boldSystemFontOfSize:12];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = [UIColor blueColor];
        [self addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.dateLabel.mas_right);
            make.right.equalTo(self.rechargeWayLable.mas_left);
            make.top.equalTo(self.dateLabel.mas_top);
            make.bottom.equalTo(self.dateLabel.mas_bottom);
        }];
        
        _rechargeMoneyLabel = lable;
    }
    
    return _rechargeMoneyLabel;
}

- (UILabel *)rechargeWayLable
{
    if (_rechargeWayLable == nil)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.font = self.dateLabel.font;
        lable.textColor = [UIColor blackColor];
        lable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.dateLabel.mas_top);
            make.bottom.equalTo(self.dateLabel.mas_bottom);
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(@55);
        }];
        
        _rechargeWayLable = lable;
    }
    
    return _rechargeWayLable;
}

- (UILabel *)beforeMoneyLabel
{
    if (_beforeMoneyLabel == nil)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.font = self.dateLabel.font;
        lable.textColor = [UIColor blackColor];
        lable.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:lable];
        
        _beforeMoneyLabel = lable;
    }
    
    return _beforeMoneyLabel;
}

- (UILabel *)afterMoneyLabel
{
    if (_afterMoneyLabel == nil)
    {
        UILabel *lable = [[UILabel alloc] init];
        lable.font = self.dateLabel.font;
        lable.textColor = [UIColor blackColor];
        lable.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:lable];
        
        _afterMoneyLabel = lable;
    }
    
    return _afterMoneyLabel;
}

- (void)setPaidChargeItemModel:(LQPaidChargeItemsModel *)paidChargeItemModel
{
    _paidChargeItemModel = paidChargeItemModel;
    
    self.dateLabel.text = paidChargeItemModel.operatdatetime;
    self.rechargeMoneyLabel.text = [NSString stringWithFormat:@"%@元",paidChargeItemModel.moneyofamount];
    self.beforeMoneyLabel.text =  [NSString stringWithFormat:@"%@%@",paidChargeItemModel.chargebefmoney,self.unit];
    self.afterMoneyLabel.text = [NSString stringWithFormat:@"%@%@",paidChargeItemModel.chargeaftmoney,self.unit];
    
    if (self.rechmodle == 1)
    {
        NSArray *array = @[@"开户结算",@"充值",@"退费",@"离线充值",@"离线退费",@"撤销充值",@"自助充值"];
        self.rechargeWayLable.text = array[paidChargeItemModel.actiontype - 1];
    }
    
    [self.beforeMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rechargeWayLable.mas_right);
        make.right.equalTo(self.afterMoneyLabel.mas_left);
        make.top.equalTo(self.dateLabel.mas_top);
        make.bottom.equalTo(self.dateLabel.mas_bottom);
        make.width.equalTo(self.afterMoneyLabel);
    }];
    
    [self.afterMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.top.equalTo(self.dateLabel.mas_top);
        make.bottom.equalTo(self.dateLabel.mas_bottom);
        make.left.equalTo(self.beforeMoneyLabel.mas_right);
        make.width.equalTo(self.beforeMoneyLabel);
    }];
    
}

@end
