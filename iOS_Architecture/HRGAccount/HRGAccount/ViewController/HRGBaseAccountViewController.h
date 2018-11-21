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
