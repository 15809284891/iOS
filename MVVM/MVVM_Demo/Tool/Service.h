//
//  Service.h
//  MVVM_Demo
//
//  Created by karisli(李雪) on 2021/3/15.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
NS_ASSUME_NONNULL_BEGIN
@interface Result : NSObject

@property (assign, nonatomic) BOOL success;
@property (copy, nonatomic) NSString *message;
@property (strong, nonatomic) id responseObject;

+ (instancetype)resultWithSuccess:(BOOL)success message:(NSString *)message responseObject:(id)responseObject;
- (instancetype)initWithSuccess:(BOOL)success message:(NSString *)message responseObject:(id)responseObject;

@end

@interface Service : NSObject

- (RACSignal *)loginSignal:(NSString *)userName passWord:(NSString *)passWord;
- (RACSignal *)logoutSignal:(NSString *)userName passWord:(NSString *)passWord;

- (RACSignal *)searchSignal:(NSString *)searchText;
- (RACSignal *)allFriendsSignal;
- (RACSignal *)friendSignalWithPage:(NSInteger)page andCount:(NSInteger)count;
- (RACSignal *)searchSignalWithContent:(NSString *)content page:(NSInteger)page andCount:(NSInteger)count;
@end

NS_ASSUME_NONNULL_END
