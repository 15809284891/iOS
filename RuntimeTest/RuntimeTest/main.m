//
//  main.m
//  RuntimeTest
//
//  Created by karisli(李雪) on 2022/2/8.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ViewController.h"
struct Books
{
   char  *title;
};

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
//        struct Books *book = (struct Books *)malloc(sizeof(struct Books));
//        char test[4] = {'a','b','c','d'};
//        book->title = (char *)malloc(sizeof(char));
//        void *p = &book;
//
//        NSLog(@"%p %p %p",p,book->title);
        ViewController *vc = [[ViewController alloc] init];
        ViewController *vc1 = [[ViewController alloc] init];
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
