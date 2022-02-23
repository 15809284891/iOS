//
//  RuntimeTest.h
//  RuntimeTest
//
//  Created by karisli(李雪) on 2022/2/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RuntimeTest : NSObject
@property(nonatomic,copy) NSString *strProperty;
-(void)printIvarValue;
@end

NS_ASSUME_NONNULL_END
