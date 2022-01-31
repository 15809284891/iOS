//
//  Test.m
//  TestReleaseApp
//
//  Created by karisli(李雪) on 2021/2/13.
//

#import "Test.h"

@implementation Test
-(void)dealloc{
    NSLog(@"dealloc = %@",self);
}
-(void)test{
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%p",self];
}
@end
