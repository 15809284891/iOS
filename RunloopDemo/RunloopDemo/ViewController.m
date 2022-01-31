//
//  ViewController.m
//  RunloopDemo
//
//  Created by karisli(李雪) on 2022/1/23.
//

#import "ViewController.h"

static void myInputSourceAction(void *info __unused){
    NSLog(@"输入源的响应函数：myInputSourceAction");
    CFRunLoopRun();
}

static void myTimerAction(CFRunLoopTimerRef timer __unused,void *info){
    NSLog(@"%d 定时器的响应函数：timer fired");
    CFRunLoopSourceSignal(info);
    NSLog(@"%d 定时器的响应函数timer action end");
}

//runloop的观察者的回调函数
static void myRunloopObserver(CFRunLoopObserverRef observer,CFRunLoopActivity activity,void *info){
    switch (activity) {
        case kCFRunLoopEntry:
            NSLog(@"runloo启动：kCFRunLoopEntry");
            break;
        case kCFRunLoopBeforeTimers:
            NSLog(@"runloop即将处理timer：kCFRunLoopBeforeTimers");
            break;
        case kCFRunLoopBeforeSources:
            NSLog(@"runloop即将处理 input source event: kCFRunLoopBeforeSources");
            break;
        case kCFRunLoopBeforeWaiting:
            NSLog(@"runloop即将进入休眠状态：kCFRunLoopBeforeWaiting");
            break;
        case kCFRunLoopAfterWaiting:
            NSLog(@"runloop被唤醒，但还未处理唤醒他的事件：kCFRunLoopAfterWaiting");
            break;
        case kCFRunLoopExit:
            NSLog(@"runloop 退出：kCFRunLoopExit");
            break;
        case kCFRunLoopAllActivities:
            NSLog(@"kCFRunLoopAllActivities");
            break;
        default:
            break;
    }
}

@interface ViewController ()
@property (nonatomic)NSThread *thread;
@end


@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 100, 200);
    [button addTarget:self action:@selector(<#selector#>) forControlEvents:<#(UIControlEvents)#>]
    [button setTitle:@"ceshi" forState:UIControlStateNormal];
    [self.view addSubview:button];
//    [self testRunloop1];
}
///**
//
// 循环只执行一次，end runloop不会打印：performSelector:onThread: withObject: waitUntilDone的时候，系统会给我们创建一个timer的source，加到对应的runloop上去
// */
//[self performSelector:@selector(testMethod) onThread:self.thread withObject:nil waitUntilDone:NO];//加上这行代码callBackThreaActionde的while循环只支持一次，且不会打印end runloop

- (void)testRunloop1{
    self.thread = [[NSThread alloc]initWithTarget:self selector:@selector(callBackThreaAction2) object:nil];
    self.thread.name = @"newThread";
    [self.thread start];
    // 先打印testMethod，再打印callBackThreaAction2，相当于在主线程调用[self method],循环只执行一次，因为加了source所以runloop不会退出
    [self performSelector:@selector(testMethod)];
    //先调用callBackThreaAction2，再调用testMethod，循环只调用一次 ，endRunloop不会执行
    [self performSelector:@selector(testMethod) onThread:self.thread withObject:nil waitUntilDone:NO];
    
}

- (void)callBackThreaAction3{
    NSLog(@"callBackThreaAction3");
    @autoreleasepool {
        [[NSRunLoop currentRunLoop]addPort:[NSPort port] forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop]run];
    }
}




/**
 */
- (void)callBackThreaAction2{
    NSLog(@"callBackThreaAction2");
    @autoreleasepool {
        NSInteger i = 1;
        //    NSLog(@"cur thread : %@ cur runoop :%@",[NSThread currentThread],[NSRunLoop currentRunLoop]);
        CFRunLoopSourceContext context = {0};
        context.perform = myInputSourceAction;
        CFRunLoopSourceRef source = CFRunLoopSourceCreate(NULL, 0, &context);
        CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopCommonModes);
        [[NSRunLoop currentRunLoop]run];
    //    这里永远不会被执行到
        CFRunLoopRemoveSource(CFRunLoopGetCurrent(), source, kCFRunLoopCommonModes);
        CFRelease(source);
    }
}

