#import "FLXSVersion.h"
#import "FLXSFlexDataGridCell.h"
/**
	 * @inheritDoc
	 */

@interface FLXSFlexDataGridPagerCell : FLXSFlexDataGridCell

-(id)getBackgroundColors;
-(id)getTextColors;
-(id)getRolloverColor;
-(BOOL)isLocked;

- (void)setActualSizeWithWidth:(float)w andHeight:(float)h;
-(void)destroy;
-(void)refreshCell;
-(NSString*)prefix;
-(BOOL)drawTopBorder;
@end

