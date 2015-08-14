//
//  LQCalendarFooterView.m
//  朝阳能源结算
//
//  Created by admin on 15/8/13.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQCalendarFooterView.h"

@interface LQCalendarFooterView()

@property (nonatomic, strong) NSMutableAttributedString *totalAttributedStr;

@end

@implementation LQCalendarFooterView

- (NSMutableAttributedString *)totalAttributedStr
{
    if (_totalAttributedStr == nil)
    {
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:@"合计： 吨" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
        _totalAttributedStr = attributedStr;
    }
    
    return _totalAttributedStr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self doLoading];
    }
    
    return self;
}

- (void)doLoading
{
    UILabel *totalLable = [[UILabel alloc] init];
    totalLable.font = [UIFont systemFontOfSize:15];
    [self addSubview:totalLable];
    [totalLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.top.and.bottom.equalTo(self);
        make.width.equalTo(@180);
    }];
    
    UILabel *unitLable = [[UILabel alloc] init];
    unitLable.text = @"单位：吨";
    unitLable.font = totalLable.font;
    unitLable.textColor = [UIColor blackColor];
    unitLable.textAlignment = NSTextAlignmentRight;
    [self addSubview:unitLable];
    [unitLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.top.and.bottom.equalTo(self);
        make.width.equalTo(@100);
    }];
    
    [self.totalAttributedStr insertAttributedString:[[NSMutableAttributedString alloc] initWithString:@"2333.99" attributes:@{NSForegroundColorAttributeName:[UIColor blueColor]}] atIndex:3];
    totalLable.attributedText = self.totalAttributedStr;
    
}


@end
