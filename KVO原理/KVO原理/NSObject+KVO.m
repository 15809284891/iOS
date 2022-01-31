//
//  NSObject+KVO.m
//  KVO原理
//
//  Created by karisli(李雪) on 2020/8/11.
//  Copyright © 2020 tencentyun.com. All rights reserved.
//

#import "NSObject+KVO.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation NSObject (KVO)
-(void)LX_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    //生成子类
    NSString *oldClassName = NSStringFromClass([self class]);
    NSString *newClassName = [@"LXKVO" stringByAppendingString:oldClassName];
    Class myClass= objc_allocateClassPair([self class], newClassName.UTF8String, 0);
    class_addMethod(myClass, @selector(setName:), (IMP)setName, "v@:@");
    objc_registerClassPair(myClass);
    object_setClass(self, myClass);
    objc_setAssociatedObject(self, (__bridge const void*)@"objc", observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

void setName(id self,SEL _cmd,NSString *newName){
    Class class = [self class];
    object_setClass(self, class_getSuperclass(class));
//    objc_msgSend(self,@selector(setName:),self);
    id observer = objc_getAssociatedObject(self, @"objc");
    if (observer) {
        objc_msgSend();
    }
    object_setClass(self, class);
}
@end