- (void)callBackThreaAction1{
    NSLog(@"callBackThreaAction1");
    NSInteger i = 1;
    //    NSLog(@"cur thread : %@ cur runoop :%@",[NSThread currentThread],[NSRunLoop currentRunLoop]);
    while (true) {
        NSLog(@"begin runloop");
        NSLog(@"loop times %ld",(long)i++);
        //启动runloop
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]];
        //下面这行代码不会执行到
        NSLog(@"end runloop");
    }
}



- (void)runloopTest2{
    self.thread = [[NSThread alloc]initWithTarget:self selector:@selector(callBackThreaAction) object:nil];
    self.thread.name = @"newThread";
    [self.thread start];
    /**只加这行代码*
     1. callBackThreaAction为处理1的时候callBackThreaActionde的while循环可以正常打印
     2.  callBackThreaAction为处理2/3（即endrunloop不被调用的时候）先打印testMethod再打印threadMethod
     */
    //    [self performSelector:@selector(testMethod)];
    /**只加这行代码*
     1. callBackThreaAction为处理1的时候callBackThreaActionde的while循环只打印一次，且不会打印end runloop
     2. callBackThreaAction为处理2/3（即endrunloop不被调用的时候）先打印threadMethod再打印testMethod
     */
    [self performSelector:@selector(testMethod) onThread:self.thread withObject:nil waitUntilDone:NO];//加上这行代码callBackThreaActionde的while循环只支持一次，且不会打印end runloop
    
}
- (void)callBackThreaAction{
    NSLog(@"threadMethod");
    NSInteger i = 1;
    //    NSLog(@"cur thread : %@ cur runoop :%@",[NSThread currentThread],[NSRunLoop currentRunLoop]);
    /**处理1：
     1. 会造成self.thread对应的runloop无数次run然后finish然后又run的无限循环，因此cpu就这样被占用了
     2. begin和endrunloop（退出runloop） 都会打印,因为runloop的items是null。所以执行一次就退出了
     */
    while (true) {
        NSLog(@"begin runloop");
        NSLog(@"loop times %ld",(long)i++);
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]];
        NSLog(@"cur thread : %@ cur runoop :%@",[NSThread currentThread],[NSRunLoop currentRunLoop]);
        //下面这行代码不会执行到
        NSLog(@"end runloop");
    }
    
    /**
     正确处理2：end runloop不会结束，因为自定义了source，并且加到了runloop中，所以runloop的items不为空就不会退出
     */
    //        CFRunLoopSourceContext context = {0};
    //        context.perform = myInputSourceAction;
    //
    //        CFRunLoopSourceRef source = CFRunLoopSourceCreate(NULL, 0, &context);
    //        CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopCommonModes);
    //        [[NSRunLoop currentRunLoop]run];
    //如果加了source，下面这一段可以不要:[runloop run]+source可以保证runloop不退出
    //        NSInteger index = 1;
    //        while (true) {
    //            NSLog(@"begin runloop");
    //            NSLog(@"loop times %ld",(long)index++);
    //            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]];
    //            NSLog(@"end runloop");
    //        }
    //这里永远不会被执行到
    //        CFRunLoopRemoveSource(CFRunLoopGetCurrent(), source, kCFRunLoopCommonModes);
    //        CFRelease(source);
    /**
     正确处理3
     runloop不会结束，因为有mach port(source1),线程也不会退出
     */
    //    [[NSRunLoop currentRunLoop]addPort:[NSPort port] forMode:NSRunLoopCommonModes];
    //    [[NSRunLoop currentRunLoop]run];
    //
}

- (void)runloopTest1{
    self.thread = [[NSThread alloc]initWithTarget:self selector:@selector(threadMethod) object:nil];
    
    self.thread.name = @"newThread";
    [self.thread start];
    [self performSelector:@selector(testMethod) onThread:self.thread withObject:nil waitUntilDone:YES];
}
- (void)threadMethod{
    NSLog(@"threadMethod");
    //不加这两句会crash，因为线程在执行完threadMethod就退出了
    //    NSRunLoop *currRunLoop = [NSRunLoop currentRunLoop];
    //    [currRunLoop run];
}

- (void)testPerformSelector{
    [self sendData];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(sendData) object:nil];
        //递归可以正常执行，普通的方法调用
        //        [self performSelector:@selector(testPerformSelector)];
        //只执行一次就会退出，因为timer是挂载在runloop上的，runloop没有启动，定时器无法开始【非主线程的runloop默认是不开启的，特别是GCD生成的线程，所以子这里用GCD启动一个线程，生成的新的线程并没有runloop，所以该方法生成的timer无法加载到当前线程的runloop上，导致没有调用】
        [self performSelector:@selector(testPerformSelector) withObject:nil afterDelay:1];
        //如果用performSelector:withObject:afterDelay:方法，必须要加下面的两行代码，让runloop runloop起来
        NSRunLoop *runlooop = [NSRunLoop currentRunLoop];
        [runlooop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    });
}

