//
//  LQAccountBillView.m
//  朝阳能源结算
//
//  Created by admin on 15/8/11.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------户头详情-账单-----------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------

#import "LQAccountBillView.h"
#import "LQRechargeRecordTableViewCell.h"
#import "LQCalendarView.h"
#import "LQChooseMonthBtnGroup.h"

#define RechargeRecordBtn_Height 40

@interface LQAccountBillView()<UITableViewDataSource,UITableViewDelegate,LQChooseMonthBtnGroupDelegate>

@property (nonatomic, weak) UIView *lineView;
@property (nonatomic, weak) UIButton *rechargeRecordBtn;
@property (nonatomic, weak) UIButton *monthAnalysisBtn;
@property (nonatomic, weak) UIButton *yearAnalysisBtn;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIView *scrollBackgroundView;
@property (nonatomic, weak) UITableView *rechargeRecordTableView;
@property (nonatomic, weak) UIView *monthAnalysisView;
@property (nonatomic, weak) UIView *yearAnalysisView;
@property (nonatomic, weak) LQCalendarView *calendar;
@property (nonatomic, weak) LQChooseMonthBtnGroup *chooseMonthBtnGroupView;

@end

@implementation LQAccountBillView

- (UIView *)lineView
{
    if (_lineView == nil)
    {
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor redColor];
        [self addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.rechargeRecordBtn.mas_centerX);
            make.bottom.equalTo(self.rechargeRecordBtn.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(LQScreen_Width/3 - 40, 3));
        }];
        
        _lineView = lineView;
    }
    
    return _lineView;
}

- (UIButton *)rechargeRecordBtn
{
    if (_rechargeRecordBtn == nil)
    {
        _rechargeRecordBtn = [self buttonWithTitle:@"充值记录" action:@selector(rechargeRecordBtn:)];
        
        [_rechargeRecordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left);
            make.size.mas_equalTo(CGSizeMake(LQScreen_Width/3, RechargeRecordBtn_Height));
        }];
        
        //画分割线
        UIView *dividingLine1 = [[UIView alloc] init];
        dividingLine1.backgroundColor = RGB(236, 236, 236);
        [self addSubview:dividingLine1];
        [dividingLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self);
            make.bottom.equalTo(self.rechargeRecordBtn.mas_bottom);
            make.height.equalTo(@1);
        }];
        UIView *dividingLine2 = [[UIView alloc] init];
        dividingLine2.backgroundColor = dividingLine1.backgroundColor;
        [self addSubview:dividingLine2];
        [dividingLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self);
            make.top.equalTo(self.rechargeRecordBtn.mas_top);
            make.height.equalTo(@1);
        }];
    }
    
    return _rechargeRecordBtn;
}

- (UIButton *)monthAnalysisBtn
{
    if (_monthAnalysisBtn == nil)
    {
        _monthAnalysisBtn = [self buttonWithTitle:@"月用能分析" action:@selector(rechargeRecordBtn:)];
        
        [_monthAnalysisBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.rechargeRecordBtn.mas_right);
            make.size.mas_equalTo(CGSizeMake(LQScreen_Width/3, RechargeRecordBtn_Height));
        }];
    }
    
    return _monthAnalysisBtn;
}

- (UIButton *)yearAnalysisBtn
{
    if (_yearAnalysisBtn == nil)
    {
        _yearAnalysisBtn = [self buttonWithTitle:@"年用能分析" action:@selector(rechargeRecordBtn:)];
        
        [_yearAnalysisBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.monthAnalysisBtn.mas_right);
            make.size.mas_equalTo(CGSizeMake(LQScreen_Width/3, RechargeRecordBtn_Height));
        }];
    }
    
    return _yearAnalysisBtn;
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil)
    {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.pagingEnabled = YES;
        [self addSubview:scrollView];
        
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.top.equalTo(self.rechargeRecordBtn.mas_bottom);
            make.bottom.equalTo(self.mas_bottom);
            make.width.equalTo([NSNumber numberWithFloat:LQScreen_Width]);
        }];
        
        _scrollView = scrollView;
    }
    
    return _scrollView;
}

- (UIView *)scrollBackgroundView
{
    if (_scrollBackgroundView == nil)
    {
        UIView *view = [[UIView alloc] init];
        [self.scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.scrollView);
            make.width.equalTo([NSNumber numberWithFloat:LQScreen_Width*3]);
            make.height.equalTo(self.scrollView);
        }];
        
        _scrollBackgroundView = view;
    }
    
    return _scrollBackgroundView;
}

- (UITableView *)rechargeRecordTableView
{
    if (_rechargeRecordTableView == nil)
    {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.scrollBackgroundView addSubview:tableView];
        
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(self.scrollBackgroundView);
            make.left.equalTo(self.scrollBackgroundView.mas_left);
            make.width.mas_equalTo(self.scrollView);
            make.height.mas_equalTo(self.scrollBackgroundView);
        }];
        
        _rechargeRecordTableView = tableView;
    }
    
    return _rechargeRecordTableView;
}

