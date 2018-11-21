//
//  AMapLocationModel.m
//  SHAREMEDICINE_SHOP_iOS
//
//  Created by mac on 2018/5/10.
//  Copyright © 2018年 liyy. All rights reserved.
//

#import "AMapLocationModel.h"

#define defaultCity @"合肥市"
#define defaultProvice @"安徽省"
#define defaultLatitude 31.84087375
#define defaultLongitude 117.19698649

@implementation AMapLocationModel

+ (instancetype) defaultValue {
    AMapLocationModel *model = [[AMapLocationModel alloc] init];
    
    model.province = defaultProvice;
    model.city = defaultCity;
    
    model.latitude = defaultLatitude;
    model.longitude = defaultLongitude;
    
    return model;
}

- (BOOL) isExistenceValue {
    if (!self.province) {
        return NO;
    }
    
    if (!self.city) {
        return NO;
    }
    
    if (!self.district) {
        return NO;
    }
    
    if (!self.formattedAddress) {
        return NO;
    }
    
    if (!self.longitude) {
        return NO;
    }
    
    if (!self.latitude) {
        return NO;
    }
    
    return YES;
}

- (NSString *) areaAddress {
    NSString *result = _formattedAddress;
    
    if (_province) {
        result = [result stringByReplacingOccurrencesOfString:_province withString:@""];
    }
    
//    if (_city) {
//        result = [result stringByReplacingOccurrencesOfString:_city withString:@""];
//    }
    
    return result;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    return [self modelInitWithCoder:aDecoder];
}

- (id)copyWithZone:(NSZone *)zone {
    return [self modelCopy];
}

- (NSUInteger)hash {
    return [self modelHash];
}

- (BOOL)isEqual:(id)object {
    return [self modelIsEqual:object];
}

- (NSString *)description {
    return [self modelDescription];
}

@end
