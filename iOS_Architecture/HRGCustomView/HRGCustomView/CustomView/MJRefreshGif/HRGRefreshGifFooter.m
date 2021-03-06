//
//  HRGRefreshGifFooter.m
//  SHAREMEDICINE_SHOP_iOS
//
//  Created by lyy on 2018/11/19.
//  Copyright © 2018 HRG. All rights reserved.
//

#import "HRGRefreshGifFooter.h"

@interface HRGRefreshGifFooter()

@property (nonatomic,strong)UILabel *statusLabel;
@property (nonatomic,strong)UIImageView *refreshView;

@end

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation HRGRefreshGifFooter

// 初始化
- (void)prepare {
    [super prepare];
    
    self.mj_h = 82;
    
    //根据拖拽的情况自动切换透明度
    self.automaticallyChangeAlpha = YES;
    
    self.stateLabel.hidden = YES;
    
    self.statusLabel = [[UILabel alloc]init];
    self.statusLabel.textColor = UIColorFromRGB(0x8A8A8A);
    self.statusLabel.font = [UIFont systemFontOfSize:12];
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.statusLabel];
    
    // 1. 在main bundle中找到特定bundle
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"HRGCustomView.bundle" ofType:nil];
    // 2. 载入bundle，即创建bundle对象
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    
    NSMutableArray *imagearray = [[NSMutableArray alloc] init];
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
            [imagearray addObject:image];
        }
    }
    
    NSString *path = [bundle pathForResource:@"Sprites_0" ofType:@"png"];
    
    self.refreshView = [[UIImageView alloc] init];
    self.refreshView.contentMode = UIViewContentModeCenter;
    self.refreshView.image = [UIImage imageWithContentsOfFile:path];
    self.refreshView.animationImages = imagearray;
    self.refreshView.animationDuration = 1;
    self.refreshView.animationRepeatCount = MAXFLOAT;
    
    [self addSubview:self.refreshView];
}

#pragma mark 在这里设置子控件的位置和尺寸

// 摆放子控件
- (void)placeSubviews {
    [super placeSubviews];
    self.refreshView.frame = CGRectMake((self.bounds.size.width - 15) / 2, 10, 15, 40);
    self.statusLabel.frame = CGRectMake(0, 60, self.bounds.size.width, 12);
}

#pragma mark 监听scrollView的contentOffset改变

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
}

#pragma mark 监听scrollView的contentSize改变

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
    [super scrollViewContentSizeDidChange:change];
}

#pragma mark 监听scrollView的拖拽状态改变

- (void)scrollViewPanStateDidChange:(NSDictionary *)change {
    [super scrollViewPanStateDidChange:change];
}

#pragma mark 监听控件的刷新状态

- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            [self.refreshView stopAnimating];
            self.statusLabel.text = @"上拉加载";
            break;
        case MJRefreshStatePulling:
            self.statusLabel.text = @"释放立即加载";
            break;
        case MJRefreshStateRefreshing:
            [self.refreshView startAnimating];
            self.statusLabel.text = @"正在加载...";
            break;
        default:
            break;
    }
}

@end
