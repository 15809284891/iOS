//
//  Father.m
//  TestRelease
//
//  Created by karisli(李雪) on 2021/2/13.
//

#import "Father.h"
#import "Son.h"
@interface Father()
@property (nonatomic,strong)Son *son;
@end
@implementation Father

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.age = 56;
        self.name = @"father";
        _son = [Son new];
        _son.name = @"son";
        _son.age = 23;
    }
    return self;
}
@end
