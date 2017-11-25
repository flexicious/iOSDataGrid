#import "FLXSKeyboardEvent.h"


@implementation FLXSKeyboardEvent
    @synthesize keyCode;

    -(id)initWithType:(NSString*)type andKey:(NSString *)keyCodeIn andCancelable:(BOOL)cancelable andBubbles:(BOOL)bubbles{
        self = [super initWithType:type
                     andCancelable:cancelable
                        andBubbles:bubbles];
        if (self)
        {
            self.keyCode =      keyCodeIn;
        }
        return self;
    }

@end