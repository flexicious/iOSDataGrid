#import "FLXSFlexDataGridCell.h"
#import "FLXSFlexDataGridColumnLevel.h"
#import "FLXSFlexDataGridColumn.h"
#import "FLXSRowInfo.h"
#import "FLXSComponentInfo.h"
#import "FLXSExpandCollapseIcon.h"
#import "FLXSTriStateCheckBox.h"
#import "FLXSCellUtils.h"
#import "FLXSFlexDataGridEvent.h"
#import "FLXSIFixedWidth.h"
#import "FLXSFlexDataGridCheckBoxColumn.h"
#import "FLXSIFlexDataGridCell.h"
#import "FLXSTouchEvent.h"
#import "FLXSExtendedUIUtils.h"
#import <objc/message.h>


@implementation FLXSFlexDataGridCell {
    __weak UIViewController *_rendererController;
}


@synthesize columnFLXS = _columnFLXS;
@synthesize rowInfo = _rowInfo;
@synthesize currentBackgroundColors = _currentBackgroundColors;
@synthesize currentTextColors = _currentTextColors;
@synthesize componentInfo = _componentInfo;
@synthesize rendererFactory = _rendererFactory;
@synthesize renderer = _renderer;
@synthesize destroyed = _destroyed;
@synthesize isNewlyCreated = _isNewlyCreated;
@synthesize moving = _moving;
@synthesize colIcon = _colIcon;
@synthesize backgroundDirty = _backgroundDirty;
@synthesize iconTimer = _iconTimer;
@synthesize expandCollapseIcon = _expandCollapseIcon;
@synthesize text = _text;
@synthesize wordWrap = _wordWrap;
@synthesize truncateToFit = _truncateToFit;
@synthesize selectable = _selectable;
@synthesize accessibilityIdentifier = _accessibilityIdentifier;

@synthesize level = _level;
@synthesize rendererController = _rendererController;

-(id)init
{	self = [super init];
    if (self)
    {
        [self initCommon];


    }
    return self;
}

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initCommon];
    }
    return self;
}
- (void)initCommon {
    self.isNewlyCreated = YES;
    self.moving = NO;
    self.backgroundDirty = YES;
    self.opaque=NO;
    self.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesture.numberOfTapsRequired = 2;
    [self addGestureRecognizer:tapGesture];


}
- (void)handleTapGesture:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateRecognized) {
        CGPoint locationPoint = [sender locationInView:self];
        FLXSTouchEvent* evt = [[FLXSTouchEvent alloc] init];
        evt.target = self;
        evt.type = [FLXSTouchEvent DOUBLE_TAP];
        evt.localX = locationPoint.x;
        evt.localY = locationPoint.y;
        [self dispatchEvent:evt];
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint locationPoint = [[touches anyObject] locationInView:self];

    FLXSTouchEvent* evt1 = [[FLXSTouchEvent alloc] init];
    evt1.target = self;
    evt1.type = [FLXSTouchEvent TOUCH_DOWN];
    evt1.localX = locationPoint.x;
    evt1.localY = locationPoint.y;
    [self dispatchEvent:evt1];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint locationPoint = [[touches anyObject] locationInView:self];
    FLXSTouchEvent* evt1 = [[FLXSTouchEvent alloc] init];
    evt1.target = self;
    evt1.type = [FLXSTouchEvent TOUCH_MOVE];
    evt1.localX = locationPoint.x;
    evt1.localY = locationPoint.y;
    [self dispatchEvent:evt1];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint locationPoint = [[touches anyObject] locationInView:self];
    FLXSTouchEvent* evt = [[FLXSTouchEvent alloc] init];
    evt.target = self;
    evt.type = touches.count==2?[FLXSTouchEvent DOUBLE_TAP]:[FLXSTouchEvent TAP];
    evt.localX = locationPoint.x;
    evt.localY = locationPoint.y;

    [self dispatchEvent:evt];
    if(self.expandCollapseIcon && CGRectContainsPoint(self.expandCollapseIcon.frame,locationPoint)){
        //user clicked on expand collapse icon
        [self.expandCollapseIcon doClick];
    }
    FLXSTouchEvent* evt1 = [[FLXSTouchEvent alloc] init];
    evt1.target = self;
    evt1.type = [FLXSTouchEvent TOUCH_UP];
    evt1.localX = locationPoint.x;
    evt1.localY = locationPoint.y;
    [self dispatchEvent:evt1];
}


