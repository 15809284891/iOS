//
//  OneViewController.h
//  TestReleaseApp
//
//  Created by karisli(李雪) on 2021/2/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^OneBlock)(void);
@interface OneViewController : UIViewController
@property (nonatomic,copy)OneBlock block;
@end

NS_ASSUME_NONNULL_END
