#import "FLXSIPager.h"
#import "FLXSVersion.h"

@class FLXSFlexDataGridColumnLevel;
@class FLXSRowInfo;

/**
	 * Works with the ExtendedDataGrid, to provide UI for the pager
	 * bar. Flexicious provides a default implementation of this,
	 * but you may override with your own. See examples.
	 */
@protocol FLXSIExtendedPager<FLXSIPager>

@property (nonatomic,weak) FLXSFlexDataGridColumnLevel * level;
@property (nonatomic,weak) FLXSRowInfo * rowInfo;
@property (nonatomic,assign) BOOL dispatchEvents;


-(void)setStyle:(NSString*)styleProp :(id)value;
-(void)invalidateDisplayList;
-(void)initializePager;

//FLXSIEventDispatcher methods
-(void)dispatchEvent:(FLXSEvent *)event;

- (void)addEventListener:(NSString *)type target:(NSObject *)target handler:(SEL)handler;
-(void)removeEventListenerOfType:(NSString *)type fromTarget:(NSObject *)target usingHandler:(SEL)handler;
//End FLXSIEventDispatcher methods
@end

