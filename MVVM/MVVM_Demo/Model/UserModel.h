//
//  UserModel.h
//  MVVM_Demo
//
//  Created by karisli(李雪) on 2021/3/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject
@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *password;
@property (assign, nonatomic, getter=isLogined) BOOL logined;

+ (instancetype)userModelWithUsername:(NSString *)username password:(NSString *)password logined:(BOOL)logined;
- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password logined:(BOOL)logined;
@end

NS_ASSUME_NONNULL_END
