//
//  CBBackupHelper.m
//  QCloudCOSBrowser
//
//  Created by 李雪 on 2020/7/3.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import "ALbumHelper.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import "libkern/OSAtomic.h"
#import "PHAsset+CBInfo.h"
@implementation ALbumHelper

+ (void)queryLocalAssets:(void (^)(NSArray<PHFetchResult *> *albumResult, NSArray<PHAsset *> *localAssets))completion {
    __block NSArray *albums;
    NSMutableArray<PHAsset *> *assets = [NSMutableArray array];
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    //请求相册权限
    if (![[TZImageManager manager] authorizationStatusAuthorized]) {
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            dispatch_semaphore_signal(sem);
        }];
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    }

    [[TZImageManager manager] getAllAlbums:YES
                         allowPickingImage:YES
                           needFetchAssets:YES
                                completion:^(NSArray<TZAlbumModel *> *models) {
                                    dispatch_semaphore_signal(sem);
                                    albums = models;
                                }];
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    __block int32_t loadingBarrier = (int32_t)albums.count;
    if (!albums.count) {
        if (completion) {
            completion(nil, nil);
            return;
        }
    }
    NSMutableArray *albumResult = [NSMutableArray array];
    for (TZAlbumModel *albumModel in albums) {
        @autoreleasepool {
            [albumResult addObject:albumModel.result];
            [[TZImageManager manager] getAssetsFromFetchResult:albumModel.result
                                             allowPickingVideo:YES
                                             allowPickingImage:YES
                                                    completion:^(NSArray<TZAssetModel *> *models) {
                                                        for (TZAssetModel *model in models) {
                                                            @autoreleasepool {
                                                                if ([assets containsObject:model.asset]) {
                                                                    continue;
                                                                    ;
                                                                }
                                                                [assets addObject:model.asset];
                                                            }
                                                        }
                                                      
                                                        if (OSAtomicDecrement32Barrier(&loadingBarrier) == 0) {
                                                            if (completion) {
                                                                completion([albumResult copy], [assets copy]);
                                                            }
                                                        }
                                                    }];
        }
    }
}

+ (void)sortAssets:(NSArray *)assets
        completion:
            (void (^)(NSArray<PHAsset *> *validPhotoAssets, NSArray<PHAsset *> *validVedioAssets, NSArray<PHAsset *> *invalidAssets))completion {
    //过滤掉无效的asset
    __block int32_t loadingBarrier = (int32_t)assets.count;
    NSMutableArray *validPhotoAssets = [NSMutableArray array];
    NSMutableArray *validVedioAssets = [NSMutableArray array];
    NSMutableArray *inValidAssets = [NSMutableArray array];
    if (!assets.count) {
        if (completion) {
            completion(nil, nil, nil);
        }
        return;
    }
    for (PHAsset *asset in assets) {
        @autoreleasepool {
            if (asset.mediaType == PHAssetMediaTypeImage) {
                [self getOriginalPhotoDataWithAsset:asset
                                         completion:^(NSData *_Nonnull data, NSDictionary *_Nonnull info, NSError *_Nullable error) {
                                            
                                             if (!data) {
                                                 [inValidAssets addObject:asset];
                                             } else {
                                                 [validPhotoAssets addObject:asset];
                                             }

                                             if (OSAtomicDecrement32Barrier(&loadingBarrier) == 0) {
                                                 if (completion) {
                                                     completion([validPhotoAssets copy], [validVedioAssets copy], [inValidAssets copy]);
                                                 }
                                             }
                                         }];

            } else if (asset.mediaType == PHAssetMediaTypeVideo) {
                [[TZImageManager manager] getVideoWithAsset:asset
                                                 completion:^(AVPlayerItem *playerItem, NSDictionary *info) {
                                                     if (!playerItem) {
                                                         [inValidAssets addObject:asset];
                                                     } else {
                                                         [validVedioAssets addObject:asset];
                                                     }
                                                     if (OSAtomicDecrement32Barrier(&loadingBarrier) == 0) {
                                                         if (completion) {
                                                             completion([validPhotoAssets copy], [validVedioAssets copy], [inValidAssets copy]);
                                                         }
                                                     }
                                                 }];
            } else {
                [inValidAssets addObject:asset];
                if (OSAtomicDecrement32Barrier(&loadingBarrier) == 0) {
                    if (completion) {
                        completion([validPhotoAssets copy], [validVedioAssets copy], [inValidAssets copy]);
                    }
                }
            }
        }
    }
}

+ (void)getOriginalPhotoDataWithAsset:(PHAsset *)asset completion:(void (^)(NSData *data, NSDictionary *info, NSError *_Nullable error))completion {
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.networkAccessAllowed = YES;
    if ([[asset valueForKey:@"filename"] hasSuffix:@"GIF"]) {
        // if version isn't PHImageRequestOptionsVersionOriginal, the gif may cann't play
        option.version = PHImageRequestOptionsVersionOriginal;
    }
    option.synchronous = YES;
    option.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    [option setProgressHandler:^(double progress, NSError *_Nullable error, BOOL *_Nonnull stop, NSDictionary *_Nullable info) {
        if (error) {
            if (completion) {
                completion(nil, info, error);
            }
        }
    }];
    @autoreleasepool {
    [[PHImageManager defaultManager]
        requestImageDataForAsset:asset
                         options:option
                   resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
        @autoreleasepool {
            if (completion) {
                completion(imageData, info, nil);
            }
        }
                   }];
    }
}

@end
