#import "FLXSFlexDataGridFooterCell.h"
#import "FLXSFlexDataGridColumn.h"
#import "FLXSExtendedUIUtils.h"
#import "FLXSFlexDataGrid.h"
#import "FLXSFlexDataGridColumnLevel.h"
#import "FLXSRowInfo.h"
#import "FLXSFilterExpression.h"
#import "FLXSCellUtils.h"
#import "FLXSFlexDataGridCheckBoxColumn.h"
#import <objc/message.h>

static  NSString* const FLXS_SUM = @"sum";
static  NSString* const FLXS_MIN = @"min";
static  NSString* const FLXS_MAX = @"max";
static  NSString* const FLXS_AVERAGE = @"average";
static  NSString* const FLXS_COUNT = @"count";

@implementation FLXSFlexDataGridFooterCell {

}


@synthesize dataProviderFLXS = _dataProviderFLXS;


-(id)init
{	self = [super init];
    if (self)
    {
        [self initCommon];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initCommon];
    }
    return self;
}
- (void)initCommon {
    [super initCommon];
}


-(void)refreshCell
{
	[super refreshCell];
    if(!([self.columnFLXS isKindOfClass:[FLXSFlexDataGridCheckBoxColumn class]])
            && [self.renderer respondsToSelector:NSSelectorFromString(@"data")] && self.columnFLXS.footerRenderer!=nil)
        [self.renderer setValue:self.rowInfo forKey:@"data"];

	if(self.columnFLXS && (self.columnFLXS.footerLabelFunction!=nil ||
            self.columnFLXS.footerLabelFunction2!=nil||self.columnFLXS.footerOperation!=nil||self.columnFLXS.footerLabel!=nil))
	{
		if(self.level.nestDepth==1)
			  [self calculateValue:([FLXSExtendedUIUtils filterArray:([self.level.grid getRootFlat]) filter:([self.level.grid getRootFilter]) grid:self.level.grid level:self.level hideIfNoChildren:NO ])]  ;
        else
			[self calculateValue:([self.level.parentLevel getChildren:self.rowInfo.data filter:YES page:NO sort:YES ])] ;
	}
	else
	{
        self.text=@"";
	}
}

-(void)calculateValue:(NSObject*)flat
{
    self.dataProviderFLXS =flat;
	if(self.columnFLXS.footerLabelFunction2!=nil){
        //self.text=[column footerLabelFunction2:self];
        SEL selector = NSSelectorFromString(self.columnFLXS.footerLabelFunction2);
        id target = self.level.grid.delegate;
        FLXSFlexDataGridFooterCell *arg = self;
        self.text = ((NSString*(*)(id, SEL, FLXSFlexDataGridFooterCell *))objc_msgSend)(target, selector, arg);
    }
	else if(self.columnFLXS.footerLabelFunction!=nil) {
        //self.text=[self.column footerLabelFunction:column];
        SEL selector = NSSelectorFromString(self.columnFLXS.footerLabelFunction);
        id target = self.level.grid.delegate;
        self.text = ((NSString*(*)(id, SEL, FLXSFlexDataGridColumn *))objc_msgSend)(target, selector, self.columnFLXS);
    }
	else
        self.text= [FLXSFlexDataGridFooterCell defaultLabelFunction:self.columnFLXS dataProvider:(NSArray *) self.dataProviderFLXS];
}

+ (NSString *)defaultLabelFunction:(FLXSFlexDataGridColumn *)col dataProvider:(NSArray *)dataProvider {
	id value = nil;
    if([col.footerOperation isEqualToString:[FLXSFlexDataGridFooterCell SUM]]){
        value = [NSNumber numberWithFloat:[FLXSUIUtils sum:dataProvider fld:col.dataFieldFLXS]];
    }
    else if([col.footerOperation isEqualToString:[FLXSFlexDataGridFooterCell AVERAGE]]){
        value = [NSNumber numberWithFloat:[FLXSUIUtils average:dataProvider fld:col.dataFieldFLXS]];
    }
    else if([col.footerOperation isEqualToString:[FLXSFlexDataGridFooterCell MIN]]){
        value = [FLXSUIUtils min:dataProvider fld:col.dataFieldFLXS comparisonType:[FLXSFilterExpression FILTER_COMPARISON_TYPE_AUTO]];
    }
    else if([col.footerOperation isEqualToString:[FLXSFlexDataGridFooterCell MAX]]){
        value = [FLXSUIUtils max:dataProvider fld:col.dataFieldFLXS comparisonType:[FLXSFilterExpression FILTER_COMPARISON_TYPE_AUTO]];
    }
    else if([col.footerOperation isEqualToString:[FLXSFlexDataGridFooterCell COUNT]]){
        value = [NSNumber numberWithInt:(int)[dataProvider count]];
    }
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    fmt.maximumFractionDigits = col.footerOperationPrecision;
    NSString* val = (value!=nil) ? [fmt stringFromNumber:[NSNumber numberWithFloat:[value floatValue] ]] : @"";
	if(col.footerFormatter!=nil)
		val=[col.footerFormatter stringForObjectValue:[NSNumber numberWithFloat:[val floatValue]]];
	if([val isEqualToString:@"0."])val=@"0";
	return [(col.footerLabel != nil? col.footerLabel : @"") stringByAppendingString:val];

}

-(id)getBackgroundColors
{
    NSObject * fromGrid=[FLXSCellUtils getBackgroundColorFromGrid:self];
	if(fromGrid!=nil)return fromGrid;
	if(self.currentBackgroundColors)return self.currentBackgroundColors;
	return [self.level getStyleValue:(@"footerColors")];
}

-(id)getTextColors
{
    NSObject * fromGrid=[FLXSCellUtils getTextColorFromGrid:self];
	if(fromGrid!=nil)return fromGrid;
	if(self.currentTextColors)return self.currentTextColors;
	return [self getStyle:(@"color")];
}

-(void)initializeCheckBoxRenderer:(UIView*)renderer
{
}

-(id)getRolloverColor
{
	if(self.columnFLXS) return [self.columnFLXS getStyleValue:(@"footerRollOverColors")];
	return [self.level getStyleValue:(@"footerRollOverColors")];
}

-(NSString*)prefix
{
	return @"footer";
}

-(BOOL)drawTopBorder
{
    return [[self getStyleValue:@"footerDrawTopBorder"] boolValue];
}

+ (NSString*)SUM
{
	return FLXS_SUM;
}
+ (NSString*)MIN
{
	return FLXS_MIN;
}
+ (NSString*)MAX
{
	return FLXS_MAX;
}
+ (NSString*)AVERAGE
{
	return FLXS_AVERAGE;
}
+ (NSString*)COUNT
{
    return FLXS_COUNT;
}
@end

