//
//  HRGViewModelProtocol.h
//  HRG_BC_TRADE_IOS
//
//  Created by lyy on 2018/11/19.
//  Copyright © 2018 HRG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRGBaseNetDataRequest.h"

@protocol HRGViewModelProtocol <NSObject>

@optional

- (instancetype)initWithModel:(id)model;

/**
 *  初始化
 */
- (void)hrg_initialize;

@end
