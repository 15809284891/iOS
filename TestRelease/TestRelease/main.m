//
//  main.m
//  TestRelease
//
//  Created by karisli(李雪) on 2021/2/13.
//

#import <Foundation/Foundation.h>
#import "Father.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        for (int i = 0; i<1000000 ; i++) {
            Father *f = [Father new];
            NSLog(@"for dealloc = %@",f);
        }
        
    }
    return 0;
}
