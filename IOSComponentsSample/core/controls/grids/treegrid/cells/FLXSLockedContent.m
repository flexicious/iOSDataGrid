
#import "FLXSLockedContent.h"
#import "FLXSIFlexDataGridCell.h"
#import "FLXSRowInfo.h"
#import "FLXSFlexDataGrid.h"

@implementation FLXSLockedContent {

}

@synthesize grid;


-(id)initWithGrid:(FLXSFlexDataGrid*)gridIn
{
	self = [super init];
	if (self)
	{
		self.grid=gridIn;
        self.backgroundColor = self.grid.backgroundColor;
	}
	return self;
}

-(void)placeSection
{
//    BOOL hidden=NO;
	NSMutableArray* affectedCells=[[NSMutableArray alloc] init];
    NSArray *subviews = [self subviews];

    for (int i=0;i< [subviews count];i++)
	{
		if([[subviews objectAtIndex:i] conformsToProtocol:@protocol(FLXSIFlexDataGridCell)])
		{
            UIView<FLXSIFlexDataGridCell>* cell= (UIView<FLXSIFlexDataGridCell>* )[subviews objectAtIndex:i] ;
            BOOL wasVisible=!cell.hidden;
			FLXSRowInfo* row = cell.rowInfo;
			if(row)
			{
				if(row.isPagerRow)
					cell.hidden=!grid.pagerVisible;
				/*else if(row.isFooterRow) footers have their own containers so do not need self
							cell.visible=cell.includeInLayout=grid.footerVisible;
				*/
                else if(row.isHeaderRow)
                    cell.hidden=!grid.headerVisible;
				else if(row.isFilterRow)
                    cell.hidden=!grid.filterVisible;
			}
			if(wasVisible&&cell.hidden)
			{
				//htRemoved=cell.height;
				[affectedCells addObject:cell];
			}
			else if (!wasVisible && cell.hidden)
			{
			//	htRemoved=0-cell.height;
				[affectedCells addObject:cell];
			}
		}
	}

    
}

@end

