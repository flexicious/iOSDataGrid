#import "FLXSVersion.h"
@class FLXSFlexDataGrid;
@class FLXSCellInfo;
@class FLXSEvent;
@protocol FLXSIFlexDataGridDataCell;
@class FLXSFlexDataGridItemEditEvent;
@protocol FLXSIFlexDataGridCell;

/**
	 * Enables full row edit behavior. Please note, when you do so,
	 * <ul>
	 * <li> The ItemEditBeginning event is dispatched, but the default is prevented </li>
	 * <li> Column based itemEditorValidatorFunction is ignored, use itemEditorsValidatorFunction on RowEditBehavior instead.</li>
	 * <li> Column based itemEditorApplyOnValueCommit is ignored, we only apply the values after the user clicks the save button. </li>
	 * </ul>
	 *
	 * The flow of logic is also different, since we now apply the values from the editor in one go as opposed to cell based edit, where each
	 * value is applied before beginning the edit on the next cell.
	 *
	 * The flow now is:
	 * <ul>
	 * <li>User clicks the save button</li>
	 * <li>If the itemEditorsValidatorFunction is defined on the RowEditBehavior, it is called. If it returns false, we stop. If it returns true, we continue.</li>
	 * <li>For each editor, if the itemEditorManagesPersistence flag is set to false, and the user has changed the value in the editor, we apply it back to the dataprovider using the editorDataField.
	 * If the itemEditorManagesPersistence flag is set to true, we ignore the editors value.</li>
	 * <li>If the itemEditorsValidatorFunction is defined on the RowEditBehavior, it is called. Return value is ignored. This is an opportunity for your code to handle any editors where the associated column has itemEditorManagesPersistence flag is set to false.</li>
	 * <li>We dispatch the ITEM_EDIT_END event</li>
	 * <li>We destroy the editors, cleanup everything and refresh the cells from the data.</li>
	 * </ul>
	 */
@interface FLXSRowEditBehavior : NSObject
{

}
/**
 * The grid associated with this behavior
 */
@property (nonatomic, weak) FLXSFlexDataGrid* grid;
@property (nonatomic, strong) UIView<FLXSIFlexDataGridDataCell>* currentEditCell;
/**
		 * Is the RowEditBehavior enabled?
		 */
@property (nonatomic, assign) BOOL enabled;
/**
* The container for left locked edit cells.
*/
@property (nonatomic, strong) UIView* leftLockedContent;
/**
		 * The container for right locked edit cells.
		 */
@property (nonatomic, strong) UIView* rightLockedContent;
/**
		 * The container for unlocked edit cells.
		 */
@property (nonatomic, strong) UIScrollView* unlockedContent;
/**
		 * The container for the buttons.
		 */
@property (nonatomic, strong) UIView* buttonContainer;
/**
		 * The height of the button row.
		 */
@property (nonatomic, assign) float buttonRowHeight;
/**
		 * The space between the top of the edit row and the editors.
		 */
@property (nonatomic, assign) float padding;
/**
		 * The width of the button container
		 */
@property (nonatomic, assign) float buttonContainerWidth;
/**
		 * The height of the button row.
		 */
@property (nonatomic, assign) float buttonContainerHeight;
@property (nonatomic, assign) float keyboardHeight;
@property (nonatomic, assign) BOOL keyboardHeightMoved;

/**
* The text of the Save Button
*/
@property (nonatomic, strong) NSString* okButtonText;
/**
		 * The ok Button
		 */
@property (nonatomic, strong) UIButton* okButton;
/**
		 * The cancel Button
		 */
@property (nonatomic, strong) UIButton* cancelButton;
/**
		 * The text of the Cancel Button
		 */
@property (nonatomic, strong) NSString* cancelButtonText;
/**
		 * The styleName to apply to the OK button
		 */
@property (nonatomic, strong) NSString* okButtonStyleName;
/**
		 * The styleName to apply to the Cancel button
		 */
@property (nonatomic, strong) NSString* cancelButtonStyleName;
/**
		 * @private
		 */
@property (nonatomic, strong) NSMutableDictionary* editorMap;
/**
		 * The cellinfo associated with the  currentEditCell
		 */
@property (nonatomic, strong) FLXSCellInfo* currentEditCellInfo;
/**
		 * A function that may be used to validate all the item editors. Will take dictionary object, where in the key will be the "uniqueIdentifier" of each of the columns, and the values will be the actual editors.
		 * Should return true or false.
		 */
@property (nonatomic, strong) NSString* itemEditorsValidatorFunction;
/**
		 * A function that may be used to commit item editors where itemEditorManagesPersistence=true. Once itemEditorsValidatorFunction is null or returns true, the editors that
		 * use the built in persistence will populate the corresponding data object properties. However, editors where itemEditorManagesPersistence=true do not do this. This function
		 * allows you to commit values for editors where itemEditorManagesPersistence=true. This is function Will take dictionary object, where in the key will be the "uniqueIdentifier" of each of the columns, and the values will be the actual editors.
		 *
		 */
@property (nonatomic, strong) NSString* itemEditorsCommitFunction;
/**
		 * A function that may be used to init all the item editors. Will take dictionary object, where in the key will be the "uniqueIdentifier" of each of the columns, and the values will be the actual editors.
		 * Should return void.
		 */
@property (nonatomic, strong) NSString* itemEditorsInitializeFunction;
/**
		 * @private
		 */
@property (nonatomic, strong) NSMutableArray* childrenDisabledForEdit;

-(id)initWithGrid:(FLXSFlexDataGrid*)grid;

-(void)endEdit:(FLXSEvent*)event;
/**
		 * @private
		 */
-(void)onItemEditBeginning:(NSNotification*)ns;
/**
		 * @private
		 */
-(void)saveEditors:(UIView*)editorContainer;
/**
* @private
*/
- (void)drawBorder:(UIView *)sprite cell:(UIView <FLXSIFlexDataGridCell> *)cell left:(BOOL)left right:(BOOL)right top:(BOOL)top bottom:(BOOL)bottom;
/**
		 * @private
		 */
-(void)onItemEditEnd:(FLXSEvent*)event;

@end

