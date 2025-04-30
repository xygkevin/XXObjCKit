//
//  XXNetworkHelper.m
//  XXObjCKit
//
//  Created by 许亚光 on 2025/4/30.
//

#import "XXNetworkHelper.h"

@interface XXNetworkHelper ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation XXNetworkHelper

+ (instancetype)shared {
    static XXNetworkHelper *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _sessionManager.requestSerializer.timeoutInterval = 60;
    }
    return self;
}

+ (void)GET:(NSString *)endpoint successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock {
    [self GET:endpoint parameters:nil headers:nil progressBlock:nil successBlock:successBlock failureBlock:failureBlock];
}

+ (void)POST:(NSString *)endpoint successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock {
    [self POST:endpoint parameters:nil headers:nil progressBlock:nil successBlock:successBlock failureBlock:failureBlock];
}

+ (void)PUT:(NSString *)endpoint successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock {
    [self PUT:endpoint parameters:nil headers:nil successBlock:successBlock failureBlock:failureBlock];
}

+ (void)DELETE:(NSString *)endpoint successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock {
    [self DELETE:endpoint parameters:nil headers:nil successBlock:successBlock failureBlock:failureBlock];
}

+ (void)HEAD:(NSString *)endpoint successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock {
    [self HEAD:endpoint parameters:nil headers:nil successBlock:successBlock failureBlock:failureBlock];
}

+ (void)PATCH:(NSString *)endpoint successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock {
    [self PATCH:endpoint parameters:nil headers:nil successBlock:successBlock failureBlock:failureBlock];
}


+ (void)GET:(NSString *)endpoint parameters:(id)parameters successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock {
    [self GET:endpoint parameters:parameters headers:nil progressBlock:nil successBlock:successBlock failureBlock:failureBlock];
}

+ (void)POST:(NSString *)endpoint parameters:(id)parameters successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock {
    [self POST:endpoint parameters:parameters headers:nil progressBlock:nil successBlock:successBlock failureBlock:failureBlock];
}

+ (void)PUT:(NSString *)endpoint parameters:(id)parameters successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock {
    [self PUT:endpoint parameters:parameters headers:nil successBlock:successBlock failureBlock:failureBlock];
}

+ (void)DELETE:(NSString *)endpoint parameters:(id)parameters successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock {
    [self DELETE:endpoint parameters:parameters headers:nil successBlock:successBlock failureBlock:failureBlock];
}

+ (void)HEAD:(NSString *)endpoint parameters:(id)parameters successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock {
    [self HEAD:endpoint parameters:parameters headers:nil successBlock:successBlock failureBlock:failureBlock];
}

+ (void)PATCH:(NSString *)endpoint parameters:(id)parameters successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock {
    [self PATCH:endpoint parameters:parameters headers:nil successBlock:successBlock failureBlock:failureBlock];
}


+ (void)GET:(NSString *)endpoint headers:(NSDictionary *)headers successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock {
    [self GET:endpoint parameters:nil headers:headers progressBlock:nil successBlock:successBlock failureBlock:failureBlock];
}

+ (void)POST:(NSString *)endpoint headers:(NSDictionary *)headers successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock {
    [self POST:endpoint parameters:nil headers:headers progressBlock:nil successBlock:successBlock failureBlock:failureBlock];
}

+ (void)PUT:(NSString *)endpoint headers:(NSDictionary *)headers successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock {
    [self PUT:endpoint parameters:nil headers:headers successBlock:successBlock failureBlock:failureBlock];
}

+ (void)DELETE:(NSString *)endpoint headers:(NSDictionary *)headers successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock {
    [self DELETE:endpoint parameters:nil headers:headers successBlock:successBlock failureBlock:failureBlock];
}

+ (void)HEAD:(NSString *)endpoint headers:(NSDictionary *)headers successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock {
    [self HEAD:endpoint parameters:nil headers:headers successBlock:successBlock failureBlock:failureBlock];
}

+ (void)PATCH:(NSString *)endpoint headers:(NSDictionary *)headers successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock {
    [self PATCH:endpoint parameters:nil headers:headers successBlock:successBlock failureBlock:failureBlock];
}


+ (void)GET:(NSString *)endpoint parameters:(id)parameters headers:(NSDictionary *)headers successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock {
    [self GET:endpoint parameters:parameters headers:headers progressBlock:nil successBlock:successBlock failureBlock:failureBlock];
}

+ (void)POST:(NSString *)endpoint parameters:(id)parameters headers:(NSDictionary *)headers successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock {
    [self POST:endpoint parameters:parameters headers:headers progressBlock:nil successBlock:successBlock failureBlock:failureBlock];
}

+ (void)GET:(NSString *)endpoint parameters:(id)parameters headers:(NSDictionary *)headers progressBlock:(XXNetworkProgressBlock)progressBlock successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock {
    
}

+ (void)POST:(NSString *)endpoint parameters:(id)parameters headers:(NSDictionary *)headers progressBlock:(XXNetworkProgressBlock)progressBlock successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock {
    
}

+ (void)PUT:(NSString *)endpoint parameters:(id)parameters headers:(NSDictionary *)headers successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock {
    
}

