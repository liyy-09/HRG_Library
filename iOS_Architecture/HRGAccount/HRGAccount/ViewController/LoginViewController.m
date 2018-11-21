//
//  LoginViewController.m
//  SHAREMEDICINE_EMPLOYEE_iOS
//
//  Created by lyy on 2018/11/19.
//  Copyright © 2018 HRG. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *pswTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;

@property (nonatomic, strong) LoginViewModel *viewModel;

@end

// ---------------- 屏幕宽高 ----------------
#define HRGScreenWidth [[UIScreen mainScreen] bounds].size.width
#define HRGScreenHeight [[UIScreen mainScreen] bounds].size.height

//是否iPhoneX YES:iPhoneX屏幕 NO:传统屏幕
#define kIs_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define HRGBarHeight (kIs_iPhoneX ? 44 : 20)
#define HRGNavHeight 44
#define HRGTabBarHeight (kIs_iPhoneX ? (49 + 34) : 49)

#define UIColorFromRGBA(rgbValue,trans) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:trans]
#define HRGThemeColor 0x09336D

// ---------------- 设置圆角和边框 ----------------
#define HRGViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

@implementation LoginViewController

- (instancetype) initWithSelfStoryborad {
    return [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginViewController"];
}

- (instancetype) initWithStoryborad {
    NSBundle *podBundle = [NSBundle bundleForClass:LoginViewController.class];
    NSURL *url = [podBundle URLForResource:@"HRGAccount" withExtension:@"bundle"];
    
    return [[UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle bundleWithURL:url]] instantiateViewControllerWithIdentifier:@"LoginViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topViewHeight.constant = HRGBarHeight + HRGNavHeight;
    _contentViewHeightConstraint.constant = HRGScreenHeight + 1 - (HRGBarHeight + HRGNavHeight);
    
    // _loginBtn
    HRGViewBorderRadius(_loginBtn, 4, 0, [UIColor clearColor]);
    _loginBtn.backgroundColor = UIColorFromRGBA(HRGThemeColor, 0.5);
    
    // 监听TextField的输入
    [_accountTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_pswTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.accountTextField.text = [[LoginInfoLocalData sharedInstance] getAccount];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void) textFieldDidChange:(UITextField *)theTextField {
    if (![_accountTextField.text isEqualToString:@""] && ![_pswTextField.text isEqualToString:@""]) {
        _loginBtn.backgroundColor = UIColorFromRGBA(HRGThemeColor, 1);
    } else {
        _loginBtn.backgroundColor = UIColorFromRGBA(HRGThemeColor, 0.5);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - HRGViewControllerProtocol

- (void)bindViewModel {
    RAC(self.viewModel.account, account) = self.accountTextField.rac_textSignal;
    RAC(self.viewModel.account, pwd) = self.pswTextField.rac_textSignal;
    
    [self.viewModel.loginResultSubject subscribeNext:^(id x) {
        [self hideHub];
        
        if ([x isKindOfClass:[NSString class]]) {
            // 登录失败
            [self showTextHubWithContent:x];
        } else {
            // 登录成功
            [self.loginSuccessSubject sendNext:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginNotificationName" object:nil userInfo:nil];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

#pragma mark - click

- (IBAction)loginBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)login:(id)sender {
    [_accountTextField resignFirstResponder];
    [_pswTextField resignFirstResponder];
    
    if ([_accountTextField.text isEqualToString:@""]) {
        [self showTextHubWithContent:@"请输入帐号"];
        return;
    }
    
    if ([_pswTextField.text isEqualToString:@""]) {
        [self showTextHubWithContent:@"请输入密码"];
        return;
    }
    
    [self showHubWithLoadText:@"正在登录"];
    [self.viewModel.loginCommand execute:nil];
}

#pragma mark - getter

- (RACSubject *) loginSuccessSubject {
    if (!_loginSuccessSubject) {
        _loginSuccessSubject = [[RACSubject alloc] init];
    }
    
    return _loginSuccessSubject;
}

- (LoginViewModel *) viewModel {
    if (!_viewModel) {
        _viewModel = [[LoginViewModel alloc] init];
    }
    
    return _viewModel;
}

@end
