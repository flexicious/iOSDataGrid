#import "FLXSReferenceData.h"


@implementation FLXSReferenceData

@synthesize code;
@synthesize name;

- (id)initWithId:(float)id andCode:(NSString *)codeIn andName:(NSString *)nameIn {
	self = [super init];
	if (self)
	{
		self.code=codeIn;
		self.id=id;
		if([nameIn length]==0)
            nameIn=codeIn;
		self.name=nameIn;
	}
	return self;
}
-(NSString *)label{
    return self.name;
}

-(NSString *)data{
    return self.code;
}


-(FLXSReferenceData *)cloneSpecial
{
	FLXSReferenceData * ref = [[FLXSReferenceData alloc] initWithId:self.id andCode:self.code andName:self.name];
	return ref;
}

-(FLXSBaseEntity *)createNew
{
	return  [self cloneSpecial];
}

@end

