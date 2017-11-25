#import "AppDelegate.h"
#import "FLXSFlexiciousMockGenerator.h"

@implementation AppDelegate
@synthesize window, iPadDetailVC;
@synthesize navController;
void onUncaughtException(NSException *exception)
{
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //FLXSConstants.DATE_FORMAT= @"dd/MM/yy";
    //this is for generating the dummy data
    FLXSFlexiciousMockGenerator *gen = [FLXSFlexiciousMockGenerator instance];
    [gen addEventListenerOfType:@"progress" usingTarget:self withHandler:@selector(onProgress:)];

    [[FLXSStyleManager instance] setGridTheme:[FLXSStyleManager FLXS_GRID_THEME_IOS7]];

    NSSetUncaughtExceptionHandler(&onUncaughtException);

    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        //for iPAD, we launch a collection view instead of the default table view, because we have more space
        //to show example screen thumbnails.
        self.iPadDetailVC = [[iPadDetailViewController    alloc] initWithNibName:@"iPadDetailViewController" bundle:nil];
        navController = [[UINavigationController alloc] initWithRootViewController:self.iPadDetailVC];
        self.window.rootViewController = navController;

    }

    return YES;
}
- (void)onProgress:(NSNotification *)ns {
    FLXSFlexiciousMockGenerator *gen = [FLXSFlexiciousMockGenerator instance];

    if (gen.progress == 100) {
        [self onLoadComplete];
    }else{
        //Need to show progress bar here.
    }
}

- (void)onLoadComplete {
    FLXSFlexiciousMockGenerator *gen = [FLXSFlexiciousMockGenerator instance];
    [gen removeEventListenerOfType:@"progress" fromTarget:self usingHandler:@selector(onProgress:)];
    //here we can notify the application that dummy data has loaded
}


-(void)didSelectIndex:(int)index{
    
    [self.iPadThemePickerPopoverVC dismissPopoverAnimated:YES];
    [self applyTheme :index];
}
-(void)showThemePicker:(UIBarButtonItem*)sender{

    //this launches the theme picker popup on basis of iPad or iPhone.
    NSArray *sortedArray =[[NSArray  alloc] initWithObjects:@"Default",  @"Office Blue",  @"Office Gray" , @"Office Black" , @"Android Gray" , @"Apple Gray",  @"Apple Ivory" , @"Green Colorful", @"Pink Colorful",   @"ITunes", @"iOS7",nil];

    if([FLXSUIUtils isIPad]){
        if (self.iPadThemePickerPopoverVC ==nil)
        {
            if (self.iPadThemePickerVC == nil)
            {
                self.iPadThemePickerVC =[[iPadThemePickerViewController alloc] initWithNibName:@"iPadThemePickerViewController" bundle:nil];
                self.iPadThemePickerVC.theDelegate = self;
            }
            self.iPadThemePickerPopoverVC = [[UIPopoverController alloc] initWithContentViewController:self.iPadThemePickerVC];
        }

        self.iPadThemePickerVC.arrayThemeData =sortedArray;
        [self.iPadThemePickerVC.tableView  reloadData];
        [self.iPadThemePickerPopoverVC setPopoverContentSize:CGSizeMake(303, 239)]; //decent enough size of a popover
        [self.iPadThemePickerPopoverVC presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

    }
    else{
        if (self.iPhoneThemePickerVC == nil)
        {
            self.iPhoneThemePickerVC = [[iPhoneThemePickerViewController alloc] initWithNibName:@"iPhoneThemePickerViewController" bundle:nil];
            self.iPhoneThemePickerVC.arrayThemeValues = sortedArray;
            self.iPhoneThemePickerVC.theDelegate   = self;
        }
        [FLXSUIUtils addPopUpController:self.iPhoneThemePickerVC parent:self.window modal:YES];
    }

}
-(void) applyTheme:(int)index{
    //swap out the theme
    switch (index) {
        case 0: // For default image ..
            [[FLXSStyleManager instance] setGridTheme:[FLXSStyleManager FLXS_GRID_THEME_DEFAULT]];
            break;
        case 1:// For office blue
            [[FLXSStyleManager instance] setGridTheme:[FLXSStyleManager FLXS_GRID_THEME_OFFICE_BLUE]];
            break;
        case 2:
            [[FLXSStyleManager instance] setGridTheme:[FLXSStyleManager FLXS_GRID_THEME_OFFICE_GRAY]];
            break;
        case 3:
            [[FLXSStyleManager instance] setGridTheme:[FLXSStyleManager FLXS_GRID_THEME_OFFICE_BLACK]];
            break;
        case 4:
            [[FLXSStyleManager instance] setGridTheme:[FLXSStyleManager FLXS_GRID_THEME_ANDROID_GRAY]];
            break;
        case 5:
            [[FLXSStyleManager instance] setGridTheme:[FLXSStyleManager FLXS_GRID_THEME_APPLE_GRAY]];
            break;
        case 6:
            [[FLXSStyleManager instance] setGridTheme:[FLXSStyleManager FLXS_GRID_THEME_APPLE_IVORY]];
            break;
        case 7:
            [[FLXSStyleManager instance] setGridTheme:[FLXSStyleManager FLXS_GRID_THEME_GREEN_COLORFUL]];
            break;
        case 8:
            [[FLXSStyleManager instance] setGridTheme:[FLXSStyleManager FLXS_GRID_THEME_PINK_COLORFUL]];
            break;
        case 9:
            [[FLXSStyleManager instance] setGridTheme:[FLXSStyleManager FLXS_GRID_THEME_ITUNES]];
            break;
        case 10:
            [[FLXSStyleManager instance] setGridTheme:[FLXSStyleManager FLXS_GRID_THEME_IOS7]];
            break;



    }
    if(self.currentExample){
        NSArray * examples = @[self.currentExample];//[FLXSUIUtils isIPad]? iPadDetailVC.gridExamples: nil;
        for(FLXSExampleData *eg in examples){
            for(UIView *vw in eg.viewController.view.subviews){
                if([vw isKindOfClass:[FLXSFlexDataGrid class]]){
                    FLXSFlexDataGrid * grid = (FLXSFlexDataGrid *)vw;
                    if(grid.dataProviderFLXS !=nil){
                        [[FLXSStyleManager instance] applyStylesToGrid:grid];
                        [grid rebuild];
                    }
                }
            }
        }
    }

}

@end