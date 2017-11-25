#import "FLXSVersion.h"

@class FLXSEvent;

@interface UIViewController (UIViewControllerAdditions)
- (void)addEventListener:(NSString *)type target:(NSObject *)target handler:(SEL)handler;
-(void)removeEventListenerOfType:(NSString *)type fromTarget:(NSObject *)target usingHandler:(SEL)handler ;
-(void)dispatchEvent:(FLXSEvent *)event;
@end