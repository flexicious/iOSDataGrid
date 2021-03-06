
#import "FLXSVersion.h"

#import <UIKit/UIKit.h>
#import "FLXSFlexDataGrid.h"
#import "FLXSComboBox.h"
#import "FLXSPopupUIViewControllerBase.h"

@class FLXSFlexDataGrid;
@interface FLXSMultiColumnSortViewController : FLXSPopupUIViewControllerBase

@property (weak, nonatomic) IBOutlet FLXSComboBox *cbx1;
@property (weak, nonatomic) IBOutlet FLXSComboBox *cbx3;
@property (weak, nonatomic) IBOutlet UIButton *m_ButtonClearAll;
@property (weak, nonatomic) IBOutlet FLXSComboBox *cbx4; 
@property (weak, nonatomic) IBOutlet UIButton *m_ButtonApply;
@property (weak, nonatomic) IBOutlet FLXSComboBox *cbx2;
@property (weak, nonatomic) IBOutlet UIButton *m_ButtonCancel;
@property (weak, nonatomic) IBOutlet UIButton *m_ButtonCross;
@property (weak, nonatomic) FLXSFlexDataGrid* grid;
@property (assign, nonatomic) BOOL preferencesSet;
@property (assign, nonatomic) BOOL filtersEnabled;
@property (weak, nonatomic) IBOutlet UISegmentedControl *uiSegmentedSort1;
@property (weak, nonatomic) IBOutlet UISegmentedControl *uiSegmentedSort2;
@property (weak, nonatomic) IBOutlet UISegmentedControl *uiSegmentedSort3;
@property (weak, nonatomic) IBOutlet UISegmentedControl *uiSegmentedSort4;

- (IBAction)buttonPressCancel:(id)sender;
- (IBAction)buttonPressCross:(id)sender;
- (IBAction)segmentSort1:(id)sender;
- (IBAction)segmentSort2:(id)sender;
- (IBAction)segmentSort3:(id)sender;
- (IBAction)segmentSort4:(id)sender;
- (IBAction)buttonPressClearAll:(id)sender;
- (IBAction)buttonPressApply:(id)sender;

@end
