#import "FLXSBaseEntity.h"
#import "FLXSSystemUser.h"
#import "FLXSDemoVersion.h"

@implementation FLXSBaseEntity

@synthesize addedBy;
@synthesize addedDate;
@synthesize updatedBy;
@synthesize updatedDate;
@synthesize generatedDate;
@synthesize id;

-(id) init{
   self = [super init];
    if(self){
        self.generatedDate = [NSDate date];
    }
    return self;
}
-(FLXSBaseEntity *)clone:(BOOL)deepClone
{
	FLXSBaseEntity * entity=[self createNew];
	entity.addedBy=addedBy;
    NSArray * info  = [FLXSUIUtils getClassInfo:[self class]] ;
    for(FLXSLabelData* data in info )
	{
        if([data.label isEqual:@"hash"] || [data.label isEqual:@"description"] || [data.label isEqual:@"debugDescription"])
            continue;

		if([FLXSUIUtils isPrimitive:[self valueForKey:data.label]])
		{
            [entity setValue:[self valueForKey:data.label] forKey:data.label];
		}
		else if([[self valueForKey:data.label] isKindOfClass:[FLXSBaseEntity class]])
		{
            [entity setValue:[self valueForKey:data.label] forKey:data.label];
		}
		else if(deepClone&&([[self valueForKey:data.label] isKindOfClass:[NSArray class]]))
		{
            NSMutableArray * dest = [[NSMutableArray alloc] init];
            [entity setValue:dest forKey:data.label];
			for(FLXSBaseEntity * item in ((NSArray *)[self valueForKey:data.label]))
			{
				[dest addObject:[item clone:deepClone]];
            }
		}
	}
	return entity;
}

- (FLXSBaseEntity *)createNew {
    return nil;
}
- (id)copyWithZone:(NSZone *)zone
{
        return self;
}

@end

