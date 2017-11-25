#import "FLXSFlexDataGrid.h"
#import "FLXSKeyValuePairCollection.h"
#import "FLXSRendererCache.h"
#import "FLXSFactoryKey.h"
#import "FLXSFlexDataGridEvent.h"
@implementation FLXSRendererCache


@synthesize dict=_dict;
@synthesize rendererFactories=_rendererFactories;
@synthesize factoryKeys=_factoryKeys;
@synthesize grid=_grid;

-(id)initWithGrid:(FLXSFlexDataGrid*)grid
{
	self = [super init];
	if (self)
	{
		_dict = [[FLXSKeyValuePairCollection alloc] init];
		_rendererFactories = [[FLXSKeyValuePairCollection alloc] init];
		_factoryKeys = [[NSMutableArray alloc] init];

		_grid=grid;
	}
	return self;
}


- (NSObject *)popInstance:(FLXSClassFactory *)factory subFactory:(FLXSClassFactory *)subFactory {
	if(!subFactory)subFactory=factory;

	FLXSFactoryKey* key= [self getFactoryKey:factory subFactory:subFactory];
	if(![_dict hasHey:key])
		[_dict addItem:key value:([[NSMutableArray alloc] init])];
    NSMutableArray *bucket=(NSMutableArray *)[_dict getValue:key];
	NSObject* retVal = bucket.count>0? [bucket objectAtIndex:0]:nil;
	if(!retVal)
	{
		retVal= [factory generateInstance];
		if([_grid dispatchCellCreated])
            [_grid dispatchEvent:[[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent CELL_CREATED] andGrid:_grid andLevel:nil andColumn:nil andCell:nil andItem:nil andTriggerEvent:nil andBubbles:NO andCancelable:NO ]];
			
		[_rendererFactories addItem:retVal value:key];
	}  else{
        [bucket removeObjectAtIndex:0];
    }
     return retVal;
}
-(void) logContents{
//    for (FLXSFactoryKey * cd in _dict.keys){
//        for (NSObject * cf in [_dict getValue:cd]){
//        }
//    }
}
-(void)pushInstance:(NSObject*)instance
{
    //return;
    ( [(NSMutableArray *)[_dict getValue:((FLXSFactoryKey *) [_rendererFactories getValue:instance])] insertObject:instance atIndex:0]);
}

- (FLXSFactoryKey *)getFactoryKey:(FLXSClassFactory *)factory subFactory:(FLXSClassFactory *)subFactory {
	for(FLXSFactoryKey* fKey in _factoryKeys)
	{
		if([fKey.factory isEqual:factory] && [fKey.subFactory isEqual:subFactory])
		{
			return fKey;
		}
	}
	FLXSFactoryKey* newKey= [[FLXSFactoryKey alloc] initWithFactory:factory andSubFactory:subFactory];
	[_factoryKeys addObject:newKey];
	return newKey;
}

@end

