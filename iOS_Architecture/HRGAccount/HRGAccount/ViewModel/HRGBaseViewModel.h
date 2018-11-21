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
//#define Host                @"http://60.174.207.15:8085/smapi"    // 公网接口地址
//#define Host                @"https://www.iomchina.com/smapi"    // 公网接口地址
//#define Host                @"http://192.168.20.13:9000"          // 内网开发地址
//#define Host                @"http://47.92.31.203:80/smapi"
#define Host                @"http://192.168.8.231:8000/smapi"

// 账户名或手机号加密码登录
#define Login_url                   Host"/login/login"
// 用户退出接口
#define Logout_url                  Host"/login/logout"

@interface HRGBaseViewModel : NSObject<HRGViewModelProtocol>

@property (nonatomic, strong) HRGBaseNetDataRequest *request;

@end
