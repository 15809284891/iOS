//
//  Test.h
//  TestReleaseApp
//
//  Created by karisli(李雪) on 2021/2/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^TestBlock)(void);
@interface Test : NSObject
@property (nonatomic,copy)TestBlock block;
@property (nonatomic,strong)NSString *name;
- (void)test;
@end

NS_ASSUME_NONNULL_END
