//
//  PHAsset+CBInfo.h
//  TestReleaseApp
//
//  Created by karisli(李雪) on 2021/2/14.
//




#import <Photos/Photos.h>
@interface PHAsset (CBInfo)
- (void)getOringeInfo:(void (^)(PHAsset *asset))completion;
@property (nonatomic, strong) NSData *mediaData;
@end
