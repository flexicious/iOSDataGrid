#import "FLXSVersion.h"
/**
	 * Stores user selection for records to print or to export. Only applicable
	 * when the filterPageSortMode of the grid is set to server,
	 * and the user requests to print all pages or specific pages
	 * of data that are not currently loaded.
	 * @return
	 */

@interface FLXSPrintExportOptions : NSObject
{

}
/**
* Specifies what to export, valid options are:
* EXPORT_CURRENT_PAGE
* EXPORT_ALL_PAGES
* EXPORT_SPECIFIED_PAGES
* EXPORT_SELECTED_RECORDS
*
* The All pages and specified pages are only available
* if paging is enabled and the grid is in client mode.
*/
@property (nonatomic, strong) NSString* printExportOption;
/**
		 * In conjunction with printOption/exportOption = PRINT_EXORT_SPECIFIED_PAGES
		 * determines which pages of a grid with paging enabled
		 * to print.
		 */
@property (nonatomic, assign) int pageFrom;
/**
		 * In conjunction with printOption/exportOption = PRINT_EXORT_SPECIFIED_PAGES
		 * determines which pages of a grid with paging enabled
		 * to print.
		 */
@property (nonatomic, assign) int pageTo;
/**
		 * In scenarios where you are using modules, or are in an AIR application,
		 * where you want the window to open up as a child of anything other than
		 * the top level application, use this property.
		 */
@property (nonatomic, strong) UIView* popupParent;
/**
		 * Flag to control whether or not to show the column picker. Defaults to true.
		 */
@property (nonatomic, assign) BOOL showColumnPicker;
/**
		 * Flag to control whether or not to show the warning message when user changes print layout or page size.
		 */
@property (nonatomic, assign) BOOL showWarningMessage;
/**
		 * A flag that will hide any columns that are not visible from being printed or exported by default. User can still go into
		 * column picker and include these columns. To disable the user from printing or exporting invisible columns altogether,
		 * please use the excludeHiddenColumns instead. Please note, when you set this flag, the columnsToPrint will get overwritten, so
		 * any changes you make to that array will be ignored.
		 * @default false
		 */
@property (nonatomic, assign) BOOL hideHiddenColumns;
/**
		 * A flag that will To disable the user from printing or exporting invisible columns altogether . User cannot go into
		 * column picker and include these columns. To hide any columns that are not visible from being printed or exported by default,
		 * please use the hideHiddenColumns instead
		 * @default false
		 */
@property (nonatomic, assign) BOOL excludeHiddenColumns;
/**
		 * To bypass flash player 10 security when filterPageSortMode="server", we need
		 * user action to initiate file download. This is the message we show the user
		 * to initiate user action.
		 */
@property (nonatomic, strong) NSString* saveFileMessage;


+ (NSString*)PRINT_EXPORT_CURRENT_PAGE;
+ (NSString*)PRINT_EXPORT_ALL_PAGES;
+ (NSString*)PRINT_EXPORT_SELECTED_PAGES;
+ (NSString*)PRINT_EXPORT_SELECTED_RECORDS;
@end

