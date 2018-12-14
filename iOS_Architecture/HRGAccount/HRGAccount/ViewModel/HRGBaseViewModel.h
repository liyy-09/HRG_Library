//
//  HRGBaseViewModel.h
//  HRG_BC_TRADE_IOS
//
//  Created by lyy on 2018/11/19.
//  Copyright © 2018 HRG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRGViewModelProtocol.h"

@interface HRGBaseViewModel : NSObject<HRGViewModelProtocol>

@property (nonatomic, strong) HRGBaseNetDataRequest *request;

@property (nonatomic, strong) RACSubject *tokenSubject;

@end
