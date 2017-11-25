

#import "iPadExampleViewControllerBase.h"
//<!---
//<p>
//        This example demonstrates a number of ways in which you can customize cell display in the iOSComponentsDataGrid.
//</p>
//<ul>
//<li>The ID column uses the useUnderLine="true" useHandCursor="true" and enableCellClickRowSelect="false" properties</li>
//<li>The Name column uses the itemRenderer property to specify a text box class property</li>
//<li>The Website column uses the linkText="View Website" useHandCursor="true" useUnderLine="true" headerText="Website" and enableCellClickRowSelect properties. Description of each of these can be found on the FlexDataGridColumn asdocs.</li>
//<li>The lastStockPrice column uses itemRenderer property to display an Image of the stock chart thumbnail.</li>
//<li>The last column, Is Active, uses a inline header renderer, and an inline item renderer.
//We wire up the Change Event of the contained Checkboxes within the renderers, to update the "active" flag on the model object.</li>
//</ul>
//-->
@interface iPadCustomItemRenderersViewController : iPadExampleViewControllerBase
@property (strong, nonatomic) IBOutlet FLXSFlexDataGrid *flxsDataGrid;

@property (strong, nonatomic) IBOutlet UIToolbar *iPadToolBar;
@end
