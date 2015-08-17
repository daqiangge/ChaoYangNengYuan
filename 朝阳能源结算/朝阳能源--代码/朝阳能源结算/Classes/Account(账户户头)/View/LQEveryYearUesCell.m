//
//  LQEveryYearUesCell.m
//  朝阳能源结算
//
//  Created by admin on 15/8/17.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQEveryYearUesCell.h"

@implementation LQEveryYearUesCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        
//        self.layer.borderColor = Layer_BorderColor;
//        self.layer.borderWidth = 0.5;
        
        [self doLoading];
    }
    
    return self;
}

- (void)doLoading
{
    UILabel *idLable = [[UILabel alloc] init];
    idLable.frame = CGRectMake(0, 0, self.height-5, self.height);
    idLable.textAlignment = NSTextAlignmentCenter;
    idLable.backgroundColor = RGB(244, 246, 249);
    idLable.textColor = [UIColor blackColor];
    idLable.font = [UIFont systemFontOfSize:12];
    idLable.layer.borderColor = Layer_BorderColor;
    idLable.layer.borderWidth = 0.5;
    [self addSubview:idLable];
    self.idLable = idLable;
    
    UILabel *numLable = [[UILabel alloc] init];
    numLable.frame = CGRectMake(CGRectGetMaxX(idLable.frame), 0, self.width-idLable.width, self.height);
    numLable.textAlignment = NSTextAlignmentCenter;
    numLable.textColor = [UIColor blackColor];
    numLable.font = [UIFont boldSystemFontOfSize:12];
    numLable.layer.borderColor = Layer_BorderColor;
    numLable.layer.borderWidth = 0.5;
    [self addSubview:numLable];
    self.numLable = numLable;
    
    
    
//    UIView *lineView = [[UIView alloc] init];
//    lineView.backgroundColor = [UIColor lightGrayColor];
//    lineView.frame = CGRectMake(CGRectGetMaxX(idLable.frame), 0, 0.5, self.height);
//    [self addSubview:lineView];
    
}

@end
