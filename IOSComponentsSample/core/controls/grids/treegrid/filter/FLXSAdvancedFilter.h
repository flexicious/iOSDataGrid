#import "FLXSVersion.h"
#import "FLXSFilter.h"
#import "FLXSFlexDataGridColumnLevel.h"
/**
	 * A container object that encapsulates all the
	 * individual property filter settings, page settings
	 * and the sort state.
	 */
@interface FLXSAdvancedFilter : FLXSFilter
{
}

@property (nonatomic, strong) NSObject* parentObject;
@property (nonatomic, weak) FLXSFlexDataGridColumnLevel* level;


+(FLXSAdvancedFilter*)from:(FLXSFilter*)param;

+ (NSString*)ALL_ITEM;
@end

