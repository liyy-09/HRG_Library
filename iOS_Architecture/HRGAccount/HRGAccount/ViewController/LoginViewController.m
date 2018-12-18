//
//  LoginViewController.m
//  SHAREMEDICINE_EMPLOYEE_iOS
//
//  Created by lyy on 2018/11/19.
//  Copyright © 2018 HRG. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgetPwdViewController.h"
#import "LoginViewModel.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *pswTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;

@property (nonatomic, strong) LoginViewModel *viewModel;

@end

@implementation LoginViewController

- (instancetype) initWithStoryboard {
    NSBundle *podBundle = [NSBundle bundleForClass:LoginViewController.class];
    NSURL *url = [podBundle URLForResource:@"HRGAccount" withExtension:@"bundle"];
    
    if (url) {
        return [[UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle bundleWithURL:url]] instantiateViewControllerWithIdentifier:@"LoginViewController"];
    } else {
        return [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginViewController"];
    }
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
//    self.pswTextField.text = [[LoginInfoLocalData sharedInstance] getPassword];
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

// 忘记密码
- (IBAction)forgetPwd:(id)sender {
    ForgetPwdViewController *controller = [[ForgetPwdViewController alloc] initWithStoryboard];
    [self basePushViewController:controller];
}

// 创建帐号
- (IBAction)registerAccount:(id)sender {
    // TODO
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
