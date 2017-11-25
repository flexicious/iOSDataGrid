#import "FLXSFilterControlImpl.h"



@implementation FLXSFilterControlImpl

@synthesize iFilterControl;
@synthesize registered;
@synthesize searchField=_searchField;
@synthesize filterOperation;
@synthesize grid;
@synthesize gridColumn;
@synthesize filterComparisonType;
@synthesize filterTriggerEvent;
@synthesize dataFieldFLXS = _dataFieldFLXS;
@synthesize autoRegister;

-(id)initWithFilterControl:(UIView <FLXSIFilterControl>*)iFilterControlIn
{
	self = [super init];
	if (self)
	{
		self.registered = NO;
        self.filterComparisonType = @"auto";
        self.filterTriggerEvent = @"change";
        self.dataFieldFLXS = @"data";
        self.autoRegister = YES;

        self.iFilterControl=iFilterControlIn;

	}
	return self;
}


-(void)register:(NSObject <FLXSIFilterControlContainer> *)container
{
	if(self.registered)
		[container unRegisterIFilterControl:self.iFilterControl];
	[container registerIFilterControl:self.iFilterControl];
	self.registered=YES;
}

-(NSString*)dataFieldFLXS {
    return _dataFieldFLXS.length>0? _dataFieldFLXS :_searchField;

}


@end

