//
//  LQRechargeRecordView.m
//  朝阳能源结算
//
//  Created by admin on 15/9/4.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQRechargeRecordView.h"
#import "LQRechargeRecordHeaderView.h"
#import "LQPaidChargeModel.h"
#import "LQPaidChargeItemsModel.h"
#import "LQRechargeRecordCell.h"
#import "LQBillsCell.h"
#import "LQNoRecordCell.h"
#import "LQAccountItemModel.h"
#import "LQOrderModel.h"

@interface LQRechargeRecordView()<UITableViewDataSource,UITableViewDelegate,LQBillsCellDelegate>

@property (nonatomic, weak  ) LQRechargeRecordHeaderView *rechargeRecordHeaderView;
@property (nonatomic, weak  ) UITableView                *rechargeRecordTableView;
@property (nonatomic, copy  ) NSString                   *accountid;
@property (nonatomic, copy  ) NSString                   *sessionid;
@property (nonatomic, strong) NSMutableArray             *paidChargeArray;
@property (nonatomic, weak  ) UIActivityIndicatorView    *rechargeRecordAct;
@property (nonatomic, copy  ) NSString                   *unit;
@property (nonatomic, strong) LQAccountItemModel         *accountItemModel;

@end

@implementation LQRechargeRecordView

- (NSMutableArray *)paidChargeArray
{
    if (!_paidChargeArray)
    {
        _paidChargeArray = [NSMutableArray array];
    }
    
    return _paidChargeArray;
}

- (LQRechargeRecordHeaderView *)rechargeRecordHeaderView
{
    if (!_rechargeRecordHeaderView)
    {
        LQRechargeRecordHeaderView *view = [LQRechargeRecordHeaderView viewWithFrame:CGRectZero rechmodle:self.accountItemModel.rechmodle];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(LQScreen_Width, 40));
        }];
        
        _rechargeRecordHeaderView = view;
    }
    
    return _rechargeRecordHeaderView;
}

- (UIActivityIndicatorView *)rechargeRecordAct
{
    if (!_rechargeRecordAct)
    {
        UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc] init];
        [act setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        [self.rechargeRecordTableView addSubview:act];
        
        [act mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.rechargeRecordTableView);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        _rechargeRecordAct = act;
    }
    
    return _rechargeRecordAct;
}

- (UITableView *)rechargeRecordTableView
{
    if (_rechargeRecordTableView == nil)
    {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
        [self addSubview:tableView];
        
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rechargeRecordHeaderView.mas_bottom);
            make.bottom.equalTo(self.mas_bottom);
            make.left.equalTo(self.mas_left);
            make.width.mas_equalTo(self);
        }];
        
        tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshingTableView)];
        
        _rechargeRecordTableView = tableView;
    }
    
    return _rechargeRecordTableView;
}

+ (instancetype)rechargeRecordViewWithFrame:(CGRect)frame accountid:(NSString *)accountid sessionid:(NSString *)sessionid accountItemModel:(LQAccountItemModel *)accountItemModel
{
    return [[self alloc] initWithFrame:frame accountid:accountid sessionid:sessionid accountItemModel:accountItemModel];
}

- (instancetype)initWithFrame:(CGRect)frame accountid:(NSString *)accountid sessionid:(NSString *)sessionid accountItemModel:(LQAccountItemModel *)accountItemModel
{
    if (self = [super initWithFrame:frame])
    {
        self.accountItemModel = accountItemModel;
        self.unit             = accountItemModel.eunit;
        self.accountid        = accountid;
        self.sessionid        = sessionid;
        
        [self.rechargeRecordAct startAnimating];
        
        self.rechargeRecordTableView.hidden = NO;
        
        [self refreshingTableView];
    }
    
    return self;
}

/**
 *  刷新充值记录列表
 */
