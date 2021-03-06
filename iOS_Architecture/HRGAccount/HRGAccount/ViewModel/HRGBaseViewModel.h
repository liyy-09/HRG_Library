//
//  HRGBaseViewModel.h
//  HRG_BC_TRADE_IOS
//
//  Created by lyy on 2018/11/19.
//  Copyright © 2018 HRG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRGViewModelProtocol.h"

// ---------------------- 域名 ----------------------
#define AccountHost             @"http://60.174.207.15:8085/ztlapi"
//#define AccountHost             @"http://wisangel.com/ztlapi"

@interface HRGBaseViewModel : NSObject<HRGViewModelProtocol>

@property (nonatomic, strong) HRGBaseNetDataRequest *request;

@property (nonatomic, strong) RACSubject *tokenSubject;

/**
 统一处理token失效

 @param model 请求的结果
 @return token是否失效
 */
- (BOOL) isReturnValidToken:(NetDataReturnModel *)model command:(RACCommand *)command;

@end
