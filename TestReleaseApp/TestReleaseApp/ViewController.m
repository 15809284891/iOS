//
//  ViewController.m
//  TestReleaseApp
//
//  Created by karisli(李雪) on 2021/2/13.
//

#import "ViewController.h"
#import "LXImage.h"
#import "Test.h"
#import <Photos/Photos.h>
#import "PHAsset+CBInfo.h"
#import "ALbumHelper.h"
#import "OneViewController.h"
#import "LXManager.h"

@interface ViewController () {
    BOOL _isPauseAll;
    BOOL _isFirstBackup;
    dispatch_queue_t _backupQueue;
    //相册中的所有视频
    NSMutableArray<PHAsset *> *_localVedioAssets;
    //相册中的所有图片
    NSMutableArray<PHAsset *> *_localPhotoAssets;
    //新增的需要备份的文件
    NSMutableArray *_incrementalAssets;
    NSMutableArray *_albumResults;
    PHAsset *_runningAsset;
    dispatch_queue_t _queue;
    NSMutableDictionary *_dic;
    
}
@property (nonatomic,strong)OneViewController *oneVC;
@property (nonatomic,strong)Test *a;
@property (strong,nonatomic)NSTimer *timer;
@property (nonatomic,weak) NSTimer *timer1;
@property (nonatomic,strong) NSThread *thread1;
@end

@implementation ViewController
- (void)timerStart{
    NSArray *arr = [_dic.allValues copy];
    NSLog(@"%d", arr.count);
}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];
//    NSRunLoop *loop =  [NSRunLoop currentRunLoop];
//    NSLog(@"%@",loop);
////    _dic  =[NSMutableDictionary dictionary];
////    for (int i = 0; i<10000; i++) {
////        Test *test = [Test new];
////        test.name = [NSString stringWithFormat:@"%d",i];
////        [_dic setObject:test forKey:test.name];
////    }
////
////    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
////        NSArray *values = [self->_dic.allValues copy];
////        for (int i = 0; i<values.count; i++) {
////            sleep(2);
////            Test *test = values[i];
////            Test *test1;
////            [_dic objectForKey:test.name] = test1;
////            test = nil;
////
////        }
////    });
//
////    [[LXManager shareInstance] start];
////
////    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerStart) userInfo:nil repeats:YES];
////
////    //加入runloop循环池
////    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
////
////    //开启定时器
////    [_timer fire];
//
//
////    _queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
////    dispatch_async(_queue, ^{
//        //不会造成循环引用
////        NSLog(@"%@",self);
////    });
////    __autoreleasing NSMutableDictionary *dic;
////    @autoreleasepool {
////        dic = [NSMutableDictionary dictionary];
////        dic[@"111"] = @"3333";
////    }
////
////    NSLog(@"测试 %@",[dic allValues]);
//    self.oneVC = [[OneViewController alloc] init];
//////
////    self.oneVC.block = ^{
//////
////        self.view.backgroundColor = [UIColor redColor];
//////        [self.navigationController popViewControllerAnimated:YES];
////    };
////    if(self.oneVC.block){
////        self.oneVC.block();
////    }
////    NSMutableArray *assets = [NSMutableArray array];
////   self.a = [Test new];
////
////    __weak __typeof(self)weakSelf = self;
////    self.a.block = ^(void){
////            [weakSelf doSomething];
////            [weakSelf doSomething];
//////            a = nil;
//////            sleep(30);
//////            a.name = @"998";
////
////        };
////        if(self.a.block){
////            self.a.block();
////        }
//
//
//
//
//
////    [ALbumHelper queryLocalAssets:^(NSArray<PHFetchResult *> *_Nonnull albumResult, NSArray<PHAsset *> *_Nonnull localAssets) {
//////        self->_albumResults = albumResult;
////
////        [ALbumHelper sortAssets:localAssets
////                       completion:^(NSArray<PHAsset *> *_Nonnull validPhotoAssets, NSArray<PHAsset *> *_Nonnull validVedioAssets,
////                                    NSArray<PHAsset *> *_Nonnull invalidAssets) {
////                           self->_isFirstBackup = NO;
////                           self->_localPhotoAssets = [validPhotoAssets mutableCopy];
////                           self->_localVedioAssets = [validVedioAssets mutableCopy];
////                            [self test];
////
////                       }];
////    }];
//
////    [aaset getOringeInfo:^(PHAsset *asset) {
////
////    }];
//
////    [assets removeAllObjects];
//
//    // Do any additional setup after loading the view.
////    self.view.backgroundColor = [UIColor yellowColor];
////    for (NSInteger i = 0 ; i<10000; i++) {
////        @autoreleasepool {
////            Test *test = [Test new];
////        PHAsset *asset = [[PHAsset alloc] init];
////             NSLog(@"for dealloc %@",asset);
////        }
////        @autoreleasepool {
////            UIImage *img = [LXImage imageNamed:@"More"];
////            NSLog(@"for dealloc %@",img);
////        }
////    }
//}
////
////-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
////     OneViewController *one = [OneViewController new];
////    one.view.backgroundColor = [UIColor yellowColor];
////    [self presentViewController:one animated:YES completion:nil];
////}
////- (void)doSomething{
////
////}
//
////- (void)test{
////    __weak typeof(self) weakSelf = self;
////    if(!_localPhotoAssets.count){
////        return;
////    }
////    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
////        __strong typeof(self) strongSelf = weakSelf;
////        //每次取第一个的时候 会加入tansfer的备份列表，所以就从waiting中移除
////        PHAsset *asset = [strongSelf->_localPhotoAssets firstObject];
////        strongSelf->_runningAsset = asset;
////        [asset getOringeInfo:^(PHAsset *_Nonnull asset) {
////            [strongSelf->_localPhotoAssets  removeObject:asset];
////            NSLog(@"getOringeInfo asset");
////            [self test];
////        }];
////    });
////}
//-(void)dealloc{
//    NSLog(@"ViewController dealloc");
//}
//
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.navigationController pushViewController:[OneViewController new] animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
//    
//    // 由于下面的方法无法拿到NSThread的引用，也就无法控制线程的状态
//    //[NSThread detachNewThreadSelector:@selector(performTask) toTarget:self withObject:nil];
//    self.thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(performTask) object:nil];
//    [self.thread1 start];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
////    [self.thread1 cancel];
////    [self dismissViewControllerAnimated:YES completion:nil];
//    NSLog(@"%@",[NSRunLoop currentRunLoop]);
//}

