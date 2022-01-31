//
//  NSTimer+Block.m
//  TestReleaseApp
//
//  Created by karisli(李雪) on 2021/3/16.
//

#import "NSTimer+Block.h"

@implementation NSTimer (Block)
+(NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti userInfo:(id)userInfo repeats:(BOOL)yesOrNo block:(selectorBlock)block{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:ti target:self selector:@selector(method:) userInfo:[block copy] repeats:yesOrNo];
    return timer;
}

+ (void)method:(NSTimer *)timer{
    
    selectorBlock block = timer.userInfo;
    if (block) {
        block(timer);
    }
}

-(void)dealloc{
    NSLog(@"timer ");
}
@end
