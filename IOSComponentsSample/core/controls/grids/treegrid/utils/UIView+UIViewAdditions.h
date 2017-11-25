#import "FLXSVersion.h"


@class FLXSEvent;


@interface UIView (Addtions)


/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) float x;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) float y;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) float right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) float bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) float width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) float height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) float centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) float centerY;

/**
 * Return the x coordinate on the screen.
 */
@property (nonatomic, readonly) float ttScreenX;

/**
 * Return the y coordinate on the screen.
 */
@property (nonatomic, readonly) float ttScreenY;

/**
 * Return the x coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) float screenViewX;

/**
 * Return the y coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) float screenViewY;

/**
 * Return the view frame on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGRect screenFrame;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize size;

- (CGPoint )globalToLocal:(CGPoint  )point;
- (CGPoint )globalToContent:(CGPoint  )point;
- (CGPoint )localToGlobal:(CGPoint  )point;


- (UIView*)descendantOrSelfWithClass:(Class)cls;

- (UIView*)ancestorOrSelfWithClass:(Class)cls;

- (void)removeAllSubviews;

- (void)setActualSizeWithWidth:(float)width andHeight:(float)height ;

- (void)moveToX:(float)x y:(float)y;

- (void)addChild:(UIView*)child;
- (BOOL)owns:(UIView*)child;
- (void)validateNow;
- (id)getStyle:(NSString *)prop;

- (void)setStyle:(NSString *)prop value:(id)value;

- (void)addEventListenerOfType:(NSString *)type usingTarget:(NSObject *)target withHandler:(SEL)handler;

- (void)removeEventListenerOfType:(NSString *)type fromTarget:(NSObject *)target usingHandler:(SEL)handler;
-(void)dispatchEvent:(FLXSEvent *)event;
@end
