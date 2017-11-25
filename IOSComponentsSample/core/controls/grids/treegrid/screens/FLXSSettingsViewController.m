
//http://www.flexicious.com/resources/Flex4/srcview/source/com/sample/examples/support/gridSettings/SettingsPopup.mxml.html

#import "FLXSSettingsViewController.h"
#import "FLXSCloseEvent.h"
#import "UIViewController+UIViewControllerAdditions.h"
#import "FLXSFlexDataGridColumn.h"
#import <QuartzCore/QuartzCore.h>

@implementation FLXSSettingsViewController
 

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self   initView];
}
 

-(void)initView{


    self.cbxColumns.layer.cornerRadius=10;
    self.cbxColumns.layer.masksToBounds=YES;
    self.cbxColumns.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    self.cbxColumns.layer.borderWidth=3;
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
    self.cbxColumns.dataField = @"headerText";
    self.cbxColumns.dataProvider = _grid.settingsColumns;
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
    self.txtPageSize.text = [[NSNumber numberWithInt:_pageSize] description];

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
    if([FLXSUIUtils isIPad])
        [self.parentViewController dismissModalViewControllerAnimated:YES];
    else
        [self.parentViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)onCancel:(id)sender {
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
@end
