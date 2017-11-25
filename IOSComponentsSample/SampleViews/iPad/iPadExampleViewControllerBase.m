#import "iPadExampleViewControllerBase.h"
#import "SampleUIUtils.h"
#import "iPhoneThemePickerViewController.h"
#import "AppDelegate.h"


@implementation iPadExampleViewControllerBase{
}

//grid setup functions                          `
-(void) buildGrid: (FLXSFlexDataGrid *)grid  FromXmlResource: (NSString *) resource{
    if(![FLXSUIUtils isIPad]){
        grid.layer.cornerRadius=10;
        grid.layer.masksToBounds=YES;
    }
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = FALSE;
    self.navigationController.toolbar.translucent = FALSE;

    grid.delegate = self;
    NSString *filePath;
    filePath = [[NSBundle mainBundle] pathForResource:resource ofType:@"xml"];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    [grid buildFromXML:fileData];

}

-(void) loadJsonData: (FLXSFlexDataGrid *)grid  FromJsonResource: (NSString *) resource{

    NSString *jsonFilePath;
    jsonFilePath = [[NSBundle mainBundle] pathForResource:resource ofType:@"json"];
    NSData *jsonFileData = [NSData dataWithContentsOfFile:jsonFilePath];
    NSError * error;
    id dic= [NSJSONSerialization JSONObjectWithData:jsonFileData options:NSJSONReadingMutableContainers error:&error];
    grid.dataProviderFLXS = [dic isKindOfClass:[NSArray class] ]?dic: ((NSDictionary *)dic).allValues;

}

//end grid setup functions

//some generic data formatting functions
-(NSString*)dataGridFormatCurrencyLabelFunction:(NSObject *)rowData :(FLXSFlexDataGridColumn *)col{

    return [SampleUIUtils formatCurrency:[(NSNumber *) [FLXSExtendedUIUtils resolveExpression:rowData expression:col.dataFieldFLXS valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ] floatValue]];
}
-(NSString*)dataGridFormatDateLabelFunction:(NSObject *)rowData :(FLXSFlexDataGridColumn *)col{

    return [SampleUIUtils formatDate:(NSDate *) [FLXSExtendedUIUtils resolveExpression:rowData expression:col.dataFieldFLXS valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ]];
}
-(NSFormatter*) getCurrencyFormatter{
    return [SampleUIUtils getCurrencyFormatter];
}
//end some generic data formatting functions


//adding support to autofit left locked columns
BOOL set=NO;
-(void)onPlacingSectionsHandler:(NSNotification *)ns{
    //by default, locked columns do not support column width mode attribute. In this section, we calculate the locked section widths dynamically
    //by adding support for locked modes.
    FLXSFlexDataGrid *grid = ((FLXSFlexDataGridEvent *)[ns.userInfo objectForKey:@"event"]).grid;
    //a demonstration of a new 2.9 feature on how to add column width mode = fit to content to left locked columns
    if(grid.dataProviderFLXS && !set){
        for (FLXSFlexDataGridColumn *col in grid.columnLevel.leftLockedColumns){
            if([col.columnWidthMode isEqualToString:[FLXSFlexDataGridColumn COLUMN_WIDTH_MODE_FIT_TO_CONTENT]])
                [grid.columnLevel applyColumnWidthFromContent:col provider:grid.dataProviderFLXS];
        }
        set=true;//do this only once otherwise user will not be able to resize.
    }

}
FLXSFlexDataGrid *grid;
-(void)autoRefreshHandler:(NSNotification *)ns{
    //for now we just show the spinner but in reality we would go back to the server
    grid = ((FLXSFlexDataGridEvent *)[ns.userInfo objectForKey:@"event"]).grid;

    [NSTimer scheduledTimerWithTimeInterval:2
                                     target:self
                                   selector:@selector(onTimer:)
                                   userInfo:nil
                                    repeats:NO];

}
-(void)onTimer:(NSTimer*)sdr{
    [grid.bodyContainer hideRefreshControl];
    grid= nil;
}

//for iPhone
-(void)initializeTitleOfToolBar:(NSString*) title {
    // choose whatever width you need instead of 600

    UIBarButtonItem* themeBtn = [[UIBarButtonItem  alloc] initWithTitle:@"Theme"
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self
                                                                 action:@selector(themeItemsOn:)];
    self.navigationItem.rightBarButtonItem = themeBtn;
    self.navigationItem.title = title;

}
-(void)back{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)themeItemsOn:(id )sender
{
    AppDelegate* delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate showThemePicker:sender];
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver: self];
}



@end