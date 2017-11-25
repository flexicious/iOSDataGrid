#import "FLXSVersion.h"

#import <Foundation/Foundation.h>
#import "FLXSEvent.h"
@protocol FLXSIEventDispatcher <NSObject>

-(void)dispatchEvent:(FLXSEvent *)event;

- (void)addEventListenerOfType:(NSString *)type usingTarget:(NSObject *)target withHandler:(SEL)handler;
-(void)removeEventListenerOfType:(NSString *)type fromTarget:(NSObject *)target usingHandler:(SEL)handler;
@end