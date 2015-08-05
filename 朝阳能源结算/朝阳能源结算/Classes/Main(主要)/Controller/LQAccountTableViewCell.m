//
//  LQAccountTableViewCell.m
//  朝阳能源结算
//
//  Created by admin on 15/8/5.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQAccountTableViewCell.h"

@implementation LQAccountTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor clearColor];
        [self doLoading];
    }
    
    return self;
}

- (void)doLoading
{
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.frame = CGRectMake(10, 10, self.frame.size.width-20, 80);
    backgroundView.backgroundColor = [UIColor greenColor];
    [self addSubview:backgroundView];
    backgroundView.layer.borderColor = [UIColor clearColor].CGColor;
    backgroundView.layer.borderWidth = 0.01;
    backgroundView.layer.cornerRadius = 8;
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
