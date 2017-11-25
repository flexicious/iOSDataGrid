#import "FLXSVersion.h"
#import "FLXSISpinner.h"
#import "FLXSClassFactory.h"

@class FLXSEvent;

@protocol FLXSISpinnerOwner

@property (nonatomic, assign) BOOL showSpinnerOnCreationComplete;
@property (nonatomic, strong) NSString* spinnerLabel;
@property (nonatomic, strong) UIView<FLXSISpinner>* spinner;
@property (nonatomic, strong) FLXSClassFactory* spinnerFactory;
/**
		 * All elements of the spinner owner that should be blurred when the spinner is active.
		 * The alpha of this element will be set to the spinnerGridAlpha style or 0.3.
		 */
-(NSArray*) elementsToBlur;
/**
		 * The element of the owner that should be used to center the spinner.
		 */
-(UIView*) elementToCenter;
/**
		 * The parent to add the spinner to.
		 */
-(UIView*) spinnerParent;

       /**
		 * Shows the spinner with default values defined below:<br/>
		 * Label: "Loading please wait"<br/>
		 * X Position : center X of the owner component<br/>
		 * Y Position : center Y of the owner component<br/>
		 * Grid Alpa when the spinner is active : 0.3<br/>
		 * Spinner appearance can be modified using styles. See all the styles that start with the word spinner for more.<br/>.
		 */
       -(void)showSpinner:(NSString*)msg;
/**
		 * Removes the spinner and sets the alpha flag of each of the elements returned by elementsToBlur back to 1
		 */
-(void)hideSpinner;

-(id)getStyle:(NSString*)styleProp;

//FLXSIEventDispatcher methods
-(void)dispatchEvent:(FLXSEvent *)event;

- (void)addEventListener:(NSString *)type target:(NSObject *)target handler:(SEL)handler;
-(void)removeEventListenerOfType:(NSString *)type fromTarget:(NSObject *)target usingHandler:(SEL)handler;
//End FLXSIEventDispatcher methods
@end

