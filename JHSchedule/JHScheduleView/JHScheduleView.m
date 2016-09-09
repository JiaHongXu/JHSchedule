//
//  JHScheduleView.m
//  JHSchedule
//
//  Created by 307A on 16/9/8.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "JHScheduleView.h"
#import "TwoTitleButton.h"
#import "DateUtils.h"
#import "CourseButton.h"

//获取设备的物理高度
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
//获取设备的物理宽度
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)


#define RGBColor(r,g,b,a) ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a])
#define WEEKDAY_BGCOLOR  ([UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5])
#define WEEKDAY_SELECT_COLOR ([UIColor colorWithRed:32/255.0 green:81/255.0 blue:148/255.0 alpha:0.23])
#define WEEKDAY_FONT_COLOR ([UIColor colorWithRed:32/255.0 green:81/255.0 blue:148/255.0 alpha:1])


@interface JHScheduleView()

@property (nonatomic) NSArray *horTitles;  //横向的标题，（月份、日期）
@property (nonatomic) UIView *weekHeaderView; //周视图头部
@property (nonatomic) NSDateComponents *todayComp;  //今天的扩展
@property (nonatomic) UIScrollView *weekScrollView;  //周课表的滚动视图

@property (nonatomic) NSInteger courseNum;

@property (nonatomic) NSArray *colors;



@end

@implementation JHScheduleView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initData];
        [self initWeekView];
    }
    
    return self;
}

- (void)initWeekView{
    [self reloadView];
}

- (void)initData{
    _kWidthGrid = ScreenWidth/8;
    _kHeightGrid = 75;
    _headerHeight = 45;
    
    _colors = [[NSArray alloc] initWithObjects:@"9,155,43",@"251,136,71",@"163,77,140",@"32,81,148",@"255,170,0",@"4,155,151",@"38,101,252",@"234,51,36",@"107,177,39",@"245,51,119", nil];
    
    //先加载本周的月份以及日期
    _horTitles = [DateUtils getDatesOfCurrence];
    
    //赋值计算今天的日期
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    _todayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:today];
    
}

- (void)reloadView{
    for (UIView *subview in [self subviews]) {
        [subview removeFromSuperview];
    }
    
    //初始化周视图表头
    [self initWeekHeader];
    
    //初始化周视图表头标题
    [self initWeekTitle];
    
    [self addSubview:_weekHeaderView];
    
    //初始化周视图主体部分
    [self initWeekBody];
    
    [self addSubview:_weekScrollView];

}

- (void)loadCourses:(NSArray *)courseArray{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[CourseButton class]]) {
            [view removeFromSuperview];
        }
    }
    
    for (int i = 0; i < courseArray.count; i++) {
        CourseBean *course = courseArray[i];
        
        NSInteger rowNum = course.row - 1;
        NSInteger colNum = course.col;
        NSInteger lessonsNum = course.length;
        
        CourseButton *courseButton = [[CourseButton alloc] initWithFrame:CGRectMake((colNum)*_kWidthGrid, _kHeightGrid*rowNum+1, _kWidthGrid-2, _kHeightGrid*lessonsNum-2)];
        [courseButton setWeekCourse:course];
        int index = i%10;
        courseButton.backgroundColor = [self handleRandomColorStr:_colors[index]];
        [courseButton addTarget:self action:@selector(courseClick:) forControlEvents:UIControlEventTouchUpInside];
        [_weekScrollView addSubview:courseButton];
    }
}

- (void)initWeekHeader{
    //初始化周视图的头
    _weekHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, _headerHeight)];
    UIButton *monthButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _kWidthGrid, _headerHeight)];
    [monthButton setTitle:_horTitles[0] forState:UIControlStateNormal];
    [monthButton setTitleColor:WEEKDAY_FONT_COLOR forState:UIControlStateNormal];
    monthButton.titleLabel.font = [UIFont fontWithName:@"Microsoft YaHei" size:13.0f];
    monthButton.layer.borderColor = WEEKDAY_SELECT_COLOR.CGColor;
    monthButton.layer.borderWidth = 0.3f;
    monthButton.layer.masksToBounds = YES;
    [_weekHeaderView addSubview:monthButton];
}

- (void)initWeekTitle{
    NSArray *weekDays = @[@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
    for (int i = 0; i< 7; i++) {
        TwoTitleButton *button = [[TwoTitleButton alloc] initWithFrame:CGRectMake((i+1)*_kWidthGrid, 0, _kWidthGrid, _headerHeight)];
        NSString *title = [NSString stringWithFormat:@"周%@",weekDays[i]];
        button.tag = 9000+i;
        button.title = _horTitles[i+1];
        button.subtitle = title;
        button.textColor = WEEKDAY_FONT_COLOR;
        
        NSString *month = [NSString stringWithFormat:@"%ld月",(long)[_todayComp month]];
        NSString *day = [NSString stringWithFormat:@"%ld",(long)[_todayComp day]];
        if ([month isEqualToString:_horTitles[0]] && [day isEqualToString:_horTitles[i+1]]) {
            button.backgroundColor = WEEKDAY_SELECT_COLOR;
        }
        
        [_weekHeaderView addSubview:button];
    }
}

- (void)initWeekBody{
    _courseNum = [self.delegate rowsOfWeekScheduleView];
    
    //主体部分
    _weekScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _headerHeight, ScreenWidth, self.frame.size.height - _headerHeight)];
    _weekScrollView.bounces = NO;
    _weekScrollView.contentSize = CGSizeMake(ScreenWidth, _kHeightGrid*_courseNum);
    for (int i = 0; i<_courseNum; i++) {
        for (int j = 0; j< _courseNum; j++) {
            if (j == 0) {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(j*_kWidthGrid, i*_kHeightGrid,_kWidthGrid, _kHeightGrid)];
                label.backgroundColor = [UIColor clearColor];
                label.layer.borderColor = WEEKDAY_SELECT_COLOR.CGColor;
                label.layer.borderWidth = 0.3f;
                label.layer.masksToBounds = YES;
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor = WEEKDAY_FONT_COLOR;
                label.text =[NSString stringWithFormat:@"第%d节",i+1];
                [_weekScrollView addSubview:label];
            } else {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(j*_kWidthGrid-1, i*_kHeightGrid, _kWidthGrid, _kHeightGrid+1)];
                imageView.image = [UIImage imageNamed:@"course_excel.png"];
                [_weekScrollView addSubview:imageView];
            }
        }
    }
}

- (void)setContent:(NSString *)content forScheduleCellAtRow:(NSInteger)row andCol:(NSInteger)col{
    
}

- (void)courseClick:(UIButton *)sender{
    [self.delegate onCourseClick:((CourseButton *)sender).weekCourse];
}

//处理随机颜色字符串
- (UIColor *)handleRandomColorStr:(NSString *)randomColorStr
{
    NSArray *array = [randomColorStr componentsSeparatedByString:@","];
    if (array.count >2) {
        NSString *red = array[0];
        NSString *green = array[1];
        NSString *blue = array[2];
        return RGBColor(red.floatValue, green.floatValue, blue.floatValue, 0.8);
    }
    return [UIColor lightGrayColor];
}

@end
