//
//  NetDataReturnModel.m
//  HRG_BC_TRADE_IOS
//
//  Created by mac on 2018/6/8.
//  Copyright © 2018年 liyy. All rights reserved.
//

#import "NetDataReturnModel.h"

@implementation NetDataReturnModel

- (NSString *) error {
    if (!_error) {
        return @"";
    }
    
    return _error;
}

- (id) result {
    if (!_result) {
        return @"";
    }
    
    return _result;
}

- (void) setType:(ReturnType)type {
    _type = type;
    
    if (_type == ReturnValidToken) {
        
    }
}

@end
