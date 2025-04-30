//
//  XXNetworkHelper.h
//  XXObjCKit
//
//  Created by 许亚光 on 2025/4/30.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <ReactiveObjC/ReactiveObjC.h>

typedef void(^XXNetworkProgressBlock)(NSProgress *progress);
typedef void(^XXNetworkSuccessBlock)(id response);
typedef void(^XXNetworkFailureBlock)(NSError *error);

@interface XXNetworkHelper : NSObject

+ (void)GET:(NSString *)endpoint successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock;
+ (void)POST:(NSString *)endpoint successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock;
+ (void)PUT:(NSString *)endpoint successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock;
+ (void)DELETE:(NSString *)endpoint successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock;
+ (void)HEAD:(NSString *)endpoint successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock;
+ (void)PATCH:(NSString *)endpoint successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock;

+ (void)GET:(NSString *)endpoint parameters:(id)parameters successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock;
+ (void)POST:(NSString *)endpoint parameters:(id)parameters successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock;
+ (void)PUT:(NSString *)endpoint parameters:(id)parameters successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock;
+ (void)DELETE:(NSString *)endpoint parameters:(id)parameters successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock;
+ (void)HEAD:(NSString *)endpoint parameters:(id)parameters successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock;
+ (void)PATCH:(NSString *)endpoint parameters:(id)parameters successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock;

+ (void)GET:(NSString *)endpoint headers:(NSDictionary *)headers successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock;
+ (void)POST:(NSString *)endpoint headers:(NSDictionary *)headers successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock;
+ (void)PUT:(NSString *)endpoint headers:(NSDictionary *)headers successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock;
+ (void)DELETE:(NSString *)endpoint headers:(NSDictionary *)headers successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock;
+ (void)HEAD:(NSString *)endpoint headers:(NSDictionary *)headers successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock;
+ (void)PATCH:(NSString *)endpoint headers:(NSDictionary *)headers successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock;

+ (void)GET:(NSString *)endpoint parameters:(id)parameters headers:(NSDictionary *)headers successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock;
+ (void)POST:(NSString *)endpoint parameters:(id)parameters headers:(NSDictionary *)headers successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock;

+ (void)GET:(NSString *)endpoint parameters:(id)parameters headers:(NSDictionary *)headers progressBlock:(XXNetworkProgressBlock)progressBlock successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock;
+ (void)POST:(NSString *)endpoint parameters:(id)parameters headers:(NSDictionary *)headers progressBlock:(XXNetworkProgressBlock)progressBlock successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock;
+ (void)PUT:(NSString *)endpoint parameters:(id)parameters headers:(NSDictionary *)headers successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock;
+ (void)DELETE:(NSString *)endpoint parameters:(id)parameters headers:(NSDictionary *)headers successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock;
+ (void)HEAD:(NSString *)endpoint parameters:(id)parameters headers:(NSDictionary *)headers successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock;
+ (void)PATCH:(NSString *)endpoint parameters:(id)parameters headers:(NSDictionary *)headers successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock;

+ (RACSignal *)GET:(NSString *)endpoint;
+ (RACSignal *)POST:(NSString *)endpoint;
+ (RACSignal *)PUT:(NSString *)endpoint;
+ (RACSignal *)DELETE:(NSString *)endpoint;
+ (RACSignal *)HEAD:(NSString *)endpoint;
+ (RACSignal *)PATCH:(NSString *)endpoint;

+ (RACSignal *)GET:(NSString *)endpoint parameters:(id)parameters;
+ (RACSignal *)POST:(NSString *)endpoint parameters:(id)parameters;
+ (RACSignal *)PUT:(NSString *)endpoint parameters:(id)parameters;
+ (RACSignal *)DELETE:(NSString *)endpoint parameters:(id)parameters;
+ (RACSignal *)HEAD:(NSString *)endpoint parameters:(id)parameters;
+ (RACSignal *)PATCH:(NSString *)endpoint parameters:(id)parameters;

+ (RACSignal *)GET:(NSString *)endpoint headers:(NSDictionary *)headers;
+ (RACSignal *)POST:(NSString *)endpoint headers:(NSDictionary *)headers;
+ (RACSignal *)PUT:(NSString *)endpoint headers:(NSDictionary *)headers;
+ (RACSignal *)DELETE:(NSString *)endpoint headers:(NSDictionary *)headers;
+ (RACSignal *)HEAD:(NSString *)endpoint headers:(NSDictionary *)headers;
+ (RACSignal *)PATCH:(NSString *)endpoint headers:(NSDictionary *)headers;

+ (RACSignal *)GET:(NSString *)endpoint parameters:(id)parameters headers:(NSDictionary *)headers;
+ (RACSignal *)POST:(NSString *)endpoint parameters:(id)parameters headers:(NSDictionary *)headers;
+ (RACSignal *)PUT:(NSString *)endpoint parameters:(id)parameters headers:(NSDictionary *)headers;
+ (RACSignal *)DELETE:(NSString *)endpoint parameters:(id)parameters headers:(NSDictionary *)headers;
+ (RACSignal *)HEAD:(NSString *)endpoint parameters:(id)parameters headers:(NSDictionary *)headers;
+ (RACSignal *)PATCH:(NSString *)endpoint parameters:(id)parameters headers:(NSDictionary *)headers;

@end

