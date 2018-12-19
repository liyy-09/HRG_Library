//
//  HRGBaseViewController.m
//  SHAREMEDICINE_SHOP_iOS
//
//  Created by lyy on 2018/11/19.
//  Copyright © 2018 HRG. All rights reserved.
//

#import "HRGBaseAccountViewController.h"
#import "LoginViewController.h"
#import "MBProgressHUDTool.h"
#import "UseInfoLocalData.h"
#import "LoginViewModel.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface HRGBaseAccountViewController ()

@property (nonatomic, retain) MBProgressHUDTool *progressHUD;

@end

@implementation HRGBaseAccountViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    HRGBaseAccountViewController *viewController = [super allocWithZone:zone];
    
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
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x1AAAF7);// 导航栏背景颜色
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
    
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
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
        Account *model = [[Account alloc] init];
        model.account = account;
        model.pwd = psw;
        loginViewModel.account = model;
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
    LoginViewController *controller = [[LoginViewController alloc] initWithStoryboard];
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

@end
