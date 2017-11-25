#import "FLXSVersion.h"
#import "FLXSIFilterControl.h"
#import "FLXSFilterControlImpl.h"
#import "FLXSEvent.h"
@interface FLXSCheckBoxList : UITableView   <UITableViewDelegate, UITableViewDataSource, FLXSIFilterControl>
{
}
/**
* A list of the 'dataFieldFLXS' property values for each of the
* items in the selectedItems list.
*/
@property (nonatomic, strong) NSMutableArray* selectedValues;
/**
 * List of items that are checked
 */
@property (nonatomic, strong) NSMutableArray* selectedItems;

@property (nonatomic, readonly) BOOL isAllSelected;

@property (nonatomic, readonly) FLXSFilterControlImpl * filterControlInterface;
/**
 * Flag, when set will cause the associated control to have
 * an Filter.ALL_ITEM Item value, which can then be used by the filtering
 * infrastructure to ignore the column in the search
 * @return
 *
 */
@property (nonatomic, assign) BOOL addAllItem;
/**
 * Text of the "All" item. Defaults to "All"
 * @return
 *
 */
@property (nonatomic, strong) NSString* addAllItemText;

/**
*  The set of items this component displays.
*/
@property (nonatomic, strong) NSArray* dataProviderFLXS;
@property (nonatomic, assign) BOOL hasSearch;
/**
 *  The name of the field or property in the data provider item associated
 *  with the data value. IT is used in the calculation of the checked value
 */
@property (nonatomic, strong) NSString* dataFieldFLXS;
/**
 *  The name of the field or property in the data provider item associated
 *  with the display.
 *  This control control
 *  requires this property
 *  to be set in order to calculate the displayable text for the item
 *  renderer.
 */
@property (nonatomic, strong) NSString* labelField;
/**
 *  Returns the String that the item renderer displays for the given data object.
 *  This  method extracts the contents of the field specified by the
 *  <code>labelField</code> property, or gets the string value of the data object.
 *  If the method cannot convert the parameter to a String, it returns a
 *  single space.
 *  @param item Object to be rendered.
 */
- (NSString *)itemToLabel:(NSObject *)item;
/**
 *  Returns the String that is the checked value for the item.
 *  This  method extracts the contents of the field specified by the
 *  <code>dataFieldFLXS</code> property, or gets the string value of the data object.
 *  If the method cannot convert the parameter to a String, it returns a
 *  single space.
 *  @param item Object to be rendered.
 */
- (NSString *)itemToData:(NSObject *)item;
- (BOOL) isItemSelected:(NSObject *)item;


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
-(NSObject*)getValue;
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

