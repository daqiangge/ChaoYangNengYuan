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

#define RechargeRecordBtn_Height 40

@interface LQAccountBillView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UIView *lineView;
@property (nonatomic, weak) UIButton *rechargeRecordBtn;
@property (nonatomic, weak) UIButton *monthAnalysisBtn;
@property (nonatomic, weak) UIButton *yearAnalysisBtn;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIView *scrollBackgroundView;
@property (nonatomic, weak) UITableView *rechargeRecordTableView;
@property (nonatomic, weak) UIView *monthAnalysisView;
@property (nonatomic, weak) UIView *yearAnalysisView;

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
        scrollView.backgroundColor = [UIColor redColor];
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
        tableView.backgroundColor = [UIColor grayColor];
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
        view.backgroundColor = [UIColor greenColor];
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

@end
