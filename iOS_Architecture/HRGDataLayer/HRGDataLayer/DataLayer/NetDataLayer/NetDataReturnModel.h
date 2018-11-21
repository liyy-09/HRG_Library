//
//  NetDataReturnModel.h
//  HRG_BC_TRADE_IOS
//
//  Created by mac on 2018/6/8.
//  Copyright © 2018年 liyy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ReturnType) {
    ReturnSuccess,
    ReturnFailure,
    ReturnProcess,
    ReturnValidToken
};

@interface NetDataReturnModel : NSObject

@property (nonatomic, assign) ReturnType type;

@property (nonatomic, strong) id result;
@property (nonatomic, copy) NSString *error;
@property (nonatomic, assign) float process;

@end
