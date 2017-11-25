
#import "FLXSElasticContainer.h"
#import "FLXSFlexDataGrid.h"
#import "FLXSFlexDataGridBodyContainer.h"

@implementation FLXSElasticContainer {

}


@synthesize boundContainer = _boundContainer;
@synthesize grid ;
@synthesize backgroundForFillerRows = _backgroundForFillerRows;


-(id)initWithGrid:(FLXSFlexDataGrid*)gridIn
{
	self = [super init];
	if (self)
	{
		FLXSGridBackground * bg = [[FLXSGridBackground alloc] init];
        self.backgroundForFillerRows = bg;
		self.grid=gridIn;
        if(self.grid.enableFillerRows)
        {
            [self addSubview:self.backgroundForFillerRows];
            [self sendSubviewToBack:self.backgroundForFillerRows];
        }
        self.backgroundColor = self.grid.backgroundColor;

    }
	return self;
}

-(void)setBackgroundFillerSize
{
	float ht=self.height-self.grid.bodyContainer.calculatedTotalHeight;
	if(ht<0)ht=0;
	self.backgroundForFillerRows.height=(ht);
	self.backgroundForFillerRows.width=(self.width);
	if(ht>0)
	{
        [self.backgroundForFillerRows moveToX:0 y:self.grid.bodyContainer.calculatedTotalHeight];
	}
}
-(CGSize)contentSize {
    return CGSizeMake(self.width, self.boundContainer.contentSize.height);
}

@end

