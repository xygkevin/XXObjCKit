//
//  UITableViewCell+XXKit.m
//  XXObjCKit
//
//  Created by 许亚光 on 2025/4/30.
//

#import "UITableViewCell+XXKit.h"

@implementation UITableViewCell (XXKit)

- (UITableView *)xx_tableView {
    UIResponder *responder = self;
    while (responder && ![responder isKindOfClass:[UITableView class]]) {
        responder = responder.nextResponder;
    }
    return (UITableView *)responder;
}

- (NSIndexPath *)xx_indexPath {
    UITableView *tableView = self.xx_tableView;
    if (!tableView) return nil;
    return [tableView indexPathForCell:self];
}

@end