//-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"end :%@",[NSRunLoop currentRunLoop]);
//    CFRunLoopObserverContext context = {0, NULL, NULL, NULL};
//    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault,
//                                                        kCFRunLoopAllActivities,
//                                                        YES,
//                                                        0,
//                                                        &runLoopObserverCallBack,
//                                                        &context);
//    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
//    
//    static const NSTimeInterval kRunLoopThreshold = 0.3;
//    //粗略计算一下，以运行时低于40帧为卡，则会掉20帧，卡住的时间约为320ms。
//    //可以假设如果runloop执行超过了0.3，主线程无法将计算好的内容提交给 GPU，会造成卡顿。
//    static uint64_t kStartTime = 0;
//    static void runLoopObserverCallBack(CFRunLoopObserverRef observer,
//     CFRunLoopActivity activity, void *info)
//    {
//      switch (activity) {
//        case kCFRunLoopAfterWaiting:
//            kStartTime = mach_absolute_time();
//            break;
//        case kCFRunLoopBeforeWaiting:
//            if (kStartTime != 0 ) {
//                uint64_t elapsed = mach_absolute_time() - kStartTime;
//                mach_timebase_info_data_t timebase;
//                mach_timebase_info(&timebase);
//                NSTimeInterval duration = elapsed * timebase.numer / timebase.denom / 1e9;
//                if (duration > kRunLoopThreshold) {
//                    assert(0);
//                }
//            }
//            break;
//        default:
//            break;
//        }
//    }
//
//    

//}
//
//- (void)dealloc {
//    [self.timer1 invalidate];
//    NSLog(@"ViewController dealloc.");
//}
//
//- (void)performTask {
//    // 使用下面的方式创建定时器虽然会自动加入到当前线程的RunLoop中，但是除了主线程外其他线程的RunLoop默认是不会运行的，必须手动调用
//    __weak typeof(self) weakSelf = self;
//    self.timer1 = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        if ([NSThread currentThread].isCancelled) {
//            //[NSObject cancelPreviousPerformRequestsWithTarget:weakSelf selector:@selector(caculate) object:nil];
//            //[NSThread exit];
//            [weakSelf.timer1 invalidate];
//        }
//        NSLog(@"timer1...");
//    }];
//    
//    NSLog(@"runloop before performSelector:%@",[NSRunLoop currentRunLoop]);
//    
//    // 区分直接调用和「performSelector:withObject:afterDelay:」区别,下面的直接调用无论是否运行RunLoop一样可以执行，但是后者则不行。
//    //[self caculate];
//    [self performSelector:@selector(caculate) withObject:nil afterDelay:2.0];
//    
//    // 取消当前RunLoop中注册测selector（注意：只是当前RunLoop，所以也只能在当前RunLoop中取消）
//    // [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(caculate) object:nil];
//    NSLog(@"runloop after performSelector:%@",[NSRunLoop currentRunLoop]);
//    
//    // 非主线程RunLoop必须手动调用
//    [[NSRunLoop currentRunLoop] run];
//    
//    NSLog(@"注意：如果RunLoop不退出（运行中），这里的代码并不会执行，RunLoop本身就是一个循环.");
//    
//    
//}
//
//- (void)caculate {
//    for (int i = 0;i < 9999;++i) {
//        NSLog(@"%i,%@",i,[NSThread currentThread]);
//        if ([NSThread currentThread].isCancelled) {
//            return;
//        }
//    }
//}


@end
