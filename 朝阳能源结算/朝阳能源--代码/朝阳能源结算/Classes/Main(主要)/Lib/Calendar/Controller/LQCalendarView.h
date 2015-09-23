//
//  LQCalendarView.h
//  RMCalendar
//
//  Created by admin on 15/8/12.
//  Copyright (c) 2015年 迟浩东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMCalendarLogic.h"


/**
 *  选中日起，回掉结果
 *
 *  @param model 返回模型
 */
typedef void (^CalendarBlock)(RMCalendarModel *model);

@interface LQCalendarView : UIView

/**
 *  UICollectionView 对象，用于显示布局，类似UITableView
 */
@property(nonatomic ,strong) UICollectionView* collectionView;
/**
 *  用于存放日期模型数组
 */
@property(nonatomic ,strong) NSMutableArray *calendarMonth;
/**
 *  逻辑处理
 */
@property(nonatomic ,strong) RMCalendarLogic *calendarLogic;
/**
 *  回调
 */
@property(nonatomic, copy) CalendarBlock calendarBlock;
/**
 *  天数
 */
@property(nonatomic, assign) int days;
/**
 *  展示类型
 */
@property(nonatomic, assign) CalendarShowType type;
/**
 *  用于存放价格模型数组
 */
@property(nonatomic, retain) NSMutableArray *modelArr;
/**
 *  无价格的日期是否可点击  默认为NO
 */
@property(nonatomic, assign) BOOL isEnable;

/**
 *  月总用量
 */
@property (nonatomic, assign) float  monthrecvalue;

+ (instancetype)calendarWithDays:(int)days showType:(CalendarShowType)type singleShowMonth:(int)singleShowMonth frame:(CGRect)frame unit:(NSString *)unit monthrecvalue:(float)monthrecvalue;
- (void)changeSingleShowMonth:(int)singleShowMonth;
- (void)reloadCalendar;

@end
