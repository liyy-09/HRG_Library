//
//  HRGBaseViewController.h
//  SHAREMEDICINE_SHOP_iOS
//
//  Created by mac on 2018/5/10.
//  Copyright © 2018年 liyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <RTRootNavigationController/RTRootNavigationController.h>
#import "LoginInfoLocalData.h"
#import "LoginModel.h"
#import "Macro.h"

@protocol HRGViewControllerProtocol <NSObject>

@optional

- (void)bindViewModel;

@end

@interface HRGBaseViewController : UIViewController<HRGViewControllerProtocol>

@property (nonatomic, assign) BOOL isCanPushViewController;// 保证push ViewController只会被调用一次

@property (nonatomic, retain) LoginModel *loginModel;

- (void) showHub;
- (void) showHubWithLoadText:(NSString *) text;
- (void) showTextHubWithContent:(NSString *) content;
- (void) hideHub;

// 定位
- (void) startUpdatingLocationWithBlock:(void (^)(void)) locationSuccessBlock;
- (void) reStartUpdatingLocationWithBlock:(void (^)(void)) locationSuccessBlock;

/**
 操作前，先登录
 */
- (void) loginFirstWithCommend:(RACCommand *)commend;

// 统一的push处理
- (void) basePushViewController:(UIViewController *)controller;
- (void) basePushViewController:(UIViewController *)controller removeSelf:(BOOL)remove;

@end
