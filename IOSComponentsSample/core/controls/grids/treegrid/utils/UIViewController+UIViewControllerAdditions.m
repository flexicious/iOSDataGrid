//
// Created by FLEXICIOUS-MAC on 7/8/13.
// Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "UIViewController+UIViewControllerAdditions.h"
#import "FLXSEvent.h"
#import "FLXSUIUtils.h"


@implementation UIViewController (UIViewControllerAdditions)


//Start FLXSIEventDispatcher methods

- (void)addEventListener:(NSString *)type target:(NSObject *)target handler:(SEL)handler {
    [FLXSUIUtils addEventListenerOfType:type
                       withTarget:target
                       andHandler:handler
                        andSender:self];
}
-(void)removeEventListenerOfType:(NSString *)type fromTarget:(NSObject *)target usingHandler:(SEL)handler {
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