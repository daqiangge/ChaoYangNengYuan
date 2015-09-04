//
//  LQYearAnalysisView.m
//  朝阳能源结算
//
//  Created by admin on 15/8/14.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQYearAnalysisView.h"
#import "LQChartView.h"
#import "LQEveryYearUesView.h"
#import "LQChooseYearBtnGroup.h"
#import "LQAnalyzeForYearUseItemModel.h"
#import "LQAnalyzeForYearUseModel.h"

@interface LQYearAnalysisView()<LQChooseYearBtnGroupDelegate,LQChartViewDataSource>

@property (nonatomic, weak) UIScrollView *scrollview;
@property (nonatomic, copy) NSString *accountid;
@property (nonatomic, copy) NSString *sessionid;
@property (nonatomic, strong) NSMutableArray *monthUseArray;

@end

@implementation LQYearAnalysisView

- (NSMutableArray *)monthUseArray
{
    if (!_monthUseArray)
    {
        _monthUseArray = [NSMutableArray array];
    }
    
    return _monthUseArray;
}

- (UIScrollView *)scrollview
{
    if (_scrollview == nil)
    {
        UIScrollView *scrollview = [[UIScrollView alloc] init];
        scrollview.contentSize = CGSizeMake(LQScreen_Width, BtnGroupView_Height+ChartView_Height+EveryYearUseView_Height+10);
        [self addSubview:scrollview];
        
        [scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.and.right.equalTo(self);
        }];
        
        _scrollview = scrollview;
    }
    
    return _scrollview;
}

+ (instancetype)yearAnalysisViewWithFrame:(CGRect)frame accountid:(NSString *)accountid sessionid:(NSString *)sessionid
{
    return [[self alloc] initWithFrame:frame accountid:accountid sessionid:sessionid];
}


- (instancetype)initWithFrame:(CGRect)frame accountid:(NSString *)accountid sessionid:(NSString *)sessionid
{
    if (self = [super initWithFrame:frame])
    {
        self.accountid = accountid;
        self.sessionid = sessionid;
        
        [self doLoading];
        [self requestAnalyzeForYearUse];
    }
    
    return self;
}

- (void)doLoading
{
    LQChooseYearBtnGroup *btnGroupView = [LQChooseYearBtnGroup chooseYearBtnGroupWithFrame:CGRectMake(0, 0, LQScreen_Width, BtnGroupView_Height)];
    btnGroupView.delegate = self;
    [self.scrollview addSubview:btnGroupView];
    
    LQChartView *chartView = [LQChartView chartViewWithFrame:CGRectMake(0, BtnGroupView_Height, LQScreen_Width, ChartView_Height)];
    chartView.dataSource = self;
    [self.scrollview addSubview:chartView];
    
    LQEveryYearUesView *everyYearUseView = [LQEveryYearUesView everyYearUesViewWithFrame:CGRectMake(0, CGRectGetMaxY(chartView.frame), LQScreen_Width, EveryYearUseView_Height)];
    [self.scrollview addSubview:everyYearUseView];
}

#pragma mark - 网络请求
- (void)requestAnalyzeForYearUse
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"%@/energy/do/chargeapp/analyzeforyearuse.do?AccountId=%@&Year=%@;sessionid=%@",IP,self.accountid,@"2015",self.sessionid];
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         LQLog(@"%@",operation.responseString);
         
         LQAnalyzeForYearUseModel *userModel = [LQAnalyzeForYearUseModel objectWithKeyValues:operation.responseString];
         
//         for (int i = 0; i < 12; i++)
//         {
//             for (LQAnalyzeForYearUseItemModel *item in userModel.items)
//             {
//                 if (i == item.recmonth)
//                 {
//                     [self.monthUseArray addObject:item.recvalues];
//                     
//                     break;
//                 }
//             }
//             
//             [self.monthUseArray addObject:@"0"];
//         }
//         
//         LQLog(@"%@",self.monthUseArray);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         LQLog(@"%@",error);
         
         MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
         hud.labelText = HTTPRequestErrer_Text;
         hud.mode = MBProgressHUDModeText;
         [hud hide:YES afterDelay:1.5];
     }];
}

#pragma mark - LQChartViewDelegate
- (NSArray *)chartViewValueArrayWithView:(LQChartView *)chartView
{
    NSArray *array = [NSArray arrayWithArray:self.monthUseArray];
    return array;
}

#pragma mark - LQChooseYearBtnGroupDelegate
- (void)chooseYearBtnGroupDidClickBtnWithView:(LQChooseYearBtnGroup *)view button:(UIButton *)btn
{
    
}

@end
