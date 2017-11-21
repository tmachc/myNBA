//
//  ViewController.m
//  myNBA
//
//  Created by ccwonline on 2017/9/19.
//  Copyright © 2017年 tmachc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //playerId=5185&
    [[HCNetManager defaultManager] getRequestToUrl:@"player/baseInfo" params:@{@"playerId": @"5185"} complete:^(BOOL successed, NSDictionary *result) {
        NSLog(@"%@ --> result = %@", successed?@"true":@"false", result);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
