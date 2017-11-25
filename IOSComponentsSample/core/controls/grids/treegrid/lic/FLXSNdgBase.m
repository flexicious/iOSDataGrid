#import "FLXSNdgBase.h"
#import "FLXSEvent.h"
#import "UIView+UIViewAdditions.h"



@interface FLXSNdgBase ()
@property (nonatomic, strong) FLXSChecker* checker;

@end

@implementation FLXSNdgBase {
    @private
    BOOL _isTrial;
    BOOL _checked;
    BOOL _check;
     int _defaultRowCount;
    NSMutableArray *_dataProviderFLXS;
    BOOL _structureDirty;
    NSMutableDictionary *_itemFilters;
    FLXSBaseUIControl *_leftLockedVerticalSeparator;
    FLXSBaseUIControl *_rightLockedVerticalSeparator;
    NSMutableDictionary *_flattenedLevels;
    NSObject *_printExportParameters;
    NSObject *_printExportData;
    BOOL _showSpinnerOnFilterPageSort;
    FLXSClassFactory *_spinnerFactory;
    int _totalRecords;
    NSString *_spinnerLabel;
    NSString *_menuCopyCellMenuText;
    NSString *_menuCopySelectedRowMenuText;
    NSString *_menuCopyAllRowsMenuText;
    NSString *_menuCopySelectedRowsMenuText;
    NSDate *_lastTrace;
    float _totalTime;
    NSString *_traceValue;
    BOOL _enableLockedSectionSeparators;
    SEL _lockedSectionSeparatorDrawFunction;
    BOOL _enableDrag;
    SEL _dropAcceptRejectFunction;
    SEL _dragDropCompleteFunction;
    NSObject *_dragRowData;
    SEL _dragAvailableFunction;
    BOOL _enableDrop;
    BOOL _lockDisclosureCell;
    BOOL _allowInteractivity;
    NSMutableArray *_selectedCells;
    BOOL _enableDrillDown;
    NSMutableArray *_toolbarActions;
    NSMutableArray *_predefinedFilters;
    BOOL _enableToolbarActions;
    NSString* _toolbarActionExecutedFunction;
    NSString *_selectionMode;
    BOOL _keyboardListenersPaused;
    BOOL _inMultiRowEdit;
    NSString *_accessibilityIdentifier;
    UIColor *_borderColor;
    NSArray *_borderSides;
    int _borderThickness;
@protected
    NSString* _lastPrintOptionsString;
    NSString* _persistedPrintOptionsString;

    BOOL _created;
    BOOL _placementDirty;
    BOOL _snapDirty;
    BOOL _heightIncreased;
    BOOL _widthIncreased;
    BOOL _useEstimation;
    BOOL _componentsCreated;
    BOOL _selectionInvalid;

}

 @synthesize defaultRowCount = _defaultRowCount;
@synthesize dataProviderFLXS = _dataProviderFLXS;
@synthesize structureDirty = _structureDirty;
@synthesize itemFilters = _itemFilters;
@synthesize dropIndicator = _dropIndicator;
@synthesize leftLockedVerticalSeparator = _leftLockedVerticalSeparator;
@synthesize rightLockedVerticalSeparator = _rightLockedVerticalSeparator;
@synthesize flattenedLevels = _flattenedLevels;
@synthesize printExportParameters = _printExportParameters;
@synthesize showSpinnerOnFilterPageSort = _showSpinnerOnFilterPageSort;
@synthesize spinnerFactory = _spinnerFactory;
@synthesize totalRecords = _totalRecords;
@synthesize spinnerLabel = _spinnerLabel;
@synthesize menuCopyCellMenuText = _menuCopyCellMenuText;
@synthesize menuCopySelectedRowMenuText = _menuCopySelectedRowMenuText;
@synthesize menuCopyAllRowsMenuText = _menuCopyAllRowsMenuText;
@synthesize menuCopySelectedRowsMenuText = _menuCopySelectedRowsMenuText;
@synthesize lastTrace = _lastTrace;
@synthesize totalTime = _totalTime;
@synthesize traceValue = _traceValue;
@synthesize enableLockedSectionSeparators = _enableLockedSectionSeparators;
@synthesize lockDisclosureCell = _lockDisclosureCell;
@synthesize allowInteractivity = _allowInteractivity;
@synthesize selectedCells = _selectedCells;
@synthesize enableDrillDown = _enableDrillDown;
@synthesize toolbarActions = _toolbarActions;
@synthesize predefinedFilters = _predefinedFilters;
@synthesize enableToolbarActions = _enableToolbarActions;
@synthesize toolbarActionExecutedFunction = _toolbarActionExecutedFunction;
@synthesize toolbarActionValidFunction = _toolbarActionValidFunction;
@synthesize selectionMode = _selectionMode;
@synthesize keyboardListenersPaused = _keyboardListenersPaused;
@synthesize inMultiRowEdit = _inMultiRowEdit;
@synthesize accessibilityIdentifier = _accessibilityIdentifier;

@synthesize placementDirty = _placementDirty;
@synthesize snapDirty = _snapDirty;

@synthesize borderColor = _borderColor;
@synthesize borderSides = _borderSides;
@synthesize borderThickness = _borderThickness;

 static BOOL checked=NO;
