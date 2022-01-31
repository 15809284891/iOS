//
//  Runloop_TableVC.m
//  Runloop_Table
//
//  Created by karisli(李雪) on 2021/3/18.
//

#import "Runloop_TableVC.h"
#import "RunloopCell.h"
typedef bool (^RunloopBlock)(void);
@interface Runloop_TableVC ()<UITableViewDelegate,UITableViewDataSource>{
    bool _useRunloop;
   
    NSInteger _maxQueueLength;
}
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *runloops;
@end

static  NSString  * const identifier = @"runloopCell";
@implementation Runloop_TableVC

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _maxQueueLength = ([UIScreen mainScreen].bounds.size.height/100)+2;
    _runloops = [NSMutableArray array];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRunloopObserver];
    [self setupTable];
}

- (void)addRunloopObserver{
    //需要监听的状态
    CFRunLoopActivity activity =  kCFRunLoopBeforeWaiting;
    //创建观察者
    __weak typeof(self)weakSelf = self;
    CFRunLoopObserverRef runloopObserver = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), activity, true, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
         NSLog(@"即将进入睡眠");
        if(!weakSelf.runloops.count) return;
        bool quit = false;
        while (!quit && weakSelf.runloops.count) {
            if( self.runloops.firstObject){
                NSLog(@"有任务，开始执行任务");
                RunloopBlock block = self.runloops.firstObject;
                quit = block();
                [self.runloops removeObjectAtIndex:0];
            }else{
                return;
            }
          
        }
        
        
//        switch (activity) {
//            case kCFRunLoopEntry:
//                NSLog(@"即将进入runloop");
//                break;
//            case kCFRunLoopBeforeTimers:
//                NSLog(@"即将处理timer");
//                break;
//            case kCFRunLoopBeforeSources:
//                NSLog(@"即将处理source");
//                break;;
//            case kCFRunLoopBeforeWaiting:
//                NSLog(@"即将进入睡眠");
//                break;;
//            case kCFRunLoopAfterWaiting:
//                NSLog(@"刚从休眠中唤醒");
//                break;
//            case kCFRunLoopExit:
//                NSLog(@"即将退出");
//                break;
//
//            default:
//                break;
//        }
    });
    //注册观察者
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), runloopObserver, kCFRunLoopDefaultMode);
    
}
- (void)setupTable{
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor redColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [self.view addSubview:label];
}

#pragma mark - tableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self loadCellWithRunloop:tableView];
}

- (RunloopCell *)loadCell:(UITableView *)tableView{
    RunloopCell *cell = [RunloopCell runloopCellForTableView:tableView indtifier:identifier];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"rose" ofType:@"jpg"];
    cell.image = [UIImage imageWithContentsOfFile:filePath];
    return cell;
}
//添加代码块的数组，在runloop即将进入睡眠时执行
- (void)addRunloopBlock:(RunloopBlock)block{
    [_runloops addObject:block];
    if (_runloops.count > _maxQueueLength) {
        [_runloops removeObjectAtIndex:0];
    }
}
- (UITableViewCell *)loadCellWithRunloop:(UITableView *)tableView{
    RunloopCell *cell = [RunloopCell runloopCellForTableView:tableView indtifier:identifier];
    RunloopBlock block = ^bool (){
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"rose" ofType:@"jpg"];
        cell.image = [UIImage imageWithContentsOfFile:filePath];
        return false;
    };
    [self addRunloopBlock:block];
 
    return cell;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    _tableView.frame = self.view.bounds;
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
