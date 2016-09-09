//
//  CourseBean.m
//  JHSchedule
//
//  Created by 307A on 16/9/9.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "CourseBean.h"

@implementation CourseBean

- (instancetype)initWithCol:(NSInteger)col andRow:(NSInteger)row andContent:(NSString *)content andLength:(NSInteger)length{
    if (self = [super init]) {
        _col = col;
        _row = row;
        _content = content;
        _length = length;
    }
    
    return self;
}

@end
