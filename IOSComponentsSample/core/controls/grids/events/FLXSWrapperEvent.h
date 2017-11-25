#import "FLXSEvent.h"
#import "FLXSVersion.h"

@interface FLXSWrapperEvent : FLXSEvent
{
	@public
		NSObject* data;
}

@property (nonatomic, strong) NSObject* data;

- (id)initWithType:(NSString *)type andData:(NSObject *)data andBubbles:(BOOL)bubbles andCancelable:(BOOL)cancelable;
-(FLXSEvent *)clone;

@end

