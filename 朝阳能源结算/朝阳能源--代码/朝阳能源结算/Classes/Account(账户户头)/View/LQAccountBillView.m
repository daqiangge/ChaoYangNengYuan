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
#import "LQRechargeRecordCell.h"
#import "LQCalendarView.h"
#import "LQChooseMonthBtnGroup.h"
#import "LQYearAnalysisView.h"
#import "LQRechargeRecordHeaderView.h"

#define RechargeRecordBtn_Height 40
#define ChooseModulaiBtn_FontOfSize 15

@interface LQAccountBillView()<UITableViewDataSource,UITableViewDelegate,LQChooseMonthBtnGroupDelegate,UIScrollViewDelegate>

@property (nonatomic, weak) UIView *lineView;
@property (nonatomic, weak) UIButton *rechargeRecordBtn;
@property (nonatomic, weak) UIButton *monthAnalysisBtn;
@property (nonatomic, weak) UIButton *yearAnalysisBtn;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIView *scrollBackgroundView;
@property (nonatomic, weak) UITableView *rechargeRecordTableView;
@property (nonatomic, weak) UIView *monthAnalysisView;
@property (nonatomic, weak) LQYearAnalysisView *yearAnalysisView;
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
        _rechargeRecordBtn = [self buttonWithTitle:@"充值记录" action:@selector(chooseModular:)];
        _rechargeRecordBtn.titleLabel.font = [UIFont boldSystemFontOfSize:ChooseModulaiBtn_FontOfSize];
        _rechargeRecordBtn.tag = 300;
        
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
        _monthAnalysisBtn = [self buttonWithTitle:@"月用能分析" action:@selector(chooseModular:)];
        _monthAnalysisBtn.tag = 301;
        
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
        _yearAnalysisBtn = [self buttonWithTitle:@"年用能分析" action:@selector(chooseModular:)];
        _yearAnalysisBtn.tag = 302;
        
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
        scrollView.delegate = self;
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
        LQRechargeRecordHeaderView *view = [[LQRechargeRecordHeaderView alloc] initWithFrame:CGRectMake(0, 0, LQScreen_Width, 40)];
        [self.scrollBackgroundView addSubview:view];
        
        UITableView *tableView = [[UITableView alloc] init];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
        [self.scrollBackgroundView addSubview:tableView];
        
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_bottom);
            make.bottom.equalTo(self.scrollBackgroundView.mas_bottom);
            make.left.equalTo(self.scrollBackgroundView.mas_left);
            make.width.mas_equalTo(self.scrollView);
        }];
        
        __weak __typeof(self) weakSelf = self;
        // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
        tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf refreshingRechargeRecord];
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

- (LQYearAnalysisView *)yearAnalysisView
{
    if (_yearAnalysisView == nil)
    {
        LQYearAnalysisView *view = [[LQYearAnalysisView alloc] init];
        [self.scrollBackgroundView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(self.scrollBackgroundView);
            make.left.equalTo(self.monthAnalysisView.mas_right);
            make.right.equalTo(self.scrollBackgroundView.mas_right);
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
    button.titleLabel.font = [UIFont systemFontOfSize:ChooseModulaiBtn_FontOfSize];
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
- (void)chooseModular:(UIButton *)btn
{
    self.rechargeRecordBtn.titleLabel.font = [UIFont systemFontOfSize:ChooseModulaiBtn_FontOfSize];
    self.monthAnalysisBtn.titleLabel.font  = [UIFont systemFontOfSize:ChooseModulaiBtn_FontOfSize];
    self.yearAnalysisBtn.titleLabel.font   = [UIFont systemFontOfSize:ChooseModulaiBtn_FontOfSize];
    
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:ChooseModulaiBtn_FontOfSize];
    
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(btn.mas_centerX);
        make.bottom.equalTo(btn.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(LQScreen_Width/3 - 40, 3));
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollView.contentOffset = CGPointMake(LQScreen_Width*(btn.tag - 300), 0);
    }];
}

/**
 *  刷新充值记录列表
 */
- (void)refreshingRechargeRecord
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"刷新成功");
        
        [self.rechargeRecordTableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.rechargeRecordTableView.header endRefreshing];
    });
}

#pragma mark - TableViewDelegate&Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQRechargeRecordCell *cell = [[LQRechargeRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Cell_Height;
}

#pragma mark - LQChooseMonthBtnGroupDelegate
- (void)chooseMonthBtnGroupDidClickBtnWithView:(LQChooseMonthBtnGroup *)view button:(UIButton *)btn
{
    [self.calendar changeSingleShowMonth:(int)btn.tag-100];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = self.scrollView.contentOffset;
    CGFloat offsetX = offset.x;
    CGFloat width = self.scrollView.frame.size.width;
    int pageNum = offsetX  / width;
    
    UIButton *btn = nil;
    switch (pageNum) {
        case 0:
            btn = self.rechargeRecordBtn;
            break;
            
        case 1:
            btn = self.monthAnalysisBtn;
            break;
            
        case 2:
            btn = self.yearAnalysisBtn;
            break;
    }
    
    [self chooseModular:btn];
}

@end
