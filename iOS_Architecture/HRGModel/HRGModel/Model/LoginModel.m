//
//  LoginModel.m
//  SHAREMEDICINE_SHOP_iOS
//
//  Created by lyy on 2018/11/19.
//  Copyright © 2018 HRG. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{ @"userID" : @"id" };
}

+ (instancetype) convertFromDict:(NSDictionary *)dict {
    LoginModel *model = [LoginModel modelWithDictionary:dict];
    
    return model;
}

// 0保密 1男 2女
- (NSString *)sexDesc {
    if ([self.sex isEqualToString:@"1"]) {
        return @"男";
    } else if ([self.sex isEqualToString:@"2"]) {
        return @"女";
    } else {
        return @"保密";
    }
}

- (NSString *) idcardDesc {
    if (_idcard && ![_idcard isEqualToString:@""]) {
        return _idcard;
    }
    
    return @"保密";
}

@end
