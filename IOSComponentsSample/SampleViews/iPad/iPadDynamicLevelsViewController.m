//
//  iPadDynamicLevelsViewController.m
//  IOSComponentsSample
//
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadDynamicLevelsViewController.h"
#import "SampleXMLReader.h"
#import "FLXSDeal.h"
#import "FLXSTouchEvent.h"

@interface iPadDynamicLevelsViewController (){
    NSString* selectedObjects;
    NSString* openObjects;
}

@end

@implementation iPadDynamicLevelsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    //
    //fix our sizing issue on iOS7
    //
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    NSMutableArray *gridCgs = [[NSMutableArray alloc] init];
    
    self.flxsDataGrid.delegate = self;
    //[self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSSimpleGrid"];
    [self.flxsDataGrid setHeaderRowHeight:75];
    self.flxsDataGrid.horizontalScrollPolicy = @"auto";
    [self.flxsDataGrid setRowHeight:55];
    [self.flxsDataGrid setVariableRowHeight:TRUE];
    [self.flxsDataGrid setEnableAutoRefresh:FALSE];
    [self.flxsDataGrid setSelectionMode:[FLXSFlexDataGrid SELECTION_MODE_SINGLE_ROW]];
    
    
    FLXSFlexDataGridColumn *dgCol = [[FLXSFlexDataGridColumn alloc] init];
    dgCol.dataFieldFLXS  = @"dealDescription";
    dgCol.headerText     = @"Circuit\nNo";
    dgCol.headerAlign    = NSTextAlignmentCenter;
    dgCol.headerWordWrap = TRUE;
    dgCol.width          = 80;
    dgCol.sortable       = FALSE;
    dgCol.draggable      = FALSE;
    dgCol.textAlign      = @"1";
    dgCol.enableCellClickRowSelect = TRUE;
    [gridCgs addObject:dgCol];
    
    dgCol = [[FLXSFlexDataGridColumn alloc] init];
    dgCol.dataFieldFLXS  = @"pszCircuitDescription";
    dgCol.headerText     = @"Circuit Designation";
    dgCol.headerAlign    = NSTextAlignmentCenter;
    dgCol.headerWordWrap = TRUE;
    dgCol.width          = 250;
    dgCol.sortable       = FALSE;
    dgCol.draggable      = FALSE;
    [gridCgs addObject:dgCol];
    
    dgCol = [[FLXSFlexDataGridColumn alloc] init];
    dgCol.dataFieldFLXS  = @"pszTypeWiring";
    dgCol.headerText     = @"Type\nof\nWiring";
    dgCol.headerAlign    = NSTextAlignmentCenter;
    dgCol.headerWordWrap = TRUE;
    dgCol.width          = 80;
    dgCol.sortable       = FALSE;
    dgCol.draggable      = FALSE;
    dgCol.textAlign      = @"1";
    [gridCgs addObject:dgCol];
    
    dgCol = [[FLXSFlexDataGridColumn alloc] init];
    dgCol.dataFieldFLXS  = @"pszReferenceMethod";
    dgCol.headerText     = @"Reference\nMethod";
    dgCol.headerAlign    = NSTextAlignmentCenter;
    dgCol.headerWordWrap = TRUE;
    dgCol.width          = 90;
    dgCol.sortable       = FALSE;
    dgCol.draggable      = FALSE;
    dgCol.textAlign      = @"1";
    [gridCgs addObject:dgCol];
    
    dgCol = [[FLXSFlexDataGridColumn alloc] init];
    dgCol.dataFieldFLXS  = @"pszPointsServed";
    dgCol.headerText     = @"No of\npoints\nserved";
    dgCol.headerAlign    = NSTextAlignmentCenter;
    dgCol.headerWordWrap = TRUE;
    dgCol.width          = 80;
    dgCol.sortable       = FALSE;
    dgCol.draggable      = FALSE;
    dgCol.textAlign      = @"1";
    [gridCgs addObject:dgCol];
    
    //
    //
    //
    NSMutableArray *pListSubColumns = [[NSMutableArray alloc] init];
    
    FLXSFlexDataGridColumn *pSubColumn = [[FLXSFlexDataGridColumn alloc] init];
    pSubColumn.dataFieldFLXS = @"pszCircuitLive";
    pSubColumn.headerText    = @"Live\n(mm2)";
    pSubColumn.headerAlign   = NSTextAlignmentCenter;
    pSubColumn.width         = 80;
    pSubColumn.sortable      = FALSE;
    pSubColumn.draggable     = FALSE;
    pSubColumn.textAlign     = @"1";
    [pListSubColumns addObject:pSubColumn];
    
    pSubColumn = [[FLXSFlexDataGridColumn alloc] init];
    pSubColumn.dataFieldFLXS = @"pszCircuitCpc";
    pSubColumn.headerText    = @"cpc\n(mm2)";
    pSubColumn.headerAlign   = NSTextAlignmentCenter;
    pSubColumn.width         = 80;
    pSubColumn.sortable      = FALSE;
    pSubColumn.draggable     = FALSE;
    pSubColumn.textAlign     = @"1";
    [pListSubColumns addObject:pSubColumn];
    
    FLXSFlexDataGridColumnGroup *dgColGroup = [[FLXSFlexDataGridColumnGroup alloc] init];
    dgColGroup.headerText     = @"Circuit\nconductors csa";
    dgColGroup.columns        = pListSubColumns;
    dgColGroup.headerWordWrap = TRUE;
    dgColGroup.calculatedHeight = 100;
    dgColGroup.headerAlign = NSTextAlignmentCenter;
    [gridCgs addObject:dgColGroup];
    
    //
    //
    //
    dgCol = [[FLXSFlexDataGridColumn alloc] init];
    dgCol.dataFieldFLXS  = @"pszMaxDisconnectionTime";
    dgCol.headerText     = @"Maximum\nDisconnection\nTime\n(s)";
    dgCol.headerAlign    = NSTextAlignmentCenter;
    dgCol.headerWordWrap = TRUE;
    dgCol.width          = 120;
    dgCol.sortable       = FALSE;
    dgCol.draggable      = FALSE;
    dgCol.textAlign      = @"1";
    [gridCgs addObject:dgCol];
    
    //
    //
    //
    pListSubColumns = [[NSMutableArray alloc] init];
    
    pSubColumn = [[FLXSFlexDataGridColumn alloc] init];
    pSubColumn.dataFieldFLXS = @"pszBSEN";
    pSubColumn.headerText    = @"BS (EN)";
    pSubColumn.headerAlign   = NSTextAlignmentCenter;
    pSubColumn.width         = 130;
    pSubColumn.sortable      = FALSE;
    pSubColumn.draggable     = FALSE;
    pSubColumn.textAlign     = @"1";
    [pListSubColumns addObject:pSubColumn];
    
    pSubColumn = [[FLXSFlexDataGridColumn alloc] init];
    pSubColumn.dataFieldFLXS = @"pszType";
    pSubColumn.headerText    = @"Type No";
    pSubColumn.headerAlign   = NSTextAlignmentCenter;
    pSubColumn.width         = 80;
    pSubColumn.sortable      = FALSE;
    pSubColumn.draggable     = FALSE;
    pSubColumn.textAlign     = @"1";
    [pListSubColumns addObject:pSubColumn];
    
    pSubColumn = [[FLXSFlexDataGridColumn alloc] init];
    pSubColumn.dataFieldFLXS = @"pszRating";
    pSubColumn.headerText    = @"Rating\n(A)";
    pSubColumn.headerAlign   = NSTextAlignmentCenter;
    pSubColumn.width         = 80;
    pSubColumn.sortable      = FALSE;
    pSubColumn.draggable     = FALSE;
    pSubColumn.textAlign     = @"1";
    [pListSubColumns addObject:pSubColumn];
    
    pSubColumn = [[FLXSFlexDataGridColumn alloc] init];
    pSubColumn.dataFieldFLXS = @"pszCapacity";
    pSubColumn.headerText    = @"Capacity\n(kA)";
    pSubColumn.headerAlign   = NSTextAlignmentCenter;
    pSubColumn.width         = 90;
    pSubColumn.sortable      = FALSE;
    pSubColumn.draggable     = FALSE;
    pSubColumn.textAlign     = @"1";
    [pListSubColumns addObject:pSubColumn];
    
    dgColGroup = [[FLXSFlexDataGridColumnGroup alloc] init];
    dgColGroup.headerText     = @"Overcurrent protective devices";
    dgColGroup.columns        = pListSubColumns;
    dgColGroup.headerWordWrap = TRUE;
    [gridCgs addObject:dgColGroup];
    
    //
    //
    //
    pListSubColumns = [[NSMutableArray alloc] init];
    
    pSubColumn = [[FLXSFlexDataGridColumn alloc] init];
    pSubColumn.dataFieldFLXS  = @"pszOperatingCurrent";
    pSubColumn.headerText     = @"Operating\nCurrent\n(mA)";
    pSubColumn.headerAlign    = NSTextAlignmentCenter;
    pSubColumn.headerWordWrap = TRUE;
    pSubColumn.width          = 90;
    pSubColumn.sortable       = FALSE;
    pSubColumn.draggable      = FALSE;
    pSubColumn.textAlign      = @"1";
    [pListSubColumns addObject:pSubColumn];
    
    dgColGroup = [[FLXSFlexDataGridColumnGroup alloc] init];
    dgColGroup.headerText     = @"RCD";
    dgColGroup.columns        = pListSubColumns;
    dgColGroup.headerWordWrap = TRUE;
    [gridCgs addObject:dgColGroup];
    
    //
    //
    //
    dgCol = [[FLXSFlexDataGridColumn alloc] init];
    dgCol.dataFieldFLXS  = @"pszMaximumZs";
    dgCol.headerText     = @"Maximum Zs\nPermitted\n(Ω)";
    dgCol.headerAlign    = NSTextAlignmentCenter;
    dgCol.headerWordWrap = TRUE;
    dgCol.width          = 90;
    dgCol.sortable       = FALSE;
    dgCol.draggable      = FALSE;
    dgCol.textAlign      = @"1";
    [gridCgs addObject:dgCol];
    
    //
    //
    //
    dgColGroup = [[FLXSFlexDataGridColumnGroup alloc] init];
    dgColGroup.headerText = @"Circuit impedances (Ohms)";
    [gridCgs addObject:dgColGroup];
    
    pListSubColumns = [[NSMutableArray alloc] init];
    
    pSubColumn = [[FLXSFlexDataGridColumn alloc] init];
    pSubColumn.dataFieldFLXS  = @"pszPhase";
    pSubColumn.headerText     = @"r1\n(Line)";
    pSubColumn.headerAlign    = NSTextAlignmentCenter;
    pSubColumn.headerWordWrap = TRUE;
    pSubColumn.width          = 80;
    pSubColumn.sortable       = FALSE;
    pSubColumn.draggable      = FALSE;
    pSubColumn.textAlign      = @"1";
    [pListSubColumns addObject:pSubColumn];
    
    pSubColumn = [[FLXSFlexDataGridColumn alloc] init];
    pSubColumn.dataFieldFLXS  = @"pszNeutral";
    pSubColumn.headerText     = @"rn\n(Neutral)";
    pSubColumn.headerAlign    = NSTextAlignmentCenter;
    pSubColumn.headerWordWrap = TRUE;
    pSubColumn.width          = 80;
    pSubColumn.sortable       = FALSE;
    pSubColumn.draggable      = FALSE;
    pSubColumn.textAlign      = @"1";
    [pListSubColumns addObject:pSubColumn];
    
    pSubColumn = [[FLXSFlexDataGridColumn alloc] init];
    pSubColumn.dataFieldFLXS  = @"pszCpc";
    pSubColumn.headerText     = @"r2\n(cpc)";
    pSubColumn.headerAlign    = NSTextAlignmentCenter;
    pSubColumn.headerWordWrap = TRUE;
    pSubColumn.width          = 80;
    pSubColumn.sortable       = FALSE;
    pSubColumn.draggable      = FALSE;
    pSubColumn.textAlign      = @"1";
    [pListSubColumns addObject:pSubColumn];
    
    FLXSFlexDataGridColumnGroup *dgColGroup2 = [[FLXSFlexDataGridColumnGroup alloc] init];
    dgColGroup2.headerText     = @"Ring final circuits only\n(measured end to end)";
    dgColGroup2.columns        = pListSubColumns;
    dgColGroup2.headerWordWrap = TRUE;
    [dgColGroup.columnGroups addObject:dgColGroup2];
    
    //
    //
    //
    pListSubColumns = [[NSMutableArray alloc] init];
    
    pSubColumn = [[FLXSFlexDataGridColumn alloc] init];
    pSubColumn.dataFieldFLXS  = @"pszR1R2";
    pSubColumn.headerText     = @"R1 + R2";
    pSubColumn.headerAlign    = NSTextAlignmentCenter;
    pSubColumn.headerWordWrap = TRUE;
    pSubColumn.width          = 80;
    pSubColumn.sortable       = FALSE;
    pSubColumn.draggable      = FALSE;
    pSubColumn.textAlign      = @"1";
    [pListSubColumns addObject:pSubColumn];
    
    pSubColumn = [[FLXSFlexDataGridColumn alloc] init];
    pSubColumn.dataFieldFLXS  = @"pszR2";
    pSubColumn.headerText     = @"R2";
    pSubColumn.headerAlign    = NSTextAlignmentCenter;
    pSubColumn.headerWordWrap = TRUE;
    pSubColumn.width          = 80;
    pSubColumn.sortable       = FALSE;
    pSubColumn.draggable      = FALSE;
    pSubColumn.textAlign      = @"1";
    [pListSubColumns addObject:pSubColumn];
    
    dgColGroup2 = [[FLXSFlexDataGridColumnGroup alloc] init];
    dgColGroup2.headerText     = @"All Circuits";
    dgColGroup2.columns        = pListSubColumns;
    dgColGroup2.headerWordWrap = TRUE;
    [dgColGroup.columnGroups addObject:dgColGroup2];
    
    //
    //
    //
    pListSubColumns = [[NSMutableArray alloc] init];
    
    pSubColumn = [[FLXSFlexDataGridColumn alloc] init];
    pSubColumn.dataFieldFLXS  = @"pszPhasePhase";
    pSubColumn.headerText     = @"Live\n- Live\n(MΩ)";
    pSubColumn.headerAlign    = NSTextAlignmentCenter;
    pSubColumn.headerWordWrap = TRUE;
    pSubColumn.width          = 80;
    pSubColumn.sortable       = FALSE;
    pSubColumn.draggable      = FALSE;
    pSubColumn.textAlign      = @"1";
    [pListSubColumns addObject:pSubColumn];
    
    pSubColumn = [[FLXSFlexDataGridColumn alloc] init];
    pSubColumn.dataFieldFLXS  = @"pszPhaseEarth";
    pSubColumn.headerText     = @"Live\n- Earth\n(MΩ)";
    pSubColumn.headerAlign    = NSTextAlignmentCenter;
    pSubColumn.headerWordWrap = TRUE;
    pSubColumn.width          = 80;
    pSubColumn.sortable       = FALSE;
    pSubColumn.draggable      = FALSE;
    pSubColumn.textAlign      = @"1";
    [pListSubColumns addObject:pSubColumn];
    
    dgColGroup = [[FLXSFlexDataGridColumnGroup alloc] init];
    dgColGroup.headerText     = @"Insulation\nresistance";
    dgColGroup.columns        = pListSubColumns;
    dgColGroup.headerWordWrap = TRUE;
    [gridCgs addObject:dgColGroup];
    
    //
    //
    //
    dgCol = [[FLXSFlexDataGridColumn alloc] init];
    dgCol.dataFieldFLXS  = @"pszPolarity";
    dgCol.headerText     = @"Polarity";
    dgCol.headerAlign    = NSTextAlignmentCenter;
    dgCol.headerWordWrap = TRUE;
    dgCol.width          = 80;
    dgCol.sortable       = FALSE;
    dgCol.draggable      = FALSE;
    dgCol.textAlign      = @"1";
    [gridCgs addObject:dgCol];
    
    dgCol = [[FLXSFlexDataGridColumn alloc] init];
    dgCol.dataFieldFLXS  = @"pszEarthFault";
    dgCol.headerText     = @"Maximum\nmeasured\nearth fault\nloop\nimpedance\n(Ω)";
    dgCol.headerAlign    = NSTextAlignmentCenter;
    dgCol.headerWordWrap = TRUE;
    dgCol.width          = 110;
    dgCol.sortable       = FALSE;
    dgCol.draggable      = FALSE;
    dgCol.textAlign      = @"1";
    [gridCgs addObject:dgCol];
    
    //
    //
    //
    pListSubColumns = [[NSMutableArray alloc] init];
    
    pSubColumn = [[FLXSFlexDataGridColumn alloc] init];
    pSubColumn.dataFieldFLXS  = @"pszRCDTimes1";
    pSubColumn.headerText     = @"Disconnection\ntime at ln\n(ms)";
    pSubColumn.headerAlign    = NSTextAlignmentCenter;
    pSubColumn.headerWordWrap = TRUE;
    pSubColumn.width          = 120;
    pSubColumn.sortable       = FALSE;
    pSubColumn.draggable      = FALSE;
    pSubColumn.textAlign      = @"1";
    [pListSubColumns addObject:pSubColumn];
    
    pSubColumn = [[FLXSFlexDataGridColumn alloc] init];
    pSubColumn.dataFieldFLXS  = @"pszRCDTimes2";
    pSubColumn.headerText     = @"Disconnection\ntime at 5ln\n(ms)";
    pSubColumn.headerAlign    = NSTextAlignmentCenter;
    pSubColumn.headerWordWrap = TRUE;
    pSubColumn.width          = 120;
    pSubColumn.sortable       = FALSE;
    pSubColumn.draggable      = FALSE;
    pSubColumn.textAlign      = @"1";
    [pListSubColumns addObject:pSubColumn];
    
    pSubColumn = [[FLXSFlexDataGridColumn alloc] init];
    pSubColumn.dataFieldFLXS  = @"pszRCDTestButton";
    pSubColumn.headerText     = @"Test\nbutton\noperation";
    pSubColumn.headerAlign    = NSTextAlignmentCenter;
    pSubColumn.headerWordWrap = TRUE;
    pSubColumn.width          = 80;
    pSubColumn.sortable       = FALSE;
    pSubColumn.draggable      = FALSE;
    pSubColumn.textAlign      = @"1";
    [pListSubColumns addObject:pSubColumn];
    
    dgColGroup = [[FLXSFlexDataGridColumnGroup alloc] init];
    dgColGroup.headerText     = @"RCD";
    dgColGroup.columns        = pListSubColumns;
    dgColGroup.headerWordWrap = TRUE;
    [gridCgs addObject:dgColGroup];
    
    self.flxsDataGrid.columnLevel.groupedColumns = gridCgs;
    
    self.flxsDataGrid.headerStyleName= [[FLXSFontInfo alloc] initWithFontName:@"HelveticaNeue" andPointSize:[NSNumber numberWithInt:18] andTextColor:[UIColor blackColor]];
    self.flxsDataGrid.columnGroupStyleName= [[FLXSFontInfo alloc] initWithFontName:@"HelveticaNeue" andPointSize:[NSNumber numberWithInt:18] andTextColor:[UIColor blackColor]];
    
    NSMutableArray *pArray = [[NSMutableArray alloc] init];
     
     for (int n = 0; n < 20; n++)
     {
         FLXSDeal *pItem = [[FLXSDeal alloc] init];
         pItem.dealDescription = [NSString stringWithFormat:@"%d", n];
     //pItem.value = @"testing";
     
         [pArray addObject:pItem];
     }
     self.flxsDataGrid.dataProviderFLXS = pArray;
    
    [self.flxsDataGrid addEventListenerOfType:[FLXSFlexDataGridEvent ITEM_CLICK] usingTarget:self withHandler:@selector(onGridItemClick:)];
    [self.flxsDataGrid addEventListenerOfType:[FLXSFlexDataGridEvent ITEM_DOUBLE_CLICK] usingTarget:self withHandler:@selector(onGridItemDoubleClick:)];
    [self.flxsDataGrid addEventListenerOfType:[FLXSFlexDataGridEvent HEADER_CLICKED] usingTarget:self withHandler:@selector(onGridHeaderClick:)];
    //[self.flxsDataGrid reDraw];
    

}

