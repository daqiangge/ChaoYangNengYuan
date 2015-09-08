//
//  LQNoRecordCell.m
//  朝阳能源结算
//
//  Created by admin on 15/9/8.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQNoRecordCell.h"

@implementation LQNoRecordCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    return [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UILabel *lable      = [[UILabel alloc] init];
        lable.text          = @"无记录";
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor     = [UIColor grayColor];
        lable.font          = [UIFont systemFontOfSize:15];
        [self addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.and.right.equalTo(self);
        }];
    }
    
    return self;
}

@end
