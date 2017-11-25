#import "FLXSFlexDataGridColumnLevel.h"
#import "FLXSItemLoadInfo.h"
#import "FLXSExtendedUIUtils.h"


@implementation FLXSItemLoadInfo

@synthesize item;
@synthesize hasLoaded;
@synthesize totalRecords;
@synthesize pageIndex;
@synthesize level;

- (id)initWithItem:(NSObject *)itemIn
          andLevel:(FLXSFlexDataGridColumnLevel *)levelIn
      andHasLoaded:(BOOL)hasLoadedIn {
	self = [super init];
	if (self)
	{
		hasLoaded = NO;
		totalRecords = -1;
		pageIndex = 0;

		self.item=itemIn;
		self.hasLoaded=hasLoadedIn;
		self.level=levelIn;
	}
	return self;
}

- (BOOL)isEqual:(NSObject *)compare levelToCompare:(FLXSFlexDataGridColumnLevel *)levelToCompare useSelectedKeyField:(BOOL)useSelectedKeyField {
	if(useSelectedKeyField)
	{
		return ([[FLXSExtendedUIUtils resolveExpression:compare expression:level.selectedKeyField valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ] isEqual:
                [FLXSExtendedUIUtils resolveExpression:item expression:level.selectedKeyField valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ]]) && ([levelToCompare isEqual:level]);
	}
	else
	{
		return [compare isEqual: item] && ([levelToCompare isEqual:level]);
	}
}

@end