-(void) onGridItemClick :(NSNotification*) ns
{
    NSLog(@"onGridItemClick()");
    [self.flxsDataGrid gotoRow:self.flxsDataGrid.dataProviderFLXS.count - 1];

    
    //FLXSFlexDataGridEvent * evt = [ns.userInfo objectForKey:@"event"];
    //evt.level.childrenField = @"Territory_Rep";//this will be the newly created level
}

-(void) onGridItemDoubleClick:(NSNotification*) ns
{
    NSLog(@"onGridItemDoubleClick()");
    
    //FLXSFlexDataGridEvent * evt = [ns.userInfo objectForKey:@"event"];
    //evt.level.childrenField = @"Territory_Rep";//this will be the newly created level
}

-(void) onGridHeaderClick:(NSNotification*) ns
{
    NSLog(@"onGridHeaderClick()");
    
    FLXSFlexDataGridEvent * evt = [ns.userInfo objectForKey:@"event"];
    FLXSTouchEvent * touchEvent  = (FLXSTouchEvent*)evt.triggerEvent;
    
    NSLog(@"touch evnt %f %f",touchEvent.localX, touchEvent.localY);
    //evt.level.childrenField = @"Territory_Rep";//this will be the newly created level
}


-(void)onItemClick:(NSNotification *)ns{
    FLXSFlexDataGridEvent *event = [ns.userInfo objectForKey:@"event"];
    [FLXSUIUtils showToast:[@"You tapped on " stringByAppendingString:event.cellFLXS.text] title:@"Tap"];
}

