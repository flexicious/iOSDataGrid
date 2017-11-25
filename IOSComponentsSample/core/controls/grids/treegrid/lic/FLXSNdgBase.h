#import "FLXSVersion.h"
#import "FLXSBaseUIControl.h"
#import "FLXSClassFactory.h"
#import "FLXSChecker.h"
@class FLXSToolbarAction;
@protocol FLXSIExtendedPager;

@interface FLXSNdgBase : FLXSBaseUIControl
{

}

@property (nonatomic, assign) int defaultRowCount;
@property (nonatomic, strong) NSArray* dataProviderFLXS;
@property (nonatomic, assign) BOOL structureDirty;
@property (nonatomic, assign) BOOL placementDirty;
@property (nonatomic, assign) BOOL snapDirty;
@property (nonatomic, assign) BOOL selectionInvalid;
@property (nonatomic, assign) BOOL heightIncreased;
@property (nonatomic, assign) BOOL widthIncreased;
@property (nonatomic, assign) BOOL componentsCreated;


@property (nonatomic, strong) NSMutableDictionary* itemFilters;
@property (nonatomic, weak) UIView* dropIndicator;
@property (nonatomic, strong) FLXSBaseUIControl* leftLockedVerticalSeparator;
@property (nonatomic, strong) FLXSBaseUIControl* rightLockedVerticalSeparator;
@property (nonatomic, strong) NSMutableDictionary* flattenedLevels;
@property (nonatomic, strong) NSObject* printExportParameters;

@property (nonatomic, assign) BOOL showSpinnerOnFilterPageSort;
@property (nonatomic, strong) FLXSClassFactory* spinnerFactory;
@property (nonatomic, assign) int totalRecords;
@property (nonatomic, strong) NSString* spinnerLabel;
//next version - v1.2 longtouchgesture will do right click
@property (nonatomic, strong) NSString* menuCopyCellMenuText;
@property (nonatomic, strong) NSString* menuCopySelectedRowMenuText;
@property (nonatomic, strong) NSString* menuCopyAllRowsMenuText;
@property (nonatomic, strong) NSString* menuCopySelectedRowsMenuText;
@property (nonatomic, strong) NSDate* lastTrace;
@property (nonatomic, assign) float totalTime;
@property (nonatomic, strong) NSString* traceValue;
@property (nonatomic, assign) BOOL enableLockedSectionSeparators;
 //@property (nonatomic, assign) BOOL enableKeyboardNavigation;
//@property (nonatomic, assign) BOOL enableDrag;
//@property (nonatomic, assign) SEL dropAcceptRejectFunction;
//@property (nonatomic, assign) SEL dragDropCompleteFunction;
//@property (nonatomic, strong) NSObject* dragRowData;
//@property (nonatomic, assign) SEL dragAvailableFunction;
//@property (nonatomic, assign) BOOL enableDrop;
@property (nonatomic, assign) BOOL lockDisclosureCell;
@property (nonatomic, assign) BOOL allowInteractivity;
@property (nonatomic, strong) NSMutableArray* selectedCells;
@property (nonatomic, assign) BOOL enableDrillDown;
@property (nonatomic, strong) NSMutableArray* toolbarActions;
@property (nonatomic, strong) NSMutableArray* predefinedFilters;
@property (nonatomic, assign) BOOL enableToolbarActions;
@property (nonatomic, strong) NSString* toolbarActionExecutedFunction;
@property (nonatomic, strong) NSString* toolbarActionValidFunction;
@property (nonatomic, strong) NSString* selectionMode;
@property (nonatomic, assign) BOOL keyboardListenersPaused;
@property (nonatomic, assign) BOOL inMultiRowEdit;


/**
        *  Color of the border.
        *  The default value depends on the component class;
        *  if not overridden for the class, the default value is <code>0xB7BABC</code>.
        * [Style(name="borderColor", type="uint", format="Color", inherit="no")]
        * @type {null}
        * @property borderColor
        * @default null
        */
@property (nonatomic, strong) UIColor *borderColor;

/**
 *  Bounding box sides.
 *  A space-delimited String that specifies the sides of the border to show.
 *  The String can contain <code>"left"</code>, <code>"top"</code>,
 *  <code>"right"</code>, and <code>"bottom"</code> in any order.
 *  The default value is <code>"left top right bottom"</code>,
 *  which shows all four sides.
 *
 *  This style is only used when borderStyle is <code>"solid"</code>.
 * [Style(name="borderSides", type="String", inherit="no")]
 * @type {null}
 * @property borderSides
 * @default null
 */
@property (nonatomic, strong) NSArray * borderSides ;
/**
 *  Bounding box thickness.
 *  @default 1
 * [Style(name="borderThickness", type="Number", format="Length", inherit="no")]
 * @type {null}
 * @property borderThickness
 * @default null
 */
@property (nonatomic, assign) int  borderThickness;

- (void)reloadData;

- (BOOL)hasBorderSide:(NSString *)side;

- (void)rebuild;

- (void)doInvalidate;

- (void)reDraw;

- (void)traceEvent:(NSString *)msg;

- (void)clearSelection;

- (void)invalidateCellWidths;

- (void)invalidateHeight;

- (void)invalidateWidth;
@end

