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

@synthesize containerViewController = _containerViewController;

- (void)viewDidLoad
{
     [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([FLXSUIUtils    isIPad])
    {
        [self       initView];
    }
    else{
        [self   initView];


        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(buttonPressCancel:)];
        UIBarButtonItem *clearButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(buttonPressSavePreferences:)];
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:(@"Clear") style:UIBarButtonItemStyleBordered target:self action:@selector(buttonPressClearSavedPreferences:)];
        //UINavigationBar *navBar = [self.view viewWithTag:150];
        self.navigationItem.rightBarButtonItems = @[clearButton ,saveButton];
        self.navigationItem.leftBarButtonItem = cancelButton;

        [self.flxsSaveSettingsScrollView setContentSize:CGSizeMake(self.flxsSaveSettingsScrollView.frame.size.width, self.view.frame.size.height+50)];
    }
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
}


- (IBAction)buttonPressClearSavedPreferences:(id)sender {
    [self.grid clearPreferences];
    FLXSCloseEvent* evt = [[FLXSCloseEvent alloc] initWithType:[FLXSCloseEvent CLOSE]
                                                 andCancelable:NO
                                                    andBubbles:NO];
    evt.detail = [FLXSCloseEvent CANCEL] ;
    [self dispatchEvent:evt];
    [self closePopup];
    [FLXSUIUtils showToast:(@"Preferences Cleared!") title:@""];

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
    if(![self.grid.preferencePersistenceMode isEqual:@"server"])
        [FLXSUIUtils showToast:(@"Preferences Saved!") title:@""];

    FLXSCloseEvent* evt = [[FLXSCloseEvent alloc] initWithType:[FLXSCloseEvent CLOSE]
                                                 andCancelable:NO
                                                    andBubbles:NO];
    evt.detail = [FLXSCloseEvent OK] ;
    [self dispatchEvent:evt];
    [self closePopup];
}


- (IBAction)buttonPressCancel:(id)sender {
    [self closePopup];
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
    [self setFlxsSaveSettingsScrollView:nil];
    [super viewDidUnload];
}


@end
