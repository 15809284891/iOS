//
//  NSObject+KVO.h
//  KVO原理
//
//  Created by karisli(李雪) on 2020/8/11.
//  Copyright © 2020 tencentyun.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KVO)
-(void)LX_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;
@end

NS_ASSUME_NONNULL_END
