//http://www.flexicious.com/resources/Flex4/srcview/source/com/sample/examples/support/gridSettings/SaveSettingsPopup.mxml.html
#import "FLXSSavePreferenceViewController.h"
#import "FLXSCloseEvent.h"
#import "UIViewController+UIViewControllerAdditions.h"
#import "FLXSConstants.h"


@implementation FLXSSavePreferenceViewController {
@private
    __weak FLXSFlexDataGrid *_grid;
    BOOL _preferencesSet;
    BOOL _filtersEnabled;
    NSString *_preferenceName;
    BOOL _preferenceIsDefault;
}

@synthesize grid = _grid;
@synthesize preferencesSet = _preferencesSet;
@synthesize filtersEnabled = _filtersEnabled;
@synthesize preferenceName = _preferenceName;
@synthesize preferenceIsDefault = _preferenceIsDefault;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self       initView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Private methods..

-(void)initView
{
    for (int i =1 ; i <10;i++) {
        UISwitch     *switchView = (UISwitch*)[self.view   viewWithTag:i];
        [switchView     addTarget:self action:@selector(buttonSwitchPressed:) forControlEvents:UIControlEventValueChanged];
    }
}

-(void)buttonSwitchPressed:(id)sender
{
    NSLog(@"%d is sender",[sender   tag]);
}

#pragma mark - Actions...

- (IBAction)buttonPressCross:(id)sender {
 }

- (IBAction)buttonPressClearSavedPreferences:(id)sender {
    [self.grid clearPreferences];
    FLXSCloseEvent* evt = [[FLXSCloseEvent alloc] initWithType:[FLXSCloseEvent CLOSE]
                                                 andCancelable:NO
                                                    andBubbles:NO];
    evt.detail = [FLXSCloseEvent CANCEL] ;
    [self dispatchEvent:evt];
    if([FLXSUIUtils isIPad])
        [self.parentViewController dismissModalViewControllerAnimated:YES];
    else
        [self.parentViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)buttonPressSavePreferences:(id)sender {
    NSMutableArray * preferencesToPersist= [[NSMutableArray alloc] init];
    if(self.cbPERSIST_COLUMN_ORDER.on)[preferencesToPersist addObject:(FLXSConstants.PERSIST_COLUMN_ORDER)];
    if(self.cbPERSIST_COLUMN_VISIBILITY.on)[preferencesToPersist addObject:(FLXSConstants.PERSIST_COLUMN_VISIBILITY)];
    if(self.cbPERSIST_COLUMN_WIDTH.on)[preferencesToPersist addObject:(FLXSConstants.PERSIST_COLUMN_WIDTH)];
    if(self.cbPERSIST_FILTER.on)[preferencesToPersist addObject:(FLXSConstants.PERSIST_FILTER)];
    if(self.cbPERSIST_SORT.on)[preferencesToPersist addObject:(FLXSConstants.PERSIST_SORT)];
    if(self.cbPERSIST_FOOTER_FILTER_VISIBILITY.on)[preferencesToPersist addObject:(FLXSConstants.PERSIST_FOOTER_FILTER_VISIBILITY)];
    if(self.cbPERSIST_PAGE_SIZE.on)[preferencesToPersist addObject:(FLXSConstants.PERSIST_PAGE_SIZE)];
    if(self.cbPERSIST_PRINT_SETTINGS.on)[preferencesToPersist addObject:(FLXSConstants.PERSIST_PRINT_SETTINGS)];


    if(self.cbPERSIST_SCROLL.on){
        [preferencesToPersist addObject:(FLXSConstants.PERSIST_VERTICAL_SCROLL)];
        [preferencesToPersist addObject:(FLXSConstants.PERSIST_HORIZONTAL_SCROLL)];
    }
    self.grid.preferencesToPersist = [preferencesToPersist componentsJoinedByString:@","];
    [self.grid persistPreferences:@"Default" isDefault:YES ];
    if(self.grid.preferencePersistenceMode!=@"server")
        [FLXSUIUtils showMessage:(@"Preferences Saved!") title:@""];

    FLXSCloseEvent* evt = [[FLXSCloseEvent alloc] initWithType:[FLXSCloseEvent CLOSE]
                                                 andCancelable:NO
                                                    andBubbles:NO];
    evt.detail = [FLXSCloseEvent OK] ;
    [self dispatchEvent:evt];
    if([FLXSUIUtils isIPad])
        [self.parentViewController dismissModalViewControllerAnimated:YES];
    else
        [self.parentViewController dismissViewControllerAnimated:YES completion:NULL];}

- (IBAction)buttonPressCancel:(id)sender {
    FLXSCloseEvent* evt = [[FLXSCloseEvent alloc] initWithType:[FLXSCloseEvent CLOSE]
                                                 andCancelable:NO
                                                    andBubbles:NO];
    evt.detail = [FLXSCloseEvent CANCEL] ;
    [self dispatchEvent:evt];
    if([FLXSUIUtils isIPad])
        [self.parentViewController dismissModalViewControllerAnimated:YES];
    else
        [self.parentViewController dismissViewControllerAnimated:YES completion:NULL];
}

-(void)setGrid:(FLXSFlexDataGrid *)val {
    _grid=val;
    self.preferencesSet=val.enableFilters;
    self.filtersEnabled=self.grid.enableFilters;
//    self.preferenceName = self.grid.currentPreferenceInfo?self.grid.currentPreferenceInfo.name:@"Default";
//    self.preferenceIsDefault = self.grid.currentPreferenceInfo?(self.grid.currentPreferenceInfo.name==self.grid.currentPreferenceInfo.defaultPreferenceName):@"Default";
}

- (void)viewDidUnload {
    [self setCbPERSIST_COLUMN_ORDER:nil];
    [self setCbPERSIST_COLUMN_VISIBILITY:nil];
    [self setCbPERSIST_COLUMN_WIDTH:nil];
    [self setCbPERSIST_FILTER:nil];
    [self setCbPERSIST_SORT:nil];
    [self setCbPERSIST_FOOTER_FILTER_VISIBILITY:nil];
    [self setCbPERSIST_PAGE_SIZE:nil];
    [self setCbPERSIST_COLUMN_VISIBILITY:nil];
    [self setCbPERSIST_COLUMN_WIDTH:nil];
    [self setCbPERSIST_FILTER:nil];
    [self setCbPERSIST_SORT:nil];
    [self setCbPERSIST_FOOTER_FILTER_VISIBILITY:nil];
    [self setCbPERSIST_PAGE_SIZE:nil];
    [self setCbPERSIST_PRINT_SETTINGS:nil];
    [self setCbPERSIST_SCROLL:nil];
    [super viewDidUnload];
}
@end
