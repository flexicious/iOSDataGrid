//
//  iPadSelectionModeViewController.m
//  IOSComponentsSample
//
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadSelectionModeViewController.h"
#import "FLXSFlexiciousMockGenerator.h"


@interface iPadSelectionModeViewController ()

@end

@implementation iPadSelectionModeViewController



- (void)viewDidLoad
{
    [super viewDidLoad];

    self.flxsDataGrid.delegate = self;
    
    
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSSelectionModes"];
    [self initializeTitleOfToolBar : @"Selection Modes"];
    
    self.flxsDataGrid.dataProviderFLXS = [[FLXSFlexiciousMockGenerator instance] getFlatOrgList];
    [self applySelectionMode:[FLXSFlexDataGrid SELECTION_MODE_SINGLE_CELL]];
}
- (IBAction)radioClick:(id)sender {
    [self applySelectionMode:
        self.segmentControl.selectedSegmentIndex == 0 ? [FLXSFlexDataGrid SELECTION_MODE_SINGLE_CELL]
    :   self.segmentControl.selectedSegmentIndex == 1 ? [FLXSFlexDataGrid SELECTION_MODE_MULTIPLE_CELLS]
    :   self.segmentControl.selectedSegmentIndex == 2 ? [FLXSFlexDataGrid SELECTION_MODE_SINGLE_ROW]
    :   self.segmentControl.selectedSegmentIndex == 3 ? [FLXSFlexDataGrid SELECTION_MODE_MULTIPLE_ROWS]
    : [FLXSFlexDataGrid SELECTION_MODE_NONE]

    ];
}
- (IBAction)btn_showSelected_clickHanlder:(id)sender {

    if(self.flxsDataGrid.isRowSelectionMode)
        [FLXSUIUtils showMessage:[[FLXSUIUtils extractPropertyValues:self.flxsDataGrid.selectedObjects propertyToExtract:@"id"] componentsJoinedByString:@","] title:@"Selected Ids"];
    else if(self.flxsDataGrid.isCellSelectionMode)
        [FLXSUIUtils showMessage:[[FLXSUIUtils extractPropertyValues:self.flxsDataGrid.selectedCells propertyToExtract:@"cellDescription"] componentsJoinedByString:@","] title:@"Selected Ids"];


}
- (IBAction)bt_clear_clickHanler:(id)sender {

    [self.flxsDataGrid clearSelection];
}

-(void)applySelectionMode :(NSString*)mode
{
    
   self.flxsDataGrid.selectionMode=mode;
    FLXSFlexDataGridCheckBoxColumn * cbCol =(FLXSFlexDataGridCheckBoxColumn *) [self.flxsDataGrid.columnLevel getColumnByUniqueIdentifier:@"cbCol"];
    if(cbCol.radioButtonMode!=(self.segmentControl.selectedSegmentIndex==2)){
        cbCol.radioButtonMode=(self.segmentControl.selectedSegmentIndex==2);
    }
    cbCol.visible = self.segmentControl.selectedSegmentIndex==2 || self.segmentControl.selectedSegmentIndex==3;
    [self.flxsDataGrid reDraw];
}
- (void)viewDidUnload {
    [self setIPadToolBar:nil];
    [self setFlxsDataGrid:nil];
    [self setSegmentControl:nil];
    [super viewDidUnload];
}
@end
