//
//  LXManager.h
//  TestReleaseApp
//
//  Created by karisli(李雪) on 2021/2/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXManager : NSObject
+ (instancetype)shareInstance;
- (void)start;
- (NSArray *)getObjects;
@end

NS_ASSUME_NONNULL_END
