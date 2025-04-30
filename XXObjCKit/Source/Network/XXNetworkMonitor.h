//
//  XXNetworkMonitor.h
//  XXObjCKit
//
//  Created by 许亚光 on 2025/4/29.
//

/**
 网络状态监听器
 
 实现原理:
 使用系统 Network 框架 nw_path_monitor_t 实现监听;
 
 使用方式:
 1.调用 [[XXNetworkMonitor shared] startMonitoring] 开始监听变换;
 2.可以通过 通知/Block/RAC订阅信号/代理 四种方式获取实时状态变化
 
 */

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

/// 通知名称
FOUNDATION_EXTERN NSNotificationName const XXNetworkReachableDidChangeNotificationName;
FOUNDATION_EXTERN NSNotificationName const XXNetworkStatusDidChangeNotificationName;
FOUNDATION_EXTERN NSNotificationName const XXNetworkTypeDidChangeNotificationName;


/// 网络状态
typedef NS_ENUM(NSUInteger, XXNetworkStatus) {
    /// 未知
    XXNetworkStatusUnknown,
    /// 不可用
    XXNetworkStatusNotReachable,
    /// 无线网络
    XXNetworkStatusReachableWiFi,
    /// 蜂窝网络
    XXNetworkStatusReachableWWAN,
    /// 有线以太网
    XXNetworkStatusReachableEthernet,
    /// 局域网
    XXNetworkStatusReachableLoopback,
    /// 其它
    XXNetworkStatusReachableOther
};

/// 网络类型
typedef NS_ENUM(NSUInteger, XXNetworkType) {
    /// 未知
    XXNetworkTypeUnknown,
    /// WiFi
    XXNetworkTypeWiFi,
    /// 蜂窝5G
    XXNetworkTypeCellular5G,
    /// 蜂窝4G
    XXNetworkTypeCellular4G,
    /// 蜂窝3G
    XXNetworkTypeCellular3G,
    /// 蜂窝2G
    XXNetworkTypeCellular2G,
    /// 有线
    XXNetworkTypeEthernet,
    /// 局域网
    XXNetworkTypeLoopback,
    /// 其它
    XXNetworkTypeOther
};

@class XXNetworkMonitor;
/// 代理
@protocol XXNetworkMonitorDelegate <NSObject>
@optional
- (void)networkMonitor:(XXNetworkMonitor *)monitor reachableDidChanged:(BOOL)reachable;
- (void)networkMonitor:(XXNetworkMonitor *)monitor statusDidChanged:(XXNetworkStatus)status;
- (void)networkMonitor:(XXNetworkMonitor *)monitor typeDidChanged:(XXNetworkType)type;
@end

@interface XXNetworkMonitor : NSObject

/// 监听状态
@property (nonatomic, assign, readonly) BOOL isMonitoring;
/// 当前网络状态
@property (nonatomic, assign, readonly) XXNetworkStatus networkStatus;
/// 当前网络类型
@property (nonatomic, assign, readonly) XXNetworkType networkType;
/// 是否可以访问网络
@property (nonatomic, assign, readonly) BOOL reachable;
/// 当前网络状态描述
@property (nonatomic, copy, readonly) NSString *statusDisplayName;
/// 当前网络类型描述
@property (nonatomic, copy, readonly) NSString *typeDisplayName;
/// 网络不可用原因
@property (nonatomic, copy, readonly) NSString *unreachableReason;
/// 是否链接了无线网络
@property (nonatomic, assign, readonly) BOOL isConnectedWiFi;
/// 是否链接了蜂窝网络
@property (nonatomic, assign, readonly) BOOL isConnectedWWAN;
/// 是否链接了有线以太网络
@property (nonatomic, assign, readonly) BOOL isConnectedEthernet;
/// 是否链接了局域网
@property (nonatomic, assign, readonly) BOOL isConnectedLoopback;
/// 是否连接了VPN
@property (nonatomic, assign, readonly) BOOL isConnectedVPN;
/// 是否链接了其它网络
@property (nonatomic, assign, readonly) BOOL isConnectedOther;
/// 是否是昂贵的
@property (nonatomic, assign, readonly) BOOL isExpensive;
/// 是否是受限制访问如低数据模式等
@property (nonatomic, assign, readonly) BOOL isConstrained;
/// 是否支持IPv4
@property (nonatomic, assign, readonly) BOOL isSupportsIPv4;
/// 是否支持IPv6
@property (nonatomic, assign, readonly) BOOL isSupportsIPv6;
/// 是否支持DNS
@property (nonatomic, assign, readonly) BOOL isSupportsDNS;

/// 网络状态Block回调
@property (nonatomic, copy) void(^networkReachableDidChangeHandler)(BOOL reachable);
@property (nonatomic, copy) void(^networkStatusDidChangeHandler)(XXNetworkStatus status);
@property (nonatomic, copy) void(^networkTypeDidChangeHandler)(XXNetworkType status);

/// 网络状态变化信号
@property (nonatomic, strong, readonly) RACBehaviorSubject<NSNumber *> *networkReachableSignal;
@property (nonatomic, strong, readonly) RACBehaviorSubject<NSNumber *> *networkStatusSignal;
@property (nonatomic, strong, readonly) RACBehaviorSubject<NSNumber *> *networkTypeSignal;

/// 监听类实例对象
+ (instancetype)shared;

/// 开始监听网络连接变化
- (void)startMonitoring;

/// 停止监听网络连接变化
- (void)stopMonitoring;

/// 添加代理
- (void)addDelegate:(id<XXNetworkMonitorDelegate>)delegate;

/// 移除代理
- (void)removeDelegate:(id<XXNetworkMonitorDelegate>)delegate;

/// 移除全部代理
- (void)removeAllDelagate;

/// 禁用系统初始化方法
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;

@end

