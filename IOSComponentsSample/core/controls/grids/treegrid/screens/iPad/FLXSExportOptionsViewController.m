
//http://www.flexicious.com/resources/Flex4/srcview/source/com/sample/examples/support/export/MyExportOptionsRenderer.mxml.html
#import "FLXSExportOptionsViewController.h"
#import "FLXSCloseEvent.h"
#import "UIViewController+UIViewControllerAdditions.h"
#import "FLXSConstants.h"
#import <MessageUI/MessageUI.h>
#import "FLXSExtendedExportController.h"


@interface FLXSExportOptionsViewController () <MFMailComposeViewControllerDelegate>

@end

@implementation FLXSExportOptionsViewController {
@private
    __weak FLXSFlexDataGrid *_grid;
    FLXSExportOptions *_exportOptions;
    UIDocumentInteractionController *_documentInteractionController;
}

@synthesize grid = _grid;
@synthesize exportOptions = _exportOptions;
@synthesize enablePaging;
@synthesize documentInteractionController = _documentInteractionController;
@synthesize pageCount;
@synthesize selectedObjectsCount;

@synthesize containerViewController = _containerViewController;

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
    if (![FLXSUIUtils isIPad])
    {
        [self initializeToolBar];
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(buttonPressCancel:)];
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(buttonPressExport:)];
        
        //UINavigationBar *navBar = [self.view viewWithTag:150];
        self.navigationItem.rightBarButtonItems = @[saveButton];
        self.navigationItem.leftBarButtonItem = cancelButton;
        
        
        [self.flxsExportOptionsScrollView setContentSize:CGSizeMake(self.flxsExportOptionsScrollView.frame.size.width, self.view.frame.size.height+50)];
    }
}

#pragma mark- Private methods..

-(void)initView
{
    // For setting TriState button state..
    
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
    
    self.rbnCurrentPage.checked =YES;
    
    
    [self.cbxExportFormat addEventListenerOfType:[FLXSEvent EVENT_CHANGE]
                                     usingTarget:self
                                     withHandler:@selector(onCbxExportFormatChange:)];
    
}


-(void)onCbxExportFormatChange:(NSNotification*) ns{
    //NSArray* dataprovider = self.cbxExportFormat.dataProviderFLXS;
    self.exportOptions.exporters = [self.cbxExportFormat.dataProviderFLXS objectAtIndex:self.cbxExportFormat.selectedIndex];
    self.exportOptions.exporter = [self.cbxExportFormat.dataProviderFLXS objectAtIndex:self.cbxExportFormat.selectedIndex];
}
- (IBAction)buttonPressExport:(id)sender {
    /* exportOptions.printExportOption=grpExportOptions.selectedValue.toString();
     if (rbnSpecifyPages.checked)
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
    
    [self closePopup];
}

- (IBAction)buttonPressEmail:(id)sender {
    [self showEmail];
}
- (void)showEmail{
    
    NSString *emailTitle = [FLXSConstants EXP_EMAIL_FILE_SUBJECT];
    NSString *messageBody =  [FLXSConstants EXP_EMAIL_FILE_BODY];
    if([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        
        FLXSExtendedExportController *exportvc = [FLXSExtendedExportController instance];
        exportvc.exportOptions = self.exportOptions;
        [exportvc doExport];
        // Determine the file name and extension
        NSArray *filepart = [self.exportOptions.exportFilePath componentsSeparatedByString:@"."];
        NSString *filename = [filepart objectAtIndex:0];
        NSString *extension = [filepart objectAtIndex:1];
        
        // Get the resource path and read the file using NSData
        NSString *filePath = [NSString stringWithFormat:@"%@.%@", filename, extension];// [[NSBundle mainBundle] pathForResource:filename ofType:extension];
        NSData *fileData = [NSData dataWithContentsOfFile:filePath];
        
        // Determine the MIME type
        NSString *mimeType;
        if ([extension isEqualToString:@"doc"]) {
            mimeType = @"application/msword";
        } else if ([extension isEqualToString:@"html"]) {
            mimeType = @"text/html";
        } else if ([extension isEqualToString:@"pdf"]) {
            mimeType = @"application/pdf";
        }else if ([extension isEqualToString:@"csv"]) {
            mimeType = @"text/csv";
        }
        else if ([extension isEqualToString:@"xml"]) {
            mimeType = @"text/xml";
        }else if([extension isEqualToString:@"txt"])
            mimeType = @"text/plain";
        
        // Add attachment
        [mc addAttachmentData:fileData mimeType:mimeType fileName:filename];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    }else{
        UIAlertView* alertview = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please setup the email account" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertview show];
    }
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self closePopup];
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
    [self setFlxsExportOptionsScrollView:nil];
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
    
    self.cbxExportFormat.dataProviderFLXS =self.exportOptions.exporters;
    self.cbxExportFormat.addAllItem = NO;
    self.cbxExportFormat.selectedValue = self.exportOptions.exporter.name;
    self.cbxExportFormat.labelField=@"name";
    self.cbxExportFormat.dataFieldFLXS =@"name";
}
//- --- iPhone ---




@end
