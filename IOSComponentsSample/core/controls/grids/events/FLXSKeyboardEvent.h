#import "FLXSVersion.h"

#import "FLXSEvent.h"


@interface FLXSKeyboardEvent : FLXSEvent
    -(id)initWithType:(NSString*)type andKey:(NSString *)keyCode andCancelable:(BOOL)cancelable andBubbles:(BOOL)bubbles;
    @property (nonatomic, strong) NSString* keyCode;

@end