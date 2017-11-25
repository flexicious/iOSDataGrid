#import "FLXSVersion.h"
#import "FLXSEvent.h"

@class FLXSFlexDataGrid;
@class FLXSPrintFlexDataGrid;

/**
	 * For Print Based Events.
	 */
@interface FLXSFlexDataGridPrintEvent : FLXSEvent
{
}

@property (nonatomic, weak) FLXSFlexDataGrid* grid;
@property (nonatomic, weak) FLXSPrintFlexDataGrid* printGrid;

- (id)initWithType:(NSString *)type andGrid:(FLXSFlexDataGrid *)grid andPrintGrid:(FLXSPrintFlexDataGrid *)printGrid andBubbles:(BOOL)bubbles andCancelable:(BOOL)cancelable;

+ (NSString*)BEFORE_PRINT;
+ (NSString*)BEFORE_PRINT_PROVIDER_SET;
+ (NSString*)AFTER_PRINT;
@end