- (UIView *)monthAnalysisView
{
    if (_monthAnalysisView == nil)
    {
        UIView *view = [[UIView alloc] init];
        [self.scrollBackgroundView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(self.scrollBackgroundView);
            make.left.equalTo(self.rechargeRecordTableView.mas_right);
            make.width.mas_equalTo(self.scrollView);
            make.height.mas_equalTo(self.scrollBackgroundView);
        }];
        
        _monthAnalysisView = view;
    }
    
    return _monthAnalysisView;
}

- (UIView *)yearAnalysisView
{
    if (_yearAnalysisView == nil)
    {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor blueColor];
        [self.scrollBackgroundView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(self.scrollBackgroundView);
            make.left.equalTo(self.monthAnalysisView.mas_right);
            make.width.mas_equalTo(self.scrollView);
            make.height.mas_equalTo(self.scrollBackgroundView);
        }];
        
        _yearAnalysisView = view;
    }
    
    return _yearAnalysisView;
}

- (LQChooseMonthBtnGroup *)chooseMonthBtnGroupView
{
    if (_chooseMonthBtnGroupView == nil)
    {
        LQChooseMonthBtnGroup *view = [LQChooseMonthBtnGroup chooseMonthBtnGroupWithFrame:CGRectZero];
        view.delegate = self;
        [self.scrollBackgroundView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollBackgroundView.mas_top);
            make.left.equalTo(self.rechargeRecordTableView.mas_right);
            make.right.equalTo(self.yearAnalysisView.mas_left);
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
        LQCalendarView *calendar = [LQCalendarView calendarWithDays:-190 showType:CalendarShowTypeSingle singleShowMonth:0 frame:CGRectZero];
        calendar.isEnable = YES;
        calendar.calendarBlock = ^(RMCalendarModel *model) {
            if (model.ticketModel) {
                NSLog(@"%lu-%lu-%lu-票价%.1f",(unsigned long)model.year,(unsigned long)model.month,(unsigned long)model.day, model.ticketModel.ticketPrice);
            } else {
                NSLog(@"%lu-%lu-%lu",(unsigned long)model.year,(unsigned long)model.month,(unsigned long)model.day);
            }
        };
        
        calendar.layer.borderColor = Layer_BorderColor;
        calendar.layer.borderWidth = 1;
        
        [self.scrollBackgroundView addSubview:calendar];
        
        [calendar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.chooseMonthBtnGroupView.mas_bottom).with.offset(0);
            make.bottom.equalTo(self.scrollBackgroundView.mas_bottom).with.offset(-10);
            make.left.equalTo(self.rechargeRecordTableView.mas_right).with.offset(10);
            make.right.equalTo(self.yearAnalysisView.mas_left).with.offset(-10);
        }];
        
        _calendar = calendar;
    }
    
    return _calendar;
}

- (UIButton *)buttonWithTitle:(NSString *)title action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    return button;
}

+ (instancetype)accountBillViewWithFrame:(CGRect)frame
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
    self.rechargeRecordBtn.selected = YES;
    self.monthAnalysisBtn.selected = NO;
    self.yearAnalysisBtn.selected = NO;
    self.lineView.hidden = NO;
    self.scrollView.hidden = NO;
    self.rechargeRecordTableView.hidden = NO;
    self.monthAnalysisView.hidden = NO;
    self.yearAnalysisView.hidden = NO;
    
    [self loadingCalendar];
    
}

- (void)loadingCalendar
{
    // 此处用到MJ大神开发的框架，根据自己需求调整是否需要
    self.calendar.modelArr = [TicketModel objectArrayWithKeyValuesArray:@[@{@"year":@2015, @"month":@8, @"day":@10,
                                                                       @"ticketCount":@194, @"ticketPrice":@283},
                                                                     @{@"year":@2015, @"month":@9, @"day":@7,
                                                                       @"ticketCount":@91, @"ticketPrice":@223},
                                                                     @{@"year":@2015, @"month":@10, @"day":@4,
                                                                       @"ticketCount":@91, @"ticketPrice":@23},
                                                                     @{@"year":@2015, @"month":@7, @"day":@8,
                                                                       @"ticketCount":@2, @"ticketPrice":@203},
                                                                     @{@"year":@2015, @"month":@8, @"day":@28,
                                                                       @"ticketCount":@2, @"ticketPrice":@103},
                                                                     @{@"year":@2015, @"month":@8, @"day":@18,
                                                                       @"ticketCount":@0, @"ticketPrice":@153}]]; //最后一条数据ticketCount 为0时不显示
}

/**
 *  功能模块的选择切换
 */
- (void)rechargeRecordBtn:(UIButton *)btn
{
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(btn.mas_centerX);
        make.bottom.equalTo(btn.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(LQScreen_Width/3 - 40, 3));
    }];
}

#pragma mark - TableViewDelegate&Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQRechargeRecordTableViewCell *cell = [[LQRechargeRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RechargeRecordCell_Height;
}

#pragma mark - LQChooseMonthBtnGroupDelegate
- (void)chooseMonthBtnGroupDidClickBtnWithView:(LQChooseMonthBtnGroup *)view button:(UIButton *)btn
{
    [self.calendar changeSingleShowMonth:(int)btn.tag-100];
}

@end
