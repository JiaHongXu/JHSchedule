//
//  ViewController.m
//  JHSchedule
//
//  Created by 307A on 16/9/8.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "ViewController.h"
#import "JHScheduleView.h"

@interface ViewController ()<JHScheduleViewDelegate>
@property (nonatomic) NSMutableArray *courseArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initData];
    [self initUI];
}

- (void)initUI{
    JHScheduleView *scheduleView = [[JHScheduleView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    scheduleView.delegate = self;
    [self.view addSubview:scheduleView];
    [scheduleView reloadView];
    
    
    [scheduleView loadCourses:_courseArray];
}

- (void)initData{
    _courseArray = [[NSMutableArray alloc] initWithCapacity:0];
    [_courseArray addObject:[[CourseBean alloc] initWithCol:5 andRow:3 andContent:@"Java程序实践 @信息114" andLength:1]];
    [_courseArray addObject:[[CourseBean alloc] initWithCol:1 andRow:2 andContent:@"高等数学 @文管B129" andLength:2]];
    [_courseArray addObject:[[CourseBean alloc] initWithCol:4 andRow:5 andContent:@"大学英语九 @食堂" andLength:1]];
}

- (NSInteger)rowsOfWeekScheduleView{
    return 8;
}

- (void)onCourseClick:(CourseBean *)course{
    NSLog(@"click on %@", course.content);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