- (void)sendData{
    NSLog(@"sendData");
}

//开启常驻线程
- (NSThread *)networkThread{
    static NSThread *_networkThread = nil;
    static dispatch_once_t onceTokenl;
    dispatch_once(&onceTokenl, ^{
        _networkThread = [[NSThread alloc]initWithTarget:self selector:@selector(networkThreadEntryPoint) object:nil];
        [_networkThread start];
    });
    return _networkThread;
}
- (void)networkThreadEntryPoint{
    @autoreleasepool {
        [[NSRunLoop currentRunLoop]addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop]run];
    }
}

- (void)testMethod{
    NSLog(@"testMethod");
}

- (void)testRunloop{
    [NSThread detachNewThreadSelector:@selector(mainTestRunloop) toTarget:self withObject:nil];
}

- (void)mainTestRunloop{
    //runloop信息采集点，获取当前的runloop
    CFRunLoopRef curRunloop1 = CFRunLoopGetCurrent();
    //添加一个输入源
    CFRunLoopSourceRef source;
    CFRunLoopSourceContext source_context;
    bzero(&source_context, sizeof(source_context));
    source_context.perform = myInputSourceAction;
    source = CFRunLoopSourceCreate(NULL, 0, &source_context);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopCommonModes);
    
    
    //添加一个定时源
    CFRunLoopTimerRef timer;
    CFRunLoopTimerContext timer_context;
    bzero(&timer_context, sizeof(timer_context));
    timer_context.info = source;
    timer = CFRunLoopTimerCreate(NULL, CFAbsoluteTimeGetCurrent(), 5, 0, 0,myTimerAction,&timer_context);
    CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, kCFRunLoopCommonModes);
    
    /**添加runloop的观察者
     //设置runloop observer的运行环境
     */
    CFRunLoopObserverContext context = {0,(__bridge void *)(self),NULL,NULL,NULL};
    
    //创建Runloop observer对象
    /**
     参数1：分配该observer对象的内存
     参数2：设置该observer需要关注的时间，详见回调函数myRunloopObserver中的注释
     参数3：标识该observer第一次进入run loop时执行还是每次进图runloop处理时执行
     参数4：设置该observer的优先级
     参数5：设置该observer的回调函数
     参数6：设置该observer的运行环境
     
     */
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &myRunloopObserver, &context);
    
    if(observer){
        //将cocoa的NSRunloop类型转换成Core Foundation的CFRunloopRef类型
        CFRunLoopRef crtRunloop = CFRunLoopGetCurrent();
        //将新建的observer加入到当前的thread的runloop
        CFRunLoopAddObserver(crtRunloop, observer, kCFRunLoopDefaultMode);
    }
    //runloop信息采集点
    CFRunLoopRef curRunloop2 = CFRunLoopGetCurrent();
    //启动runlooop
    CFRunLoopRun();
    NSLog(@"mainTestRunloop END");
    
}

- (void)runloopTest3{
    [self performSelector:@selector(onMainThreadMethod) withObject:nil];
}

- (void)onMainThreadMethod{
    NSLog(@"execute %s",__func__);
}

- (void)runloopTest4{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self performSelector:@selector(onbBackGroundThread) onThread:[NSThread currentThread] withObject:nil waitUntilDone:NO];
        /**不加下面这两行onbBackGroundThread不会执行，
         */
        //        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        //        [runLoop run];
    });
}

- (void)onbBackGroundThread{
    NSLog(@"execute %s",__func__);
}

/**
 1. NSTimer只有在注册到runloop之后才会生效，这个注册是由系统自动给我们完成的，既然需要注册runloop，那么就需要启动子线程的runloop
 2. 在子线程加上[[NSRunLoop currentRunLoop] run]即可
 */
- (void)runloopTest5{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSTimer *myTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [myTimer fire];
        /**不加下面两行，timer只执行一次，加了之后才会定时打印
         NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
         [runLoop run];
         */
        
    });
}

- (void)timerAction{
    NSLog(@"execute %s",__func__);
}



@end
