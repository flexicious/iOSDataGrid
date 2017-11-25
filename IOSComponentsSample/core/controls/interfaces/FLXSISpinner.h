#import "FLXSVersion.h"
@protocol FLXSISpinner

@property (nonatomic,strong) NSString * label;
@property (nonatomic,assign) float startX;
@property (nonatomic,assign) float startY;
/**
*Begin the animation
*/
-(void)startSpin;
/**
		 *End the animation
		 */
-(void)stopSpin;
/**
		 * The actual spinning component.
		 */
-(UIView*)spinner;
-(void)validateNow;
@end

