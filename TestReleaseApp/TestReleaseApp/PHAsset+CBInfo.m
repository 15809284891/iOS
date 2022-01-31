//
//  PHAsset+CBInfo.m
//  TestReleaseApp
//
//  Created by karisli(李雪) on 2021/2/14.
//

#import "PHAsset+CBInfo.h"
#import <Objc/runtime.h>
@implementation PHAsset (CBInfo)
static const void *mediaDataKey = (void *)@"mediaData";

- (void)setMediaData:(NSData *)mediaData {
    objc_setAssociatedObject(self, mediaDataKey, mediaData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSData *)mediaData {
    return objc_getAssociatedObject(self, mediaDataKey);
}

- (void)getOringeInfo:(void (^)(PHAsset *asset))completion {
        [self getImageInfo:^(NSData *mediaData, NSDictionary *_Nullable info, NSError *_Nullable error) {
            if (mediaData != nil) {
                self.mediaData = mediaData;
            }
            if (completion) {
                completion(self);
            }
        }];
    
}
- (void)getImageInfo:(void (^)(NSData *mediaData, NSDictionary *_Nullable info, NSError *_Nullable error))completion {
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.networkAccessAllowed = YES;
    if ([[self valueForKey:@"filename"] hasSuffix:@"GIF"]) {
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
    [[PHImageManager defaultManager]
        requestImageDataForAsset:self
                         options:option
                   resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
                       if (completion) {
                           completion(imageData, info, nil);
                       }
                   }];
}

- (void)getThumbnailInfo:(void (^)(UIImage *image, NSDictionary *_Nullable info))completion {
    if (self.mediaType == PHAssetMediaTypeImage) {
        PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
        option.networkAccessAllowed = YES;
        option.synchronous = YES;
        option.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;

        [[PHImageManager defaultManager] requestImageForAsset:self
                                                   targetSize:CGSizeMake(80, 80)
                                                  contentMode:PHImageContentModeAspectFit
                                                      options:option
                                                resultHandler:^(UIImage *_Nullable result, NSDictionary *_Nullable info) {
                                                    completion(result, info);
                                                }];
    }
}

-(void)dealloc{
    NSLog(@"asset dealloc[%p]",self);
}
@end
