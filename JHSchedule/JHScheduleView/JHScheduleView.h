//
//  JHScheduleView.h
//  JHSchedule
//
//  Created by 307A on 16/9/8.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseBean.h"

@protocol JHScheduleViewDelegate<NSObject>

- (NSInteger)rowsOfWeekScheduleView;
- (void)onCourseClick:(CourseBean *)course;

@end

@interface JHScheduleView : UIView

@property (nonatomic) id delegate;

@property (nonatomic) CGFloat kWidthGrid;   //周视图中一个格子的宽度
@property (nonatomic) CGFloat kHeightGrid;   //周视图中一个格子的高度
@property (nonatomic) CGFloat headerHeight;  //周视图中头部高度

//加载课程
- (void)loadCourses:(NSArray *)courseArray;

//重新加载表格，应用自定义样式
- (void)reloadView;

@end

