#import "iPadSimpleViewController.h"
#import "FLXSFlexiciousMockGenerator.h"
#import "SampleUIUtils.h"

@interface iPadSimpleViewController ()

@end

@implementation iPadSimpleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeTitleOfToolBar : @"Simple"];
    self.flxsDataGrid.delegate = self;
    [self buildGrid:self.flxsDataGrid FromXmlResource:[FLXSUIUtils isIPad]?@"FLXSSimpleGrid":@"FLXSSimpleGridIPhone"];
    self.flxsDataGrid.dataProviderFLXS = [[FLXSFlexiciousMockGenerator instance] getFlatOrgList];
 
    self.flxsDataGrid.headerStyleName= [[FLXSFontInfo alloc] initWithFontName:@"HelveticaNeue" andPointSize:[NSNumber numberWithInt:20] andTextColor:[UIColor blackColor]];
    
    
    self.flxsDataGrid.columnGroupStyleName= [[FLXSFontInfo alloc] initWithFontName:@"HelveticaNeue" andPointSize:[NSNumber numberWithInt:20] andTextColor:[UIColor blackColor]];

}


 -(NSString*)dataGridFormatCurrencyLabelFunction:(NSObject *)rowData :(FLXSFlexDataGridColumn *)col{
     // return @"123";
     return [SampleUIUtils formatCurrency:[(NSNumber *) [FLXSExtendedUIUtils resolveExpression:rowData expression:col.dataFieldFLXS valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ] floatValue]];
 }

- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [super viewDidUnload];
}
@end
