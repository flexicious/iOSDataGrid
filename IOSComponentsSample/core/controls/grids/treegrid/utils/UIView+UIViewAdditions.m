//
//  UIViewAdditions.m
//  Weibo
//
//  Created by junmin liu on 10-9-29.
//  Copyright 2010 Openlab. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UIView+UIViewAdditions.h"
#import "FLXSEvent.h"
#import "FLXSUIUtils.h"


@implementation UIView (Addtions)



///////////////////////////////////////////////////////////////////////////////////////////////////
- (float)x {
    return self.frame.origin.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setX:(float)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;

}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (float)y {
    return self.frame.origin.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setY:(float)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (float)right {
    return self.frame.origin.x + self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setRight:(float)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (float)bottom {
    return self.frame.origin.y + self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setBottom:(float)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (float)centerX {
    return self.center.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterX:(float)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (float)centerY {
    return self.center.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterY:(float)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (float)width {
    return self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setWidth:(float)width {

    if(width==0)width=1;
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
    FLXSEvent* evt1 = [[FLXSEvent alloc] init];
    evt1.target = self;
    evt1.type = [FLXSEvent RESIZE];
    [self dispatchEvent:evt1];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (float)height {
    return self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHeight:(float)height {
    if(height==0)height=1;
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
    FLXSEvent* evt1 = [[FLXSEvent alloc] init];
    evt1.target = self;
    evt1.type = [FLXSEvent RESIZE];
    [self dispatchEvent:evt1];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (float)ttScreenX {
    float x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.x;
    }
    return x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (float)ttScreenY {
    float y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.y;
    }
    return y;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (float)screenViewX {
    float x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.x;

        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }

    return x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (float)screenViewY {
    float y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.y;

        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGRect)screenFrame {
    return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)origin {
    return self.frame.origin;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)size {
    return self.frame.size;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}




///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)descendantOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls])
        return self;

    for (UIView* child in self.subviews) {
        UIView* it = [child descendantOrSelfWithClass:cls];
        if (it)
            return it;
    }

    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)ancestorOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls]) {
        return self;
    } else if (self.superview) {
        return [self.superview ancestorOrSelfWithClass:cls];
    } else {
        return nil;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (void)setActualSizeWithWidth:(float)width andHeight:(float)height {
    CGRect frame = self.frame;
    frame.size.width = width;
    frame.size.height = height;
    self.frame = frame;
    FLXSEvent* evt1 = [[FLXSEvent alloc] init];
    evt1.target = self;
    evt1.type = [FLXSEvent RESIZE];
    [self dispatchEvent:evt1];
}

- (void)moveToX:(float)x y:(float)y {
    CGRect frame = self.frame;
    frame.origin.x = x;
    frame.origin.y = y;

    self.frame = frame;
}

- (id)getStyle:(NSString *)prop {
    if([self respondsToSelector:NSSelectorFromString(prop)])
        return [self valueForKey:prop];
    return nil;
}

- (void)setStyle:(NSString *)prop value:(id)value {
    if([self respondsToSelector:NSSelectorFromString(prop)])
        [self setValue:value forKey:prop];
}

- (CGPoint )localToGlobal:(CGPoint )point{
    CGPoint globalPoint = [[[UIApplication sharedApplication] keyWindow] convertPoint:point fromView:self];
    return globalPoint;
}
- (CGPoint )globalToLocal:(CGPoint  )point{
    CGPoint localPoint = [self convertPoint:point fromView:[[UIApplication sharedApplication] keyWindow]];
    return localPoint;
}
- (CGPoint )globalToContent:(CGPoint  )point{
    CGPoint localPoint = [self convertPoint:point fromView:[[UIApplication sharedApplication] keyWindow]];
    return localPoint;
}
- (void)addChild:(UIView*)child{
    [self addSubview:child];
}

- (BOOL)owns:(UIView*)child{
    if(child.superview==self)return YES;
    else{
        for (UIView* otherChild in self.subviews) {
            BOOL it = [otherChild owns:child];
            if (it)
                return it;
        }

    }
    return NO;

}
-(void)validateNow{
    [[self layer] display];
}
//Start FLXSIEventDispatcher methods

- (void)addEventListenerOfType:(NSString *)type usingTarget:(NSObject *)target withHandler:(SEL)handler {
    [FLXSUIUtils addEventListenerOfType:type
                       withTarget:target
                       andHandler:handler
                        andSender:self];
}

- (void)removeEventListenerOfType:(NSString *)type fromTarget:(NSObject *)target usingHandler:(SEL)handler {
    [FLXSUIUtils removeEventListener:type
                          withTarget:target
                          andHandler:handler
                           andSender:self];
}
-(void)dispatchEvent:(FLXSEvent *)event {
    [FLXSUIUtils dispatchEvent:event
                    withSender:self];
}

@end
