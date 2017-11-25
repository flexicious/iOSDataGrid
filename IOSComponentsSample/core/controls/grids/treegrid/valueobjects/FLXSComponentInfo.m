#import "FLXSComponentInfo.h"
#import "FLXSIFlexDataGridCell.h"
#import "FLXSRowInfo.h"
#import "FLXSFlexDataGridColumn.h"
#import "FLXSFlexDataGridPaddingCell.h"


@implementation FLXSComponentInfo

@synthesize component;
@synthesize x;
@synthesize row;
@synthesize inCornerAreas;
@synthesize useComponentPosition;

- (id)initWithCell:(UIView *)componentIn
              andX:(float)xIn
        andRowInfo:(FLXSRowInfo *)rowIn {
	self = [super init];
	if (self)
	{
		self.inCornerAreas = NO;
		self.useComponentPosition = NO;

		self.component= (UIView<FLXSIFlexDataGridCell>* )componentIn;
		self.x=xIn;
		self.row=rowIn;
	}
	return self;
}

-(BOOL)isLocked
{
	UIView <FLXSIFlexDataGridCell>* cell = (UIView <FLXSIFlexDataGridCell>*)component;
	return cell && cell.isLocked ;
}

-(BOOL)isRightLocked
{
	UIView <FLXSIFlexDataGridCell>* cell = (UIView <FLXSIFlexDataGridCell>*)component;
	return cell && cell.isRightLocked;
}

-(BOOL)isLeftLocked
{
	UIView <FLXSIFlexDataGridCell>* cell = (UIView <FLXSIFlexDataGridCell>*)component;
	return cell && cell.isLeftLocked;
}

-(BOOL)isContentArea
{
	UIView <FLXSIFlexDataGridCell>* cell = (UIView <FLXSIFlexDataGridCell>*)component;
	return cell && (cell.isContentArea) ;
}

-(float)perceivedX
{
	UIView <FLXSIFlexDataGridCell>* cell = (UIView <FLXSIFlexDataGridCell>*)component;
	if(!cell)return self.x;
	return cell.perceivedX;
}

-(int)colIndex
{
	UIView <FLXSIFlexDataGridCell>* cell = (UIView <FLXSIFlexDataGridCell>*)component;
	if(!cell)return -1;
	FLXSFlexDataGridPaddingCell* pad= [cell isKindOfClass:[FLXSFlexDataGridPaddingCell class]]?(FLXSFlexDataGridPaddingCell* )cell:nil;
	if(pad)
	{
		if(pad.scrollBarPad)
			return 99999;
		else if(pad.forceRightLock)
            return 99998;
        else
            return -2;
	}
	return cell.columnFLXS ?cell.columnFLXS.colIndex:-1;
}

@end