-(void)setCurrentBackgroundColors:(id)value
{
	_currentBackgroundColors = value;
	self.backgroundDirty=YES;
	[self setNeedsDisplay];
}


-(void)setLevel:(FLXSFlexDataGridColumnLevel*)value
{
	_level = value;
	[self dispatchEvent:([[FLXSEvent alloc] initWithType:@"levelChanged" andCancelable:NO andBubbles:NO ])];
}

 -(void)setColumnFLXS:(FLXSFlexDataGridColumn*)value
{
	_columnFLXS = value;
	[self dispatchEvent:([[FLXSEvent alloc] initWithType:(@"columnChanged")])];
}

-(void)destroy
{
	_level =nil;
	self.columnFLXS =nil;
	self.rowInfo=nil;
	self.currentBackgroundColors=nil;
	self.currentTextColors=nil;
	self.destroyed=YES;
}

-(void)setSelectable:(BOOL)val
{
    _selectable =val;
	if([self.renderer respondsToSelector:NSSelectorFromString(@"selectable")])
	{
        [self.renderer setValue:[NSNumber numberWithBool:val ] forKey:@"selectable"];
	}
}

-(void)setTruncateToFit:(BOOL)val
{
    _truncateToFit=val;
    //in IOS, UILabel View truncates by default
}

-(void)setText:(NSString*)val
{

    _text=val;
    if([self.renderer respondsToSelector:NSSelectorFromString(@"text")])
	{
        [self.renderer setValue:val forKey:@"text"];
	}
    [self setNeedsDisplay];
}


-(void)setWordWrap:(BOOL)val
{
    _wordWrap = val;
    if([self.renderer isKindOfClass:[UILabel class]]){
        UILabel * lbl = ( UILabel*)self.renderer;
        lbl.numberOfLines=val?0:1;
    }
}


- (void)setActualSizeWithWidth:(float)wIn andHeight:(float)h {
    if(wIn!=self.width || h!=self.height)
		[self invalidateBackground];

	if(self.renderer)
	{
		[self placeComponent:self.renderer unscaledWidth:wIn unscaledHeight:h usePadding:YES ];
	}
    [super setActualSizeWithWidth:wIn andHeight:h];
}

-(void)setHeight:(float)value
{
	if(value!=self.height)
	{
		[self invalidateBackground];
	}

    super.height=value;
}

-(void)setWidth:(float)value
{
    BOOL toSet=self.width!=value;
    super.width=value;
	if(toSet)
	{
		[self invalidateBackground];
		[self placeComponent:self.renderer unscaledWidth:self.width unscaledHeight:self.height usePadding:YES ];
	}
}

