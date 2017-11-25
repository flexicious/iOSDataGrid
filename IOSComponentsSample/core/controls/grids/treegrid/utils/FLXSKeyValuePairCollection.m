#import "FLXSKeyValuePairCollection.h"


@implementation FLXSKeyValuePairCollection

@synthesize keys=_keys;
@synthesize values=_values;

-(id)init
{
	self = [super init];
	if (self)
	{
		_keys = [[NSMutableArray alloc] init];
		_values = [[NSMutableArray alloc] init];;

	}
	return self;
}

- (void)addItem:(NSObject *)key value:(NSObject *)value {
    if(key){
	NSUInteger keyIdx=[self.keys indexOfObject :key];
	if(keyIdx==NSNotFound)
	{

		[self.keys addObject :key];
		[self.values addObject:value==nil? [NSNull null]:value];
	}
	else
	{
        [[self values] setObject:value==nil? [NSNull null]:value atIndexedSubscript:keyIdx];
	}
    }
}

-(void)removeItem:(NSObject*)key
{
	NSUInteger keyIdx=[self.keys indexOfObject:key];
	if(keyIdx!=-1)
	{
		[self.keys removeObjectAtIndex:keyIdx];
		[self.values removeObjectAtIndex:keyIdx];
	}
}

-(NSObject*)getValue:(NSObject*)key
{
	NSUInteger keyIdx=[self.keys indexOfObject:key];
	if(keyIdx==NSNotFound)
		return nil;
	return self.values[keyIdx];
}

-(BOOL)hasHey:(NSObject*)key
{
	return [self.keys indexOfObject:key]!=NSNotFound;
}

-(void)clear
{
    [self.keys removeAllObjects];
    [self.values removeAllObjects];
}

@end

