#import "FLXSVersion.h"
#import "FLXSFlexDataGridCell.h"

@protocol FLXSIExpandCollapseComponent;
@protocol FLXSIFlexDataGridCell;

/**
	 * @inheritDoc
	 */
@interface FLXSFlexDataGridExpandCollapseCell : FLXSFlexDataGridCell
{

}

@property (nonatomic, assign) BOOL hasChildren;
@property (nonatomic, assign) BOOL open;
@property (nonatomic, assign) BOOL forceRightLock;
@property (nonatomic, assign) int colSpan;
@property (nonatomic, assign) int rowSpan;
@property (nonatomic, readonly) UIImageView * expandCollapseImageView;

-(UIView<FLXSIExpandCollapseComponent>*)iExpandCollapseComponent;
+ (NSString*)EVENT_EXPAND_COLLAPSE;
@end

