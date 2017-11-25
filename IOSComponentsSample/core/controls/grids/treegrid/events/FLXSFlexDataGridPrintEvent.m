#import "FLXSFlexDataGridPrintEvent.h"
#import "FLXSPrintFlexDataGrid.h"

static const NSString* BEFORE_PRINT = @"beforePrint";
static const NSString* BEFORE_PRINT_PROVIDER_SET = @"beforePrintProviderSet";
static const NSString* AFTER_PRINT = @"printComplete";

@implementation FLXSFlexDataGridPrintEvent

@synthesize grid;
@synthesize printGrid;

- (id)initWithType:(NSString *)type
           andGrid:(FLXSFlexDataGrid *)gridIn
      andPrintGrid:(FLXSPrintFlexDataGrid *)printGridIn
        andBubbles:(BOOL)bubbles
     andCancelable:(BOOL)cancelable {
	self = [super initWithType:type
                 andCancelable:cancelable
                    andBubbles:bubbles
            ];
	if (self)
	{
		self.grid=gridIn;
		self.printGrid=printGridIn;
	}
	return self;
}


+ (NSString*)BEFORE_PRINT
{
	return [BEFORE_PRINT description];
}
+ (NSString*)BEFORE_PRINT_PROVIDER_SET
{
	return [BEFORE_PRINT_PROVIDER_SET description];
}
+ (NSString*)AFTER_PRINT
{
	return [AFTER_PRINT description];
}
@end

