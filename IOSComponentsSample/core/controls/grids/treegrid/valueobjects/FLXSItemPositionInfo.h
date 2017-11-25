#import "FLXSVersion.h"
@class FLXSFlexDataGridColumnLevel;
/**
	 *A class that stores information about what page an
	 * item exists on, at what level.
	 */

@interface FLXSItemPositionInfo : NSObject
{
}

@property (nonatomic, weak) FLXSFlexDataGridColumnLevel* level;
@property (nonatomic, assign) float pageIndex;
@property (nonatomic, assign) float itemIndex;
@property (nonatomic, weak) NSObject* item;

- (id)initWithItem:(NSObject *)item andLevel:(FLXSFlexDataGridColumnLevel *)level andPageIndex:(int)pageIndex andItemIndex:(float)itemindex;

@end

