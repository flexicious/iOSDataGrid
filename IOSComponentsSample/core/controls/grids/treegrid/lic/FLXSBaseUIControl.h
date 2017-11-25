#import "FLXSVersion.h"
@class FLXSEvent;

@interface FLXSBaseUIControl : UIControl



//FLXSIEventDispatcher methods
-(void)dispatchEvent:(FLXSEvent *)event;

- (void)addEventListener:(NSString *)type target:(NSObject *)target handler:(SEL)handler;
-(void)removeEventListenerOfType:(NSString *)type fromTarget:(NSObject *)target usingHandler:(SEL)handler;
//End FLXSIEventDispatcher methods


@end