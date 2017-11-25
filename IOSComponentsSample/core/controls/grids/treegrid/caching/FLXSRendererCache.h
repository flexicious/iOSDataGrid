#import "FLXSVersion.h"
@class FLXSClassFactory;
@class FLXSFactoryKey;
@class FLXSKeyValuePairCollection;
@class FLXSFlexDataGrid;

/**
	 * Class to keep renderes around...
	 *
	 * Each Cell in the grid, is a container UI component, and the actual renderer UI component
	 * The _dict object here holds a bucket for each container type/renderer type combination
	 * The _rendererFactories holds a map of each cell and the corresponding bucket key (FactoryKey) that
	 * was used to generate it, so we are able to put it back into the bucket that it came from.
	 *
	 * The idea is, there should always be only just as many things in memory as are currently visibule
	 * plus a little outside so we scroll smoothly...
	 */
@interface FLXSRendererCache : NSObject
{
}

@property (nonatomic, strong) FLXSKeyValuePairCollection* dict;
@property (nonatomic, strong) FLXSKeyValuePairCollection* rendererFactories;
@property (nonatomic, strong) NSMutableArray* factoryKeys;
@property (nonatomic, weak) FLXSFlexDataGrid* grid;

-(id)initWithGrid:(FLXSFlexDataGrid*)grid;
/**
* Returns an instance of the specified factory/subfactory combination from the cache, if once exists.
* Else, instantiates a new instance, and stores the factory key that was used to create it.
* @param factory
* @return
*/
- (NSObject *)popInstance:(FLXSClassFactory *)factory subFactory:(FLXSClassFactory *)subFactory;
/**
		 * Returns a previously created renderer into the bucket for reuse later.
		 * @param factory
		 * @param instance
		 * @return
		 *
		 */
-(void)pushInstance:(NSObject*)instance;

- (FLXSFactoryKey *)getFactoryKey:(FLXSClassFactory *)factory subFactory:(FLXSClassFactory *)subFactory;

@end

