#import "FLXSVersion.h"
@class FLXSEvent;

/**
	 * Attaches the tooltip behavior to any UI component. The behavior does not
	 * automatically trigger, however, it does wrap all the functionality needed to
	 * display a tooltip type control next to the requesting control.
	 */

@interface FLXSTooltipBehavior : NSObject
{

}

@property (nonatomic, weak) UIView* ownerComponent;
/**
		 * The current tooltip object.
		 */
@property (nonatomic, weak) UIView* currentTooltip;
/**
		 * The current tooltip object trigger.
		 */
@property (nonatomic, weak) UIView* currentTooltipTrigger;
@property (nonatomic, strong) NSTimer* tooltipWatcher;
@property (nonatomic, assign) float tooltipWatcherTimeout;

-(id)initWithGrid:(UIView*)ownerComponent;
/**
* Displays a tooltip for the control in question. The tooltip will disappear if the mouse
* moves over an area that is not the 'relativeTo' component or the tooltip component..
* @param relativeTo Which component to position the popup relative to
* @param tooltip The popup to display
* @param dataContext If the popup has a data property, it will be set to this value
* @param point If you specify this, the relativeTo is ignored, and the popup appears at the exact point you specify. Please ensure that the X and Y are relative to the Grid.
* @param leftOffset Whether to shift the popup left after calculating the positions, for customizing the actual position
* @param topOffset	Whether to shift the popup top after calculating the positions, for customizing the actual position
* @param offScreenMath	Whether or not to adjust the popup if it appears off screen
* @param where		One of three values, left, right or none. If left, positions to bottom left, if right, positions to bottom right, if none, positions right below the relativeTo component.
* @param container	The holder for the tooltip, defaults to UIUtils.getTopLevelApplication(). You may need to override in multi window Air apps.
* By default, the tooltip will go away once you hover the mouse out of the trigger cell or the tooltip and stayed that way for tooltipWatcherTimeout. You may also
* manually remove the tooltip by calling the hideToolTip() function.
*/
- (void)showTooltip:(UIView *)relativeTo tooltip:(UIView *)tooltip dataContext:(NSObject *)dataContext point:(Point *)point leftOffset:(float)leftOffset topOffset:(float)topOffset offScreenMath:(BOOL)offScreenMath where:(NSString *)where container:(NSObject *)container;
/**
		 * Dispatched by the system manager when the mouse moves and a tooltip is active...
		 * @param event
		 */
-(void)toolTipMoveHandler:(FLXSEvent*)event;
/**
		 * Hides the current tooltip.
		 */
-(void)hideTooltip;

@end

