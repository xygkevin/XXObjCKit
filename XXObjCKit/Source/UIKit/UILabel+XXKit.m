//
//  UILabel+XXKit.m
//  XXObjCKit
//
//  Created by 许亚光 on 2025/4/30.
//

#import "UILabel+XXKit.h"

@implementation UILabel (XXKit)

+ (UILabel *)xx_labelWithFont:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSUInteger)numberOfLines {
    UILabel *label = [UILabel new];
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.numberOfLines = numberOfLines;
    return label;
}

@end
