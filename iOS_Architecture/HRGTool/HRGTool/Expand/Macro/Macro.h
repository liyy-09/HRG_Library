//
//  Macro.h
//  HRGTool
//
//  Created by lyy on 2018/11/20.
//  Copyright © 2018 HRG. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

//是否iPhoneX YES:iPhoneX屏幕 NO:传统屏幕
#define kIs_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

// ---------------- Self ----------------
#define WeakSelf __weak typeof(self) weakSelf = self;
#define HRGWeakSelf(type)  __weak typeof(type) weak##type = type;
#define HRGStrongSelf(type)  __strong typeof(type) type = weak##type;

// ---------------- 屏幕宽高 ----------------
#define HRGScreenWidth [[UIScreen mainScreen] bounds].size.width
#define HRGScreenHeight [[UIScreen mainScreen] bounds].size.height

#define HRGBarHeight (kIs_iPhoneX ? 44 : 20)
#define HRGNavHeight 44
#define HRGTabBarHeight (kIs_iPhoneX ? (49 + 34) : 49)

// ---------------- 设置圆角和边框 ----------------
#define HRGViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// ---------------- 沙盒目录文件 ----------------
//获取temp
#define HRGPathTemp NSTemporaryDirectory()
//获取沙盒 Document
#define HRGPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define HRGPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

// ---------------- Masonry ----------------
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

// ----------------  设置颜色 ----------------
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBA(rgbValue,trans) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:trans]

#define HRGColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// ----------------  颜色代码 ----------------
#define HRGThemeColor 0x09336D
// 背景颜色
#define HRGBackGroundColor 0xeeeeee
// 字体颜色
#define HRGBaseFontColor 0x8A8A8A
#define HRGTextBlackColor 0x333333
#define HRGTextGrayColor 0x9FA1A1
// 背景颜色
#define HRGBaseViewColor 0xf5f5f5
// 线条色
#define HRGBLineViewColor 0xCCCCCC

#define HRGTextFont 15.0

// ----------------  NSLog ----------------
#ifdef DEBUG
// 分别是方法地址，文件名，在文件的第几行，自定义输出内容
#define HRGLog( s, ... ) NSLog( @"<%p %@><%@:(%d)>： %@", self, NSStringFromClass([self class]), [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define HRGLog( s, ... )
#endif

// ---------------- YZPullDownMenu ----------------
#define YZPullDownMenuHeight 50

#endif /* Macro_h */
