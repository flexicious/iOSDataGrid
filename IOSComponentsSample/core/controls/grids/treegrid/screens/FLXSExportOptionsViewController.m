
//http://www.flexicious.com/resources/Flex4/srcview/source/com/sample/examples/support/export/MyExportOptionsRenderer.mxml.html
#import "FLXSExportOptionsViewController.h"
#import "FLXSCloseEvent.h"
#import "UIViewController+UIViewControllerAdditions.h"
#import "FLXSConstants.h"


@interface FLXSExportOptionsViewController ()

@end

@implementation FLXSExportOptionsViewController {
@private
    __weak FLXSFlexDataGrid *_grid;
    __weak FLXSExportOptions *_exportOptions;
    UIDocumentInteractionController *_documentInteractionController;
}

@synthesize grid = _grid;
@synthesize exportOptions = _exportOptions;
@synthesize enablePaging;
@synthesize documentInteractionController = _documentInteractionController;
@synthesize pageCount;
@synthesize selectedObjectsCount;

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
    
    [self   initView];
}

#pragma mark- Private methods..

-(void)initView
{
    // For setting Tristatte button state..

    [self.rbnAllPages setRadioButtonMode:YES];
    [self.rbnCurrentPage setRadioButtonMode:YES];
    [self.rbnSelectedRecords setRadioButtonMode:YES];
    [self.rbnSpecifyPages setRadioButtonMode:YES];
    self.rbnAllPages.title = [FLXSConstants EXP_RBN_ALL_PAGES_LABEL];
    self.rbnCurrentPage.title =  [FLXSConstants EXP_RBN_CURRENT_PAGE_LABEL];
    self.rbnSelectedRecords.title =  [FLXSConstants SELECTED_RECORDS];
    self.rbnSpecifyPages.title = [FLXSConstants EXP_RBN_SELECT_PGS_LABEL];

    [self.rbnAllPages setRadioButtonGroupName:@"PrintExportOption"];
    [self.rbnCurrentPage setRadioButtonGroupName:@"PrintExportOption"];
    [self.rbnSelectedRecords setRadioButtonGroupName:@"PrintExportOption"];
    [self.rbnSpecifyPages setRadioButtonGroupName:@"PrintExportOption"];

    self.rbnCurrentPage.selected=YES;


    [self.cbxExportFormat addEventListenerOfType:[FLXSEvent EVENT_CHANGE]
                                     usingTarget:self
                                     withHandler:@selector(onCbxExportFormatChange:)];

}


-(void)onCbxExportFormatChange:(NSNotification*) ns{
    
    self.exportOptions.exporters = [self.cbxExportFormat.dataProvider objectAtIndex:self.cbxExportFormat.selectedIndex];
}
- (IBAction)buttonPressExport:(id)sender {
    /* exportOptions.printExportOption=grpExportOptions.selectedValue.toString();
     if (rbnSpecifyPages.selected)
     {
     if (Validator.validateAll([vldTxtPageFrom, vldTxtPageTo]).length == 0)
     {
     exportOptions.pageFrom=Number(txtPageFrom.text);
     exportOptions.pageTo=Number(txtPageTo.text);
     if (exportOptions.pageFrom <= exportOptions.pageTo)
     {
     close(Alert.OK);
     }
     else
     {
     Alert.show("Please ensure that the 'page from' is less than or equal to 'page to'");
     }
     }
     }
     else
     {
     */
    self.exportOptions.printExportOption=[FLXSPrintExportOptions PRINT_EXPORT_CURRENT_PAGE];


    FLXSCloseEvent* evt = [[FLXSCloseEvent alloc] initWithType:[FLXSCloseEvent CLOSE]
                                                 andCancelable:NO
                                                    andBubbles:NO];
    evt.detail = [FLXSCloseEvent OK] ;
   [self dispatchEvent:evt];
    //[self.parentViewController dismissModalViewControllerAnimated:YES];
    UIDocumentInteractionController *interactionController =  [UIDocumentInteractionController interactionControllerWithURL:[NSURL
        fileURLWithPath:self.exportOptions.exportFilePath]];
    // Initialize Document Interaction Controller
    self.documentInteractionController = interactionController;
    // Configure Document Interaction Controller
    [self.documentInteractionController setDelegate:self];
    // Present Open In Menu
    [self.documentInteractionController presentOpenInMenuFromRect:self.btnExport.frame
                                                           inView:self.view
                                                         animated:YES];
}
- (UIViewController *) documentInteractionControllerViewControllerForPreview: (UIDocumentInteractionController *) controller {
    return self;
}

- (IBAction)buttonPressCancel:(id)sender {
    FLXSCloseEvent* evt = [[FLXSCloseEvent alloc] initWithType:[FLXSCloseEvent CLOSE]
                                                 andCancelable:NO
                                                    andBubbles:NO];
    evt.detail = [FLXSCloseEvent CANCEL] ;
    [self dispatchEvent:evt];
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}
- (void)viewDidUnload {
    [self setBtnCancel:nil];
    [self setBtnExport:nil];
    [self setRbnCurrentPage:nil];
    [self setRbnAllPages:nil];
    [self setRbnSpecifyPages:nil];
    [self setRbnSelectedRecords:nil];
    [self setLblCurrentPage:nil];
    [self setLblAllPages:nil];
    [self setLblSpecifyPages:nil];
    [self setLblSelectedRecords:nil];
     [self setCbxExportFormat:nil];
    [self setCbxExportFormat:nil];
    [super viewDidUnload];
}

-(void)setGrid:(FLXSFlexDataGrid *)val {
   
    enablePaging = val.enablePaging;
    pageCount  = val.pageSize >0?val.totalRecords/val.pageSize :1;
    selectedObjectsCount = val.selectedObjects? val.selectedObjects.count:0;
    
    _grid=val;
    self.rbnSelectedRecords.userInteractionEnabled = _grid.selectedObjects.count>0;
}

-(void)setExportOptions:(FLXSExportOptions *)val {
    _exportOptions=val;

    self.cbxExportFormat.dataProvider=self.exportOptions.exporters;
    self.cbxExportFormat.addAllItem = NO;
    self.cbxExportFormat.selectedValue = self.exportOptions.exporter.name;
    self.cbxExportFormat.labelField=@"name";
    self.cbxExportFormat.dataField=@"name";
}


@end