- (void)refreshingTableView
{
    if (self.accountItemModel.rechmodle == 1)
    {
        //  获取预付费充值记录
        [self requestPaidChargeWithURLStr:@"/energy/do/chargeapp/getprepaidcharge.do"];
    }
    else
    {
        // 获取后付费充值记录
        [self requestPaidChargeWithURLStr:@"/energy/do/chargeapp/getpostpaidcharge.do"];
    }
}

#pragma mark - 网络请求
- (void)requestPaidChargeWithURLStr:(NSString *)str
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@?;sessionid=%@",IP,str,self.sessionid];
    NSDictionary *parameters = @{@"AccountId":self.accountid};
    
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         LQPaidChargeModel *paidChargeModel = [LQPaidChargeModel objectWithKeyValues:operation.responseString];
         
         if (paidChargeModel.returns)
         {
            NSArray *modelArray = [NSMutableArray arrayWithArray:paidChargeModel.items];
             
             NSMutableArray *array = [NSMutableArray array];
             
             for (LQPaidChargeItemsModel *itemModel in modelArray)
             {
                 LQPaidChargeCellFrameModel *frameModel = [[LQPaidChargeCellFrameModel alloc] init];
                 frameModel.itemsModel = itemModel;
                 [array addObject:frameModel];
             }
             
             self.paidChargeArray = [NSMutableArray arrayWithArray:array];
             
             [self.rechargeRecordAct stopAnimating];
             
             [self.rechargeRecordTableView reloadData];
             
             [self.rechargeRecordTableView.header endRefreshing];
         }
         else
         {
             if ([paidChargeModel.code isEqualToString:@"1006"])
             {
                 if ([self.delegate respondsToSelector:@selector(showAccountTimeOutAlterViewWithRechargeRecordView:)])
                 {
                     [self.delegate showAccountTimeOutAlterViewWithRechargeRecordView:self];
                 }
             }
             else
             {
                 if ([self.delegate respondsToSelector:@selector(showOtherRequestReturnFalseAlterViewWithRechargeRecordView:message:)])
                 {
                     [self.delegate showOtherRequestReturnFalseAlterViewWithRechargeRecordView:self message:paidChargeModel.info];
                 }
             }
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         LQLog(@"%@",error);
         
         [self.rechargeRecordAct stopAnimating];
         
         [self.rechargeRecordTableView.header endRefreshing];
         
         MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
         hud.labelText = HTTPRequestErrer_Text;
         hud.mode = MBProgressHUDModeText;
         [hud hide:YES afterDelay:1.5];
     }];
}

#pragma mark - TableViewDelegate&Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.paidChargeArray.count == 0)
    {
        return 1;
    }
    
    return self.paidChargeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.paidChargeArray.count == 0)
    {
        LQNoRecordCell *cell = [LQNoRecordCell cellWithTableView:tableView];
        
        return cell;
    }
    
    if (self.accountItemModel.rechmodle == 1)
    {
        LQRechargeRecordCell *cell = [LQRechargeRecordCell cellWithTableView:tableView accountItemModel:self.accountItemModel];
        
        cell.cellFrameModel = self.paidChargeArray[indexPath.row];
        
        return cell;
    }
    else
    {
        LQBillsCell *cell = [LQBillsCell cellWithTableView:tableView cellForRowAtIndexPath:indexPath accountItemModel:self.accountItemModel];
        cell.delegate = self;
        cell.cellFrameModel = self.paidChargeArray[indexPath.row];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.paidChargeArray.count == 0)
    {
        return 30;
    }
    
    LQPaidChargeCellFrameModel *frameModel = self.paidChargeArray[indexPath.row];
    
    return frameModel.cellHeight;
}

#pragma mark - LQBillsCellDelegate
- (void)billsCellDidClickSettlementBtnWithCell:(LQBillsCell *)cell orderModel:(LQOrderModel *)orderModel
{
    if ([self.delegate respondsToSelector:@selector(billsCellDidClickSettlementBtnWithRechargeRecordView:Cell:orderModel:)])
    {
        [self.delegate billsCellDidClickSettlementBtnWithRechargeRecordView:self Cell:cell orderModel:orderModel];
    }
}

@end
