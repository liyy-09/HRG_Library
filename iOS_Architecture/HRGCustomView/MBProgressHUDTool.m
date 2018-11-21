//
//  MBProgressHUDTool.m
//  AcrossAnHui
//
//  Created by liyy on 2017/6/27.
//  Copyright © 2017年 安徽畅通行. All rights reserved.
//

#import "MBProgressHUDTool.h"
#import "AppDelegate.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MBProgressHUDTool()

@property (nonatomic, retain) MBProgressHUD *hub;
@property (nonatomic, retain) MBProgressHUD *textHub;

@end

@implementation MBProgressHUDTool

#pragma mark - 显示加载动画

- (void) showHubWithLoadText:(NSString *)text superView:(UIView *)view {
    if (self.hub) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self addContent:text];
        });
    } else {
        self.hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
        
        [self addContent:text];
    }
}

- (void) addContent:(NSString *)text {
    UIImageView *imageView = [[UIImageView alloc]init];
    
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 52; i++) {
        NSString *name = [NSString stringWithFormat:@"Sprites_%d", i];
        [imageArray addObject:[UIImage imageNamed:name]];
    }
    
    imageView.animationImages = imageArray;
    imageView.animationRepeatCount = MAXFLOAT;
    imageView.animationDuration = 2;
    [imageView startAnimating];
    
    self.hub.mode = MBProgressHUDModeCustomView;
    self.hub.customView = imageView;
    self.hub.label.text = text;
    self.hub.label.font = [UIFont systemFontOfSize:14.0f];
    self.hub.removeFromSuperViewOnHide = YES;// 隐藏时候从父控件中移除
    self.hub.square = NO;
    self.hub.bezelView.backgroundColor = UIColorFromRGB(0x6c6c6c);
}

- (void) hideHub {
    self.hub.removeFromSuperViewOnHide = YES;
    [self.hub hideAnimated:YES];
    self.hub = nil;
}

#pragma mark - 显示提示信息

- (void) showTextHubWithContent:(NSString *) content {
    [self showTextHubWithContent:content superView:[AppDelegate sharedDelegate].window];
}

- (void) showTextHubWithContent:(NSString *) content superView:(UIView *)view {
    if (!content || [content isEqualToString:@""]) {
        return;
    }
    
    self.textHub = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    self.textHub.bezelView.backgroundColor = [UIColor blackColor];
    
    // Set the text mode to show only text.
    self.textHub.mode = MBProgressHUDModeText;
    self.textHub.detailsLabel.text = NSLocalizedString(content, @"HUD message title");
    self.textHub.detailsLabel.font = [UIFont systemFontOfSize:15.0];
    self.textHub.detailsLabel.textColor = [UIColor whiteColor];
    // Move to bottm center.
    self.textHub.offset = CGPointMake(0.f, MBProgressMaxOffset);
    
    [self.textHub hideAnimated:YES afterDelay:0.8f];
}

@end
