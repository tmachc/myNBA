//
//  MainTabBarController.m
//  myNBA
//
//  Created by ccwonline on 2018/1/30.
//  Copyright © 2018年 tmachc. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController () <UITabBarDelegate>

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@" --->>> %@", self.navigationController.navigationBar);
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = MainColor;
    self.navigationController.navigationBar.translucent = NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    self.navigationController.navigationBar.topItem.title = item.title;
}

@end
