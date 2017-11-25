#import "FLXSVersion.h"
#import "FLXSFlexDataGridCell.h"

@class FLXSFlexDataGridColumn;
/**
	 * @inheritDoc
	 */

@interface FLXSFlexDataGridFooterCell : FLXSFlexDataGridCell
{
}

@property (nonatomic, weak) NSObject* dataProviderFLXS;


-(void)refreshCell;
-(void)calculateValue:(NSObject*)flat;

+ (NSString *)defaultLabelFunction:(FLXSFlexDataGridColumn *)col dataProvider:(NSArray *)dataProvider;
-(id)getBackgroundColors;
-(id)getTextColors;
-(void)initializeCheckBoxRenderer:(UIView*)renderer;
-(id)getRolloverColor;
-(NSString*)prefix;
-(BOOL)drawTopBorder;

+ (NSString*)SUM;
+ (NSString*)MIN;
+ (NSString*)MAX;
+ (NSString*)AVERAGE;
+ (NSString*)COUNT;
@end

