//
//  Dog.h
//  KVO原理
//
//  Created by karisli(李雪) on 2020/8/11.
//  Copyright © 2020 tencentyun.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Dog : NSObject
@property (nonatomic,assign)int64_t age;
@property (nonatomic,assign)int64_t level;
@end

NS_ASSUME_NONNULL_END
