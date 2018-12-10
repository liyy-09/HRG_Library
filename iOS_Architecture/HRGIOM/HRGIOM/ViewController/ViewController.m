//
//  ViewController.m
//  HRGIOM
//
//  Created by lyy on 2018/11/19.
//  Copyright © 2018 HRG. All rights reserved.
//

#import "ViewController.h"
#import "SelectPhotoManager.h"
#import "LoginModel.h"
#import "DES3Util.h"
#import "HRGBaseNetDataRequest.h"
#import <HRGAccountCatogery/CTMediator+Login.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iv;

@property (nonatomic, strong) SelectPhotoManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0x555555);
    
    HRGBaseNetDataRequest *request = [[HRGBaseNetDataRequest alloc] init];
    [request httpGetRequest:@"" params:nil requestModel:nil];
    
    [self showHub];
}

- (IBAction)asd:(id)sender {
//    [self.manager startSelectPhotoWithImageName:@"选择头像"];
//
//    @weakify(self)
//    self.manager.successHandle = ^(SelectPhotoManager *manager, UIImage *image) {
//        @strongify(self)
//        self.iv.image = image;
//    };
//
//    LoginModel *m = [[LoginModel alloc] init];
//    [LoginModel convertFromDict:@{}];
//
//    [DES3Util isMobileNumber:@""];
    
    UIViewController *vc = [[CTMediator sharedInstance] Login_viewControllerWithCallback:^(NSString * _Nonnull result) {
        NSLog(@"%@", result);
    }];
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (SelectPhotoManager *) manager {
    if (!_manager) {
        _manager = [[SelectPhotoManager alloc] init];
    }
    
    return _manager;
}

- (void)bindViewModel {
    
}

@end
