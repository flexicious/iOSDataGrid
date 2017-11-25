

#import <Foundation/Foundation.h>
#import "FLXSVersion.h"

/**
 *
 * This is the main spinner class which is extended from mx.core.UIComponent to create
 * a custom Spinner
 *
 */

@interface FLXSSpinner : UIView

@property (nonatomic,strong) NSString * label;
@property (nonatomic,assign) float startX;
@property (nonatomic,assign) float startY;

@property (nonatomic, strong)  UIActivityIndicatorView * activityIndicator;
@property (nonatomic, strong)  UILabel * spinnerLabel;
//[Style(name="labelBackgroundColor", type="uint", format="Color",inherit="yes")]
@property (nonatomic, assign) BOOL  labelShowBackground;
@property (nonatomic, strong)  UIColor * labelBackgroundColor;
@property (nonatomic, strong)  UIColor * labelColor;
@property (nonatomic, strong)  UIColor * spinnerColor;


/**
  *
  * Starts the spinner
  *
  */
-(void)startSpin;
/**
		 *
		 * Stops the spinner
		 *
		 */
-(void)stopSpin;
/**
		 * The actual spinning component.
		 * @return
		 *
		 */
-(UIView*)spinner;
-(void)validateNow;
@end