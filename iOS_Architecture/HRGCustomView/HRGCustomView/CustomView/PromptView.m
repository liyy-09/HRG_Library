//
//  PromptView.m
//  AcrossAnHui
//
//  Created by lyy on 2018/11/19.
//  Copyright © 2018 HRG. All rights reserved.
//

#import "PromptView.h"
#import "Masonry.h"

#define HRGScreenWidth [[UIScreen mainScreen] bounds].size.width

#define HRGColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// ---------------- 设置圆角和边框 ----------------
#define HRGViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

@interface PromptView()

@property (nonatomic, retain) UIButton *imageBtn;// weizhaodao,car_mytt,load_failure
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UIButton *operationBtn;

@end

@implementation PromptView

- (instancetype) init {
    if (self = [super init]) {
        [self setItemView];
    }
    
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setItemView];
    }
    
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setItemView];
    }
    
    return self;
}

- (void) setItemView {
    self.backgroundColor = [UIColor whiteColor];
    
    if (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
    
    // 图标
    _imageBtn = [[UIButton alloc] init];
    [self addSubview:_imageBtn];
    [_imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-30);
    }];
    
    // 描述
    _label = [[UILabel alloc] init];
    _label.font = [UIFont systemFontOfSize:15];
    _label.textColor = HRGColor(108, 108, 108);
    [self addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.imageBtn.mas_bottom).offset(20);
    }];
    
    // 按钮
    _operationBtn = [[UIButton alloc] init];
    _operationBtn.backgroundColor = UIColorFromRGB(0xFF4E57);
    [_operationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _operationBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    HRGViewBorderRadius(_operationBtn, 5, 0, [UIColor clearColor]);
    [_operationBtn addTarget:self action:@selector(operation) forControlEvents:UIControlEventTouchUpInside];
    _operationBtn.hidden = YES;
    [self addSubview:_operationBtn];
    [_operationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.label.mas_bottom).offset(15);
        make.width.equalTo(@(HRGScreenWidth - 100));
        make.height.equalTo(@40);
    }];
}

#pragma mark - public method

- (void) setNilDataWithImagePath:(NSString *)path tint:(NSString *)tint btnTitle:(NSString *)title isNeedAddData:(BOOL) isAdd {
    if (isAdd) {
        [_imageBtn addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
    } else {
        // 数据为空，则不需要点击图标
        [_imageBtn removeTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (!path || [path isEqualToString:@""]) {
        path = @"icon_jzsb";
    }
    
    // 1. 在main bundle中找到特定bundle
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"HRGCustomView.bundle" ofType:nil];
    // 2. 载入bundle，即创建bundle对象
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    // 3. 从bundle中获取资源路径(注意这里的图片位于通用资源目录下的Images二级目录，相对路径要明确这种关系)
    NSString *imagePath = [bundle pathForResource:path ofType:@"png"];
    
    UIImage *image;
    if (imagePath) {
        image = [UIImage imageWithContentsOfFile:path];// 4. 通过路径创建对象
    } else {
        image = [UIImage imageNamed:@"icon_jzsb"];
    }
    
    [_imageBtn setImage:image forState:UIControlStateNormal];
    
    // 提示信息
    if (tint && ![tint isEqualToString:@""]) {
        _label.text = tint;
        [_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
        }];
    } else {
        [_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }
    
    // nil／@"" 则表示不显示按钮；否则则显示按钮
    if (title && ![title isEqualToString:@""]) {
        _operationBtn.hidden = NO;
        [_operationBtn setTitle:title forState:UIControlStateNormal];
        [_operationBtn addTarget:self action:@selector(operation) forControlEvents:UIControlEventTouchUpInside];
    } else {
        _operationBtn.hidden = YES;
        [_operationBtn removeTarget:self action:@selector(operation) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void) setNilDataWithImagePath:(NSString *) path tint:(NSString *)tint btnTitle:(NSString *)title {
    [self setNilDataWithImagePath:path tint:tint btnTitle:title isNeedAddData:NO];
}

- (void) setRequestFailureWithImagePath:(NSString *) path tint:(NSString *)tint {
    // 提示信息
    if (tint) {
        _label.text = tint;
    }
    
    if (!path || [path isEqualToString:@""]) {
        path = @"icon_jzsb";
    }
    
    // 1. 在main bundle中找到特定bundle
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"HRGCustomView.bundle" ofType:nil];
    // 2. 载入bundle，即创建bundle对象
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    // 3. 从bundle中获取资源路径(注意这里的图片位于通用资源目录下的Images二级目录，相对路径要明确这种关系)
    NSString *imagePath = [bundle pathForResource:path ofType:@"png"];
    
    UIImage *image;
    if (imagePath) {
        image = [UIImage imageWithContentsOfFile:path];// 4. 通过路径创建对象
    } else {
        image = [UIImage imageNamed:@"icon_jzsb"];
    }
    
    [_imageBtn setImage:image forState:UIControlStateNormal];
    
    // 网络出错，需要点击图标刷新
    [_imageBtn addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
}

- (void) setRequestFailureImageView {
    [self setRequestFailureWithImagePath:@"shoppingcar_n" tint:@"网络开小差, 请点击重试"];
}

- (NSString *) getLabelName {
    return self.label.text;
}

#pragma mark - click listener

- (void) refresh {
    if (self.promptRefreshListener) {
        self.promptRefreshListener();
    }
}

- (void) operation {
    if (self.promptOperationListener) {
        self.promptOperationListener();
    }
}

@end
