//
//  LQMonthAnalysisView.m
//  朝阳能源结算
//
//  Created by admin on 15/8/17.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQMonthAnalysisView.h"
#import "LQCalendarView.h"
#import "LQChooseMonthBtnGroup.h"
#import "LQAccountItemModel.h"

@interface LQMonthAnalysisView()<LQChooseMonthBtnGroupDelegate>

@property (nonatomic, weak) LQCalendarView *calendar;
@property (nonatomic, weak) LQChooseMonthBtnGroup *chooseMonthBtnGroupView;
@property (nonatomic, weak) UIScrollView *scrollview;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, strong) LQAccountItemModel *accountItemModel;

@end


@implementation LQMonthAnalysisView

- (UIScrollView *)scrollview
{
    if (_scrollview == nil)
    {
        UIScrollView *scrollview = [[UIScrollView alloc] init];
        scrollview.contentSize = CGSizeMake(LQScreen_Width, 400);
        [self addSubview:scrollview];
        
        [scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.and.right.equalTo(self);
        }];
        
        _scrollview = scrollview;
    }
    
    return _scrollview;
}

- (LQChooseMonthBtnGroup *)chooseMonthBtnGroupView
{
    if (_chooseMonthBtnGroupView == nil)
    {
        LQChooseMonthBtnGroup *view = [LQChooseMonthBtnGroup chooseMonthBtnGroupWithFrame:CGRectZero];
        view.delegate = self;
        [self.scrollview addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.and.right.equalTo(self);
            make.height.equalTo(@40);
        }];
        
        _chooseMonthBtnGroupView = view;
    }
    
    return _chooseMonthBtnGroupView;
}

- (LQCalendarView *)calendar
{
    if (_calendar == nil)
    {
        LQCalendarView *calendar = [LQCalendarView calendarWithDays:-190 showType:CalendarShowTypeSingle singleShowMonth:0 frame:CGRectMake(10, 40, LQScreen_Width-20, 400) unit:self.unit];
        calendar.isEnable = YES;
        calendar.calendarBlock = ^(RMCalendarModel *model) {
            if (model.ticketModel) {
                NSLog(@"%lu-%lu-%lu-票价%.1f",(unsigned long)model.year,(unsigned long)model.month,(unsigned long)model.day, model.ticketModel.ticketPrice);
            } else {
                NSLog(@"%lu-%lu-%lu",(unsigned long)model.year,(unsigned long)model.month,(unsigned long)model.day);
            }
        };
        [self.scrollview addSubview:calendar];
        
        _calendar = calendar;
    }
    
    return _calendar;
}

- (instancetype)initWithFrame:(CGRect)frame accountItemModel:(LQAccountItemModel *)accountItemModel
{
    if (self = [super initWithFrame:frame])
    {
        self.accountItemModel = accountItemModel;
        self.chooseMonthBtnGroupView.hidden = NO;
        self.calendar.hidden = NO;
        [self loadingCalendar];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)loadingCalendar
{
    // 此处用到MJ大神开发的框架，根据自己需求调整是否需要
    self.calendar.modelArr = [TicketModel objectArrayWithKeyValuesArray:@[@{@"year":@2015, @"month":@9, @"day":@9,
                                                                            @"ticketCount":@194, @"ticketPrice":@283},
                                                                          @{@"year":@2015, @"month":@9, @"day":@8,
                                                                            @"ticketCount":@91, @"ticketPrice":@223},
                                                                          @{@"year":@2015, @"month":@7, @"day":@8,
                                                                            @"ticketCount":@2, @"ticketPrice":@203},
                                                                          @{@"year":@2015, @"month":@8, @"day":@28,
                                                                            @"ticketCount":@2, @"ticketPrice":@103},
                                                                          @{@"year":@2015, @"month":@8, @"day":@18,
                                                                            @"ticketCount":@0, @"ticketPrice":@153}]]; //最后一条数据ticketCount 为0时不显示
}

#pragma mark - LQChooseMonthBtnGroupDelegate
- (void)chooseMonthBtnGroupDidClickBtnWithView:(LQChooseMonthBtnGroup *)view button:(UIButton *)btn
{
    [self.calendar changeSingleShowMonth:(int)btn.tag-100];
}

@end
