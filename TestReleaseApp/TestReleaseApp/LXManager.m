//
//  LXManager.m
//  TestReleaseApp
//
//  Created by karisli(李雪) on 2021/2/17.
//

#import "LXManager.h"
#import "LXImage.h"
#import "Test.h"
#import <Photos/Photos.h>
#import "PHAsset+CBInfo.h"
#import "ALbumHelper.h"
@interface LXManager() {
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
    NSMutableArray<PHAsset *> *backupingAssets;
    NSMutableArray<PHAsset *> *backupingAssets1;
   
    
}
@property (nonatomic, strong) NSMutableDictionary *backupingDictoinary;
//@property (nonatomic, strong) NSMutableArray<PHAsset *> *backupingAssets;
@end

static LXManager* _instance;

@implementation LXManager

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [LXManager new];
        
    });
    return _instance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _backupingDictoinary = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)start{
    [ALbumHelper queryLocalAssets:^(NSArray<PHFetchResult *> *_Nonnull albumResult, NSArray<PHAsset *> *_Nonnull localAssets) {
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [ALbumHelper sortAssets:localAssets
                           completion:^(NSArray<PHAsset *> *_Nonnull validPhotoAssets, NSArray<PHAsset *> *_Nonnull validVedioAssets,
                                        NSArray<PHAsset *> *_Nonnull invalidAssets) {
                self->_isFirstBackup = NO;
                self->_localPhotoAssets = [validPhotoAssets mutableCopy];
                self->_localVedioAssets = [validVedioAssets mutableCopy];
          ;
                for (int i = 0;i<localAssets.count;i++) {
                    Test *test = [Test new];
                    test.name = [NSString stringWithFormat:@"%d",i];
                    PHAsset *asset = localAssets[i];
                    [self->_backupingDictoinary setObject:test forKey:asset.creationDate];
                }
                [self test];
            }];
//        });

                     
    }];
}

-(NSArray *)getObjects{
    return [[_backupingDictoinary allValues] copy];
}
- (void)prepareNeedToBackupAssets:(void (^)(void))completion {

    if (completion) {
        completion();
    }
}

- (void)test{
    NSLog(@"下一个");
    if(!_localPhotoAssets.count){
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //每次取第一个的时候 会加入tansfer的备份列表，所以就从waiting中移除
        PHAsset *asset = [self->_localPhotoAssets firstObject];
        self->_runningAsset = asset;
        [asset getOringeInfo:^(PHAsset *_Nonnull asset) {
            [self->_localPhotoAssets  removeObject:asset];
//            //为什么不移除backupingAssets的asset内存就会暴增
//            [strongSelf1->backupingAssets removeObject:asset];
            sleep(1);
            [self.backupingDictoinary removeObjectForKey:asset.creationDate];
            [self test];
        }];
    });
}
@end
