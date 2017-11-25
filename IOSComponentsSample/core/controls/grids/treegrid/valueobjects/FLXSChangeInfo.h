#import "FLXSVersion.h"

/**
	 * Class to keep track of changes - additions, modifications and deletions to the data provider.
	 */
@interface FLXSChangeInfo : NSObject
{

}
/**
* The item that was changed
*/
@property (nonatomic, weak) NSObject* changedItem;
/**
		 * The property on the item that was changed
		 */
@property (nonatomic, weak) NSString* changedProperty;
/**
		 * The value before the change
		 */
@property (nonatomic, weak) NSObject* previousValue;
@property (nonatomic, weak) NSObject* changedValue;
/**
		 * The original value
		 */
@property (nonatomic, weak) NSObject* origValue;
/**
		 * One of the three change types : CHANGE_TYPE_INSERT, CHANGE_TYPE_UPDATE or CHANGE_TYPE_DELETE
		 */
@property (nonatomic, strong) NSString* changeType;
@property (nonatomic, assign) int changeLevelNestDepth;

- (id)initWithChangedItem:(NSObject *)changedItem changeLevelNestDepth:(int)changeLevelNestDepth changedProperty:(NSString *)changedProperty previousValue:(NSObject *)previousValue changedValue:(NSObject *)newValue changeType:(NSString *)changeType;
 

+ (NSString*)CHANGE_TYPE_INSERT;
+ (NSString*)CHANGE_TYPE_UPDATE;
+ (NSString*)CHANGE_TYPE_DELETE;
@end