+ (void)DELETE:(NSString *)endpoint parameters:(id)parameters headers:(NSDictionary *)headers successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock {
    
}

+ (void)HEAD:(NSString *)endpoint parameters:(id)parameters headers:(NSDictionary *)headers successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock {
    
}

+ (void)PATCH:(NSString *)endpoint parameters:(id)parameters headers:(NSDictionary *)headers successBlock:(XXNetworkSuccessBlock)successBlock failureBlock:(XXNetworkFailureBlock)failureBlock {
    
}


+ (RACSignal *)GET:(NSString *)endpoint {
    return [self GET:endpoint parameters:nil headers:nil];
}

+ (RACSignal *)POST:(NSString *)endpoint {
    return [self POST:endpoint parameters:nil headers:nil];
}

+ (RACSignal *)PUT:(NSString *)endpoint {
    return [self PUT:endpoint parameters:nil headers:nil];
}

+ (RACSignal *)DELETE:(NSString *)endpoint {
    return [self DELETE:endpoint parameters:nil headers:nil];
}

+ (RACSignal *)HEAD:(NSString *)endpoint {
    return [self HEAD:endpoint parameters:nil headers:nil];
}

+ (RACSignal *)PATCH:(NSString *)endpoint {
    return [self PATCH:endpoint parameters:nil headers:nil];
}


+ (RACSignal *)GET:(NSString *)endpoint parameters:(id)parameters {
    return [self GET:endpoint parameters:parameters headers:nil];
}

+ (RACSignal *)POST:(NSString *)endpoint parameters:(id)parameters {
    return [self POST:endpoint parameters:parameters headers:nil];
}

+ (RACSignal *)PUT:(NSString *)endpoint parameters:(id)parameters {
    return [self PUT:endpoint parameters:parameters headers:nil];
}

+ (RACSignal *)DELETE:(NSString *)endpoint parameters:(id)parameters {
    return [self DELETE:endpoint parameters:parameters headers:nil];
}

+ (RACSignal *)HEAD:(NSString *)endpoint parameters:(id)parameters {
    return [self HEAD:endpoint parameters:parameters headers:nil];
}

+ (RACSignal *)PATCH:(NSString *)endpoint parameters:(id)parameters {
    return [self PATCH:endpoint parameters:parameters headers:nil];
}


+ (RACSignal *)GET:(NSString *)endpoint headers:(NSDictionary *)headers {
    return [self GET:endpoint parameters:nil headers:headers];
}

+ (RACSignal *)POST:(NSString *)endpoint headers:(NSDictionary *)headers {
    return [self POST:endpoint parameters:nil headers:headers];
}

+ (RACSignal *)PUT:(NSString *)endpoint headers:(NSDictionary *)headers {
    return [self PUT:endpoint parameters:nil headers:headers];
}

+ (RACSignal *)DELETE:(NSString *)endpoint headers:(NSDictionary *)headers {
    return [self DELETE:endpoint parameters:nil headers:headers];
}

+ (RACSignal *)HEAD:(NSString *)endpoint headers:(NSDictionary *)headers {
    return [self HEAD:endpoint parameters:nil headers:headers];
}

+ (RACSignal *)PATCH:(NSString *)endpoint headers:(NSDictionary *)headers {
    return [self PATCH:endpoint parameters:nil headers:headers];
}


+ (RACSignal *)GET:(NSString *)endpoint parameters:(id)parameters headers:(NSDictionary *)headers {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *dataTask = [[self shared].sessionManager GET:endpoint parameters:parameters headers:headers progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];
        [dataTask resume];
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
    }];
}

+ (RACSignal *)POST:(NSString *)endpoint parameters:(id)parameters headers:(NSDictionary *)headers {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *dataTask = [[self shared].sessionManager POST:endpoint parameters:parameters headers:headers progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];
        [dataTask resume];
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
    }];
}

+ (RACSignal *)PUT:(NSString *)endpoint parameters:(id)parameters headers:(NSDictionary *)headers {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *dataTask = [[self shared].sessionManager PUT:endpoint parameters:parameters headers:headers success:^(NSURLSessionDataTask *task, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];
        [dataTask resume];
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
    }];
}

+ (RACSignal *)DELETE:(NSString *)endpoint parameters:(id)parameters headers:(NSDictionary *)headers {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *dataTask = [[self shared].sessionManager DELETE:endpoint parameters:parameters headers:headers success:^(NSURLSessionDataTask *task, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];
        [dataTask resume];
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
    }];
}

+ (RACSignal *)HEAD:(NSString *)endpoint parameters:(id)parameters headers:(NSDictionary *)headers {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *dataTask = [[self shared].sessionManager HEAD:endpoint parameters:parameters headers:headers success:^(NSURLSessionDataTask *task) {
            [subscriber sendNext:nil];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];
        [dataTask resume];
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
    }];
}

+ (RACSignal *)PATCH:(NSString *)endpoint parameters:(id)parameters headers:(NSDictionary *)headers {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *dataTask = [[self shared].sessionManager PATCH:endpoint parameters:headers headers:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];
        [dataTask resume];
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
    }];
}


@end
