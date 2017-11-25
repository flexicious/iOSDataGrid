#import "FLXSDemoVersion.h"
#import <QuartzCore/QuartzCore.h>

@interface iPadExampleViewControllerBase : UIViewController<UISplitViewControllerDelegate,FLXSFlexDataGridDelegate>


-(void) buildGrid: (FLXSFlexDataGrid *)grid  FromXmlResource: (NSString *) resource;
-(void) loadJsonData: (FLXSFlexDataGrid *)grid  FromJsonResource: (NSString *) resource;

-(void)initializeTitleOfToolBar:(NSString*) title;

@end