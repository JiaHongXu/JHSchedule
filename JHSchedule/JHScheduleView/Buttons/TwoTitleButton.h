//
//  TwoTitleButton.h
//  Course
//
//  Created by MacOS on 14-12-16.
//  Copyright (c) 2014年 Joker. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGBColor(r,g,b,a) ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a])
#define WEEKDAY_BGCOLOR  ([UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5])
#define WEEKDAY_SELECT_COLOR ([UIColor colorWithRed:32/255.0 green:81/255.0 blue:148/255.0 alpha:0.23])
#define WEEKDAY_FONT_COLOR ([UIColor colorWithRed:32/255.0 green:81/255.0 blue:148/255.0 alpha:1])

@interface TwoTitleButton : UIButton
{
    UILabel *_rectTitleLabel;
    UILabel *_subTitileLabel;
}

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subtitle;

@property (nonatomic,retain) UIColor *textColor;

@end