-(void)onDynamicLevelCreated:(NSNotification *)ns{
    FLXSFlexDataGridEvent * evt = [ns.userInfo objectForKey:@"event"];
    evt.level.childrenField = @"Territory_Rep";//this will be the newly created level
}
-(void) dynamiclevels_gridchangeHandler:(NSNotification*)ns
{
    selectedObjects=@"";
     for (NSObject* item in [self.flxsDataGrid getSelectedObjects:NO :NO])
      selectedObjects =  [selectedObjects stringByAppendingFormat:@"%@,", [item valueForKey:@"id"] ];
    
    openObjects=@"";
    for(NSObject* item in [self.flxsDataGrid getOpenKeys])
        openObjects = [openObjects stringByAppendingFormat:@"%@,",item];
}

- (IBAction)button1_clickHandler:(id)sender {
    [self.flxsDataGrid setOpenKeys:[[NSArray alloc]initWithObjects:@"SW",@"AR", nil]];
    [self.flxsDataGrid setSelectedKeys:[[NSArray alloc] initWithObjects:@"BJ", @"TS", nil] openItems:NO ];
}

//-(void)button1_clickHandler:(NSNotification*)ns
//{
//    [self.flxsDataGrid setOpenKeys:[[NSArray alloc]initWithObjects:@"SW",@"AR", nil]];
//    [self.flxsDataGrid setSelectedKeys:[[NSArray alloc]initWithObjects:@"BJ",@"TS", nil] :NO];
//}
- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [self setIPadToolBar:nil];
    [super viewDidUnload];
}
@end
