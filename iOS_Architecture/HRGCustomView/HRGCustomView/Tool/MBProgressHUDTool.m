//
//  MBProgressHUDTool.m
//  AcrossAnHui
//
//  Created by lyy on 2018/11/19.
//  Copyright © 2018 HRG. All rights reserved.
//

#import "MBProgressHUDTool.h"

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
    
    // 1. 在main bundle中找到特定bundle
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"HRGCustomView.bundle" ofType:nil];
    // 2. 载入bundle，即创建bundle对象
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 52; i++) {
        NSString *name = [NSString stringWithFormat:@"Sprites_%d", i];
        
        // 3. 从bundle中获取资源路径(注意这里的图片位于通用资源目录下的Images二级目录，相对路径要明确这种关系)
        NSString *path = [bundle pathForResource:name ofType:@"png"];
        
        UIImage *image;
        if (path) {
            image = [UIImage imageWithContentsOfFile:path];// 4. 通过路径创建对象
        } else {
            image = [UIImage imageNamed:name];
        }
        
        if (image) {
            [imageArray addObject:image];
        }
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
