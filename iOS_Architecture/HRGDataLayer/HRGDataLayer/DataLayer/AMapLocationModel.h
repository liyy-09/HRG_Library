//
//  AMapLocationModel.h
//  SHAREMEDICINE_SHOP_iOS
//
//  Created by mac on 2018/5/10.
//  Copyright © 2018年 liyy. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<YYModel/YYModel.h>)
    FOUNDATION_EXPORT double YYModelVersionNumber;
    FOUNDATION_EXPORT const unsigned char YYModelVersionString[];
    #import <YYModel/NSObject+YYModel.h>
    #import <YYModel/YYClassInfo.h>
#else
    #import "NSObject+YYModel.h"
    #import "YYClassInfo.h"
#endif

@interface AMapLocationModel : NSObject<NSCoding, NSCopying>

@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *district;
@property (nonatomic, copy) NSString *formattedAddress;

@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) double latitude;

+ (instancetype) defaultValue;

- (BOOL)isExistenceValue;
- (NSString *) areaAddress;

@end
