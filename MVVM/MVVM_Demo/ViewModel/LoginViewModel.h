//
//  LoginViewModel.h
//  MVVM_Demo
//
//  Created by karisli(李雪) on 2021/3/15.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import <ReactiveObjC/ReactiveObjC.h>
NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : NSObject
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) RACCommand *loginCommand;

+ (instancetype)loginViewModelWithUser:(User *)user;
- (instancetype)initWithUser:(User *)user;
@end

NS_ASSUME_NONNULL_END
