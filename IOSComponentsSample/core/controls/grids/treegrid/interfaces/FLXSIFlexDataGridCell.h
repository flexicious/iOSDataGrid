#import "FLXSVersion.h"
#import "FLXSEvent.h"
@class FLXSClassFactory;
@class FLXSFlexDataGridColumnLevel;
@class FLXSFlexDataGridColumn;
@class FLXSRowInfo;
@class FLXSComponentInfo;
@protocol FLXSIExpandCollapseComponent;
/**
	 * This is the interface implemented by all the cells that appear in the Flexicious Ultimate DataGrid.
	 * These cells can either inherit from UIComponent (most of them inherit from FlexDataGridCell, which extends UIComponent),
	 * or FlexSprite(FlexDataGridDataCell3 inherits from Sprite).
	 *
	 * This interface defines all the common properties on each of these cells. All the code in the Flexicious
	 * DataGrid works against this interface for loose coupling.
	 *
	 * The IFlexDataGridCell interface defines the basic set of APIs that you must implement to
	 * be added as a cell to a row in the Flexicious Ultimate DataGrid.
	 */
@protocol FLXSIFlexDataGridCell



@property (nonatomic,weak) FLXSFlexDataGridColumnLevel* level;
@property (nonatomic,weak) FLXSFlexDataGridColumn*columnFLXS;

@property (nonatomic,readonly) BOOL isChromeCell;
@property (nonatomic,readonly) BOOL isContentArea;
@property (nonatomic,readonly) BOOL isDataCell;
@property (nonatomic,readonly) BOOL isElastic;
@property (nonatomic,readonly) BOOL isLeftLocked;
@property (nonatomic,readonly) BOOL isLocked;
@property (nonatomic,readonly) BOOL isRightLocked;

@property (nonatomic,readonly) float nestDepth;
@property (nonatomic,readonly) float perceivedX;

@property (nonatomic,weak) UIView* renderer;

@property (nonatomic,weak) FLXSClassFactory* rendererFactory;
@property (nonatomic,weak) FLXSRowInfo* rowInfo;
@property (nonatomic,assign) BOOL destroyed;
@property (nonatomic,assign) BOOL wordWrap;
@property (nonatomic,assign) BOOL selectable;

@property (nonatomic,assign) BOOL isNewlyCreated;

@property (nonatomic,strong) NSString* text;

 

- (void)setActualSizeWithWidth:(float)width andHeight:(float)height;

//FLXSIEventDispatcher methods
-(void)dispatchEvent:(FLXSEvent *)event;

- (void)addEventListenerOfType:(NSString *)type usingTarget:(NSObject *)target withHandler:(SEL)handler;
-(void)removeEventListenerOfType:(NSString *)type fromTarget:(NSObject *)target usingHandler:(SEL)handler;
//End FLXSIEventDispatcher methods



@property (nonatomic,strong) NSObject * currentBackgroundColors;
@property (nonatomic,strong) NSObject * currentTextColors;
@property (nonatomic,weak) FLXSComponentInfo* componentInfo;
@property (nonatomic,assign) BOOL backgroundDirty;
@property (nonatomic, readonly) UIColor * horizontalGridLineColor;
@property (nonatomic,readonly) UIColor * verticalGridLineColor;
@property (nonatomic,readonly) float horizontalGridLineThickness;
@property (nonatomic,readonly) float verticalGridLineThickness;
@property (nonatomic,readonly) BOOL drawTopBorder;
@property (nonatomic,readonly) BOOL isExpandCollapseCell;
@property (nonatomic,readonly) UIView<FLXSIExpandCollapseComponent>* iExpandCollapseComponent;

- (CGPoint)placeComponent:(UIView *)cellRenderer unscaledWidth:(float)unscaledWidth unscaledHeight:(float)unscaledHeight usePadding:(BOOL)usePadding;


- (void)drawRightBorder:(float)unscaledWidth unscaledHeight:(float)unscaledHeight;
-(id)getBackgroundColors;
-(id)getRolloverColor;
-(id)getRolloverTextColor;
-(id)getStyleValue:(NSString*)styleProp;
-(id)getTextColors;
-(BOOL)hasHorizontalGridLines;
-(BOOL)hasVerticalGridLines;
-(void)refreshCell;
-(void)destroy;
-(void)invalidateBackground;
- (void)invalidateDisplayList;

@end