-(void)refreshCell
{
    	self.destroyed=NO;
	self.currentBackgroundColors=nil;
	self.currentTextColors=nil;
//	UIView* mine=self.renderer;
    if(self.expandCollapseIcon){
        self.expandCollapseIcon.hidden=YES;
    }

	if(_level.grid.dispatchRendererInitialized)
	{
        [_level.grid dispatchEvent:[[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent RENDERER_INITIALIZED] andGrid:_level.grid andLevel:_level andColumn:self.columnFLXS andCell:self andItem:nil andTriggerEvent:nil andBubbles:NO andCancelable:NO ]];
	}
	if([self.columnFLXS isKindOfClass:[FLXSFlexDataGridCheckBoxColumn class]] && (self.rowInfo.isDataRow || self.rowInfo.isHeaderRow) )
	{
		[self initializeCheckBoxRenderer:self.renderer];
	}
	self.isNewlyCreated=NO;
	if(self.columnFLXS && self.columnFLXS.enableExpandCollapseIcon)
	{
		if(!self.expandCollapseIcon)
		{
			FLXSExpandCollapseIcon * icon1=[[FLXSExpandCollapseIcon alloc] init];
            self.expandCollapseIcon = icon1;
			[self addChild:self.expandCollapseIcon];


		}
 		[FLXSExpandCollapseIcon refreshCell:self.expandCollapseIcon];
		[FLXSExpandCollapseIcon drawIcon:self.expandCollapseIcon];
	}
	[self placeComponent:self.renderer unscaledWidth:self.width unscaledHeight:self.height usePadding:YES ];
    
    if(self.colIcon)
    {
        self.colIcon.hidden = YES;
    }
	if(self.columnFLXS && self.columnFLXS.enableIcon)
	{
		self.renderer.hidden=self.columnFLXS.hideText;
		NSString * iconUrl = [self getIconUrl :NO];
		if(iconUrl)
		{
			if(!self.colIcon )
			{
				self.colIcon = [[UIImageView alloc] init];
				[self addChild:self.colIcon];

				[self.colIcon addEventListenerOfType:[FLXSTouchEvent TAP] usingTarget:self withHandler:@selector(onIconMouseClick:)];
//				[self.colIcon addEventListener:[MouseEvent MOUSE_OVER] :onIconMouseOver];
//				[self.colIcon addEventListener:[MouseEvent MOUSE_OUT] :onIconMouseOut];
//				self.colIcon.buttonMode= self.column.iconHandCursor;
//				self.colIcon.useHandCursor = self.column.iconHandCursor;
			}
			//self.colIcon.toolTip = [self.column iconToolTipFunction:self];
			self.colIcon.hidden=NO;

            [self loadImage:iconUrl];
//			if(self.colIcon.contentWidth>0)
//                self.colIcon.width = colIcon.contentWidth;
//            if(self.colIcon.contentHeight>0)
//                self.colIcon.height = colIcon.contentHeight;
//			if(self.column.showIconOnCellHover||self.column.showIconOnRowHover)
//				self.colIcon.visible=NO;
		}
		else if(self.colIcon)
		{
            [self loadImage:iconUrl];

			//there is an icon, and self cell is being recycled so we no longer should be showing an [self icon:iconUrl comes back undefined], then we should wipe out the icon
		}
	}
    
    if([self.renderer respondsToSelector:NSSelectorFromString(@"font")] && self.rowInfo.isDataRow){
        
        int fontSize=[[self.columnFLXS getStyleValue:@"fontSize"] intValue] >0?
        [[self.columnFLXS getStyleValue:@"fontSize"] intValue]:15;
        
        NSString* fontName = [self.columnFLXS getStyleValue:@"fontName"];
        if(fontName){
            [self.renderer setValue:[UIFont fontWithName:fontName size:fontSize] forKey:@"font"];
        }else{
            [self.renderer setValue:[UIFont systemFontOfSize:fontSize] forKey:@"font"];
        }
    }
    
	[self setNeedsDisplay];
}

- (void)loadImage:(NSString *)iconUrl {
    if([iconUrl isKindOfClass:[NSString class] ] && [iconUrl hasPrefix:@"http"]){
                __weak NSURL *url = [NSURL URLWithString:iconUrl];
                __weak UIImageView* blockSafeColIcon = self.colIcon;
                dispatch_async( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0 ), ^(void)
                {
                    NSData * data = [[NSData alloc] initWithContentsOfURL:url];
                    UIImage * image = [[UIImage alloc] initWithData:data];
                    dispatch_async( dispatch_get_main_queue(), ^(void){
                        if( image != nil )
                        {
                            [blockSafeColIcon setImage:image];
                            [blockSafeColIcon setActualSizeWithWidth:image.size.width andHeight:image.size.height];
                         } else {
                            [blockSafeColIcon setImage:nil];

                        }
                    });
                });
            } else{
                [self.colIcon setImage:[UIImage imageNamed:iconUrl]];
                [self.colIcon sizeToFit];
        }

}

