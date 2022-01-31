//
//  RunloopViewController.m
//  TestReleaseApp
//
//  Created by karisli(李雪) on 2021/3/17.
//

#import "RunloopViewController.h"

@interface RunloopViewController ()
@property (nonatomic,strong)NSThread *thread;
@end

@implementation RunloopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    // Do any additional setup after loading the view.
    NSLog(@"%@ 1.创建线程", [NSThread currentThread]);
    _thread = [[NSThread alloc] initWithTarget:self selector:@selector(alwaysRun) object:nil];;
    NSLog(@"2.启动线程，包括：1）.线程进入就绪状态；2）.线程获得CPU资源后运行状态");
    [_thread start];
}

/**
 2017-10-17 test[35026:1575126] <NSThread: 0x600000260c40>{number = 1, name = main} 1.创建线程
 2017-10-17 test[35026:1575126] <NSThread: 0x600000260c40>{number = 1, name = main} 2.启动线程，包括：1）.线程进入就绪状态；2）.线程获得CPU资源后运行状态
 2017-10-17 test[35026:1575230] <NSThread: 0x604000461200>{number = 3, name = (null)} 该线程一直在活跃
 2017-10-17 test[35026:1575230] <NSThread: 0x604000461200>{number = 3, name = (null)} 即将进入 runloop
 2017-10-17 test[35026:1575230] <NSThread: 0x604000461200>{number = 3, name = (null)} 即将处理 Timer
 2017-10-17 test[35026:1575230] <NSThread: 0x604000461200>{number = 3, name = (null)} 即将处理 Source
 2017-10-17 test[35026:1575230] <NSThread: 0x604000461200>{number = 3, name = (null)} 即将进入休眠
 
 2017-10-17 test[35026:1575230] <NSThread: 0x604000461200>{number = 3, name = (null)} 从休眠中唤醒 runloop
 2017-10-17 test[35026:1575230] <NSThread: 0x604000461200>{number = 3, name = (null)} 即将处理 Timer
 2017-10-17 test[35026:1575230] <NSThread: 0x604000461200>{number = 3, name = (null)} 即将处理 Source
 2017-10-17 test[35026:1575230] <NSThread: 0x604000461200>{number = 3, name = (null)} 你点击了1次屏幕
 2017-10-17 test[35026:1575230] <NSThread: 0x604000461200>{number = 3, name = (null)} 即将退出 runloop
 
 2017-10-17 test[35026:1575230] <NSThread: 0x604000461200>{number = 3, name = (null)} 即将进入 runloop
 2017-10-17 test[35026:1575230] <NSThread: 0x604000461200>{number = 3, name = (null)} 即将处理 Timer
 2017-10-17 test[35026:1575230] <NSThread: 0x604000461200>{number = 3, name = (null)} 即将处理 Source
 2017-10-17 test[35026:1575230] <NSThread: 0x604000461200>{number = 3, name = (null)} 即将进入休眠
 2017-10-17 test[35026:1575230] <NSThread: 0x604000461200>{number = 3, name = (null)} 从休眠中唤醒 runloop
 2017-10-17 test[35026:1575230] <NSThread: 0x604000461200>{number = 3, name = (null)} 即将处理 Timer
 2017-10-17 test[35026:1575230] <NSThread: 0x604000461200>{number = 3, name = (null)} 即将处理 Source
 2017-10-17 test[35026:1575230] <NSThread: 0x604000461200>{number = 3, name = (null)} 你点击了2次屏幕
 */
- (void)alwaysRun{
    NSLog(@"该线程一直在活跃 %@", [NSThread currentThread]);
    CFRunLoopObserverRef runLoopObserver = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, true, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"%@ 即将进入 runloop", [NSThread currentThread]);
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"%@ 即将处理 Timer", [NSThread currentThread]);
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"%@ 即将处理 Source", [NSThread currentThread]);
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"%@ 即将进入休眠", [NSThread currentThread]);
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"%@ 从休眠中唤醒 runloop", [NSThread currentThread]);
                break;
            case kCFRunLoopExit:
                NSLog(@"%@ 即将退出 runloop ", [NSThread currentThread]);
                break;
            default:
                break;
        }
    });
    
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), runLoopObserver, kCFRunLoopDefaultMode);
    
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [runloop run];
    
    NSLog(@"%@ 不会执行到这里", [NSThread currentThread]);
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"你点击了屏幕 %@", [NSThread currentThread]);
    __weak typeof(self)weakSelf = self;
    [self performSelector:@selector(subthreadRun) onThread:self.thread withObject:nil waitUntilDone:NO];
}

- (void)subthreadRun{
    
    static int i = 0;
    i++;
    NSLog(@"%@ 你点击了%d次屏幕 ", [NSThread currentThread], i);
    if (i==2) {
        NSLog(@"3.线程进入阻塞状态，阻塞3秒钟");
        //    [NSThread sleepForTimeInterval:3.0f];
//        [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:3.0]];
        sleep(3);
        NSLog(@"4.退出线程，退出线程后，该方法下面的代码不在执行");
        [NSThread exit];
        NSLog(@"该线程挂了");
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
