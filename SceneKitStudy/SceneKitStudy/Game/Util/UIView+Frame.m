//
//  UIView+Frame.m
//  MoneyScrollAnimationKit
//
//  Created by prince on 2017/12/12.
//  Copyright © 2017年 tencent. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)centerX{
    return self.center.x;
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)width{
    return self.bounds.size.width;
}

- (CGFloat)height{
    return self.bounds.size.height;
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(void)setLeft:(CGFloat)left{
    self.x = left;
}

-(void)setRight:(CGFloat)right{
    self.x = right - self.width;
}

-(void)setTop:(CGFloat)top{
    self.y = top;
}

-(void)setBottom:(CGFloat)bottom{
    self.y = bottom - self.height;
}

-(CGFloat)left{
    return self.x;
}

-(CGFloat)right{
    return self.x + self.width;
}

-(CGFloat)top{
    return self.y;
}

-(CGFloat)bottom{
    return self.y + self.height;
}

@end
