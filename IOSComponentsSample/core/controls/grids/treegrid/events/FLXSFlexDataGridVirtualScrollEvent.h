#import "FLXSVersion.h"
#import "FLXSEvent.h"

@class FLXSFlexDataGrid;

/**
	 * For Virtual scroll enabled grids
	 */
@interface FLXSFlexDataGridVirtualScrollEvent : FLXSEvent
{
}

@property (nonatomic, weak) FLXSFlexDataGrid* grid;
@property (nonatomic, weak) NSArray* recordsToLoad;

- (id)initWithType:(NSString *)type andGrid:(FLXSFlexDataGrid *)grid andRecordsToLoad:(NSArray *)recordsToLoad andBubbles:(BOOL)bubbles andCancelable:(BOOL)cancelable;

+ (NSString*)VIRTUAL_SCROLL;
@end

