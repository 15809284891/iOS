//
//  Person.h
//  KVO原理
//
//  Created by karisli(李雪) on 2020/8/11.
//  Copyright © 2020 tencentyun.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Dog;
NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property (nonatomic,strong)Dog *dog;
@property (nonatomic,strong)NSMutableArray *array;
@property (nonatomic,strong)NSString *name;
@end

NS_ASSUME_NONNULL_END
