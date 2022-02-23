//
//  ViewController.m
//  RuntimeTest
//
//  Created by karisli(李雪) on 2022/2/8.
//

#import "ViewController.h"
#import "RuntimeTest.h"
#define POOL_BOUNDARY nil
@interface ViewController ()

@end

@implementation ViewController
- (instancetype)init{
    self = [super init];
    if(!self){
        return self;
    }

    NSLog(@"POOL_BOUNDARY = %p",POOL_BOUNDARY);
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    /** id表示将其转换为一个对象指针，实际类型为struct objct_object *
     [RuntimeTest class]返回的是class，所以类型应该为struct objc_class *
     objc_class都指向了一个类对象的地址，
     */
    id cls = [RuntimeTest class];
    // 会crash，因为类方法不能调用实例方法
    
//    [cls printIvarValue];
    /**
     
     &cls：表示struct objc_class *结构体的首地址，存的是第一个元素的首地址，该结构体的第一个元素是isa指针（也就是说，我们如果有一个指向class的地址的指针，相当于这个对象就已经可以使用了）
     通过id类型转换，XCode就会将obj识别为RuntimeTest实例对象了，所以执行printIvarValue可以成
     */
    void *obj = &cls;
    

   [(__bridge  id)obj printIvarValue];
}


@end
