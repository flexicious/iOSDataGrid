#import "FLXSExpandCollapseIcon.h"
#import "FLXSIFlexDataGridCell.h"
#import "FLXSIExpandCollapseComponent.h"
#import "FLXSRowInfo.h"
#import "FLXSRowPositionInfo.h"
#import "FLXSFlexDataGridColumnLevel.h"
#import "FLXSFlexDataGrid.h"
#import "FLXSFlexDataGridExpandCollapseCell.h"

@implementation FLXSExpandCollapseIcon {
@private
    BOOL _hasChildren;
    BOOL _open;
}

@synthesize hasChildren = _hasChildren;
@synthesize open = _open;

-(id)init
{
	self = [super init];
	if (self)
	{
		self.hasChildren = NO;
        self.open = NO;

	}
	return self;
}

-(UIView<FLXSIFlexDataGridCell>*)cellFLXS
{
   return (UIView<FLXSIFlexDataGridCell>*)self.superview;
}

-(FLXSFlexDataGridColumnLevel*)level
{
     return self.cellFLXS ?self.cellFLXS.level:nil;

}

-(FLXSRowInfo*)rowInfo
{
     return self.cellFLXS ?self.cellFLXS.rowInfo:nil;
}

-(void)refreshCell
{
    if(self.cellFLXS)
		[self.cellFLXS refreshCell];
}

-(void)doClick
{
    [FLXSExpandCollapseIcon doClick:self];
}
-(UIImageView*)expandCollapseImageView{
    return self;
}

+(void)refreshCell:(UIView<FLXSIExpandCollapseComponent>*)iexp
{
	if(iexp.superview ==nil)return;
	if(iexp.rowInfo.rowPositionInfo.isDataRow)
	{
		NSObject* item=iexp.rowInfo.data;
		if(!item)return;
		iexp.open = [iexp.level isItemOpen:item];
		iexp.hasChildren = (iexp.level.nextLevelRenderer!=nil)|| (iexp.level.isClientItemLoadMode? iexp.level.nextLevel
&&([iexp.level.grid getLength:([iexp.level getChildren:item filter:YES page:NO sort:NO ])]>0):iexp.level.childrenCountField.length>0?
                ([item valueForKey: iexp.level.childrenCountField]>0):YES);
		//iexp.toolTip = [iexp.level.grid expandCollapseTooltipFunction:iexp.cell];
	}
}

+(void)doClick:(UIView<FLXSIExpandCollapseComponent>*)iexp
{
	if(iexp.superview ==nil)return;
	if(!iexp.level.grid.allowInteractivity||!iexp.rowInfo||iexp.rowInfo.isFillRow)return;
	iexp.open=!iexp.open;
	[iexp.cellFLXS dispatchEvent:([[FLXSEvent alloc] initWithType:[FLXSFlexDataGridExpandCollapseCell EVENT_EXPAND_COLLAPSE]])];
	if([iexp isKindOfClass:[FLXSFlexDataGridExpandCollapseCell class]]){
        FLXSFlexDataGridExpandCollapseCell* fdgE=( FLXSFlexDataGridExpandCollapseCell*)iexp;
        [fdgE invalidateBackground];
    }
	else
    [self drawIcon:iexp];
}

+(void)drawIcon:(UIView<FLXSIExpandCollapseComponent>*)iexp
{
  if((iexp.superview ==nil)||!iexp.level)return;
	UIView<FLXSIFlexDataGridCell>* cell=iexp.cellFLXS;
	if(cell.rowInfo&&cell.rowInfo.isFillRow)
	{
		return;
	}
	if(iexp.hasChildren)
	{
		NSString* cls = [iexp.level getStyleValue:(@"disclosureClosedIcon")];
		if (iexp.open)
			cls = [iexp.level getStyleValue:(@"disclosureOpenIcon")];
        UIImage * image = [UIImage imageNamed:cls];
        [iexp.expandCollapseImageView setImage:image];
        float width = image.size.width;
        float height = image.size.height;
        CGRect imageRect = CGRectMake(iexp.expandCollapseImageView.x, (iexp.height>height) ? (iexp.height-height)/2:iexp.expandCollapseImageView.y, width, height);
        iexp.expandCollapseImageView.frame=imageRect;
        iexp.expandCollapseImageView.alpha=1;
    }
    else
    {
        iexp.expandCollapseImageView.alpha=0;
    }
}

-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];

}

@end

