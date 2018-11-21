//
//  HomeLocalData.h
//  SHAREMEDICINE_SHOP_iOS
//
//  Created by mac on 2018/5/10.
//  Copyright © 2018年 liyy. All rights reserved.
//

#import "HRGBaseLocalData.h"
#import "AMapLocationModel.h"
#import <YYKit/YYKit.h>

@interface MapLocLocalData : HRGBaseLocalData

@property (nonatomic, retain) YYCache *yyCache;

+ (instancetype) sharedInstance;

- (void) saveAMapLocationModel:(AMapLocationModel *)model;
- (AMapLocationModel *) aMapLocationModel;

@end
