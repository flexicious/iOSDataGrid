#import "FLXSIFilterControl.h"
#import "FLXSVersion.h"
/**
* To be implemented by containers like VBOX and HBOX.
* This gives them the capability to consolidate the
* search criterion in all controls contained by them.
* So if you have a screen with a section dedicated
* to search, you can group all those controls within
* a container, and just get the consolidated filter
* object from the container.
*/
@protocol FLXSIFilterControlContainer
-(void)registerIFilterControl:(UIView <FLXSIFilterControl>*)iFilterControl;
-(void)unRegisterIFilterControl:(UIView <FLXSIFilterControl>*)iFilterControl;
-(NSMutableArray*)getFilterArguments;
-(NSMutableArray*)getFilterControls;
@end

