//
//  SelectView.h
//  liyy
//
//  Created by lyy on 2018/11/19.
//  Copyright © 2018 HRG. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectViewListener)(id result);

@interface SelectView : UIView<UIGestureRecognizerDelegate> {
    int _defaultColor;
    int _selectColor;
}

@property (nonatomic, assign) int defaultColor;
@property (nonatomic, assign) int selectColor;
@property (nonatomic, assign) float alphaCount;

@property (nonatomic, strong) SelectViewListener clickListener;

@end
