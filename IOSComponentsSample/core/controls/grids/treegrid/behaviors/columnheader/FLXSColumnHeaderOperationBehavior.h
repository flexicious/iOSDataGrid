#import "FLXSVersion.h"
@class FLXSClassFactory;
@class FLXSFlexDataGrid;
@class FLXSFlexDataGridHeaderCell;
@class FLXSToolbarAction;
@protocol FLXSIFlexDataGridCell;

/**
	 * A class that is responsible for associating the column header menu with header cells
	 * The default list of operations is the static variable on this class. You can override
	 * this default list globally by modifying this list, or you can associate individual column
	 * header operations with each column.
	 */
@interface FLXSColumnHeaderOperationBehavior : NSObject
{

}

@property (nonatomic, weak) FLXSFlexDataGrid* grid;
@property (nonatomic, weak) FLXSFlexDataGridHeaderCell* currentHeaderCell;
@property (nonatomic, assign) BOOL hideDisabledOptions;
@property (nonatomic, strong) UIView* dropdownIcon;
@property (nonatomic, strong) UIView<FLXSIFlexDataGridCell>* triggerCell;
@property (nonatomic, strong) UIView* menu;
@property (nonatomic, strong) FLXSClassFactory* dropDownIconRenderer;
@property (nonatomic, assign) BOOL enabled;

+ (BOOL)isEnabledFunction:(FLXSToolbarAction *)action grid:(FLXSFlexDataGrid *)grid;

+ (BOOL)onToolbarActionExecuted:(FLXSToolbarAction *)action grid:(FLXSFlexDataGrid *)grid;
-(id)initWithGrid:(FLXSFlexDataGrid*)grid;

 -(void)killIcon;

+ (UIImage*)iconsortDescending;
+ (UIImage*)iconHideColumn;
+ (UIImage*)iconSizeToFit;
+ (UIImage*)iconSizeColToFit;
+ (UIImage*)iconswapsort;
+ (UIImage*)iconaddtosort;
+ (UIImage*)iconremovefromsort;
+ (UIImage*)iconremoveallsorts;
+ (UIImage*)iconsortsettings;
+ (UIImage*)iconunlock;
+ (UIImage*)iconscrollLeft;
+ (UIImage*)iconscrollRight;
+ (FLXSToolbarAction*)COL_HEADER_SORT_ASCENDING_ACTION;
+ (FLXSToolbarAction*)COL_HEADER_SORT_DESCENDING_ACTION;
+ (FLXSToolbarAction*)COL_HEADER_ADD_TO_SORT_ACTION;
+ (FLXSToolbarAction*)COL_HEADER_REMOVE_FROM_SORT_ACTION;
+ (FLXSToolbarAction*)COL_HEADER_SWAP_SORT_ORDER_ACTION;
+ (FLXSToolbarAction*)COL_HEADER_REMOVE_SORT_ACTION;
+ (FLXSToolbarAction*)COL_HEADER_SORT_SETTINGS_ACTION;
+ (FLXSToolbarAction*)COL_HEADER_CLEAR_FILTER_ACTION;
+ (FLXSToolbarAction*)COL_HEADER_HIDE_COLUMN_ACTION;
+ (FLXSToolbarAction*)COL_HEADER_SHOW_HIDE_COLUMNS_ACTION;
+ (FLXSToolbarAction*)COL_HEADER_SIZE_COL_TO_FIT_ACTION;
+ (FLXSToolbarAction*)COL_HEADER_SIZE_ALL_COLS_TO_FIT_ACTION;
+ (FLXSToolbarAction*)COL_HEADER_LEFT_LOCK_COLUMN_ACTION;
+ (FLXSToolbarAction*)COL_HEADER_RIGHT_LOCK_COLUMN_ACTION;
+ (FLXSToolbarAction*)COL_HEADER_UNLOCK_COLUMN_ACTION;
+ (NSArray*)DEFAULT_COLUMN_HEADER_OPERATIONS;
@end

