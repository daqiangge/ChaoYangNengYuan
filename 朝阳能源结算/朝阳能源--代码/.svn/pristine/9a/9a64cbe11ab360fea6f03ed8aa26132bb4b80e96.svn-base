//
//  LQEveryYearUesView.m
//  朝阳能源结算
//
//  Created by admin on 15/8/14.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "LQEveryYearUesView.h"
#import "LQEveryYearUesCell.h"
#import "LQCalendarFooterView.h"

@interface LQEveryYearUesView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation LQEveryYearUesView

+ (instancetype)everyYearUesViewWithFrame:(CGRect)frame
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
    
    UICollectionView *collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 0, LQScreen_Width-20, EveryYearUseView_Height) collectionViewLayout:flowLayout];
    [collectView setUserInteractionEnabled:YES];
    [collectView setPagingEnabled:YES];
    collectView.delegate = self;
    collectView.dataSource = self;
    [collectView registerClass:[LQEveryYearUesCell class] forCellWithReuseIdentifier:@"mycell"];
    [collectView registerClass:[LQCalendarFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    [self addSubview:collectView];
    
}

#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LQEveryYearUesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mycell" forIndexPath:indexPath];
    
    cell.idLable.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    cell.numLable.text = @"145.99";
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionFooter)
    {
        LQCalendarFooterView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        
        footerview.backgroundColor = [UIColor whiteColor];
        reusableview = footerview;
    }
    
    return reusableview;
    
}

@end
