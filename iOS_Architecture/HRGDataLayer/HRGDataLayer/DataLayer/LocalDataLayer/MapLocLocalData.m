//
//  HomeLocalData.m
//  SHAREMEDICINE_SHOP_iOS
//
//  Created by mac on 2018/5/10.
//  Copyright © 2018年 liyy. All rights reserved.
//

#import "MapLocLocalData.h"

static NSString *aMapLocationModelKey = @"aMapLocationModelKey";

@implementation MapLocLocalData

#pragma mark - 单例模式

static MapLocLocalData *instance;

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

- (instancetype) init {
    if (self = [super init]) {
        _yyCache = [YYCache cacheWithName:LocationDataCache];
    }
    return self;
}

#pragma mark - public method

- (void) saveAMapLocationModel:(AMapLocationModel *)model {
    [_yyCache setObject:model forKey:aMapLocationModelKey withBlock:^{
        NSLog(@"set AMapLocationModel sucess");
    }];
}

- (AMapLocationModel *) aMapLocationModel {
    // 根据key读取数据
    AMapLocationModel * model =(AMapLocationModel *) [_yyCache objectForKey:aMapLocationModelKey];
    return model;
}

@end
