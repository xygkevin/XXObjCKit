//
//  ViewController.m
//  XXObjCKit
//
//  Created by 许亚光 on 2025/4/29.
//

#import "ViewController.h"
#import "XXNetworkMonitor.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XXNetworkMonitor *monitor = [XXNetworkMonitor shared];
    RACSignal *signal = monitor.networkTypeSignal;
    [[[signal skipWhileBlock:^BOOL(NSNumber *status) {
        return status.integerValue == XXNetworkStatusUnknown;
    }] distinctUntilChanged] subscribeNext:^(NSNumber *type) {
        self.statusLabel.text = [NSString stringWithFormat:@"%@\n%@\n%@",
                                 monitor.statusDisplayName,
                                 monitor.typeDisplayName,
                                 monitor.unreachableReason ?:@""];
        NSLog(@"%@", monitor.typeDisplayName);
    }];
    
}


@end
