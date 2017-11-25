#import "FLXSVersion.h"
#import "FLXSFlexDataGridCell.h"

/**
	 * @inheritDoc
	 */
@interface FLXSFlexDataGridLevelRendererCell : FLXSFlexDataGridCell

-(id)getBackgroundColors;
-(id)getTextColors;
-(id)getRolloverColor;
-(void)refreshCell;
-(NSString*)prefix;
-(BOOL)drawTopBorder;
@end

