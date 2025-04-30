//
//  XXNetworkMonitor.m
//  XXObjCKit
//
//  Created by 许亚光 on 2025/4/29.
//

#import "XXNetworkMonitor.h"
#import <Network/Network.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <ifaddrs.h>
#import <net/if.h>

NSNotificationName const XXNetworkReachableDidChangeNotificationName = @"XXNetowrkReachableDidChangeNotificationName";
NSNotificationName const XXNetworkStatusDidChangeNotificationName = @"XXNetowrkStatusDidChangeNotificationName";
NSNotificationName const XXNetworkTypeDidChangeNotificationName = @"XXNetowrkTypeDidChangeNotificationName";

@interface XXNetworkMonitor ()

@property (nonatomic, strong) nw_path_monitor_t monitor;
@property (nonatomic, strong) nw_path_t path;

@property (nonatomic, assign) XXNetworkStatus networkStatus;
@property (nonatomic, assign) XXNetworkType networkType;
@property (nonatomic, assign) BOOL isMonitoring;
@property (nonatomic, assign) BOOL reachable;
@property (nonatomic, strong) NSHashTable<id<XXNetworkMonitorDelegate>> *delegates;

@property (nonatomic, strong) RACBehaviorSubject<NSNumber *> *networkReachableSignal;
@property (nonatomic, strong) RACBehaviorSubject<NSNumber *> *networkStatusSignal;
@property (nonatomic, strong) RACBehaviorSubject<NSNumber *> *networkTypeSignal;


@end

@implementation XXNetworkMonitor

+ (instancetype)shared {
    static XXNetworkMonitor *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
        _instance.delegates = [NSHashTable weakObjectsHashTable];
        
        _instance.networkReachableSignal = [RACBehaviorSubject behaviorSubjectWithDefaultValue:@(NO)];
        _instance.networkStatusSignal = [RACBehaviorSubject behaviorSubjectWithDefaultValue:@(XXNetworkStatusUnknown)];
        _instance.networkTypeSignal = [RACBehaviorSubject behaviorSubjectWithDefaultValue:@(XXNetworkTypeUnknown)];

        dispatch_queue_t queue = dispatch_queue_create("network_monitor_queue", DISPATCH_QUEUE_PRIORITY_DEFAULT);
        nw_path_monitor_t monitor = nw_path_monitor_create();
        nw_path_monitor_set_queue(monitor, queue);
        nw_path_monitor_set_update_handler(monitor, ^(nw_path_t path) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [_instance updatePath:path];
            });
        });
        nw_path_monitor_set_cancel_handler(monitor, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                _instance.path = nil;
                _instance.reachable = NO;
                _instance.networkStatus = XXNetworkStatusUnknown;
                _instance.networkType = XXNetworkTypeUnknown;
                [_instance sendNext];
            });
        });
        _instance.monitor = monitor;
    });
    return _instance;
}

- (void)updatePath:(nw_path_t)path {
    self.path = path;
    nw_path_status_t status = nw_path_get_status(path);
    switch (status) {
        case nw_path_status_satisfied: {
            self.reachable = YES;
            self.networkStatus = [self fetchNetworkStatusWithPath:path];
            self.networkType = [self fetchNetworkTypeWithPath:path];
        } break;
        case nw_path_status_invalid:
        case nw_path_status_unsatisfied:
        case nw_path_status_satisfiable: {
            self.reachable = NO;
            self.networkStatus = XXNetworkStatusNotReachable;
            self.networkType = XXNetworkTypeUnknown;
        } break;
    }
    [self sendNext];
}

- (void)sendNext {

    [self.networkReachableSignal sendNext:@(self.reachable)];
    [self.networkStatusSignal sendNext:@(self.networkStatus)];
    [self.networkTypeSignal sendNext:@(self.networkType)];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:XXNetworkReachableDidChangeNotificationName object:self userInfo:@{@"reachable":@(self.reachable)}];
    [[NSNotificationCenter defaultCenter] postNotificationName:XXNetworkStatusDidChangeNotificationName object:self userInfo:@{@"status":@(self.networkStatus)}];
    [[NSNotificationCenter defaultCenter] postNotificationName:XXNetworkTypeDidChangeNotificationName object:self userInfo:@{@"type":@(self.networkType)}];
    
    if (self.networkReachableDidChangeHandler) {
        self.networkReachableDidChangeHandler(self.reachable);
    }
    if (self.networkStatusDidChangeHandler) {
        self.networkStatusDidChangeHandler(self.networkStatus);
    }
    if (self.networkTypeDidChangeHandler) {
        self.networkTypeDidChangeHandler(self.networkType);
    }
    
    for (id<XXNetworkMonitorDelegate> delegate in self.delegates) {
        if ([delegate respondsToSelector:@selector(networkMonitor:reachableDidChanged:)]) {
            [delegate networkMonitor:self reachableDidChanged:self.reachable];
        }
        if ([delegate respondsToSelector:@selector(networkMonitor:statusDidChanged:)]) {
            [delegate networkMonitor:self reachableDidChanged:self.networkStatus];
        }
        if ([delegate respondsToSelector:@selector(networkMonitor:typeDidChanged:)]) {
            [delegate networkMonitor:self typeDidChanged:self.networkType];
        }
    }
}

