#import "FLXSFlexDataGridColumn.h"
#import "FLXSVersion.h"

@class FLXSClassFactory;

/**
* A column to add checkbox selection to the grid. 
*/	
@interface FLXSFlexDataGridCheckBoxColumn : FLXSFlexDataGridColumn
{
}

/**
 * In single select datagrids, set this to true for the icon to appear as if it is a radio button 
 */	
@property (nonatomic, assign) BOOL radioButtonMode;
/**
 * Flag to enable/disable the top level select checkbox. You would use this if you need the checkbox selection behavior, but do not wish for the user to be able to select all. 
 */		

@property (nonatomic, assign) BOOL allowSelectAll;
/**
 * Flag to show checkbox as well as a display label. In header cells, shows checkbox and headerText. When you set this to true, the column width  mode switches from fixed to none, and the width switches from 25 to 100 (default column width)
 */
@property (nonatomic, assign) BOOL enableLabelAndCheckBox;
/**
 * Flag to enable/disable the top level select checkbox. You would use this if you need the checkbox selection behavior, but do not wish for the user to be able to select all. 
 */
@property (nonatomic, assign) BOOL enableSelectAll;
/**
 * In single select datagrids, set this to true for the icon to appear as if it is a radio button 
 */
@property (nonatomic, assign) BOOL enableRadioButtonMode;

-(FLXSFlexDataGridCheckBoxColumn *)generateInstance;

+ (FLXSClassFactory*)static_TriStateCheckBox;
@end