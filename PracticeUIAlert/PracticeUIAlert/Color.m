//
//  Color.m
//  PracticeUIAlert
//
//  Created by 정하민 on 12/04/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

#import "Color.h"

@implementation UIColor (Utility)

+ (UIColor *)getBCColor
{
    return RGB(232, 61, 68);
}

+ (UIColor *)getWRColor
{
    return RGB(0, 104, 172);
}

+ (UIColor *)getKBColor
{
    return RGB(250, 190, 0);
}

+ (UIColor *)getKAColor
{
    return RGB(250, 190, 0);
}

+ (UIColor *)getEtcColor
{
    return RGB(72, 77, 91);
}

+ (UIColor *)getDisableBackgroundColor
{
    return RGB(250, 250, 250);
}

+ (UIColor *)getDisableGrayColor
{
    return RGB(224, 224, 224);
}

+ (UIColor *)getEnableTextColor
{
    return RGB(32, 32, 32);
}

+ (UIColor *)getDisableTabTextColor
{   // Tab, Guide Text
    return RGB(144, 144, 144);
}

+ (UIColor *)getDisableTextColor
{   // 통신사 Text
    return RGB(204, 204, 204);
}

+ (UIColor *)getDeleteBackgroundColor
{
    return RGB(175, 171, 171);
}

+ (UIColor *)getPopUpBackgroundColor
{
    return RGB(176, 176, 176);
}

@end

