//
//  NSTimer+Block.h
//  TestReleaseApp
//
//  Created by karisli(李雪) on 2021/3/16.
//

#import <Foundation/Foundation.h>
typedef void(^selectorBlock)(NSTimer
                              *timer);
NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (Block)
+(NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti  userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo block:(selectorBlock)block;
@end

NS_ASSUME_NONNULL_END
