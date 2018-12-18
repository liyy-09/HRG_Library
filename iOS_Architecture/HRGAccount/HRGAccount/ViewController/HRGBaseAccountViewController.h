//
//  HRGBaseViewController.h
//  SHAREMEDICINE_SHOP_iOS
//
//  Created by lyy on 2018/11/19.
//  Copyright © 2018 HRG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <RTRootNavigationController/RTRootNavigationController.h>
#import "LoginInfoLocalData.h"
#import "LoginModel.h"

// ---------------- 屏幕宽高 ----------------
#define HRGScreenWidth [[UIScreen mainScreen] bounds].size.width
#define HRGScreenHeight [[UIScreen mainScreen] bounds].size.height

//是否iPhoneX YES:iPhoneX屏幕 NO:传统屏幕
#define kIs_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define HRGBarHeight (kIs_iPhoneX ? 44 : 20)
#define HRGNavHeight 44
#define HRGTabBarHeight (kIs_iPhoneX ? (49 + 34) : 49)

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBA(rgbValue,trans) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:trans]

#define HRGThemeColor 0x1AAAF7

// ---------------- 设置圆角和边框 ----------------
#define HRGViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

@protocol HRGAccountVCProtocol <NSObject>

@optional

- (void)bindViewModel;

@end

@interface HRGBaseAccountViewController : UIViewController<HRGAccountVCProtocol>

@property (nonatomic, assign) BOOL isCanPushViewController;// 保证push ViewController只会被调用一次

@property (nonatomic, retain) LoginModel *loginModel;

- (void) showHub;
- (void) showHubWithLoadText:(NSString *) text;
- (void) showTextHubWithContent:(NSString *) content;
- (void) hideHub;

/**
 操作前，先登录
 */
- (void) loginFirstWithCommend:(RACCommand *)commend;

// 统一的push处理
- (void) basePushViewController:(UIViewController *)controller;
- (void) basePushViewController:(UIViewController *)controller removeSelf:(BOOL)remove;

@end
