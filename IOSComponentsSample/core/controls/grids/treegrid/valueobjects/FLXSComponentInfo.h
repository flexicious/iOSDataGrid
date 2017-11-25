#import "FLXSVersion.h"

@class FLXSRowInfo;
@protocol FLXSIFlexDataGridCell;

@interface FLXSComponentInfo : NSObject
{
}

@property (nonatomic, weak) UIView<FLXSIFlexDataGridCell>* component;
@property (nonatomic, assign) float x;
@property (nonatomic, weak) FLXSRowInfo* row;
@property (nonatomic, assign) BOOL inCornerAreas;
@property (nonatomic, assign) BOOL useComponentPosition;

- (id)initWithCell:(UIView *)component andX:(float)x andRowInfo:(FLXSRowInfo *)row;
-(BOOL)isLocked;
-(BOOL)isRightLocked;
-(BOOL)isLeftLocked;
/**
		 * Returns true if we are a data cell or if we area a chrome cell
		 * at a nest depth of greater than 1. These cells are all drawn in the
		 * content area, hence have to scroll
		 */
-(BOOL)isContentArea;
/**
		 *If left locked, returns X, if right locked returns leftLockedWidth+unlockedWidth+x
		 * if unlocked returns leftLockedX + x
		 */
-(float)perceivedX;
-(int)colIndex;

@end

