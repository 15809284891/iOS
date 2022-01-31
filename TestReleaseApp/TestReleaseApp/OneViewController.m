//
//  OneViewController.m
//  TestReleaseApp
//
//  Created by karisli(李雪) on 2021/2/19.
//

#import "OneViewController.h"
#import "Test.h"
#import "NSTimer+Block.h"
@interface OneViewController ()
@property (nonatomic,unsafe_unretained)Test *a;
@property (nonatomic, strong) NSString *string1;
@property (nonatomic, unsafe_unretained) NSString *string2;
@property (nonatomic,weak)NSTimer *timer1;
@property (nonatomic,weak)NSTimer *timer2;
@end

@implementation OneViewController

__weak id reference = nil;
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSRunLoop mainRunLoop] run];
//    CFRunLoopRef runloop = CFRunLoopGetCurrent();
//   //获取所有Mode，因为可能有很多Mode，每个Mode都需要跑，此处可以选择提交下崩溃信息之类的
//    UIAlertController *alertView = [[UIAlertView alloc] initWithTitle:@"程序崩溃了" message:@"崩溃信息"
//               delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
//    [alertView show];
//    NSArray *allModes = CFBridgingRelease(CFRunLoopCopyAllModes(runloop));
//    while (1) {
//       //快速切换Mode
//       for (NSString *mode in allModes) {
//           CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
//       }
//   }
//    _timer1 = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"wwwwww");
//    }];
//    NSTimer *tempTime  = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(someMethod) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:tempTime forMode:NSDefaultRunLoopMode];
//    _timer2 = tempTime;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [_timer1 invalidate];
    _timer1 = nil;
}
//
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self doSomething];
}
- (void)doSomething{
    [self.navigationController popViewControllerAnimated:YES];
}
//- (void)doOtherThing{
//    for (NSInteger i = 0;i <1000;i++) {
//        NSLog(@"%d",i);
//    }
//}
//-(void)dealloc{
//    NSLog(@"dealoc one[%@]",self);
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)dealloc{
    NSLog(@"one dealloc");
}
-(void)testpop{
    [self.navigationController popViewControllerAnimated:YES];
//    [self performSelector:@selector(someMethod) withObject:nil afterDelay:10];
}
-(void)someMethod{
    NSLog(@"wwwwww");
}
@end
