//
//  UITableView+XXKit.m
//  XXObjCKit
//
//  Created by 许亚光 on 2025/4/30.
//

#import "UITableView+XXKit.h"

@implementation UITableView (XXKit)

- (void)xx_registerCellClass:(Class)cellClass {
    [self registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
}

- (__kindof UITableViewCell *)dequeueReusableCellWithCellClass:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath {
    [self dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass) forIndexPath:indexPath];
}


@end