-(void)setEnabled:(BOOL)val
{
    self.userInteractionEnabled=val;
    if(self.colIcon)
	{
		self.colIcon.image=[self getIconUrl:NO];
	}

}

-(void)onIconMouseOver:(FLXSEvent*)evnt
{
 //no mouse over in ios
}

-(void)onIconMouseClick:(FLXSEvent*)evt
{
}

-(void)onTimerComplete:(NSTimer*)evt
{
    // no mouse over in ios
}

-(void)onIconMouseOut:(FLXSEvent*)evnt
{
   //no mouseout in ios
}

-(id)getIconUrl:(BOOL)over
{
    if(![FLXSUIUtils nullOrEmpty:_columnFLXS.iconField])
    {
        return [FLXSExtendedUIUtils resolveExpression:self.rowInfo.data expression:_columnFLXS.iconField valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO];
    }
    SEL selector = NSSelectorFromString(self.columnFLXS.iconFunction);
    if([self.columnFLXS.iconFunction isEqualToString:@"defaultIconFunction::"]){
        return ((id(*)(id, SEL, UIView<FLXSIFlexDataGridCell>*,NSString*))objc_msgSend)(self.columnFLXS
                            , selector,self,self.userInteractionEnabled?@"":@"disabled");
        
    }else{
        return ((id(*)(id, SEL, UIView<FLXSIFlexDataGridCell>*,NSString*))objc_msgSend)
                (self.columnFLXS.level.grid.delegate, selector,self,self.userInteractionEnabled?@"":@"disabled");
        
    }
}

- (void)setRendererSize:(UIView *)cellRenderer width:(float)w height:(float)h {
    [FLXSCellUtils setRendererSize:cellRenderer width:w height:h];
}

-(float)getLeftPadding
{
	  
    if(self.columnFLXS){
        return [[self.columnFLXS getStyleValue:[self.prefix stringByAppendingString:[self capitalizeFirstLetterIfPrefix:@"paddingLeft"]]] floatValue];
    }
    else{
        return [[self.level getStyleValue:[self.prefix stringByAppendingString:[self capitalizeFirstLetterIfPrefix:@"paddingLeft"]]] floatValue];
    }

}
-(void)drawRect:(CGRect)rect {
    if(self.hidden){return;}
    if(!self.level){return;}
    [self drawCell:self.width unscaledHeight:self.height];
    [self placeIcon];

    if(self.level.grid.dispatchCellRenderered){
        [self.level.grid dispatchEvent:[[FLXSFlexDataGridEvent alloc] initWithType:[FLXSFlexDataGridEvent CELL_RENDERED] andGrid:self.level.grid andLevel:self.level andColumn:self.columnFLXS andCell:self andItem:self.rowInfo.data andTriggerEvent:nil andBubbles:NO andCancelable:NO ]];

    }

}

-(void)placeIcon
{
	if(!self.colIcon)return;
	if(!self.columnFLXS ||!self.userInteractionEnabled)
	{
        self.colIcon.hidden=YES;
		return;
	}
	if(self.columnFLXS.showIconOnCellHover)
	{
        self.colIcon.hidden=(![_level.grid.currentCell isEqual:self]);
	}
	else if(self.columnFLXS.showIconOnRowHover)
	{
		if(_level.grid.currentCell==nil)
            self.colIcon.hidden=YES;
		else
            self.colIcon.hidden=(![_level.grid.currentCell.rowInfo isEqual:self.rowInfo]);
	}
	float left = [[self.columnFLXS getStyle:(@"iconLeft")] floatValue];
	float top = [[self.columnFLXS getStyle:(@"iconTop")] floatValue];
	float bottom = [[self.columnFLXS getStyle:(@"iconBottom")] floatValue];
	float right = [[self.columnFLXS getStyle:(@"iconRight")] floatValue];
	float iconX=-1;
	float iconY=-1;
	if(left>0)
		iconX=left;
	if(top>0)
		iconY=top;
	if(right>0)
		iconX=self.width-right-self.colIcon.width;
		if(bottom>0)
		iconY=self.height-bottom-self.colIcon.height;
	if((iconX)==-1)iconX=self.width-2-self.colIcon.width;
	if((iconY)==-1)iconY=MAX(0,(self.height-self.colIcon.height)/2);
    [self.colIcon moveToX:iconX y:iconY];
}

