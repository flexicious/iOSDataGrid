#import "FLXSVersion.h"
#import "FLXSFlexDataGridCell.h"

/**
	 * @inheritDoc
	 */
@interface FLXSFlexDataGridPaddingCell : FLXSFlexDataGridCell
{
}

@property (nonatomic, assign) BOOL forceRightLock;
@property (nonatomic, assign) BOOL scrollBarPad;


-(void)destroy;
-(id)getBackgroundColors;
-(id)getTextColors;
-(BOOL)drawTopBorder;
-(NSString*)prefix;
-(BOOL)isLocked;
-(BOOL)isLeftLocked;
-(BOOL)isRightLocked;

- (void)drawRightBorder:(float)unscaledWidth unscaledHeight:(float)unscaledHeight;

@end

