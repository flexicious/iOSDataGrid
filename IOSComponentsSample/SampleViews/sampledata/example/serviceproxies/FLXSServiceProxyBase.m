#import "FLXSServiceProxyBase.h"
#import "FLXSDemoVersion.h"
#import <objc/message.h>
@implementation FLXSServiceProxyBase


-(void)callServiceMethod:(NSObject*)token :(SEL)resultFunction :(NSObject *)target
{
    [NSTimer scheduledTimerWithTimeInterval:2
                                     target:self
                                   selector:@selector(onTimer:)
                                   userInfo:nil
                                    repeats:NO];
    if(!self.messageQueue){
        self.messageQueue = [[NSMutableArray alloc] init];
    }
    [self.messageQueue push:[[NSMutableArray alloc] initWithObjects:token,[NSValue valueWithPointer:resultFunction],target,nil] ];
}

-(void)onTimer:(NSTimer*)sdr{
   NSArray *msg = [self.messageQueue pop];
    NSObject * result = [msg objectAtIndex:0];
    SEL selector = [[msg objectAtIndex:1] pointerValue];
    NSObject * target = [msg objectAtIndex:2];

    void (*response)(id,SEL,NSObject*) = (void (*)(id,SEL,NSObject*) ) objc_msgSend;
    response(target,selector, result);


   // objc_msgSend(target,selector,result);
}
@end

