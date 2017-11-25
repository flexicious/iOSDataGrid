#import "FLXSVersion.h"
@interface FLXSEvent : NSObject

-(id)initWithType:(NSString*)type ;
-(id)initWithType:(NSString*)type andCancelable:(BOOL)cancelable andBubbles:(BOOL)bubbles;
-(void)preventDefault ;

@property (nonatomic, weak) UIResponder* target;
    @property (nonatomic, strong) NSString* type;
    @property (nonatomic, assign) BOOL bubbles;
    @property (nonatomic, assign) BOOL cancelable;
    @property (nonatomic, assign) BOOL isDefaultPrevented;

+ (NSString *)EVENT_KEY_UP;
+ (NSString *)EVENT_CHANGE;
+ (NSString *)EVENT_DELAYED_CHANGE;
+ (NSString *)RESIZE;
+ (NSString *)DICTIONARY_KEY;


@end

