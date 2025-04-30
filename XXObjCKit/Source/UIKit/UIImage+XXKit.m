//
//  UIImage+XXKit.m
//  XXObjCKit
//
//  Created by 许亚光 on 2025/4/30.
//

#import "UIImage+XXKit.h"

@implementation UIImage (XXKit)

+ (UIImage *)xx_imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) {
        return nil;
    }
    
    UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:size];
    UIImage *image = [renderer imageWithActions:^(UIGraphicsImageRendererContext *context) {
        [color setFill];
        [context fillRect:CGRectMake(0, 0, size.width, size.height)];
    }];
    
    return image;
}

@end
