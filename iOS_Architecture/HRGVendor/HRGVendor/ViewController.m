//
//  ViewController.m
//  HRGVendor
//
//  Created by lyy on 2018/11/19.
//  Copyright © 2018 HRG. All rights reserved.
//

#import "ViewController.h"
#import "NSArray+Boundary.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = [[NSArray alloc]initWithObjects:@"111",@"222", nil];
    
    NSString *res = [array objectAtIndex:3];
    NSLog(@"------>> %@", res);
}


@end
