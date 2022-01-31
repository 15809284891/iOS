//
//  Person.m
//  TestRelease
//
//  Created by karisli(李雪) on 2021/2/13.
//

#import "Person.h"

@implementation Person
-(NSString *)description{
    return self.name;
}

-(void)dealloc{
    NSLog(@"dealloc %@",self);
}
@end