- (XXNetworkStatus)fetchNetworkStatusWithPath:(nw_path_t)path {
    if (nw_path_uses_interface_type(path, nw_interface_type_wifi)) {
        return XXNetworkStatusReachableWiFi;
    } else if (nw_path_uses_interface_type(path, nw_interface_type_cellular)) {
        return XXNetworkStatusReachableWWAN;
    } else if (nw_path_uses_interface_type(path, nw_interface_type_wired)) {
        return XXNetworkStatusReachableEthernet;
    } else if (nw_path_uses_interface_type(path, nw_interface_type_loopback)) {
        return XXNetworkStatusReachableLoopback;
    } else if (nw_path_uses_interface_type(path, nw_interface_type_other)) {
        return XXNetworkStatusReachableOther;
    }
    return XXNetworkStatusUnknown;
}

- (XXNetworkType)fetchNetworkTypeWithPath:(nw_path_t)path {
    if (nw_path_uses_interface_type(path, nw_interface_type_wifi)) {
        return XXNetworkTypeWiFi;
    } else if (nw_path_uses_interface_type(path, nw_interface_type_cellular)) {
        return [self fetchWWANDetail];
    } else if (nw_path_uses_interface_type(path, nw_interface_type_wired)) {
        return XXNetworkTypeEthernet;
    } else if (nw_path_uses_interface_type(path, nw_interface_type_loopback)) {
        return XXNetworkTypeLoopback;
    } else if (nw_path_uses_interface_type(path, nw_interface_type_other)) {
        return XXNetworkTypeOther;
    }
    return XXNetworkTypeUnknown;
}

- (XXNetworkType)fetchWWANDetail {
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    NSDictionary *radioDic = networkInfo.serviceCurrentRadioAccessTechnology;
    NSString *dataServiceIdentifier = networkInfo.dataServiceIdentifier;
    NSString *currentRadioAccessTechnology = radioDic[dataServiceIdentifier];
    if (currentRadioAccessTechnology) {
        NSArray *typeStrings2G = @[CTRadioAccessTechnologyEdge,
                                   CTRadioAccessTechnologyGPRS,
                                   CTRadioAccessTechnologyCDMA1x];
        NSArray *typeStrings3G = @[CTRadioAccessTechnologyHSDPA,
                                   CTRadioAccessTechnologyWCDMA,
                                   CTRadioAccessTechnologyHSUPA,
                                   CTRadioAccessTechnologyCDMAEVDORev0,
                                   CTRadioAccessTechnologyCDMAEVDORevA,
                                   CTRadioAccessTechnologyCDMAEVDORevB,
                                   CTRadioAccessTechnologyeHRPD];
        NSArray *typeStrings4G = @[CTRadioAccessTechnologyLTE];
        NSArray *typeStrings5G = @[];
        if (@available(iOS 14.1, *)) {
            typeStrings5G = @[CTRadioAccessTechnologyNRNSA,
                              CTRadioAccessTechnologyNR];
        }
        if ([typeStrings5G containsObject:currentRadioAccessTechnology]) {
            return XXNetworkTypeCellular5G;
        } else if ([typeStrings4G containsObject:currentRadioAccessTechnology]) {
            return XXNetworkTypeCellular4G;
        } else if ([typeStrings3G containsObject:currentRadioAccessTechnology]) {
            return XXNetworkTypeCellular3G;
        } else if ([typeStrings2G containsObject:currentRadioAccessTechnology]) {
            return XXNetworkTypeCellular2G;
        } else {
            return XXNetworkTypeUnknown;
        }
    } else {
        return XXNetworkTypeUnknown;
    }
}

- (void)startMonitoring {
    if (self.isMonitoring) return;
    nw_path_monitor_start(self.monitor);
    self.isMonitoring = YES;
}

- (void)stopMonitoring {
    if (!self.isMonitoring) return;
    nw_path_monitor_cancel(self.monitor);
    self.isMonitoring = NO;
}

- (BOOL)isConnectedWiFi {
    if (!self.path) return NO;
    __block BOOL result = NO;
    nw_path_enumerate_interfaces(self.path, ^bool(nw_interface_t interface) {
        nw_interface_type_t type = nw_interface_get_type(interface);
        if (type == nw_interface_type_wifi) {
            result = YES;
            return false;
        }
        return true;
    });
    return result;
}

- (BOOL)isConnectedWWAN {
    if (!self.path) return NO;
    __block BOOL result = NO;
    nw_path_enumerate_interfaces(self.path, ^bool(nw_interface_t interface) {
        nw_interface_type_t type = nw_interface_get_type(interface);
        if (type == nw_interface_type_cellular) {
            result = YES;
            return false;
        }
        return true;
    });
    return result;
}

