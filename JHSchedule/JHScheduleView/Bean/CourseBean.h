//
//  CourseBean.h
//  JHSchedule
//
//  Created by 307A on 16/9/9.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseBean : NSObject
@property (nonatomic) NSInteger col;
@property (nonatomic) NSInteger row;
@property (nonatomic) NSInteger length;
@property (nonatomic) NSString *content;

- (instancetype)initWithCol:(NSInteger)col andRow:(NSInteger)row andContent:(NSString *)content andLength:(NSInteger)length;
@end
