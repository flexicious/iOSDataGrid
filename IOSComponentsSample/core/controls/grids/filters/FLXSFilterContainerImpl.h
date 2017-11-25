#import "FLXSVersion.h"
#import "FLXSIDelayedChange.h"
#import "FLXSICustomMatchFilterControl.h"
#import "FLXSIDynamicFilterControl.h"
#import "FLXSIFilterControl.h"
#import "FLXSIMultiSelectFilterControl.h"
#import "FLXSIRangeFilterControl.h"
#import "FLXSISelectedBitFilterControl.h"
#import "FLXSISingleSelectFilterControl.h"
#import "FLXSITextFilterControl.h"
#import "FLXSITriStateCheckBoxFilterControl.h"
#import "FLXSIExtendedDataGrid.h"
#import "FLXSFilterPageSortChangeEvent.h"
#import "FLXSEvent.h"
#import "FLXSTextInput.h"
#import "FLXSFilterExpression.h"
#import "UIView+UIViewAdditions.h"

/**
	 * @private
	 */

@interface FLXSFilterContainerImpl : NSObject
{
}

@property (nonatomic, strong) NSMutableArray* filterControls;
@property (nonatomic, weak) NSObject <FLXSIEventDispatcher>* iEventDispatcher;
@property (nonatomic, assign) BOOL tabHandled;

-(id)initWithIEventDispatcher:(NSObject*)iEventDispatcher;
-(void)resetFilterControls;
-(void)unRegisterIFilterControl:(UIView  <FLXSIFilterControl>*)iFilterControl;
-(BOOL)isIFilterControlRegistered:(UIView <FLXSIFilterControl>*)iFilterControl;
-(void)registerIFilterControl:(UIView <FLXSIFilterControl>*)iFilterControl;
-(NSMutableArray*)getFilterControls;
-(NSMutableArray*)getFilterArguments;

- (void)setFilterValue:(NSString *)column value:(NSObject *)value;
-(NSObject*)getFilterValue:(NSString*)column;
-(BOOL)hasField:(NSString*)column;
-(void)processFilter;
-(void)clearFilter:(NSString*)col;
-(BOOL)setFilterFocus:(NSString*)fld;
-(void)onChangeHandler:(NSNotification *)event;
+(FLXSFilterExpression *)getFilterExpression:(UIView <FLXSIFilterControl>*)iFilterControl;



@end

