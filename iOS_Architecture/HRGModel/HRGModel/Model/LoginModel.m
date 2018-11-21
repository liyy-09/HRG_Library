//
//  LoginModel.m
//  SHAREMEDICINE_SHOP_iOS
//
//  Created by lyy on 2018/11/19.
//  Copyright © 2018 HRG. All rights reserved.
//

#import "LoginModel.h"

@implementation UserModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{ @"userID" : @"id" };
}

+ (instancetype) convertFromDict:(NSDictionary *)dict {
    UserModel *model = [UserModel modelWithDictionary:dict];
    return model;
}

- (NSString *)memberDesc {
    NSMutableString *res = [[NSMutableString alloc] init];
    if (_memeberCode && ![_memeberCode isEqualToString:@""]) {
        [res appendString:[NSString stringWithFormat:@"会员等级:%@  ", _memeberCode]];
    }
    
    if (_memberPoint && ![_memberPoint isEqualToString:@""]) {
        [res appendString:[NSString stringWithFormat:@"会员积分:%@", _memberPoint]];
    }
    
    return [NSString stringWithFormat:@"%@", res];
}

@end

@implementation LoginModel

+ (instancetype) convertFromDict:(NSDictionary *)dict {
    LoginModel *model = [LoginModel modelWithDictionary:dict];
    
    return model;
}

@end
