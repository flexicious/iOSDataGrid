#import "FLXSVersion.h"
@protocol FLXSICheckBoxList
-(NSString*)getTooltip:(NSObject*)data;
-(BOOL)isItemSelected:(NSObject*)item;
-(int)indexOfObject:(NSObject*)item;
-(BOOL)useTriState;
-(NSArray*)selectedItems;
-(BOOL)isAllSelected;
-(BOOL)hasSearch;
@end

