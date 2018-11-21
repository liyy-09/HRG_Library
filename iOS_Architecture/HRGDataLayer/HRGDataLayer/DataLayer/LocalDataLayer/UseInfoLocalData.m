//
//  UseInfoLocalData.m
//  SHAREMEDICINE_SHOP_iOS
//
//  Created by mac on 2018/5/10.
//  Copyright © 2018年 liyy. All rights reserved.
//

#import "UseInfoLocalData.h"
#import "VersionTool.h"

@implementation UseInfoLocalData

#pragma mark - 单例模式

static UseInfoLocalData *instance;

+ (id) allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

+ (instancetype) sharedInstance {
    static dispatch_once_t oncetToken;
    dispatch_once(&oncetToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (id) copyWithZone:(NSZone *)zone {
    return instance;
}

#pragma mark - public method

#pragma mark - 第一次登录

- (BOOL) isFirstUseOrUpdata {
    static NSString *isFirstInstallKey = @"isFirstInstallKey";
    static NSString *versonKey = @"versonKey";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *isFirstInstall = [userDefault objectForKey:isFirstInstallKey];// 是否第一次安装
    
    if (!isFirstInstall || [isFirstInstall isEqualToString:@""]) {// 是第一次安装
        // 标记已安装
        [userDefault setObject:@"NO" forKey:isFirstInstallKey];
        // 记录版本号
        [userDefault setObject:[[VersionTool sharedInstance] getVersion] forKey:versonKey];
        
        return YES;
    } else {
        // 不是第一次安装，需要根据版本号来判断是否更新了
        NSString *localVerson = [userDefault objectForKey:versonKey];
        if ([[VersionTool sharedInstance] isLargeVersionWithLocalVersion:localVerson]) {// 更新了版本
            // 更新新版本号
            [userDefault setObject:[[VersionTool sharedInstance] getVersion] forKey:versonKey];
            
//            // 重置极光绑定
//            [self updateJPushBindSuccess];
            
            // 最新版，返回YES
            return YES;
        } else {
            return NO;
        }
    }
}

#pragma mark - 极光的registrationID

- (void) saveRegistrationID:(NSString *)registrationID {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:registrationID forKey:@"registrationID"];
    
    [defaults synchronize];
}

- (NSString *)getRegistrationID {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *registrationID = [defaults objectForKey:@"registrationID"];
    
    return registrationID;
}

// 标志绑定成功
- (void) setJPushBindSuccess {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:@"YES" forKey:@"JPushBindKey"];
    
    [defaults synchronize];
}

// 更新应用后，重置
- (void) updateJPushBindSuccess {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:@"NO" forKey:@"JPushBindKey"];
    
    [defaults synchronize];
}

// 获取绑定释放成功
- (BOOL) isJPushBindSuccess {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *account = [defaults objectForKey:@"JPushBindKey"];
    
    if (account && [account isEqualToString:@"YES"]) {
        return YES;
    } else {
        return NO;
    }
}

@end
