//
//  LQChooseMonthBtnGroup.m
//  朝阳能源结算
//
//  Created by admin on 15/8/13.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQChooseMonthBtnGroup.h"

#define space  (10)
#define Button_Width (LQScreen_Width-space*7)/6

@interface LQChooseMonthBtnGroup()

@property (nonatomic, weak) UIButton *myBtn;

@end

@implementation LQChooseMonthBtnGroup

+ (instancetype)chooseMonthBtnGroupWithFrame:(CGRect)frame
{
    return [[self alloc] initWithFrame:frame];
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
    NSDateComponents *date= [[NSDate date] YMDComponents];
    
    UIButton *button = nil;
    for (int i = 0; i < 6; i++)
    {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"background_gray"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"background_green"] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.selected = NO;
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(chooseMonth:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        if (i == 0)
        {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).with.offset(10);
                make.top.equalTo(self.mas_top).with.offset(10);
                make.bottom.equalTo(self.mas_bottom).with.offset(-10);
                make.width.equalTo([NSNumber numberWithFloat:Button_Width]);
            }];
        }else
        {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(button.mas_right).with.offset(10);
                make.top.equalTo(self.mas_top).with.offset(10);
                make.bottom.equalTo(self.mas_bottom).with.offset(-10);
                make.width.equalTo([NSNumber numberWithFloat:Button_Width]);
            }];
        }
        
        NSInteger months = (date.month-i)<=0?(date.month-i)+12:(date.month-i);
        NSString *titleStr = [NSString stringWithFormat:@"%ld月",months];
        [btn setTitle:titleStr forState:UIControlStateNormal];
        
        switch (i)
        {
            case 0:
                [btn setTitle:@"本月" forState:UIControlStateNormal];
                btn.selected = YES;
                self.myBtn = btn;
                break;
        }
        
        button = btn;
    }
}

- (void)chooseMonth:(UIButton *)btn
{
    if (self.myBtn.tag == btn.tag)
    {
        return;
    }else
    {
        btn.selected = YES;
        self.myBtn.selected = NO;
        self.myBtn = btn;
        
        if ([self.delegate respondsToSelector:@selector(chooseMonthBtnGroupDidClickBtnWithView:button:)])
        {
            [self.delegate chooseMonthBtnGroupDidClickBtnWithView:self button:btn];
        }
    }
}

@end
