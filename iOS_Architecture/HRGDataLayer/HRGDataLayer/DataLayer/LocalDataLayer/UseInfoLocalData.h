//
//  UseInfoLocalData.h
//  SHAREMEDICINE_SHOP_iOS
//
//  Created by mac on 2018/5/10.
//  Copyright © 2018年 liyy. All rights reserved.
//

#import "HRGBaseLocalData.h"

@interface UseInfoLocalData : HRGBaseLocalData

+ (instancetype) sharedInstance;

- (BOOL) isFirstUseOrUpdata;

// 极光的registrationID
- (void) saveRegistrationID:(NSString *)registrationID;
- (NSString *)getRegistrationID;

// 标志绑定成功
- (void) setJPushBindSuccess;

// 更新应用后，重置
- (void) updateJPushBindSuccess;

// 获取绑定释放成功
- (BOOL) isJPushBindSuccess;

@end
