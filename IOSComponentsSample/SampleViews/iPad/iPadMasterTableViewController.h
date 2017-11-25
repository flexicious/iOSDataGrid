
#import <UIKit/UIKit.h>
#import "FLXSExampleData.h"
#import "iPadDetailViewController.h"
 #import "iPadTextInputViewController.h"
#import "AppDelegate.h"
#import "iPadComboBoxViewController.h"
#import "iPadRadioButtonViewController.h"
#import "iPadCheckBoxListViewController.h"
#import "iPadMultiSelectComboBoxViewController.h"
#import "iPadDateComboBoxViewController.h"
#import "iPadSimpleViewController.h"
#import "iPadNestedViewController.h"
#import "iPadNestedDataFullyLazyLoadedViewController.h"
#import "iPadNestedDataPartialLazyLoadedViewController.h"
#import "iPadExampleViewControllerBase.h"
#import "iPadGrouped_Data_OutlookStyleViewController.h"
#import "iPadGroupedData_2ViewController.h"
#import "iPadGroupedDataViewController.h"
#import "iPadLevelItemRenderers_2ViewController.h"
#import "iPadLevelItemRenderersViewController.h"
#import "iPadProgramaticCellFormattingViewController.h"
#import "iPadCustomItemRenderersViewController.h"
#import "iPadEditableCellsViewController.h"
#import "iPadDynamicColumnsViewController.h"
#import "iPadLargeDatasetViewController.h"
#import "iPadToolbarActions_NestedDataViewController.h"
#import "iPadToolbarActionsViewController.h"
#import "iPadXmlDataViewController.h"
#import "iPadXmlGroupedDataViewController.h"
#import "iPadAutoResizingGridViewController.h"
#import "iPadSelectionModeViewController.h"
#import "iPadColumnLockModesViewController.h"
#import "iPadIconColumnsViewController.h"
#import "iPadHoverOverMenuViewController.h"
#import "iPadDragDropGridViewController.h"
#import "iPadCustomLoadingSpinnerViewController.h"
#import "iPadCustomPrintExampleViewController.h"
#import "iPadLargeDynamicGridViewController.h"
#import "iPadDynamicLevelsViewController.h"
#import "iPadErrorHandlingViewController.h"
#import "iPadDynamicGroupingViewController.h"
#import "iPadNestedUIViewController.h"
#import "iPadDisclosureIcon_GroupedUIViewController.h"
#import "iPadDisclosureIcon_NestedUIViewController.h"
#import "iPadExternalFilterViewController.h"
#import "iPadChangeTrackingAPIViewController.h"
#import "iPadRowSpanandColSpanViewController.h"
#import "iPadTraderViewViewController.h"
#import "iPadMultiSelectSetFilterValueViewController.h"
#import "iPadVariableHeaderRowHeightViewController.h"
#import "iPadVariableRowHeightViewController.h"
#import "iPadFiltercomboboxdataproviderViewController.h"
#import "iPadLocalizationViewController.h"
#import "iPadOnlyOneItemOpenViewController.h"
#import "iPadSortNumericViewController.h"
#import "iPadMultipleGroupingManualViewController.h"
#import "iPadCustomFooterViewController.h"
#import "iPadColumnWidthModeViewController.h"
#import "iPadFullRowEditViewController.h"
#import "iPadCustomMatchFilterControlViewController.h"

@class iPadDetailViewController,AppDelegate,iPadTextInputViewController;

@interface iPadMasterTableViewController : UITableViewController {
    NSMutableArray*controlExampleNames, *gridExampleNames;
    UIViewController    *currentViewController;
}

@property (strong, nonatomic)NSArray *gridExamples, *controlExamples;
@property(assign, nonatomic)AppDelegate *appDelegate;

@end


