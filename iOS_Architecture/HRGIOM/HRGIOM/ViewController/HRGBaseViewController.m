//
//  HRGBaseViewController.m
//  SHAREMEDICINE_SHOP_iOS
//
//  Created by mac on 2018/5/10.
//  Copyright © 2018年 liyy. All rights reserved.
//

#import "HRGBaseViewController.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import "MBProgressHUDTool.h"
#import "UseInfoLocalData.h"
#import "MapLocLocalData.h"
#import "LoginViewModel.h"
#import "LoginViewController.h"

@interface HRGBaseViewController ()

@property (nonatomic, retain) AMapLocationManager *locationManager;
@property (nonatomic, retain) MBProgressHUDTool *progressHUD;

@end

@implementation HRGBaseViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    HRGBaseViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController)
    
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        @strongify(viewController)
        
        [viewController bindViewModel];
    }];
    
    return viewController;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0xf5f5f5);
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(HRGThemeColor);// 导航栏背景颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];// item字体颜色
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    // 默认使用的是RTRoot框架内部的导航效果和返回按钮，如果要自定义，必须将此属性设置为NO，然后实现下方方法；
    self.rt_navigationController.useSystemBackBarButtonItem = NO;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.isCanPushViewController = YES;// 每次进入，重新置为YES,表示可以push ViewController
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    HRGLog(@"%@ dealloc", NSStringFromClass([self class]));
}

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

#pragma mark - MBProgressHUD

- (void) showHubWithLoadText:(NSString *) text {
    [self.progressHUD showHubWithLoadText:text superView:self.view];
}

- (void) showHub {
    [self.progressHUD showHubWithLoadText:@"查询中..." superView:self.view];
}

- (void) hideHub {
    [self.progressHUD hideHub];
}

- (void) showTextHubWithContent:(NSString *) content {
    [self.progressHUD showTextHubWithContent:content superView:self.view];
}

- (MBProgressHUDTool *)progressHUD {
    if (!_progressHUD) {
        _progressHUD = [[MBProgressHUDTool alloc] init];
    }
    
    return _progressHUD;
}

#pragma mark - 操作前 需要登录/Token有效

- (void) loginFirstWithCommend:(RACCommand *)commend {
    // 获取帐号信息
    NSString *account = [[LoginInfoLocalData sharedInstance] getAccount];
    NSString *psw = [[LoginInfoLocalData sharedInstance] getPassword];
    
    if (account && psw && ![account isEqualToString:@""] && ![psw isEqualToString:@""]) {
        // 有帐号密码，则需要更新Token
        LoginViewModel *loginViewModel = [[LoginViewModel alloc] init];
        [loginViewModel.loginCommand execute:nil];
        
        [loginViewModel.loginResultSubject subscribeNext:^(id x) {
            if ([x isKindOfClass:[NSString class]]) { // 登录失败
                [self toLoginViewWithCommend:commend];
            } else {// 登录成功
                if (commend) {
                    [commend execute:nil];
                }
            }
        }];
    } else {
        [self toLoginViewWithCommend:commend];// 没有帐号密码，则需要登录
    }
}

- (void) toLoginViewWithCommend:(RACCommand *)commend {
    LoginViewController *controller = [[LoginViewController alloc] initWithStoryborad];
    [controller.loginSuccessSubject subscribeNext:^(id x) {
        if (commend) {
            [commend execute:nil];// 登录成功之后的操作
        }
    }];
    
    RTRootNavigationController *naviController = [[RTRootNavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:naviController animated:YES completion:nil];
}

#pragma mark - private method

- (LoginModel *) loginModel {
    _loginModel = [[LoginInfoLocalData sharedInstance] getLoginModel];// 获取登录的用户信息
    
    return _loginModel;
}

#pragma mark - public method

- (void) basePushViewController:(UIViewController *)controller {
    [self basePushViewController:controller removeSelf:NO];
}

- (void) basePushViewController:(UIViewController *)controller removeSelf:(BOOL)remove {
    if (self.isCanPushViewController) {
        self.isCanPushViewController = NO;
        
        // 注意这里push的时候需要使用rt_navigation push出去
//        [self.navigationController pushViewController:controller animated:YES];
        [self.rt_navigationController pushViewController:controller animated:YES complete:^(BOOL finished) {
            if (remove) {
                [self.rt_navigationController removeViewController:self];
            }
        }];
    }
}

#pragma mark - 定位 Action Handle

- (void)startUpdatingLocationWithBlock:(void (^)(void)) locationSuccessBlock {
    AMapLocationModel *model = [[MapLocLocalData sharedInstance] aMapLocationModel];
    
    if ([model isExistenceValue]) {
        // 定位完成后的操作
        if (locationSuccessBlock) {
            locationSuccessBlock();
        }
        
        return;
    }
    
    [self reStartUpdatingLocationWithBlock:locationSuccessBlock];
}

- (void) reStartUpdatingLocationWithBlock:(void (^)(void)) locationSuccessBlock {
    self.locationManager = [[AMapLocationManager alloc] init];
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    // 定位超时时间，最低2s
    [self.locationManager setLocationTimeout:6];
    // 逆地理请求超时时间，最低2s
    [self.locationManager setReGeocodeTimeout:6];
    
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error) {
            HRGLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            // 定位失败,如果没有缓存，则保存默认值
            if (![[MapLocLocalData sharedInstance] aMapLocationModel]) {
                // 默认值
                AMapLocationModel *model = [AMapLocationModel defaultValue];
                [[MapLocLocalData sharedInstance] saveAMapLocationModel:model];
            }
        } else {
            //逆地理信息
            AMapLocationModel *model = [[AMapLocationModel alloc] init];
            model.province = regeocode.province;
            model.city = regeocode.city;
            model.district = regeocode.district;
            model.formattedAddress = regeocode.formattedAddress;
            model.latitude = location.coordinate.latitude;
            model.longitude = location.coordinate.longitude;
            
            [[MapLocLocalData sharedInstance] saveAMapLocationModel:model];
        }
        
        // 定位完成后的操作
        if (locationSuccessBlock) {
            locationSuccessBlock();
        }
    }];
}

@end
