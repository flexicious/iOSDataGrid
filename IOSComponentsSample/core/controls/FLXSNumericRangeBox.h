#import "FLXSIFilterControl.h"

#import "FLXSIRangeFilterControl.h"
#import "FLXSEvent.h"
#import "FLXSTextInput.h"

/**
* An  HBox that contains two textboxes to specify a range.
* Implements IRangeFilterControl (IFilterControl)
* which enables it to be used within the filtering/binding infrasturcture.
* @see com.flexicious.controls.interfaces.filters.IFilterControl
* @see com.flexicious.controls.interfaces.databindings.IDataBoundControl
*/
@interface FLXSNumericRangeBox : UIView
{
	@private
		FLXSTextInput* textBoxStart;
		UILabel* separatorText;
		FLXSTextInput* textBoxEnd;
		BOOL _relinquishFocus;
		BOOL _shiftTabHandled;
		BOOL _tabHandled;
}

@property (nonatomic, strong) FLXSTextInput* textBoxStart;
@property (nonatomic, strong) UILabel* separatorText;
@property (nonatomic, strong) FLXSTextInput* textBoxEnd;
/**
		 * During filter tabbing, indicates that this control wishes to
		 * own its own tabbing, between the two boxes. If user tabs out of the second box
		 * or shift tabs out of the first box, it relinquishes focus to the tabbing mechanism
		 * of the filter row.
		 */
@property (nonatomic, assign) BOOL relinquishFocus;
@property (nonatomic, assign) BOOL shiftTabHandled;
@property (nonatomic, assign) BOOL tabHandled;

/**
		 * The start of the range
		 */
-(float)rangeStart;
/**
		 * @private
		 */
-(void)rangeStart:(float)o;
/**
		 * The End of the range
		 */
-(float)rangeEnd;
/**
		 * The start of the range
		 */
-(void)rangeEnd:(float)o;

-(void)onChange_textBoxEnd:(FLXSEvent*)evt;
-(void)onChange_textBoxStart:(FLXSEvent*)evt;
-(void)onChange;
-(BOOL)isRangeValid;
/**
		 *Returns an array of [rangeStart,rangeEnd]
		 */
-(NSArray*)range;
/**
		 * @private
		 */
-(void)range:(NSArray*)value;
/**
		 *Wipes out the text boxes
		 */
-(void)reset;
/**
		 *If the range is valid, returns the first value of the range.
		 */
-(NSObject*)searchRangeStart;
/**
		 *If the range is valid, returns the larst value of the range.
		 */
-(NSObject*)searchRangeEnd;
/**
		 * Returns the minimum value of the range
		 */
-(NSObject*)minValue;
/**
		 * Returns the maxinimum value of the range
		 */
-(NSObject*)maxValue;
/**
		 * Clears out the textboxes
		 */
-(void)clear;
/**
		 * Generic function that returns the value of a IFilterControl
		 */
-(NSObject*)getValue;
/**
		 * Generic function that sets the value of a IFilterControl
		 * @param val
		 */
-(void)setValue:(NSObject*)val;
/**
		 *Sets the focus on the first checkbox
		 */
-(void)setFocus;
/**
		 *Draws the focus around the first textbox
		 */
-(void)drawFocus:(BOOL)isFocused;

@end

