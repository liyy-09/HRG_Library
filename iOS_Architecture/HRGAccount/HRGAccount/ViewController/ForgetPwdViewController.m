//
//  ForgetPwdViewController.m
//  HRG_BC_TRADE_IOS
//
//  Created by mac on 2018/6/14.
//  Copyright © 2018年 liyy. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "DES3Util.h"
#import "PwdViewModel.h"
#import "HWWeakTimer.h"

@interface ForgetPwdViewController ()

@property (nonatomic, strong) PwdViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *pwsTF;
@property (weak, nonatomic) IBOutlet UIButton *gainCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, assign) int timeCount;

@end

@implementation ForgetPwdViewController

- (instancetype) initWithStoryboard {
    NSBundle *podBundle = [NSBundle bundleForClass:ForgetPwdViewController.class];
    NSURL *url = [podBundle URLForResource:@"HRGAccount" withExtension:@"bundle"];
    
    if (url) {
        return [[UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle bundleWithURL:url]] instantiateViewControllerWithIdentifier:@"ForgetPwdViewController"];
    } else {
        return [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"ForgetPwdViewController"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"忘记密码";
    self.navigationController.navigationBarHidden = NO;
    
    self.timeCount = 121;// 倒计时120秒
    
    HRGViewBorderRadius(self.registerBtn, 3.0, 0, [UIColor clearColor]);
    [self.registerBtn setTitleColor:UIColorFromRGBA(0xffffff, 1) forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:UIColorFromRGBA(0xffffff, 0.3) forState:UIControlStateDisabled];
    self.registerBtn.enabled = NO;
    
    [self.gainCodeBtn setTitleColor:UIColorFromRGBA(HRGThemeColor, 1) forState:UIControlStateNormal];
    [self.gainCodeBtn setTitleColor:UIColorFromRGBA(HRGThemeColor, 0.3) forState:UIControlStateDisabled];
    self.gainCodeBtn.enabled = NO;
    
    [[_phoneTF rac_textSignal] subscribeNext:^(NSString *phone) {
        if ([DES3Util isMobileNumber:phone]) {
            self.gainCodeBtn.enabled = YES;
        } else {
            self.gainCodeBtn.enabled = NO;
        }
    }];
    
    // 获取验证码
    [[self.gainCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self resign];
        [self showHubWithLoadText:@"正在发送验证码"];
        
        [self.viewModel.codeCommand execute:nil];
    }];
    
    // 忘记密码
    [[self.registerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self resign];
        [self showHubWithLoadText:@"修改密码中"];
        
        [self.viewModel.forgetCommand execute:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - HRGViewControllerProtocol

- (void)bindViewModel {
    RAC(self.viewModel.password, phone) = self.phoneTF.rac_textSignal;
    RAC(self.viewModel.password, code) = self.codeTF.rac_textSignal;
    RAC(self.viewModel.password, pwd) = [self.pwsTF.rac_textSignal filter:^BOOL(NSString *pwd) {
        int result = [DES3Util isValidPassword:pwd];
        return result;
    }];
    
    RAC(self.gainCodeBtn, enabled) = self.viewModel.enableCodeSignal;
    [self.viewModel.enableCodeSignal subscribeNext:^(id x) {
        
    }];
    
    RAC(self.registerBtn, enabled) = self.viewModel.forgetSignal;
    [self.viewModel.forgetSignal subscribeNext:^(id x) {
        
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
    
    [self.viewModel.forgetSubject subscribeNext:^(NSString *x) {
        if ([x isEqualToString:@"1"]) {// 忘记密码成功
            [self showTextHubWithContent:@"密码修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
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
    [self.pwsTF resignFirstResponder];
}

@end
