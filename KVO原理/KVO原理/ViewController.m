//
//  ViewController.m
//  KVO原理
//
//  Created by karisli(李雪) on 2020/8/11.
//  Copyright © 2020 tencentyun.com. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Dog.h"
@interface ViewController ()
@property (nonatomic,strong)Person *p;
@end

@implementation ViewController
- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    // Do any additional setup after loading the view.
    _p = [Person new];
    [_p addObserver:self forKeyPath:NSStringFromSelector(@selector(name)) options:(NSKeyValueObservingOptionNew) context:nil];
    [_p addObserver:self forKeyPath:@"dog" options:(NSKeyValueObservingOptionNew) context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"keyPath : %@",keyPath);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _p.dog.age ++;
    _p.dog.level ++;
//    _p.name = @"1111";
}
@end
