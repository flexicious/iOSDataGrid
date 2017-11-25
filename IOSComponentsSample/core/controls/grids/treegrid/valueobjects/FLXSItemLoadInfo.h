#import "FLXSVersion.h"
@class FLXSFlexDataGridColumnLevel;
/**
	 * In lazy loaded grids, stores information about which items
	 * are being loaded or have been loaded.
	 */

@interface FLXSItemLoadInfo : NSObject
{
}

@property (nonatomic, strong) NSObject* item;
@property (nonatomic, assign) BOOL hasLoaded;
@property (nonatomic, assign) int totalRecords;
@property (nonatomic, assign) int pageIndex;
@property (nonatomic, weak) FLXSFlexDataGridColumnLevel* level;

- (id)initWithItem:(NSObject *)item andLevel:(FLXSFlexDataGridColumnLevel *)level andHasLoaded:(BOOL)hasLoaded;
/**
    *
    * @private
    */
- (BOOL)isEqual:(NSObject *)compare levelToCompare:(FLXSFlexDataGridColumnLevel *)levelToCompare useSelectedKeyField:(BOOL)useSelectedKeyField;

@end

