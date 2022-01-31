//
//  Person.m
//  KVO原理
//
//  Created by karisli(李雪) on 2020/8/11.
//  Copyright © 2020 tencentyun.com. All rights reserved.
//

#import "Person.h"
#import "Dog.h"

@implementation Person
- (instancetype)init
{
    self = [super init];
    if (self) {
        _dog = [Dog new];
        _array = [NSMutableArray array];
    }
    return self;
}
+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0)){
    NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
    if ([key isEqualToString:@"dog"]) {
        /**必须通过_dog访问，通过dog访问会报错
         Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Person: A +keyPathsForValuesAffectingValueForKey: message returned a set that includes a key path that starts with the same key that was passed in, which is not valid. The property identified by the key path already depends on the property identified by the key, never vice versa.
         Passed-in key: dog
         */
        keyPaths = [[NSSet alloc]initWithObjects:@"dog.level",@"dog.age", nil];
    }
    return keyPaths;
}
//+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key{
//
//}


@end
