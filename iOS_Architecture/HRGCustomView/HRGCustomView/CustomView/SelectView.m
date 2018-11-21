//
//  SelectView.m
//  liyy
//
//  Created by lyy on 2018/11/19.
//  Copyright © 2018 HRG. All rights reserved.
//

#import "SelectView.h"

#define UIColorFromRGBA(rgbValue,trans) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:trans]

@implementation SelectView

@synthesize defaultColor = _defaultColor;
@synthesize selectColor = _selectColor;

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initView];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void) initView {
    self.userInteractionEnabled = YES;
    
    self.defaultColor = 0xffffff;
    self.selectColor = 0xf5f5f5;
    self.alphaCount = 1;
    
    [self setBackgroundColor:UIColorFromRGBA(self.defaultColor, self.alphaCount)];
}

- (void) setDefaultColor:(int)defaultColor {
    _defaultColor = defaultColor;
    [self setBackgroundColor:UIColorFromRGBA(self.defaultColor, self.alphaCount)];
}

#pragma 手势操作的方法
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self setBackgroundColor:UIColorFromRGBA(self.selectColor, self.alphaCount)];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self setBackgroundColor:UIColorFromRGBA(self.selectColor, self.alphaCount)];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self setBackgroundColor:UIColorFromRGBA(self.defaultColor, self.alphaCount)];
    
    if (self.clickListener) {
        self.clickListener(self);
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self setBackgroundColor:UIColorFromRGBA(self.defaultColor, self.alphaCount)];
}

@end
