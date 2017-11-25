
//http://www.flexicious.com/resources/Flex4/srcview/source/com/sample/examples/support/gridSettings/SettingsPopup.mxml.html

#import "FLXSSettingsViewController.h"
#import "FLXSCloseEvent.h"
#import "UIViewController+UIViewControllerAdditions.h"
#import "FLXSFlexDataGridColumn.h"
#import <QuartzCore/QuartzCore.h>

@implementation FLXSSettingsViewController


@synthesize containerViewController = _containerViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    if ([FLXSUIUtils isIPad])
    {
        self.cbxColumns.layer.cornerRadius=10;
        self.cbxColumns.layer.masksToBounds=YES;
        self.cbxColumns.layer.borderColor=[[UIColor lightGrayColor] CGColor];
        self.cbxColumns.layer.borderWidth=3;
    }
    else
    {
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(onCancel:)];
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(onOk:)];
        //UINavigationBar *navBar = [self.view viewWithTag:150];
        self.navigationItem.rightBarButtonItems = @[saveButton];
        self.navigationItem.leftBarButtonItem = cancelButton;
       
        
    }
    self.grid = self.grid;
}
  

- (void)viewDidUnload {
    [self setCbxColumns:nil];
    [self setCbFooters:nil];
    [self setCbFilters:nil];
    [self setTxtPageSize:nil];
    [super viewDidUnload];
}

-(void)setGrid:(FLXSFlexDataGrid *)grid {

    _grid=grid;
    NSMutableArray *visibleCols = [NSMutableArray array];
    
    for (FLXSFlexDataGridColumn *col in _grid.settingsColumns)
    {
        if(col.visible)
        [visibleCols        addObject:col];
    }
    self.cbxColumns.labelField = @"columnLabel";
    self.cbxColumns.dataFieldFLXS = @"headerText";
    self.cbxColumns.dataProviderFLXS = _grid.settingsColumns;
    self.cbxColumns.addAllItem = YES;

    self.cbxColumns.selectedValues = [FLXSUIUtils extractPropertyValues:visibleCols propertyToExtract:@"headerText"];

    [self.cbxColumns reloadData];
    _filterVisible=grid.filterVisible;
    _footerVisible=grid.footerVisible;
    _pageSize=grid.pageSize;
    _enablePaging=grid.enablePaging;
    _enableFilters=grid.enableFilters;
    _enableFooters=grid.enableFooters;

    self.cbFilters.on = _filterVisible;
    self.cbFooters.on = _footerVisible;
    self.txtPageSize.text = [[NSNumber numberWithInt:(int)_pageSize] description];

}
- (IBAction)onOk:(id)sender {
    NSMutableArray *collection = [NSMutableArray arrayWithArray:self.cbxColumns.selectedItems];
    for (FLXSFlexDataGridColumn *col in _grid.columns)
    {
         col.visible= [collection containsObject:col] || self.cbxColumns.isAllSelected;
    }
    _grid.filterVisible=self.cbFilters.on;
    _grid.footerVisible=self.cbFooters.on;
    _grid.pageSize= ([self.txtPageSize.text intValue]);
    [_grid reDraw];

    FLXSCloseEvent* evt = [[FLXSCloseEvent alloc] initWithType:[FLXSCloseEvent CLOSE]
                                                 andCancelable:NO
                                                    andBubbles:NO];
    evt.detail = [FLXSCloseEvent OK] ;
    [self dispatchEvent:evt];
    [self closePopup];
}

- (IBAction)onCancel:(id)sender {
    
    [self closePopup];
}

#pragma  Textfield Delegate
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
