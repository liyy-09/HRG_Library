//
//  HRGBaseViewModel.m
//  HRG_BC_TRADE_IOS
//
//  Created by lyy on 2018/11/19.
//  Copyright © 2018 HRG. All rights reserved.
//

#import "HRGBaseViewModel.h"

@implementation HRGBaseViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    HRGBaseViewModel *viewModel = [super allocWithZone:zone];
    
    if (viewModel) {
        [viewModel hrg_initialize];
    }
    
    return viewModel;
}

- (instancetype)initWithModel:(id)model {
    if (self = [super init]) {
        
    }
    
    return self;
}

- (HRGBaseNetDataRequest *)request {
    if (!_request) {
        _request = [[HRGBaseNetDataRequest alloc] init];
    }
    
    return _request;
}

- (void)hrg_initialize {
    
}

- (RACSubject *) tokenSubject {
    if (!_tokenSubject) {
        _tokenSubject = [RACSubject subject];
    }
    
    return _tokenSubject;
}

- (BOOL) isReturnValidToken:(NetDataReturnModel *)model command:(RACCommand *)command {
    if (model.type == ReturnValidToken) {
        [self.tokenSubject sendNext:command];
        return NO;
    }
    
    return YES;
}

@end
