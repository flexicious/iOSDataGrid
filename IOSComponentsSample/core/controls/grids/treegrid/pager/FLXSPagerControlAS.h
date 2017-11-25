#import "FLXSVersion.h"
#import "FLXSExportOptionsViewController.h"
#import "FLXSMultiColumnSortViewController.h"
#import "FLXSSettingsViewController.h"
#import "FLXSSavePreferenceViewController.h"


@class FLXSFlexDataGridColumnLevel;
@class FLXSRowInfo;
@class FLXSComboBox;

@class FLXSClassFactory;
@class FLXSEvent;
@class FLXSFlexDataGrid;
@class FLXSFlexDataGridEvent;
@class FLXSToolbarAction;
/**
	 * A ActionScript only version of the Pager control that significantly cuts down on
	 * initialization time. It does so by using pure ActionScript opposed to MXML,
	 * not using as many nested HBoxes, and not using plain events instead databindings to modify appearance.
	 */

@interface FLXSPagerControlAS : UIScrollView
{
    UIToolbar *toolBar ;

}

@property (nonatomic, assign) int totalRecords;
@property (nonatomic, assign) int pageSize;
@property (nonatomic, assign) int pageIndex;
@property (nonatomic, strong) NSString* pagerPosition;
@property (nonatomic, weak) FLXSFlexDataGridColumnLevel* level;
@property (nonatomic, weak) FLXSFlexDataGrid* grid;
@property (nonatomic, weak) FLXSRowInfo* rowInfo;
@property (nonatomic, strong) UIView* popMenu;
@property (nonatomic, strong) UIView* hboxToolbar;

@property (nonatomic, assign) BOOL pageDropdownDirty;
@property (nonatomic, strong) UILabel* lblPaging;
@property (nonatomic, strong) UIButton* BTN_FIRST_PAGE;
@property (nonatomic, strong) UIButton* BTN_PREV_PAGE;
@property (nonatomic, strong) UIButton* BTN_NEXT_PAGE;
@property (nonatomic, strong) UIButton* BTN_LAST_PAGE;
@property (nonatomic, strong) UILabel* lblGotoPage;
@property (nonatomic, strong) FLXSComboBox* cbxPage;
@property (nonatomic, strong) UIButton* BTN_MCS;
@property (nonatomic, strong) UIButton* BTN_EXP_ONE_DOWN;
@property (nonatomic, strong) UIButton* BTN_EXP_ONE_UP;
@property (nonatomic, strong) UIButton* BTN_EXP_ALL;
@property (nonatomic, strong) UIButton* BTN_COLLAPSE_ALL;
@property (nonatomic, strong) UIButton* BTN_PREFERENCES;
@property (nonatomic, strong) UIButton* BTN_SAVE_PREFS;
@property (nonatomic, strong) UIButton* BTN_OPEN_PREFS;
@property (nonatomic, strong) UIButton* BTN_FOOTER;
@property (nonatomic, strong) UIButton* BTN_FILTER;
@property (nonatomic, strong) UIButton* BTN_RUN_FILTER;
@property (nonatomic, strong) UIButton* BTN_CLEAR_FILTER;
@property (nonatomic, strong) UIButton* BTN_PRINT;
@property (nonatomic, strong) UIButton* BTN_PDF;
@property (nonatomic, strong) UIButton* BTN_WORD;
@property (nonatomic, strong) UIButton* BTN_EXCEL;



@property (nonatomic, strong) FLXSComboBox* cbxSettings;
@property (nonatomic, strong) FLXSComboBox* cbxFilter;
@property (nonatomic, strong) FLXSComboBox* cbxExport;



@property (nonatomic, assign) BOOL built;
@property (nonatomic, assign) int levelDepth;
@property (nonatomic, assign) int padding;
@property (nonatomic, strong) FLXSClassFactory* separatorFactory;
@property (nonatomic, assign) BOOL dispatchEvents;
@property (nonatomic, assign) BOOL actionsWidthInvalid;
-(void)reBuild;


-(void)popupButton_openHandler:(FLXSEvent*)event;
/**
		 * Default handler for the First Page Navigation Button
		 */
-(void)onImgFirstClick;
/**
		 * Default handler for the Previous Page Navigation Button
		 */
-(void)onImgPreviousClick;
/**
		 * Default handler for the Next Page Navigation Button
		 */
-(void)onImgNextClick;
/**
		 * Default handler for the Last Page Navigation Button
		 */
-(void)onImgLastClick;
/**
		 * Default handler for the Page Change Combo Box
		 */
