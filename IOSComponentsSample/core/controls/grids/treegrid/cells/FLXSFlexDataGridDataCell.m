#import "FLXSFlexDataGridDataCell.h"
#import "FLXSRowInfo.h"
#import "FLXSCellUtils.h"
#import "FLXSFlexDataGridColumn.h"
#import "FLXSFlexDataGridCheckBoxColumn.h"
#import "FLXSFlexDataGridColumnLevel.h"
#import "FLXSTriStateCheckBox.h"


@implementation FLXSFlexDataGridDataCell {
@private
    int _colSpan;
    int _rowSpan;
}

@synthesize colSpan = _colSpan;
@synthesize rowSpan = _rowSpan;

-(void)refreshCell
{
    if(self.rowInfo.isFillRow)return;
	[super refreshCell];
    [FLXSCellUtils refreshCell:self];
//	UIView* mine=self.renderer;
	if(self.columnFLXS)
	{
//		UIView* rendererComponent = mine;

        NSTextAlignment al= [[self.columnFLXS getStyleValue:(@"textAlign")] intValue];
        if([self.renderer respondsToSelector:NSSelectorFromString(@"textAlignment")])
        [self.renderer setValue:[NSNumber numberWithInt:al] forKey:@"textAlignment"];


//		if(self.column.useUnderLine && [self.rendererComponent getStyle:(@"textDecoration")]!=@"underline")
//			[rendererComponent setStyle:(@"textDecoration") :(@"underline")];
//		else if(!column.useUnderLine && [[rendererComponent getStyle:(@"textDecoration")] isEqual:@"underline"])
//[rendererComponent setStyle:(@"textDecoration") :(@"")];
		//if([mine hasOwnProperty:(@"selectable")] && mine[@"selectable"]!=column.selectable) mine[@"selectable"]=column.selectable;
		//if((mine is Label) && mine[@"truncateToFit"]!=column.truncateToFit) mine[@"truncateToFit"]=column.truncateToFit;
	}
	if([self.columnFLXS isKindOfClass:[FLXSFlexDataGridCheckBoxColumn class]])
	{
        ((FLXSTriStateCheckBox*)self.renderer).userInteractionEnabled= [self.level checkRowSelectable:self object:self.rowInfo.data];
	}
}

-(float)getLeftPadding
{
    return self.columnFLXS &&self.columnFLXS.enableHierarchicalNestIndent?self.level.maxPaddingCellWidth+[super getLeftPadding]: [super getLeftPadding];
}

@end

