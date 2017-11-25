#import "FLXSVersion.h"

@class FLXSFlexDataGrid;
#import <UIKit/UIKit.h>
#import "FLXSTriStateCheckBox.h"
#import "UIViewController+UIViewControllerAdditions.h"
#import "FLXSComboBox.h"


@interface FLXSExportOptionsViewController : UIViewController<UIDocumentInteractionControllerDelegate>
- (IBAction)buttonPressExport:(id)sender;
- (IBAction)buttonPressCancel:(id)sender;

@property(nonatomic, assign)BOOL        enablePaging;
@property(nonatomic, assign)NSInteger pageCount;
@property(nonatomic, assign)NSInteger selectedObjectsCount;

@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (nonatomic,strong) UIDocumentInteractionController *documentInteractionController;

@property (weak, nonatomic) IBOutlet UIButton *btnExport;

@property (weak, nonatomic) IBOutlet FLXSTriStateCheckBox *rbnCurrentPage;
@property (weak, nonatomic) IBOutlet FLXSTriStateCheckBox *rbnAllPages;
@property (weak, nonatomic) IBOutlet FLXSTriStateCheckBox *rbnSpecifyPages;
@property (weak, nonatomic) IBOutlet FLXSTriStateCheckBox *rbnSelectedRecords;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrentPage;
@property (weak, nonatomic) IBOutlet UILabel *lblAllPages;
@property (weak, nonatomic) IBOutlet UILabel *lblSpecifyPages;
@property (weak, nonatomic) IBOutlet UILabel *lblSelectedRecords;
@property (weak, nonatomic) FLXSFlexDataGrid* grid;
@property (weak, nonatomic) IBOutlet FLXSComboBox *cbxExportFormat;
@property (weak, nonatomic) FLXSExportOptions* exportOptions; 

@end
