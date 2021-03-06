//
//  LQEveryYearUesView.m
//  朝阳能源结算
//
//  Created by admin on 15/8/14.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-----------------------年用能分析中该年每月用能情况----------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------

#import "LQEveryYearUesView.h"
#import "LQEveryYearUesCell.h"
#import "LQCalendarFooterView.h"

@interface LQEveryYearUesView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectView;
@property (nonatomic, copy) NSString *eunit;

@end

@implementation LQEveryYearUesView

- (void)setMonthUseArray:(NSArray *)monthUseArray
{
    _monthUseArray = monthUseArray;
    
    [self.collectView reloadData];
}

+ (instancetype)everyYearUesViewWithFrame:(CGRect)frame eunit:(NSString *)eunit
{
    return [[self alloc] initWithFrame:frame eunit:eunit];
}

- (instancetype)initWithFrame:(CGRect)frame eunit:(NSString *)eunit
{
    if (self = [super initWithFrame:frame])
    {
        self.eunit = eunit;
        
        [self doLoading];
    }
    
    return self;
}

- (void)doLoading
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake((LQScreen_Width-20)/4, 25)];//设置cell的尺寸
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];//设置其布局方向
    flowLayout.footerReferenceSize = CGSizeMake(LQScreen_Width-20, 40.0f);
    
    // 每行的最小间距
    flowLayout.minimumLineSpacing = 0.0f;
    // 每列的最小间距，设置Cell的大小已经留出1个像素大小，所以此处设置0即可
    flowLayout.minimumInteritemSpacing = 0.0f;
    // CollectionView视图的/上/左/下/右,的边距
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 0, LQScreen_Width-20, EveryYearUseView_Height) collectionViewLayout:flowLayout];
    [self.collectView setUserInteractionEnabled:YES];
    [self.collectView setPagingEnabled:YES];
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    [self.collectView registerClass:[LQEveryYearUesCell class] forCellWithReuseIdentifier:@"mycell"];
    [self.collectView registerClass:[LQCalendarFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    self.collectView.layer.borderColor = Layer_BorderColor;
    self.collectView.layer.borderWidth = Layer_BorderWidth;
    [self addSubview:self.collectView];
}

#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.monthUseArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LQEveryYearUesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mycell" forIndexPath:indexPath];
    
    cell.idLable.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    cell.numLable.text = self.monthUseArray[indexPath.row];
    
    return cell;
}

/**
 *  设置表格尾部的view
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionFooter)
    {
        LQCalendarFooterView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        footerview.backgroundColor = [UIColor whiteColor];
        footerview.unit = self.eunit;
        
        //计算当年所有月份的用能总和
        float total = 0.0;
        for (NSString *num in self.monthUseArray)
        {
            float numm = [num floatValue];
            
            total = total + numm;
        }
        footerview.total = total;
        
        reusableview = footerview;
    }
    
    return reusableview;
    
}

@end
