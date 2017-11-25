#import "FLXSVersion.h"
@class FLXSFlexDataGrid;

#import "FLXSGridBackground.h"

/**
	 * @author Flexicious
	 * Attaches to the owner component (which is the bodyContainer) and scrolls vertically along with it.
	 * The horizontal scroll of this component is set to off)
	 */
@interface FLXSElasticContainer : UIScrollView
{
}

@property (nonatomic, weak) UIScrollView* boundContainer;
/**
		 * The grid that we belong to
		 */
@property (nonatomic, weak) FLXSFlexDataGrid* grid;
/**
		 * @private
		 */
@property (nonatomic, weak) FLXSGridBackground* backgroundForFillerRows;

@property (nonatomic, strong) NSString* horizontalScrollPolicy;
@property (nonatomic, strong) NSString* verticalScrollPolicy;



-(id)initWithGrid:(FLXSFlexDataGrid*)grid;
/**
		 * @private
		 */
-(void)setBackgroundFillerSize;

@end

