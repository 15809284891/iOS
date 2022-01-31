//
//  User.h
//  MVVM_Demo
//
//  Created by karisli(李雪) on 2021/3/15.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import <ReactiveObjC/ReactiveObjC.h>
NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject
@property (strong, nonatomic, readonly) Service *service;
@property (strong, nonatomic) UserModel *userModel;
@property (assign, nonatomic, readonly, getter=isValidOfUsername) BOOL validOfUsername;
@property (assign, nonatomic, readonly, getter=isValidOfPassword) BOOL validOfPassword;

+ (instancetype)userWithServices:(Service *)services userModel:(UserModel *)model;
- (instancetype)initWithServices:(Service *)services userModel:(UserModel *)model;

- (RACSignal *)loginSignal;
- (RACSignal *)logoutSignal;
@end

NS_ASSUME_NONNULL_END
