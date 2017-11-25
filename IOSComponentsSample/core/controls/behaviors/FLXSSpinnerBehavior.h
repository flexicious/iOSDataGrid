#import "FLXSVersion.h"
@protocol FLXSISpinnerOwner;
@class FLXSEvent;

/**
	 * Attaches the spinner behavior to the owner component.
	 * When the startspin method of this behavior is called, the
	 * behavior will instantiate a new spinner based on the owners
	 * Spinner Factory, and position it in the middle of the owner
	 * components display area.
	 * When the stop spin method is called, the behavior will remove
	 * the spinner from the owner component and stop the spin.
	 */

@interface FLXSSpinnerBehavior : NSObject
{
}

@property (nonatomic, weak) UIView<FLXSISpinnerOwner>* ownerComponent;

-(id)initWithGrid:(UIView<FLXSISpinnerOwner>*)ownerComponent;
/**
		 * Shows the spinner with default values defined below:<br/>
		 * Label: "Loading please wait"<br/>
		 * X Position : center X of the grid <br/>
		 * Y Position : center Y of the grid<br/>
		 * Grid Alpa when the spinner is active : 0.3<br/>
		 * Spinner appearance can be modified using styles <br/>.
		 */
 -(void)showSpinner:(NSString*)msg;
/**
		 * Removes the spinner and sets the bodyContainer.alpha back to 1
		 */
-(void)hideSpinner;

@end

