#import "FLXSVersion.h"
#import "FLXSIFilterControl.h"
#import "FLXSFilterControlImpl.h"
#import "FLXSEvent.h"
#import "FLXSISingleSelectFilterControl.h"


@interface FLXSComboBox : UIControl <UIPopoverControllerDelegate, UITableViewDelegate, UITableViewDataSource, FLXSIFilterControl
        ,UIActionSheetDelegate,FLXSISingleSelectFilterControl>
{
    @private
        UINavigationItem *navItem;
}
@property (nonatomic, readonly) UITableView *popOverTable;
@property (nonatomic, readonly) UIPopoverController *popOverController;
@property (nonatomic, readonly) UIActionSheet *uiActionSheet;

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
@property (nonatomic, readonly) UIAlertController *alertController;
#endif
@property (nonatomic, strong)   NSString *pickerTitle;

@property (nonatomic, readonly) FLXSFilterControlImpl * filterControlInterface;
@property (nonatomic, strong) NSString* selectedValue;
@property (nonatomic, assign) int selectedIndex;
@property (nonatomic, readonly) NSObject* selectedItem;
@property (nonatomic, assign) BOOL addAllItem;
@property (nonatomic, strong) NSString* addAllItemText;
@property (nonatomic, strong) NSArray* dataProviderFLXS;
@property (nonatomic, assign) BOOL hasSearch;
@property (nonatomic, assign) BOOL showAccessory;
@property (nonatomic, assign) float rowHeight;
@property (nonatomic, strong) NSString* dataFieldFLXS;
@property (nonatomic, strong) NSString* labelField;
@property (nonatomic, assign) float dropDownWidth;
-(id)initWithFrame:(CGRect)frame AndIcon:(UIImage *)icon;
-(void)_initWithIcon:(UIImage*)icon;

//non synthesized
@property (nonatomic, strong) NSString* text;

- (void)comboBoxButtonClicked:(id)comboBoxButtonClicked;
- (NSString*)itemToLabel:(NSObject *)item;




//FLXSIFilterControl methods
/**
 * The field to search on, usually same as the data field.
 * @return
 */
@property (nonatomic, strong) NSString* searchField;
/**
 * The filter operation to apply to the comparison
 * See the FilterExpression class for a list.
 * Please note, for CheckBoxList and MultiSelectComboBox, this field
 * defaults to "InList" and is ignored when set.
 * see FLXSFilterExpression
 *
 */
@property (nonatomic, strong) NSString* filterOperation;
/**
 * The event that the filter triggers on. Defaults to "change", or if the
 * filterRenderer supports FLXSIDelayedChange, then
 * the delayedChange event.
 * @see FLXSIDelayedChange
 */
@property (nonatomic, strong) NSString* filterTriggerEvent;
/**
 * This is usually automatically set, you don't have to manually set it,
 * unless you're sending strings as Date objects. When set, will attempt
 * to first convert the current value to the type you specified and then
 * do the conversion.
 * Values : auto,string,number,boolean,date
 * @default auto
 */
@property (nonatomic, strong) NSString* filterComparisonType;
/**
 * The grid that the filter belongs to - can be null
 * if filter is used outside the grid
 * @return
 *
 */
@property (nonatomic, strong) NSObject <FLXSIExtendedDataGrid>* grid;
/**
 * The grid column that the filter belongs to - can be null
 * if filter is used outside the grid
 * @return
 *
 */
@property (nonatomic, strong) NSObject <FLXSIDataGridFilterColumn>* gridColumn;
/**
 * Register with the container on creation complete
 */
@property (nonatomic, assign) BOOL autoRegister;
/**
		 * Calls clear on the underlying checkboxlist.
		 * If All Item is added, it is checked.
		 */
-(void)clear;
/**
 * Generic function that returns the value of a IFilterControl
  */
-(NSString*)getValue;
/**
 * Generic function that sets the value of a IFilterControl.
  */
-(void)setValue:(NSObject*)val;
//End IFilter control methods

//FLXSIEventDispatcher methods
/**
 *  Dispatches an event into the event flow.
 *  The event target is the EventDispatcher object upon which
 *  the <code>dispatchEvent()</code> method is called.
 *
 *  @param event The Event object that is dispatched into the event flow.
 *
 */
-(void)dispatchEvent:(FLXSEvent *)event;

/*
Registers an event listener object with an EventDispatcher object so that the listener receives notification of an event.
When you no longer need an event listener, remove it by calling EventDispatcher.removeEventListener(); otherwise,
memory problems might result. Objects with registered event listeners are not automatically removed from memory
 */
- (void)addEventListenerOfType:(NSString *)type usingTarget:(NSObject *)target withHandler:(SEL)handler;
/* Removes a listener from the EventDispatcher object. If there is no matching listener registered with the
EventDispatcher object, a call to this method has no effect.
 */
-(void)removeEventListenerOfType:(NSString *)type fromTarget:(NSObject *)target usingHandler:(SEL)handler;
//End FLXSIEventDispatcher methods


//Events
+ (NSString *)EVENT_CHANGE;
//End Events

@end
