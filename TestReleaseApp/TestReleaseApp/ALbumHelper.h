//
//  ALbumHelper.h
//  TestReleaseApp
//
//  Created by karisli(李雪) on 2021/2/14.
//

#import <Foundation/Foundation.h>
@class PHAsset;
@class PHFetchResult;
NS_ASSUME_NONNULL_BEGIN

@interface ALbumHelper : NSObject
+ (void)queryLocalAssets:(void (^)(NSArray<PHFetchResult *> *albumResult, NSArray<PHAsset *> *localAssets))completion;
+ (void)sortAssets:(NSArray *)assets
        completion:
            (void (^)(NSArray<PHAsset *> *validPhotoAssets, NSArray<PHAsset *> *validVedioAssets, NSArray<PHAsset *> *invalidAssets))completion;

+ (void)getOriginalPhotoDataWithAsset:(PHAsset *)asset completion:(void (^)(NSData *data, NSDictionary *info, NSError *_Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
