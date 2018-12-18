
//
//  UpdatePwdViewController.m
//  HRG_BC_TRADE_IOS
//
//  Created by mac on 2018/6/8.
//  Copyright © 2018年 liyy. All rights reserved.
//

#import "UpdatePwdViewController.h"
#import "DES3Util.h"
#import "PwdViewModel.h"
#import "HWWeakTimer.h"
#import "LoginInfoLocalData.h"

@interface UpdatePwdViewController ()

@property (nonatomic, strong) PwdViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *oldPwsTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UIButton *gainCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, assign) int timeCount;

@end

@implementation UpdatePwdViewController

- (instancetype) initWithStoryboard {
    NSBundle *podBundle = [NSBundle bundleForClass:UpdatePwdViewController.class];
    NSURL *url = [podBundle URLForResource:@"HRGAccount" withExtension:@"bundle"];
    
    if (url) {
        return [[UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle bundleWithURL:url]] instantiateViewControllerWithIdentifier:@"UpdatePwdViewController"];
    } else {
        return [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"UpdatePwdViewController"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"更改密码";
    
    self.timeCount = 121;// 倒计时120秒
    
    HRGViewBorderRadius(self.registerBtn, 3.0, 0, [UIColor clearColor]);
    [self.registerBtn setTitleColor:UIColorFromRGBA(0xffffff, 1) forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:UIColorFromRGBA(0xffffff, 0.3) forState:UIControlStateDisabled];
    self.registerBtn.enabled = NO;
    
    [self.registerBtn setTitle:@"更改密码" forState:UIControlStateNormal];
    self.registerBtn.backgroundColor = UIColorFromRGB(HRGThemeColor);
    
    [self.gainCodeBtn setTitleColor:UIColorFromRGBA(HRGThemeColor, 1) forState:UIControlStateNormal];
    [self.gainCodeBtn setTitleColor:UIColorFromRGBA(HRGThemeColor, 0.3) forState:UIControlStateDisabled];
    self.gainCodeBtn.enabled = NO;
    
    // 获取验证码
    [[self.gainCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self resign];
        [self showHubWithLoadText:@"正在发送验证码"];
        
        [self.viewModel.codeCommand execute:nil];
    }];
    
    // 更新密码
    [[self.registerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self resign];
        
        if ([self.oldPwsTF.text isEqualToString:self.pwdTF.text]) {
            [self showTextHubWithContent:@"原密码和新密码不能一样，请重新输入"];
            return ;
        }
        
        [self showHubWithLoadText:@"修改密码中"];
        [self.viewModel.updateCommand execute:nil];
    }];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.viewModel.password.phone = self.loginModel.telephone;
    self.phoneTF.enabled = NO;
    self.gainCodeBtn.enabled = YES;
    
    if (self.loginModel.telephone.length >= 11) {
        self.phoneTF.text = [NSString stringWithFormat:@"%@****%@", [self.loginModel.telephone substringToIndex:3], [self.loginModel.telephone substringWithRange:NSMakeRange(7, 4)]];
    } else {
        self.phoneTF.text = self.loginModel.telephone;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];   
}

#pragma mark - HRGViewControllerProtocol

- (void)bindViewModel {
    RAC(self.viewModel.password, phone) = self.phoneTF.rac_textSignal;
    RAC(self.viewModel.password, code) = self.codeTF.rac_textSignal;
    RAC(self.viewModel.password, oldPwd) = self.oldPwsTF.rac_textSignal;
    RAC(self.viewModel.password, pwd) = [self.pwdTF.rac_textSignal filter:^BOOL(NSString *pwd) {
        int result = [DES3Util isValidPassword:pwd];
        return result;
    }];
    
    RAC(self.gainCodeBtn, enabled) = self.viewModel.enableCodeSignal;
    [self.viewModel.enableCodeSignal subscribeNext:^(id x) {
        
    }];
    
    RAC(self.registerBtn, enabled) = self.viewModel.updateSignal;
    [self.viewModel.updateSignal subscribeNext:^(id x) {
        
    }];
    
    [self.viewModel.codeSubject subscribeNext:^(id x) {
        if ([x isEqualToString:@"1"]) {
            [self showTextHubWithContent:@"验证码已发送"];
            
            // 倒计时
            self.timer = [HWWeakTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        } else {
            [self showTextHubWithContent:x];
        }
        
        [self hideHub];
    }];
    
    [self.viewModel.updateSubject subscribeNext:^(NSString *x) {
        if ([x isEqualToString:@"1"]) {// 忘记密码成功
            [self showTextHubWithContent:@"更新修改成功"];
            
            // 删除登录的信息
            [[LoginInfoLocalData sharedInstance] clearInfo];
            [[LoginInfoLocalData sharedInstance] removeLoginModel];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdatePwdViewController" object:nil userInfo:nil];
        } else {
            [self showTextHubWithContent:x];
        }
        
        [self hideHub];
    }];
}

#pragma mark - timer

- (void) updateTimer {
    self.timeCount--;
    
    if (self.timeCount <= 0) {
        [self.gainCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.gainCodeBtn setTitleColor:UIColorFromRGB(HRGThemeColor) forState:UIControlStateNormal];
        self.gainCodeBtn.enabled = YES;
        
        [self invalidate];
    } else {
        NSString *title = [NSString stringWithFormat:@"%d秒", self.timeCount];
        
        [self.gainCodeBtn setTitle:title forState:UIControlStateNormal];
        [self.gainCodeBtn setTitleColor:UIColorFromRGB(0xf5f5f5) forState:UIControlStateNormal];
        self.gainCodeBtn.enabled = NO;
    }
}

- (void) invalidate {
    if (self.timer) {
        self.timeCount = 121;
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark - getter

- (PwdViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[PwdViewModel alloc] init];
    }
    
    return _viewModel;
}

- (void) resign {
    [self.phoneTF resignFirstResponder];
    [self.codeTF resignFirstResponder];
    [self.oldPwsTF resignFirstResponder];
    [self.pwdTF resignFirstResponder];
}

@end
