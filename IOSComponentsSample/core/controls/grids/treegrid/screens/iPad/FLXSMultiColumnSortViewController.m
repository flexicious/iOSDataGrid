//
//  FLXSMultiColumnSortViewController.m
//  IOSComponentsSample
//
//  Created by Flexicious-111 on 7/2/13.
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "FLXSMultiColumnSortViewController.h"
#import "FLXSCloseEvent.h"
#import "UIViewController+UIViewControllerAdditions.h"
#import "FLXSFilterSort.h"
#import "FLXSFlexDataGridColumnLevel.h"
#import "FLXSFlexDataGridColumn.h"

@interface FLXSMultiColumnSortViewController ()
{
@private
    __weak FLXSFlexDataGrid *_grid;
    BOOL _preferencesSet;
    BOOL _filtersEnabled;
}
@end

@implementation FLXSMultiColumnSortViewController
@synthesize grid = _grid;

@synthesize containerViewController = _containerViewController;

-(void)viewDidLoad
{
    [super      viewDidLoad];
    if([FLXSUIUtils isIPad])
    {
    }
    else
    {
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(buttonPressCancel:)];
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(buttonPressApply:)];
        UIBarButtonItem *clearButton = [[UIBarButtonItem alloc] initWithTitle:(@"Clear") style:UIBarButtonItemStyleBordered target:self action:@selector(buttonPressClearAll:)];
        //UINavigationBar *navBar = [self.view viewWithTag:150];
        self.navigationItem.rightBarButtonItems = @[clearButton ,saveButton];
        self.navigationItem.leftBarButtonItem = cancelButton;
        
    }
    NSArray* myDataSource = _grid.sortableColumns;
    
    // Sort 1...
    self.cbx1.dataProviderFLXS = myDataSource;
    self.cbx1.text = @"Select";
    self.cbx1.labelField = @"headerText";
    self.cbx1.addAllItem = NO;
    
    // Sort 2/...
    self.cbx2.dataProviderFLXS = myDataSource;
    self.cbx2.text = @"Select";
    self.cbx2.labelField = @"headerText";
    self.cbx2.addAllItem = NO;
    
    // Sort 3..
    self.cbx3.dataProviderFLXS = myDataSource;
    self.cbx3.text = @"Select";
    self.cbx3.labelField = @"headerText";
    self.cbx3.addAllItem = NO;
    
    
    // Sort 4..
    self.cbx4.dataProviderFLXS = myDataSource;
    self.cbx4.labelField = @"headerText";
    self.cbx4.text = @"Select";
    self.cbx4.addAllItem = NO;
    
    self.uiSegmentedSort1.selectedSegmentIndex = 0;
    self.uiSegmentedSort2.selectedSegmentIndex = 0;
    self.uiSegmentedSort3.selectedSegmentIndex = 0;
    self.uiSegmentedSort4.selectedSegmentIndex = 0;
    
}

-(void) initView{
    
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setM_ButtonClearAll:nil];
    [self setM_ButtonApply:nil];
    [self setM_ButtonCancel:nil];
    [self setM_ButtonCross:nil];
    [self setCbx1:nil];
    [self setCbx2:nil];
    [self setCbx3:nil];
    [self setCbx4:nil];
    [super viewDidUnload];
}


- (IBAction)buttonPressClearAll:(id)sender {
    
    [self.grid removeAllSorts];
    
    [self closePopup];
    
}


- (IBAction)buttonPressCancel:(id)sender {
    
    [self closePopup];
}

- (IBAction)buttonPressCross:(id)sender {
    [self closePopup];
    
}

- (IBAction)segmentSort1:(id)sender {
    
}

- (IBAction)segmentSort2:(id)sender {
    
}

- (IBAction)segmentSort3:(id)sender {
    
}

- (IBAction)segmentSort4:(id)sender {
    
}

