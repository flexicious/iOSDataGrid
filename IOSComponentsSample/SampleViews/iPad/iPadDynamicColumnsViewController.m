//
//  iPadDynamicColumnsViewController.m
//  IOSComponentsSample
//
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadDynamicColumnsViewController.h"
#import "FLXSFlexiciousMockGenerator.h"

@interface iPadDynamicColumnsViewController ()

@end

@implementation iPadDynamicColumnsViewController

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
    
    self.flxsDataGrid.delegate=self;
    
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSDynamicColumns"];
    [self initializeTitleOfToolBar:@"Dynamic Columns"];
    self.flxsDataGrid.dataProviderFLXS = [[FLXSFlexiciousMockGenerator instance] getFlatOrgList];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(FLXSFlexDataGridColumn*)addColumn:(NSString*)dataField :(NSString*)headerText
{
    FLXSFlexDataGridColumn *dgCol = [[FLXSFlexDataGridColumn alloc] init];
    dgCol.dataFieldFLXS =dataField;
    dgCol.headerText=headerText;
    dgCol.filterControlClass=@"TextInput";
    dgCol.filterOperation=@"BeginsWith";
    dgCol.width=200;
    dgCol.paddingLeft=10;
    dgCol.headerPaddingLeft=10;
    dgCol.footerPaddingLeft=10;
    dgCol.filterWaterMark =@"Begins With";
    return dgCol;
}
-(FLXSFlexDataGridColumn*)addCurrencyColumn:(NSString*)dataField :(NSString*)headerText
{
    FLXSFlexDataGridColumn *dgCol = [self addDateColumn:dataField :headerText];
    [dgCol setStyle:@"textAlign" :@"right"];
    dgCol.footerOperation=@"average";
    dgCol.footerLabel=@"Avg: ";
    [dgCol setStyle:@"paddingRight" :[NSNumber numberWithInt:15]];
    [dgCol setStyle:@"paddingRight":[NSNumber numberWithInt:15]];
    dgCol.filterOperation=@"GreaterThan";
    dgCol.filterWaterMark = @"Greater Than";
    return dgCol;
}
-(FLXSFlexDataGridColumn*)addDateColumn:(NSString*)dataField :(NSString*)headerText
{
    FLXSFlexDataGridColumn* dgCol =[self addColumn:dataField :headerText];
    dgCol.filterControlClass=@"DateComboBox";
    return dgCol;
}
-(void)DynamicColumns_grid_creationCompleteHandler:(NSNotification*)ns{
    
    self.flxsDataGrid.dataProviderFLXS = [FLXSFlexiciousMockGenerator.instance getFlatOrgList];
    [self.flxsDataGrid clearColumns:YES];
    FLXSFlexDataGridColumn *col=[ self addColumn:@"id" :@"Company ID"];
    col.columnLockMode=FLXSFlexDataGridColumn.LOCK_MODE_LEFT;
    [self.flxsDataGrid addColumn:col];
    col=[self addColumn:@"legalName" :@"Company Name"];
    col.paddingLeft=10;
    col.headerPaddingLeft=10;
    col.columnLockMode=FLXSFlexDataGridColumn.LOCK_MODE_RIGHT;
    [self.flxsDataGrid addColumn:col];
    [self.flxsDataGrid addColumn:[self addColumn:@"headquarterAddress.line1" :@"Address Line 1"]];
    [self.flxsDataGrid addColumn: [self addColumn:@"headquarterAddress.line2":@"Address Line2"]];
    [self.flxsDataGrid addColumn:[self addCurrencyColumn:@"earningsPerShare" :@"EPS"]];
    [self.flxsDataGrid addColumn:[self addColumn:@"headquarterAddress.line1":@"Address Line 1"]];
    [self.flxsDataGrid addColumn:[self addColumn:@"headquarterAddress.line2" :@"Address Line2"]];
    [self.flxsDataGrid addColumn:[self addCurrencyColumn:@"earningsPerShare" :@"EPS"]];
    [self.flxsDataGrid addColumn:[self addColumn:@"headquarterAddress.line1" :@"Address Line 1"]];
    [self.flxsDataGrid addColumn:[self addColumn:@"headquarterAddress.line2" :@"Address Line2"]];
    [self.flxsDataGrid addColumn:[self addCurrencyColumn:@"earningsPerShare" :@"EPS"] ];
    [self.flxsDataGrid addColumn:[self addColumn:@"headquarterAddress.line1" :@"Address Line 1"]];
    [self.flxsDataGrid addColumn:[self addColumn:@"headquarterAddress.line2" :@"Address Line2"]];
    [self.flxsDataGrid addColumn:[self addCurrencyColumn:@"earningsPerShare" :@"EPS"]];
    [self.flxsDataGrid distributeColumnWidthsEqually];
    [self.flxsDataGrid reDraw];
}

- (IBAction)btnAddCol_clickHandler:(id)sender {
    FLXSFlexDataGridColumn *col=[self addCurrencyColumn:@"lastStockPrice" :@"Last Stock Price"];
    [self.flxsDataGrid addColumn:col];
    [self.flxsDataGrid distributeColumnWidthsEqually];
    [self.flxsDataGrid reDraw];

}

//-(void)btnAddCol_clickHandler:(NSNotification*)ns
//{
//    FLXSFlexDataGridColumn *col=[self addCurrencyColumn:@"lastStockPrice" :@"Last Stock Price"];
//    [self.flxsDataGrid addColumn:col];
//    [self.flxsDataGrid distributeColumnWidthsEqually];
//    [self.flxsDataGrid reDraw];
//}
- (IBAction)btnRemoveCol_clickHandler:(id)sender {
    [self.flxsDataGrid removeColumn:[self.flxsDataGrid getColumnByDataField:@"lastStockPrice"]];
    [self.flxsDataGrid distributeColumnWidthsEqually];
    [self.flxsDataGrid reDraw];
}


//-(void)btnRemoveCol_clickHandler:(NSNotification *)ns
//{
//   [self.flxsDataGrid removeColumn:[self.flxsDataGrid getColumnByDataField:@"lastStockPrice"]];
//    [self.flxsDataGrid distributeColumnWidthsEqually];
//    [self.flxsDataGrid reDraw];
//}

- (void)viewDidUnload {
    [self setIPadToolBar:nil];
    [self setFlxsDataGrid:nil];
    [self setIPadToolBar:nil];
    [super viewDidUnload];
}
@end