- (BOOL)isConnectedEthernet {
    if (!self.path) return NO;
    __block BOOL result = NO;
    nw_path_enumerate_interfaces(self.path, ^bool(nw_interface_t interface) {
        nw_interface_type_t type = nw_interface_get_type(interface);
        if (type == nw_interface_type_wired) {
            result = YES;
            return false;
        }
        return true;
    });
    return result;
}

- (BOOL)isConnectedLoopback {
    if (!self.path) return NO;
    __block BOOL result = NO;
    nw_path_enumerate_interfaces(self.path, ^bool(nw_interface_t interface) {
        nw_interface_type_t type = nw_interface_get_type(interface);
        if (type == nw_interface_type_loopback) {
            result = YES;
            return false;
        }
        return true;
    });
    return result;
}

- (BOOL)isConnectedVPN {
    struct ifaddrs *interfaces = NULL;
    BOOL vpnConnected = NO;
    if (getifaddrs(&interfaces) == 0) {
        struct ifaddrs *temp = interfaces;
        while (temp != NULL) {
            NSString *name = [NSString stringWithUTF8String:temp->ifa_name];
            if ([name hasPrefix:@"utun"] || [name hasPrefix:@"ppp"]) {
                vpnConnected = YES;
                break;
            }
            temp = temp->ifa_next;
        }
        freeifaddrs(interfaces);
    }
    return vpnConnected;
}

- (BOOL)isConnectedOther {
    if (!self.path) return NO;
    __block BOOL result = NO;
    nw_path_enumerate_interfaces(self.path, ^bool(nw_interface_t interface) {
        nw_interface_type_t type = nw_interface_get_type(interface);
        if (type == nw_interface_type_other) {
            result = YES;
            return false;
        }
        return true;
    });
    return result;
}

- (BOOL)isExpensive {
    if (!self.path) return NO;
    return nw_path_is_expensive(self.path);
}

- (BOOL)isConstrained {
    if (!self.path) return NO;
    return nw_path_is_constrained(self.path);
}

- (BOOL)isSupportsIPv4 {
    if (!self.path) return NO;
    return nw_path_has_ipv4(self.path);
}

- (BOOL)isSupportsIPv6 {
    if (!self.path) return NO;
    return nw_path_has_ipv6(self.path);
}

- (BOOL)isSupportsDNS {
    return nw_path_has_dns(self.path);
}

- (NSString *)statusDisplayName {
    switch (self.networkStatus) {
        case XXNetworkStatusUnknown:
            return @"当前网络连接未知";
        case XXNetworkStatusNotReachable:
            return @"当前网络链接已断开";
        case XXNetworkStatusReachableWiFi:
            return @"当前使用无线网络";
        case XXNetworkStatusReachableWWAN:
            return @"当前使用蜂窝网络";
        case XXNetworkStatusReachableEthernet:
            return @"当前使用有线网络";
        case XXNetworkStatusReachableLoopback:
            return @"当前使用本地回路";
        case XXNetworkStatusReachableOther:
            return @"当前使用其他网络";
    }
}

- (NSString *)typeDisplayName {
    switch (self.networkType) {
        case XXNetworkTypeUnknown:
            if (self.reachable) {
                return @"未知";
            } else {
                return @"无";
            }
        case XXNetworkTypeWiFi:
            return @"WiFi";
        case XXNetworkTypeCellular5G:
            return @"5G";
        case XXNetworkTypeCellular4G:
            return @"4G";
        case XXNetworkTypeCellular3G:
            return @"3G";
        case XXNetworkTypeCellular2G:
            return @"2G";
        case XXNetworkTypeEthernet:
            return @"以太网";
        case XXNetworkTypeLoopback:
            return @"局域网";
        case XXNetworkTypeOther:
            return @"其它";
    }
}

- (NSString *)unreachableReason {
    if (!self.path) return nil;
    if (nw_path_get_status(self.path) == nw_path_status_unsatisfied) {
        nw_path_unsatisfied_reason_t reason = nw_path_get_unsatisfied_reason(self.path);
        switch (reason) {
            case nw_path_unsatisfied_reason_not_available:
                return @"网络不可用(可能是关闭了所有网络连接或者当前无信号)";
            case nw_path_unsatisfied_reason_cellular_denied:
                return @"蜂窝网络访问受限(可能是用户在应用网络访问设置中关闭了蜂窝网络的访问权限)";
            case nw_path_unsatisfied_reason_wifi_denied:
                return @"无线网络访问受限(可能是用户在应用网络访问设置中关闭了无线网络的访问权限)";
            case nw_path_unsatisfied_reason_local_network_denied:
                return @"局域网络访问受限(可能是用户未允许应用使用本地网络)";
            case nw_path_unsatisfied_reason_vpn_inactive:
                return @"VPN网络访问受限";
        }
    }
    return nil;
}

- (void)addDelegate:(id<XXNetworkMonitorDelegate>)delegate {
    [self.delegates addObject:delegate];
}

- (void)removeDelegate:(id<XXNetworkMonitorDelegate>)delegate {
    [self.delegates removeObject:delegate];
}

- (void)removeAllDelagate {
    [self.delegates removeAllObjects];
}

@end
