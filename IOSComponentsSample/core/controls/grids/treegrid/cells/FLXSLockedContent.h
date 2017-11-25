#import "FLXSVersion.h"
@class FLXSFlexDataGrid;

/**
	 * Basically an extended UIComponent that manages the filter and footer cell visibility, heights, and the y positions
	 */
@interface FLXSLockedContent : UIScrollView
{

}

@property (nonatomic, weak) FLXSFlexDataGrid* grid;


-(id)initWithGrid:(FLXSFlexDataGrid*)grid;
-(void)placeSection;

@end

