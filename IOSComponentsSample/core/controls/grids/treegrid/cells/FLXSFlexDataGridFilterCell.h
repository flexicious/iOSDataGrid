#import "FLXSVersion.h"
#import "FLXSFlexDataGridCell.h"
/**
	 * @inheritDoc
	 */

@interface FLXSFlexDataGridFilterCell : FLXSFlexDataGridCell
{
}


-(id)getBackgroundColors;
-(id)getIconUrl:(BOOL)over;
-(id)getTextColors;
-(void)initializeCheckBoxRenderer:(UIView*)renderer;
-(id)getRolloverColor;
//we want to always rebuild the filter renderer
-(void)destroy;
-(void)refreshCell;
-(NSString*)prefix;
-(BOOL)drawTopBorder;

+ (NSString*)FILTER_CHANGE;
@end

