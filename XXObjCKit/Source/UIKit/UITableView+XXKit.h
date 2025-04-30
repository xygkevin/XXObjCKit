//
//  UITableView+XXKit.h
//  XXObjCKit
//
//  Created by 许亚光 on 2025/4/30.
//

#import <UIKit/UIKit.h>

@interface UITableView (XXKit)

- (void)xx_registerCellClass:(Class)cellClass;
- (__kindof UITableViewCell *)dequeueReusableCellWithCellClass:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath;

@end