-(void)placeExpandCollapseIcon
{
    if(!self.expandCollapseIcon)return;
	if(!self.columnFLXS || !self.columnFLXS.enableExpandCollapseIcon)
	{
        self.expandCollapseIcon.hidden=YES;
		return;
	}
    self.expandCollapseIcon.hidden=NO;
	float left = [[self.columnFLXS getStyle:(@"expandCollapseIconLeft")] floatValue];
	float top = [[self.columnFLXS getStyle:(@"expandCollapseIconTop")] floatValue];
	float bottom = [[self.columnFLXS getStyle:(@"expandCollapseIconBottom")] floatValue];
	float right = [[self.columnFLXS getStyle:(@"expandCollapseIconRight")] floatValue];
	float iconX=-1;
	float iconY=-1;
	if(left>0)
		iconX=left;
	if(top>0)
		iconY=top;
	if(right>0)
		iconX=self.width-right-self.expandCollapseIcon.width  ;
		if(bottom>0)
		iconY=self.height-bottom-self.expandCollapseIcon.height;
	if((iconX)==-1)iconX=2;
	if((iconY)==-1)iconY=MAX(0,(self.height-self.expandCollapseIcon.height)/2);
	if(self.columnFLXS.enableHierarchicalNestIndent)
		iconX+= _level.maxPaddingCellWidth;
    [self.expandCollapseIcon moveToX:iconX y:iconY];
}

- (void)drawCell:(float)unscaledWidth unscaledHeight:(float)unscaledHeight {
	if(!self.superview)return;
    [self drawBackground:unscaledWidth unscaledHeight:unscaledHeight];
}

- (CGPoint)placeComponent:(UIView *)cellRenderer unscaledWidth:(float)unscaledWidth unscaledHeight:(float)unscaledHeight usePadding:(BOOL)usePadding {
	if(!self.superview)return CGPointMake(0, 0);
    if([cellRenderer isKindOfClass:[FLXSTriStateCheckBox class]]
            && [self.columnFLXS isKindOfClass:[FLXSFlexDataGridCheckBoxColumn class]]
            && !((FLXSFlexDataGridCheckBoxColumn *)self.columnFLXS).enableLabelAndCheckBox){
        FLXSTriStateCheckBox * cb = (FLXSTriStateCheckBox *) cellRenderer;
        FLXSPoint *pt= [[FLXSPoint alloc] initWithX:( unscaledWidth-cb.imageView.width)/2  andY:(unscaledHeight-cb.imageView.height)/2];
        [cellRenderer moveToX:pt.x y:pt.y];
        [self setRendererSize:cellRenderer width:cb.imageView.width height:cb.imageView.height];
        [self placeIcon];
        [self placeExpandCollapseIcon];
        return CGPointMake(pt.x,pt.y);
    }
	else if(usePadding)
	{
		float paddingLeft = [self getLeftPadding] ;
		float paddingTop = [[self getStyleValue:([self.prefix stringByAppendingString: [self capitalizeFirstLetterIfPrefix:(@"paddingTop")]])]floatValue] ;
        float paddingRight = [[self getStyleValue:([self.prefix stringByAppendingString: [self capitalizeFirstLetterIfPrefix:(@"paddingRight")]])]floatValue] ;
        float paddingBottom = [[self getStyleValue:([self.prefix stringByAppendingString: [self capitalizeFirstLetterIfPrefix:(@"paddingBottomFLXS")]])]floatValue] ;
        [self setRendererSize:cellRenderer width:(unscaledWidth - paddingLeft - paddingRight) height:(unscaledHeight - paddingTop - paddingBottom)];
		[self setNeedsDisplay];

        [self.renderer moveToX:paddingLeft y:paddingTop];
        [self placeIcon];
		[self placeExpandCollapseIcon];
        return CGPointMake(paddingLeft,paddingTop);
	}
	else
	{
        [self setRendererSize:cellRenderer width:unscaledWidth height:unscaledHeight];
        return CGPointMake(0, 0);
    }
}

