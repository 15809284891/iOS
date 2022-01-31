//
//  TabbarViewController.m
//  LXTextField
//
//  Created by karisli(李雪) on 2020/6/15.
//  Copyright © 2020 tencentyun.com. All rights reserved.
//

#import "TabbarViewController.h"
#import "ViewController.h"
@interface TabbarViewController ()

@end

@implementation TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ViewController *oneVC = [[ViewController alloc] init];
       //设置标题

    oneVC.tabBarItem.title = @"test";
       //设置图片
    [self addChildViewController:oneVC];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
