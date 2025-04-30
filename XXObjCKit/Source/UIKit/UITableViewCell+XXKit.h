//
//  UITableViewCell+XXKit.h
//  XXObjCKit
//
//  Created by 许亚光 on 2025/4/30.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (XXKit)

@property (nonatomic, strong, readonly) UITableView *xx_tableView;
@property (nonatomic, strong, readonly) NSIndexPath *xx_indexPath;

@end