-(NSString*)prefix
{
	return @"";
}

-(NSString*)capitalizeFirstLetterIfPrefix:(NSString*)val
{
	return [FLXSCellUtils capitalizeFirstLetterIfPrefix:self.prefix val:val];

}

-(BOOL)hasVerticalGridLines
{
    return [[self getStyleValue: [self.prefix stringByAppendingString:[self capitalizeFirstLetterIfPrefix:(@"verticalGridLines")] ]] boolValue];

}

-(BOOL)hasHorizontalGridLines
{
    return [[self getStyleValue: [self.prefix stringByAppendingString:[self capitalizeFirstLetterIfPrefix:(@"horizontalGridLines")] ]] boolValue];

}

-(UIColor*)verticalGridLineColor
{
    return (UIColor*)[self getStyleValue: [self.prefix stringByAppendingString:  [self capitalizeFirstLetterIfPrefix:(@"verticalGridLineColor")] ]] ;
}

-(UIColor*)horizontalGridLineColor
{
    return (UIColor*)[self getStyleValue: [self.prefix stringByAppendingString:  [self capitalizeFirstLetterIfPrefix:(@"horizontalGridLineColor")] ]] ;

}

-(float)verticalGridLineThickness
{
    return [[self getStyleValue: [self.prefix stringByAppendingString:  [self capitalizeFirstLetterIfPrefix:(@"verticalGridLineThickness")] ]] integerValue];

}

-(float)horizontalGridLineThickness
{
    return [[self getStyleValue: [self.prefix stringByAppendingString:  [self capitalizeFirstLetterIfPrefix:(@"horizontalGridLineThickness")] ]] integerValue];
}

-(BOOL)drawTopBorder
{
	return NO;
}

- (void)drawBackground:(float)unscaledWidth unscaledHeight:(float)unscaledHeight {
    [FLXSCellUtils drawBackground:self];
}
-(id)getRolloverColor
{
    return [FLXSCellUtils getRolloverColor:self prop:(@"rollOverColor")];
}

-(id)getRolloverTextColor
{
	return [FLXSCellUtils getRolloverColor:self prop:(@"textRollOverColor")];

}

-(id)getTextColors
{
    NSObject * fromGrid=[FLXSCellUtils getTextColorFromGrid:self];
	if(fromGrid!=nil)return fromGrid;
	return [FLXSCellUtils getTextColors:self];
}

-(id)getBackgroundColors
{
    NSObject * fromGrid=[FLXSCellUtils getBackgroundColorFromGrid:self];
	if(fromGrid!=nil)return fromGrid;
	return [FLXSCellUtils getBackgroundColors:self];
}

- (void)drawRightBorder:(float)unscaledWidth unscaledHeight:(float)unscaledHeight {
    return [FLXSCellUtils drawRightBorder:self];
}

-(FLXSClassFactory*)rendererFactory
{
	if(!_rendererFactory)
	{
		_rendererFactory =  [FLXSFlexDataGridColumn static_UILabel];
	}
	return _rendererFactory;
}


-(UIView*)renderer
{
    if(!_renderer)
	{
        NSObject *generatedInstance =[self.rendererFactory generateInstance];

        if([generatedInstance isKindOfClass:[UIViewController class]]){
            _rendererController =   ((UIViewController *)generatedInstance) ;
            _renderer = _rendererController.view;
        }else{
            _renderer = (UIView *)generatedInstance;
        }
		if([self.columnFLXS isKindOfClass:[FLXSFlexDataGridCheckBoxColumn class]] &&
                (self.rowInfo.isDataRow || self.rowInfo.isHeaderRow))
		{
             [self.renderer addEventListenerOfType:[FLXSTouchEvent TAP] usingTarget:self withHandler:@selector(onCheckChange:)];
		}
        [self addChild:_renderer];
    }
	return _renderer;
}

