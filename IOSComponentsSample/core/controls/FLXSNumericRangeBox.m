#import "FLXSNumericRangeBox.h"


@implementation FLXSNumericRangeBox

@synthesize textBoxStart;
@synthesize separatorText;
@synthesize textBoxEnd;
@synthesize relinquishFocus;
@synthesize shiftTabHandled;
@synthesize tabHandled;

-(float)rangeStart
{
//	float startIndex=[[textBoxStart text] floatValue];
	//return ([self isnan:startIndex]?-1:startIndex); //next version
    return 0;
}

-(void)rangeStart:(float)o
{
	textBoxStart.text = [NSString stringWithFormat:@"%f",o];
}

-(float)rangeEnd
{
//	float endIndex=[[textBoxEnd text] floatValue];//[self parseFloat:textBoxEnd.text];
	//return ([self isNaN:endIndex]?-1:endIndex);//next version
    return 0;
}

-(void)rangeEnd:(float)o
{
	textBoxEnd.text = [NSString stringWithFormat:@"%f",o];
}

-(id)init
{
	self = [super init];
	if (self)
	{
		textBoxStart = [[FLXSTextInput alloc] init];
		separatorText = [[UILabel alloc] init];
		textBoxEnd = [[FLXSTextInput alloc] init];
		_relinquishFocus = YES;
		_shiftTabHandled = NO;
		_tabHandled = NO;
//next version
//		self.percentHeight=100;
//		self.percentWidth=100;
//		[self setStyle:(@"horizontalGap") :0];
//		[self setStyle:(@"verticalGap") :0];
//		[self setStyle:(@"paddingTop") :0];
//		[self setStyle:(@"paddingBottomFLXS") :0];
//		[self setStyle:(@"marginTop") :0];
//		[self setStyle:(@"marginBottom") :0];
//		//textBoxStart.percentWidth=45;
//		[textBoxEnd addEventListener:[FocusEvent KEY_FOCUS_CHANGE] :onFocusChange];
//		[textBoxEnd addEventListener:[KeyboardEvent KEY_DOWN] :onEndKeyDown];
//		[textBoxEnd addEventListener:[KeyboardEvent KEY_UP] :onEndKeyUp];
//		[textBoxStart addEventListener:[FocusEvent KEY_FOCUS_CHANGE] :onFocusChange];
//		[textBoxStart addEventListener:[KeyboardEvent KEY_DOWN] :onStartKeyDown];
//		[textBoxStart addEventListener:[KeyboardEvent KEY_UP] :onStartKeyUp];
//		separatorText.width=10;
		separatorText.text=@"-";
        [self addSubview:textBoxStart];
		[self addSubview:separatorText];
		[self addSubview:textBoxEnd];
//		horizontalScrollPolicy=@"off";//next version
		[textBoxStart addEventListenerOfType:[FLXSEvent EVENT_DELAYED_CHANGE] usingTarget:self withHandler:@selector(onChange_textBoxStart)];
		[textBoxEnd addEventListenerOfType:[FLXSEvent EVENT_DELAYED_CHANGE] usingTarget:self withHandler:@selector(onChange_textBoxEnd)];
	}
	return self;
}
   
//next version
//-(void)setFocusOnChild:(IFocusManagerComponent*)child
//{
//	[focusManager setFocus:child as IFocusManagerComponent];
//	if(child is TextInput)
//	{
//		FLXSTextInput* txtInput = (child as FLXSTextInput);
//		NSString* txt=txtInput.text;
//		if(txt.length>0)
//			[txtInput setSelection:txt.length :txt.length];
//	}
//}

-(void)onChange_textBoxEnd:(FLXSEvent*)evt
{
	[self onChange];
}

-(void)onChange_textBoxStart:(FLXSEvent*)evt
{
	[self onChange];
}

-(void)onChange
{
	if([self isRangeValid])
	{
		//[self dispatchEvent:([[FLXSEvent alloc] initWithType:[FLXSEvent EVENT_CHANGE]])]; //next version
	}
	if([textBoxEnd.text isEqual:@""] && [textBoxStart.text isEqual:@""])
	{
		//[self dispatchEvent:([[FLXSEvent alloc] initWithType:[FLXSEvent EVENT_CHANGE]])];//next version
	}
}

-(BOOL)isRangeValid
{
//	float startIndex=[textBoxStart.text floatValue];
//	float endIndex=[textBoxEnd.text floatValue];
	//return (![self isNaN:startIndex] && ![self isNaN:endIndex] &&  startIndex<=endIndex);//next version
    return NO;
}

-(NSArray*)range
{
	if(![self isRangeValid])return nil;
	NSMutableArray* a = [[NSMutableArray alloc] init];
	[a addObject:[NSNumber numberWithFloat:self.rangeStart]];
	[a addObject:[NSNumber numberWithFloat:self.rangeEnd]];
	return a;
}

-(void)range:(NSArray*)value
{
	if(value== nil)return;
	if(value.count!=2)[FLXSUIUtils raiseExceptionWithType:@"Invalid argument for numeric range box range" andMessage:@""];
	self.textBoxStart.text = [[value objectAtIndex:0] stringValue];
	self.textBoxEnd.text = [[value objectAtIndex:1] stringValue];
	if(![self isRangeValid])
		[self reset];
}

-(void)reset
{
	self.textBoxEnd.text=@"";
	self.textBoxStart.text=@"";
}

-(NSObject*)searchRangeStart
{
	return [self isRangeValid]?[NSNumber numberWithFloat:[self rangeStart]]:nil;
}

-(NSObject*)searchRangeEnd
{
	return [self isRangeValid]?[NSNumber numberWithFloat:[self rangeEnd]]:nil;
}

-(NSObject*)minValue
{
	return [self rangeStart]!=-1?[NSNumber numberWithFloat:[self rangeStart]]:[NSNumber numberWithLong:NSIntegerMin];
}

-(NSObject*)maxValue
{
	return [self rangeEnd]!=-1?[NSNumber numberWithFloat:[self rangeEnd]]:[NSNumber numberWithLong:NSIntegerMax];
}

-(void)clear
{
	[textBoxEnd clear];
	[textBoxStart clear];
}

-(NSObject*)getValue
{
	return [self range]==nil?nil:[[NSMutableArray alloc] initWithArray:self.range];
}

-(void)setValue:(NSObject*)val
{
	if([val isKindOfClass:[NSArray class]])
		[self range:(NSArray*)val];
}

- (void)setActualSizeWithWidth:(float )width andHeight:(float)height
{
 //[super setActualSizeWithWidth:width andHeight:height];//next version
	float remaining = width - 10;
    CGRect textBoxStartFrame= textBoxStart.frame;
    textBoxStartFrame.size.width=remaining/2;
    textBoxStartFrame.size.height=height;
    textBoxStart.frame=textBoxStartFrame;
    
	CGRect textBoxEndFrame= textBoxEnd.frame;
    textBoxEndFrame.size.width=remaining/2;
    textBoxEndFrame.size.height=height;
    textBoxEnd.frame=textBoxEndFrame;
	
}

-(void)setFocus
{
    //next version
//	[textBoxStart setFocus];
}

-(void)drawFocus:(BOOL)isFocused
{
    //next version
	//[self.textBoxStart];
}

@end