- (IBAction)buttonPressApply:(id)sender {
     NSMutableArray* sorts = [NSMutableArray array];
    FLXSFilterSort* fs;
    if(self.cbx1.selectedIndex>=0){
       
        FLXSFilterSort* fs= [[FLXSFilterSort alloc] init];
        
        FLXSFlexDataGridColumn* column = self.cbx1.dataProviderFLXS[self.cbx1.selectedIndex];
        fs.sortColumn = [column sortField];
        fs.isAscending = self.uiSegmentedSort1.selectedSegmentIndex == 0 ? YES: NO;
        //fs.sortCaseInsensitive = self.cbx1.selectedItem.sortCaseInsensitive;
        //fs.sortNumeric = cbCol1.selectedItem.sortNumeric;
        [sorts addObject:fs];
    }
    if(self.cbx2.selectedIndex>=0){
        fs=[[FLXSFilterSort alloc] init];
        FLXSFlexDataGridColumn* column = self.cbx2.dataProviderFLXS[self.cbx2.selectedIndex];
        fs.sortColumn = [column sortField];
        fs.isAscending = self.uiSegmentedSort2.selectedSegmentIndex == 0 ? YES : NO;
        //fs.sortCaseInsensitive = cbCol2.selectedItem.sortCaseInsensitive;
        //fs.sortNumeric = cbCol2.selectedItem.sortNumeric;
        [sorts addObject:fs];
    }
    if(self.cbx3.selectedIndex>=0){
       fs=[[FLXSFilterSort alloc] init];
        FLXSFlexDataGridColumn* column = self.cbx3.dataProviderFLXS[self.cbx3.selectedIndex];
        fs.sortColumn = [column sortField];
        fs.isAscending = self.uiSegmentedSort3.selectedSegmentIndex == 0 ? YES : NO;
        //fs.sortCaseInsensitive = cbCol3.selectedItem.sortCaseInsensitive;
        //fs.sortNumeric = cbCol2.selectedItem.sortNumeric;
        [sorts addObject:fs];
    }
    
    if(self.cbx4.selectedIndex>=0){
        fs=[[FLXSFilterSort alloc] init];
        FLXSFlexDataGridColumn* column = self.cbx4.dataProviderFLXS[self.cbx4.selectedIndex];
        fs.sortColumn = [column sortField];
        fs.isAscending = self.uiSegmentedSort4.selectedSegmentIndex == 0 ? YES : NO;
        [sorts addObject:fs];
    }
    
    [self.grid removeAllSorts];
    for(FLXSFilterSort *sort in sorts){
        [self.grid.columnLevel addSort:sort];
        
    }
    [self.grid rebuildBody:YES];
    [self.grid rebuildHeader];
    [self closePopup];
    
    /*
     if(cbCol1.selectedIndex>0){
     fs=new FilterSort();
     fs.sortColumn = cbCol1.selectedItem.sortField.toString();
     fs.isAscending = rbAsc1.selected;
     fs.sortCaseInsensitive = cbCol1.selectedItem.sortCaseInsensitive;
     fs.sortNumeric = cbCol1.selectedItem.sortNumeric;
     sorts.addItem(fs)
     }
     if(cbCol2.selectedIndex>0){
     fs=new FilterSort();
     fs.sortColumn = cbCol2.selectedItem.sortField.toString();
     fs.isAscending = rbAsc2.selected;
     fs.sortCaseInsensitive = cbCol2.selectedItem.sortCaseInsensitive;
     fs.sortNumeric = cbCol2.selectedItem.sortNumeric;
     sorts.addItem(fs)
     }
     if(cbCol3.selectedIndex>0){
     fs=new FilterSort();
     fs.sortColumn = cbCol3.selectedItem.sortField.toString();
     fs.isAscending = rbAsc3.selected;
     fs.sortCaseInsensitive = cbCol3.selectedItem.sortCaseInsensitive;
     fs.sortNumeric = cbCol2.selectedItem.sortNumeric;
     sorts.addItem(fs)
     }
     _grid.removeAllSorts();
     var i:int=0;
     for each(var sort:FilterSort in sorts){
     sort.column.level.addSort(sort);
     
     }
     grid.rebuildBody();
     grid.rebuildHeader();
     UIUtils.removePopUp(this);
     */
}


-(void)setGrid:(FLXSFlexDataGrid *)val {
    _grid=val;
    self.preferencesSet=val.enableFilters;
    self.filtersEnabled=self.grid.enableFilters;
    [self initView];
    //    self.preferenceName = self.grid.currentPreferenceInfo?self.grid.currentPreferenceInfo.name:@"Default";
    //    self.preferenceIsDefault = self.grid.currentPreferenceInfo?(self.grid.currentPreferenceInfo.name==self.grid.currentPreferenceInfo.defaultPreferenceName):@"Default";
}



@end
