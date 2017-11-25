#import "FLXSBaseUIControl.h"
#import "FLXSUIUtils.h"
#import "FLXSEvent.h"

@implementation FLXSBaseUIControl {


}
- (id)getStyle:(NSString *)prop {
    if([self respondsToSelector:NSSelectorFromString(prop)])
        return [self valueForKey:prop];
    return nil;
}


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
//End FLXSIEventDispatcher methods


@end