//
//  ImageTool.h
//  AcrossAnHui
//
//  Created by lyy on 2018/11/19.
//  Copyright © 2018 HRG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageTool : NSObject

/**
 图片压缩

 @param image image
 @return data
 */
+ (NSData *) compressImage:(UIImage *)image;

@end
