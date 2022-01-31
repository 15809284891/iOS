//
//  main.m
//  LXTextField
//
//  Created by karisli(李雪) on 2020/3/19.
//  Copyright © 2020 tencentyun.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
        NSArray *titles = @[@"1",@"2",@"3"];
        NSString *test = @"1";
        NSInteger index = NSNotFound;
        index = [titles indexOfObject:test];
        if (index == NSNotFound) {
         NSLog(@"111");
        }else{
            NSLog(@"%@",titles[index]);
        }
        
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