-(void)setFrame:(CGRect)frame {
    if(!checked){
        checked= YES;
        self.checker=[[FLXSChecker alloc] init];
    }
    if(frame.size.height!=self.frame.size.height){
        [self invalidateHeight];
    }
    if(frame.size.width!=self.frame.size.width){
        [self invalidateHeight];
    }

    super.frame = frame;
}

-(void)reloadData
{
	[self rebuild];
}

-(BOOL)hasBorderSide:(NSString*)side
{
	NSArray * borderSides = (NSArray *)[self getStyle:(@"borderSides")];
	if(borderSides)
		return [borderSides containsObject:side];
    return NO;
}
-(void)rebuild
{
	if(_structureDirty)return;
	_structureDirty=YES;
	[self doInvalidate];
}

-(void)doInvalidate
{
	[self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect {
	//[graphics clear];
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextSetRGBFillColor(ctx, 1.0, 0.0, 0.0, 1.0);
//    CGContextFillRect(ctx, CGRectMake(100.0, 100.0, 100.0, 100.0));
    NSArray * borderSides = (NSArray *)[self getStyle:(@"borderSides")];
//	NSNumber * borderThickness= [self getStyle:(@"borderThickness")];
    if(borderSides)
	{
        CGContextRef context = UIGraphicsGetCurrentContext();

        float thickness = [[self getStyle:(@"borderThickness")] floatValue]?[[self getStyle:(@"borderThickness")] floatValue]:1 ;
        if(self.borderColor == nil){
            self.borderColor =  [UIColor redColor]    ;
        }
        CGContextSetStrokeColorWithColor(context, [self.borderColor CGColor]);

        // Draw them with a 2.0 stroke width so they are a bit more visible.
        CGContextSetLineWidth(context, thickness);
		if([self hasBorderSide:(@"top")])
		{
            CGContextMoveToPoint(context, 0,0); //start at this point
            CGContextAddLineToPoint(context, self.frame.size.width, 0); //draw to this point
		}
		if([self hasBorderSide:(@"bottom")])
		{
            CGContextMoveToPoint(context, 0,self.frame.size.height); //start at this point
            CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height); //draw to this point
		}
		if([self hasBorderSide:(@"left")])
		{
            CGContextMoveToPoint(context, 0,0); //start at this point
            CGContextAddLineToPoint(context, 0, self.frame.size.height); //draw to this point
		}
		if([self hasBorderSide:(@"right")])
		{
            CGContextMoveToPoint(context, self.frame.size.width-thickness, 0); //draw to this point
            CGContextAddLineToPoint(context, self.frame.size.width-thickness, self.frame.size.height); //draw to this point
		}

        CGContextStrokePath(context);
	}
	if(self.enableLockedSectionSeparators)
	{
        [self drawDefaultSeparators];
	}
    [super drawRect:rect];
}
-(void)drawDefaultSeparators{

}

//TODO v1.2 code to detect modifications to the dataprovider
//-(void)onCollectionChange:(FLXSEvent*)event
//{
//	CollectionEvent* ce=event as CollectionEvent;
//	if(ce)
//	{
//		if(ce.kind == [CollectionEventKind RESET] || ce.kind==[CollectionEventKind ADD] ||
//			ce.kind==[CollectionEventKind REMOVE]
//			)
//		{
//			_flattenedLevels=[[Dictionary alloc] init];
//			[self rebuild];
//		}
//	}
//}

-(void)reDraw
{
	if(_placementDirty)return;
	_placementDirty=YES;
	[self doInvalidate];
}

-(void)traceEvent:(NSString*)msg
{
	//if(!_lastTrace)_lastTrace=[[Date alloc] init];
	//Date* current=[[Date alloc] init];
	//float timeTaken = current.time-[_lastTrace time];
	//_totalTime+=timeTaken;
	//_lastTrace=current;
	//
}

-(NSObject*)traceValue
{
	return _traceValue;
}

-(void)traceValue:(NSObject*)value
{
	_traceValue=[value description];
	[self dispatchEvent:([[FLXSEvent alloc] initWithType:(@"traceChanged")])];
}

//
//-(void)dragEnter:(DragEvent*)event
//{
//}
//
//-(void)dragDrop:(DragEvent*)event
//{
//}

-(NSArray*)selectedCells
{
	return _selectedCells;
}


-(void)setSelectionMode:(NSString*)value
{
	if(_selectionMode!=value)
	{
		[self clearSelection]  ;
	}
	_selectionMode=value;
}

-(void)clearSelection
{
	// TODO Auto Generated method stub
}


-(void)invalidateCellWidths
{
	if(!_snapDirty)
	{
		_snapDirty=YES;
		[self doInvalidate];
	}
}
// next version v1.2 implement drag and drop
//-(Image*)getUIComponentBitmapData:(UIView*)target
//{
//	BitmapData* bd = [[BitmapData alloc] init:target.width :target.height];
//	Matrix* m = [[Matrix alloc] init];
//	[bd draw:target :m];
//	Image* img=[[Image alloc] init];
//	Bitmap* bitMap = [[Bitmap alloc] init:bd];
//	img.source=bitMap;
//	return img;
//}


-(void)invalidateHeight
{
	_heightIncreased=YES;
	[self doInvalidate];
}

-(void)invalidateWidth
{
	_widthIncreased=YES;
	[self doInvalidate];
}

@end