-(void)onPageCbxChange;
/**
		 * Default handler for the Page Change Event
		 */
-(void)onPageChanged;
-(void)onCreationComplete:(FLXSEvent*)event;
/**
		 * Sets the page index to 1(0), dispatches the reset event.
		 */
-(void)reset;
/**
		 * Returns the first record on the page
		 */
-(int)pageStart;
/**
		 * Returns the last record on the page
		 */
-(int)pageEnd;
/**
		 * Returns the first total number of pages
		 */
-(int)pageCount;
-(FLXSFlexDataGrid*)nestedGrid;
/**
		 * Default handler for the Word Export Button. Calls
		 * ExtendedExportController.instance().export(this.grid,ExportOptions.create(ExportOptions.DOC_EXPORT))
		 */
-(void)onWordExport;
/**
		 * Default handler for the Word Export Button. Calls
		 * ExtendedExportController.instance().export(this.grid,ExportOptions.create())
		 */
-(void)onExcelExport;
/**
		 * Default handler for the Print Button. Calls
		 * var po:PrintOptions=PrintOptions.create();
		 * po.printOptionsViewrenderer = new ClassFactory(ExtendedPrintOptionsView);
		 * ExtendedPrintController.instance().print(this.grid,po)
		 */
-(void)onPrint;
/**
		 * Default handler for the Print Button. Calls
		 * var po:PrintOptions=PrintOptions.create(true);
		 * po.printOptionsViewrenderer = new ClassFactory(ExtendedPrintOptionsView);
		 * ExtendedPrintController.instance().print(this.grid,po)
		 */
-(void)onPdf;
/**
		 * Default handler for the Clear Filter Button.
		 * Calls grid.clearFilter()
		 */
-(void)onClearFilter;
/**
		 * Default handler for the Process Filter Button.
		 * Calls grid.processFilter()
		 */
-(void)onProcessFilter;
/**
		 * Default handler for the Show Hide Filter Button.
		 * Calls this.grid.filterVisible=!this.grid.filterVisible;nestedGrid.placeSections()
		 */
-(void)onShowHideFilter;
/**
		 * Default handler for the Show Hide Filter Button.
		 * Calls this.grid.filterVisible=!this.grid.filterVisible;nestedGrid.placeSections()
		 */
-(void)onShowHideFooter;
/**
		 * Default handler for the Settings Popup
		 * Calls var popup:Object=nestedGrid.popupFactorySettingsPopup.newInstance();UIUtils.addPopUp(popup as IFlexDisplayObject,grid as DisplayObject,true,null,null,grid.useModuleFactory?grid.moduleFactory:null);popup.grid=grid;
		 */
-(void)onShowSettingsPopup;
/**
		 * Default handler for the Save Settings Popup
		 * Calls var popup:Object=nestedGrid.popupFactorySaveSettingsPopup.newInstance();UIUtils.addPopUp(popup as IFlexDisplayObject,grid as DisplayObject,null,null,grid.useModuleFactory?grid.moduleFactory:null);popup.grid=grid;
		 */
-(void)onSaveSettingsPopup;
/**
		 * Default handler for the Open Settings Popup
		 * Calls var popup:Object=nestedGrid.popupFactoryOpenSettingsPopup.newInstance();UIUtils.addPopUp(popup as IFlexDisplayObject,grid as DisplayObject,true,null,null,grid.useModuleFactory?grid.moduleFactory:null);popup.grid=grid;
		 */
-(void)onOpenSettingsPopup;
/**
		 * @private
		 */
-(void)createToolbarActions;

+ (UIImage*)_toolbarActionIcon;
+ (void)applyTheme:(NSString*) themeName;

+ (UIImage*)iconFirstPage;
+ (UIImage*)iconPrevPage;
+ (UIImage*)iconNextPage;
+ (UIImage*)iconLastPage;
+ (UIImage*)iconMultiColumnSort;
+ (UIImage*)iconExpandOne;
+ (UIImage*)iconCollapseOne;
+ (UIImage*)iconExpandAll;
+ (UIImage*)iconCollapseAll;
+ (UIImage*)iconSettings;
+ (UIImage*)iconSaveSettings;
+ (UIImage*)iconOpenSettings;
+ (UIImage*)iconFooterShowHide;
+ (UIImage*)iconFilterShowHide;
+ (UIImage*)iconFilterRun;
+ (UIImage*)iconFilterClear;
+ (UIImage*)iconPrint;
+ (UIImage*)iconPdf;
+ (UIImage*)iconExportWord;
+ (UIImage*)iconExportExcel;
@end