//Start FLXSIEventDispatcher methods

- (void)addEventListenerOfType:(NSString *)type usingTarget:(NSObject *)target withHandler:(SEL)handler {
    [FLXSUIUtils addEventListenerOfType:type
                       withTarget:target
                       andHandler:handler
                        andSender:self];
}

- (void)removeEventListenerOfType:(NSString *)type fromTarget:(NSObject *)target usingHandler:(SEL)handler {
    [FLXSUIUtils removeEventListener:type
                          withTarget:target
                          andHandler:handler
                           andSender:self];
}
-(void)dispatchEvent:(FLXSEvent *)event {
    [FLXSUIUtils dispatchEvent:event
                    withSender:self];
}
//End FLXSIEventDispatcher methods

-(void)initializeCheckBoxRenderer:(UIView*)renderer
{
    [FLXSCellUtils initializeCheckBoxRenderer:self level:_level];
}

-(void)onCheckChange:(NSNotification*)ns
{
    FLXSTouchEvent* evt1 = [[FLXSTouchEvent alloc] init];
    evt1.target = self;
    evt1.type = [FLXSTouchEvent TAP];
    [self dispatchEvent:evt1];
}

-(BOOL)isLocked
{
    return (self.columnFLXS && self.columnFLXS.isLocked );
}

-(BOOL)isRightLocked
{
    return (self.columnFLXS && self.columnFLXS.isRightLocked);
}

-(BOOL)isLeftLocked
{
    return (self.columnFLXS && self.columnFLXS.isLeftLocked);
}

-(BOOL)isContentArea
{
    return (self.isDataCell || (self.isChromeCell && (self.nestDepth>1))) ;
}

-(id)getStyleValue:(NSString*)styleProp
{
     return self.columnFLXS ? [self.columnFLXS getStyleValue:styleProp]:
             [self.level getStyleValue:styleProp ] ;
}

-(BOOL)isElastic
{
	return (!self.isRightLocked&&!([self conformsToProtocol:@protocol(FLXSIFixedWidth)]) && !([self.columnFLXS conformsToProtocol:@protocol(FLXSIFixedWidth)]));
}

-(BOOL)isDataCell
{
    return self.rowInfo?self.rowInfo.isDataRow:NO;
}

-(BOOL)isChromeCell
{
    return self.rowInfo?self.rowInfo.isChromeRow:YES;
}

-(float)nestDepth
{
	return _level ? _level.nestDepth:-1;
}

-(float)perceivedX
{
    
    FLXSFlexDataGridColumn* col=(FLXSFlexDataGridColumn*)self.columnFLXS;
	if(!col)return self.frame.origin.x;
	return col.isLeftLocked?self.frame.origin.x:self.isRightLocked?col.level.grid.leftLockedContent.frame.size.width
            +col.level.unLockedWidth+self.frame.origin.x:col.level.grid.leftLockedContent.frame.size.width+self.frame.origin.x;
}

-(void)invalidateBackground
{
    self.backgroundDirty=YES;
	[self setNeedsDisplay];
}

-(BOOL)isExpandCollapseCell
{
    return self.columnFLXS && self.columnFLXS.enableExpandCollapseIcon;
}

-(UIView<FLXSIExpandCollapseComponent>*)iExpandCollapseComponent
{
	return self.expandCollapseIcon;
}

-(NSString*)checkBoxState
{
	if([self.renderer isKindOfClass:[FLXSTriStateCheckBox class] ] )
	{
		return ((FLXSTriStateCheckBox*)self.renderer).selectedState;
	}
	return @"";
}

-(void)invalidateDisplayList
{
    [super setNeedsDisplay];
}

-(void)dealloc {
    self.renderer = nil;
    self.rendererController=nil;
    [[NSNotificationCenter defaultCenter]removeObserver: self];
}
@end

