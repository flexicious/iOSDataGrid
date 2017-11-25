#import "FLXSUIUtils.h"
#import "FLXSEvent.h"
#import "FLXSFilterExpression.h"

#import "objc/runtime.h"
#import "FLXSLabelData.h"
#import "FLXSiToast.h"
#import "FLXSExtendedUIUtils.h"
#import "FLXSDateUtils.h"
//static NSObject* expressionCache;
//static int _openWindowCount = 0;

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@implementation FLXSUIUtils

//
//
//+(NSObject*)getObjectProperty:(NSObject*)data :(NSString*)property
//{
//	if (data)
//	{
//		if (property)
//		{
//			Array* names = [property componentsSeparatedByString:(@".")];
//			var obj:* = data;
//			var parent:* = data;
//			for (NSString* name in names)
//			{
//				obj = parent[name];
//				if (obj)
//				{
//					parent = obj;
//				}
//				else
//				{
//					// @"nil" may be a valid value. In any event no need to search further
//					return nil;
//				}
//			}
//			return obj;
//		}
//		else
//		{
//			return data;
//		}
//	}
//	else
//	{
//		return nil;
//	}
//}
//
//+(NSString*)labelObjectProperty:(NSObject*)item :(NSObject*)column
//{
//	var obj:* = [FLXSUIUtils getObjectProperty:item :column.dataFieldFLXS];
//	return obj != nil ? ((NSString*)(obj)) : @"";
//}
//
//+(NSString*)concatenateList:(NSMutableArray*)list :(NSString*)propertyName :(NSString*)delimiter
//{
//	NSString* result = @"";
//	if (list)
//	{
//		for (int i = 0; i < list.length; i++)
//		{
//			var obj:* = list[i];
//			NSString* item = ((NSString*)([self getObjectProperty:obj :propertyName]));
//			if (item)
//			{
//				result += result.length > 0 ? delimiter + item : item;
//			}
//		}
//	}
//	return result;
//}
//
//+(NSString*)labelObjectPropertyList:(NSObject*)item :(NSObject*)column
//{
//	if (column.dataFieldFLXS)
//	{
//		Array* names = [column.dataFieldFLXS componentsSeparatedByString:(@"/")];
//		NSString* fieldName = names[0];
//		NSString* propName = names[1];
//		NSString* delimiter = names.length > 2 ? names[2] : nil;
//		return [self concatenateList:([self getObjectProperty:item :fieldName] as NSMutableArray) :propName :delimiter];
//	}
//	else
//	{
//		return @"";
//	}
//}
//
//+(NSString*)dataGridFormatYesNoLabelFunction:(NSObject*)item :(NSObject*)dgColumn
//{
//	BOOL val = [self resolveExpression:item :dgColumn.dataFieldFLXS] as BOOL;
//	return [self formatBoolean:val];
//}
//
//+(NSString*)dataGridFormatDateLabelFunction:(NSObject*)item :(NSObject*)dgColumn
//{
//	NSObject* num = [self resolveExpression:item :dgColumn.dataFieldFLXS];
//	Date* date=num is NSString?[[Date alloc] initWithType:([Date parse:([num toString])])]:num  as Date;
//	if(date)
//		return [self formatDate:date];
//	return nil;
//}
//
//+(NSString*)dataGridFormatCurrencyLabelFunction:(NSObject*)item :(NSObject*)dgColumn
//{
//	NSObject* num = [self resolveExpression:item :dgColumn.dataFieldFLXS];
//	float number =num is NSString?[self parseFloat:([num toString])]:num  as float;
//	if(![self isNaN:number])
//		return [self formatCurrency:number :' '];
//	else
//return @"";
//}
//
//+(NSString*)formatBoolean:(BOOL)val
//{
//	return val?@"Yes":@"No";
//}
//
//+(NSString*)formatDate:(NSDate*)date :(NSString*)formatString
//{
//	DateFormatter* dateFormatter = [[DateFormatter alloc] init];
//	dateFormatter.formatString = formatString;
//	[return dateFormatter format:date];
//}
//
//+(NSString*)formatCurrency:(float)val :(NSString*)currencySymbol
//{
//	CurrencyFormatter* currencyFormatter = [[CurrencyFormatter alloc] init];
//	currencyFormatter.currencySymbol = currencySymbol;
//	currencyFormatter.precision = 2;
//	[return currencyFormatter format:val];
//}
//
+ (NSObject<UIAppearanceContainer> *)addPopUpController:(UIViewController *)controller parent:(UIView *)parent modal:(BOOL)modal {
    UIWindow *window = [FLXSUIUtils getTopLevelWindow];
    UIViewController *rootViewController = window.rootViewController;
    if(!modal && [FLXSUIUtils isIPad]){
        //iPhone does not support non modal popups
        controller.contentSizeForViewInPopover = controller.view.frame.size;
        UIPopoverController* popOverController = [[UIPopoverController alloc] initWithContentViewController:controller];
        [popOverController setPopoverContentSize:CGSizeMake(controller.view.frame.size.width, controller.view.frame.size.height)];
        [popOverController presentPopoverFromRect:CGRectMake(20, 20, 20, 20)
                                           inView:parent
                         permittedArrowDirections:UIPopoverArrowDirectionAny
                                         animated:YES];
        return popOverController;

    }else{
        // Create a Navigation controller
        if([FLXSUIUtils isIPad]){
            UINavigationController *navController = [[UINavigationController alloc]
                    initWithRootViewController:controller];

            navController.modalPresentationStyle = UIModalPresentationFormSheet;
            [rootViewController presentViewController:navController animated:YES completion:nil];

            return navController;
        }   else{
//            CGRect mainFrame = [[UIScreen mainScreen] applicationFrame];
//            UIViewController *popupController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
//            UIView *masterView = [[UIView alloc] initWithFrame:mainFrame];
//            [masterView  setBackgroundColor:[UIColor blackColor]];
//            [masterView     setAlpha:0.6];
//
//            popupController.view= masterView;
//            popupController.view.tag = 100;
//            [window addSubview:popupController.view];
//            if([controller respondsToSelector:NSSelectorFromString(@"containerViewController")]){
//                [controller setValue:popupController forKey:@"containerViewController"];
//            }
            UINavigationController *navCon=[[UINavigationController alloc] initWithRootViewController:controller];
            [rootViewController presentViewController:navCon animated:YES completion:nil];

            return navCon;
        }

    }
}
 //
//+(void)addPopUp:(IFlexUIView*)window :(UIView*)parent :(BOOL)modal :(NSString*)childList :(MouseEvent*)triggerEvent :(NSObject*)moduleFactory
//{
//	[PopUpManager addPopUp:window :parent :modal :childList :moduleFactory as IFlexModuleFactory];
//	[PopUpManager centerPopUp:window];
//	if(triggerEvent)
//	{
//		[window move:((triggerEvent.stageX>window.width)?triggerEvent.stageX-window.width:0) :(triggerEvent.stageY+20)];
//	}
//}
//
//+(void)positionBelow:(IFlexUIView*)popup :(UIView*)parent :(float)leftOffset :(float)topOffset :(BOOL)offScreenMath :(NSString*)where
//{
//	Rectangle* screen=[self getScreen:parent];
//	int popUpGap=0;
//	Point* point = [[Point alloc] init:0 :(parent.height+popUpGap)];
//	point = [parent localToGlobal:point];
//	if (point.y + popup.height > screen.bottom &&
//		                point.y > (screen.top + parent.height + popup.height)&&offScreenMath)
//	{
//		// PopUp will go below the bottom of the stage
//		// and be clipped. Instead, have it grow up.
//		point.y -= (parent.height + popup.height + 2*popUpGap);
//	}
//	if([where isEqual:@"left"])
//		point.x -= popup.width;
//	else if([where isEqual:@"right"])
//point.x += parent.width;
//	if(leftOffset)
//		point.x +=leftOffset;
//	if(topOffset)
//		point.y +=topOffset;
//	if(offScreenMath)
//	{
//		point.x = [Math min:point.x :(screen.right - popup.width)];
//		point.x = [Math max:point.x :0];
//	}
//	point = [popup.parent globalToLocal:point];
//	if (popup.x != point.x || popup.y != point.y)
//		                [popup move:point.x :point.y];
//}
//
//+(Rectangle*)getScreen:(UIView*)parent
//{
//	Rectangle* screen;
//	ISystemManager* sm = parent.systemManager.topLevelSystemManager;
//	UIView* sbRoot = [sm getSandboxRoot];
//	if (sm != sbRoot)
//	{
//		InterManagerRequest* request = [[InterManagerRequest alloc] initWithType:[InterManagerRequest SYSTEM_MANAGER_REQUEST] :NO :NO :(@"getVisibleApplicationRect")];
//		[sbRoot dispatchEvent:request];
//		screen = ((Rectangle*)(request.value));
//	}
//	else
//screen = [sm getVisibleApplicationRect];
//	return screen;
//}
//
+(BOOL)isPrimitive:(id)input
{
    return [input isKindOfClass:[NSNumber class] ] || [input isKindOfClass:[NSDate class]] || [input isKindOfClass:[NSString class]]
            ||[input isKindOfClass:[NSValue class]];
}

//
//+(void)ensureWithinView:(IFlexUIView*)popup :(UIView*)parent
//{
//	if((popup.y+popup.height)>parent.height)
//	{
//		popup.y-=popup.height;
//	}
//	if((popup.x+popup.width)>parent.width)
//	{
//		popup.x-=popup.width;
//	}
//}
//
//+(void)removePopUp:(IFlexUIView*)window
//{
//	[PopUpManager removePopUp:window];
//	[window dispatchEvent:([[FLXSEvent alloc] initWithType:(@"popupRemoved")])];
//}
//
//
+ (float)average:(NSArray *)dataProvider fld:(NSString *)fld {
	if (dataProvider && [dataProvider count]>0)
	{
		return ([self sum:dataProvider fld:fld] / [dataProvider count]);
	}
	else
	{
		return 0;
	}
}

//
//+(int)getLength:(NSObject*)arr
//{
//	if(!arr)return 0;
//	if(arr is XML)
//	{
//		return [(arr as XML) length];
//	}
//	else if (arr is XMLList)
//	{
//		return [(arr as XMLList) length];
//	}
//	else
//	{
//		return arr.length;
//	}
//	return -1;
//}
//
+ (float)sum:(NSArray *)dataProvider fld:(NSString *)fld {
	float total = 0;
	for(NSObject* row in dataProvider)
	{
		float num=[(NSNumber *) [FLXSExtendedUIUtils resolveExpression:row expression:fld valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ] floatValue];
		if(!isnan(num))
			total += num;
	}
	return total;
}

+ (NSObject *)min:(NSArray *)dataProvider fld:(NSString *)fld comparisonType:(NSString *)comparisonType {
	NSObject* min;
	for(NSObject* row in dataProvider)
	{
		NSObject* value = [FLXSFilterExpression convert:comparisonType object:([FLXSExtendedUIUtils resolveExpression:row expression:fld valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ])];
		if (value != nil)
		{
			if ((value) < min || !min)
			{
				min = (value);
			}
		}
	}
	return min;
}

+ (NSObject *)max:(NSArray *)dataProvider fld:(NSString *)fld comparisonType:(NSString *)comparisonType {
	NSNumber* max= nil;
	for(NSObject* row in dataProvider)
	{
		NSNumber* value = (NSNumber*)[FLXSFilterExpression convert:comparisonType object:([FLXSExtendedUIUtils resolveExpression:row expression:fld valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ])];
		if (value != nil)
		{
            
            if (([value floatValue] > [max floatValue]) || (max==nil))
			{
                max = value;
			}
		}
    }
	return max;
}
//
+(void)pasteToClipBoard:(NSString*)strToPaste
{
    [UIPasteboard generalPasteboard].string = strToPaste;
}

//
//+(BOOL)isStringNumeric:(NSString*)str
//{
//	return str && str.length>0 && str!= @"NaN";
//}
//
//+(void)onAlertCloseHandler:(CloseEvent*)event
//{
//	AlertClass* ac= [self doesArrayContainObjectValue:_alerts :(@"alert") :event.currentTarget] as AlertClass;
//	if(ac!=nil)
//	{
//		[ac resultFunction:ac.callingComponent :event];
//		[_alerts removeObjectAtIndex:([_alerts indexOfObject:ac])];
//	}
//}
//
//+(void)showConfirm:(NSString*)msg :(SEL)result :(NSObject*)callingComponent :(NSString*)title :(int)flags :(Sprite*)parent
//{
//	AlertClass* ac = [[AlertClass alloc] init];
//	ac.alert=[mx.controls.Alert show:msg :title :flags :parent :onAlertCloseHandler];
//	ac.resultFunction = result;
//	ac.callingComponent =callingComponent;
//	[_alerts addObject:ac];
//}
//
+ (void)showError:(NSString *)errorMessage errorTitle:(NSString *)errorTitle {
    UIAlertView *alert = [[UIAlertView alloc]
            initWithTitle: errorTitle
                  message: errorMessage
                 delegate: nil
        cancelButtonTitle:@"OK"
        otherButtonTitles:nil];
    [alert show];

}

+ (void)showMessage:(NSString *)message title:(NSString *)title {
    UIAlertView *alert = [[UIAlertView alloc]
            initWithTitle: title
                  message: message
                 delegate: nil
        cancelButtonTitle:@"OK"
        otherButtonTitles:nil];
    [alert show];
}

+ (void)showToast:(NSString *)message title:(NSString *)title {
   [[[FLXSiToast makeText:message] setDuration:2000]show];
}
+ (void)showToast:(NSString *)message title:(NSString *)title duration:(int)duration {
    [[[FLXSiToast makeText:message] setDuration:duration]show];
}

//
//+(void)showValidationErrors:(NSArray*)errors :(NSString*)errorTitle
//{
//}
//
//+(void)wrapLables:(Form*)form
//{
//	// Determine best label width.
//	int n = form.numChildren;
//	for (int i = 0; i < n; i++)
//	{
//		UIView* child = [form getChildAt:i];
//		if (child is FormItem && ((FormItem*)(child)).includeInLayout)
//		{
//			(child as FormItem ).itemLabel.mx_internal::[self getTextField].wordWrap = YES;
//		}
//	}
//}
//
//+(NSMutableArray*)dictionaryToNSMutableArray:(NSObject*)obj
//{
//	NSMutableArray* NSMutableArray = [[NSMutableArray alloc] init];
//	for(var key:* in obj)
//	{
//		[NSMutableArray addObject:({@"data":key) :(@"label":obj[key[] toString]})];
//	}
//	return NSMutableArray;
//}
//
//+(void)traceData:(NSObject*)obj
//{
//}
//
//-(void)applyStyles:(NSArray*)properties :(NSObject*)sourceStyle :(NSObject*)targetStyle
//{
//	for(NSString* prop in properties)
//	{
//		if([sourceStyle getStyle:prop])
//			[targetStyle setStyle:prop :([sourceStyle getStyle:prop])];
//	}
//}
//
//+(void)handleError:(NSObject*)event
//{
//	[self showError:(@"Error occured : " + [event toString])];
//}
//
+ (NSArray *)removeFromArray:(NSMutableArray *)array itemToRemove:(NSObject *)itemToRemove {
    if([array containsObject:itemToRemove])
        [array removeObjectAtIndex:[array indexOfObject:itemToRemove]];
    return array;
}

+ (NSObject *)doesArrayContainValue:(NSArray *)array valFld:(NSString *)valFld compareVal:(NSString *)compareVal {
	for(NSObject* o1 in array)
	{
		if([o1 respondsToSelector:NSSelectorFromString(valFld)]
                && [o1 valueForKey:valFld]!=nil
                && [[[[o1 valueForKey:valFld] description] lowercaseString] isEqualToString: [compareVal lowercaseString]])
		{
			return o1;
		}
	}
	return nil;
}

+ (NSObject *)doesArrayContainStringValue:(NSArray *)array compareVal:(NSString *)compareVal {
 	for(NSObject* o1 in array)
	{
		if([[[o1 description] lowercaseString] isEqualToString:[compareVal lowercaseString]])
		{
			return o1;
		}
	}
	return nil;
}

+ (NSObject *)doesArrayContainObjectValue:(NSArray *)array valueField:(NSString *)valFld compareVal:(NSObject *)compareVal {
	for(NSObject* o1 in array)
	{
        if([o1 isKindOfClass:[NSString class]]){
             if([compareVal isEqual:o1]){
                 return o1;
             }
        }
		else if([o1 valueForKey:valFld  ] !=nil &&
                [[o1 valueForKey:valFld] isEqual:compareVal])
		{
			return o1;
		}
	}
	return nil;
}

+ (BOOL)nullOrEmpty:(NSString *)str {
    return str==nil || str.length==0;
}

//
//+(NSString*)getServerUrl
//{
//	NSString* url = [self getTopLevelApplication].url;
//	[return URLUtil getProtocol:url] + @"://" +
//[URLUtil getServerNameWithPort:url];
//}
//
//+(void)openBrowserPopup:(NSString*)url :(NSString*)options :(BOOL)useNew
//{
//	[ExternalInterface call:(@"[window open:('"+url+@"') :('newwin"+(useNew?[(_openWindowCount++) toString]:@"")+@"') :('"+options+@"')]")];
//}
//
+ (BOOL)areArraysEqual:(NSArray *)a1 array2:(NSArray *)a2 {
	if(a1==nil && a2==nil)
		return YES;
	else if(a1!=nil && a2!=nil)
	{
		if([a1 count] != [a2 count])
			return NO;
		for(int index=0;index< [a1 count];index++)
			if(![a1[index] isEqual:a2[index]])
			return NO;
	}
        return NO;
}

//
//+(FLXSClassFactory*)createRenderer:(Class*)renderer :(NSObject*)properties
//{
//	FLXSClassFactory* factory = [[FLXSClassFactory alloc] init:renderer];
//	factory.properties = properties;
//	return factory;
//}
//
//+(NSObject*)getTopLevelApplication
//{
//	[return FlexVersionSpecific getTopLevelApplication];
//}
//
+ (void)addChild:(UIView *)parent child:(UIView *)child {
    [parent addSubview:child];
}

+ (void)removeChild:(UIView *)parent child:(UIView *)child {
    [child removeFromSuperview];
}

+(void)removeAllChildren:(UIView*)parent
{
    NSArray *viewsToRemove = [parent subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
}

//
+ (NSMutableArray *)extractPropertyValues:(NSArray *)source propertyToExtract:(NSString *)propertyToExtract {
	NSMutableArray* result = [[NSMutableArray alloc] init];
	for(NSObject* obj in source)
	{
		if(obj)
			[result addObject:([obj valueForKey:propertyToExtract])];
	}
	return result;
}

+(NSString*)toString:(NSObject*)host
{
	if(host!=nil)return [host description];
	return @"";
}

+(NSString*)toPersistenceString:(NSObject*)host
{
	NSString* result=@"";
	if([host isKindOfClass:[NSMutableArray class]] || [host isKindOfClass:[NSArray class]])
	{
		result= [result stringByAppendingString:([host isKindOfClass:[NSMutableArray class]]?@"ac+=":@"ar+=")];
		for(NSObject* obj in (NSArray*)host)
		{
			result= [[result stringByAppendingString:[obj description]] stringByAppendingString:@"+="];
		}
	}
	else if([host isKindOfClass:[NSNumber class]] && strcmp([((NSNumber *)host) objCType], @encode(BOOL))==0 )
	{
		result=[result stringByAppendingString:@"b+="];
		result=[result stringByAppendingString:(host?@"y":@"n")];
	}
	else if([host isKindOfClass:[NSString class]])
	{
		result=[result stringByAppendingString:@"s+="];
		result=[result stringByAppendingString:[host description]];
	}
	else if([host isKindOfClass:[NSDate class]])
	{
		result= [result stringByAppendingString:@"d+="];
		result= [result stringByAppendingString:[FLXSDateUtils dateToString:(NSDate*)host withFormat:@"MM-DD-YYYY"]];
	}
	else if([host isKindOfClass:[NSNumber class]] )
	{
		result=[result stringByAppendingString:@"n+="];
		result=[result stringByAppendingString:[host description]];
	}
	return result;
}

+(id)fromPersistenceString:(NSString*)host
{
	id result;
	NSArray* parts = [host componentsSeparatedByString:(@"+=")];
	if([parts[0] isEqual:@"ac"] || [parts[0] isEqual:@"ar"])
	{
		result=[parts[0] isEqual:@"ac"]?[[NSMutableArray alloc] init]:[[NSMutableArray alloc] init];
		float partIndex=0;
		for(NSString* part in parts)
		{
			if(partIndex!=0)
			{
				if(part!=nil && part.length>0)
					[result addObject:part];
			}
			partIndex++;
		}
	}
	else if([parts[0] isEqual:@"b"])
	{
		return [NSNumber numberWithBool:[parts[1] isEqual:@"y"]?YES:NO];
	}
	else if([parts[0] isEqual:@"s"])
	{
		return parts[1]?parts[1]:@"";
	}
	else if([parts[0] isEqual:@"d"])
	{
		return [FLXSDateUtils dateFromString:parts[1] withFormat:@"MM-DD-YYYY"];//[Date parse:(parts[1[] toString])];
	}
	else if([parts[0] isEqual:@"n"])
	{
		return [NSNumber numberWithFloat:[parts[1] floatValue]];
	}
	return result;
}
//
//+(XML*)NSMutableArrayToXML:(NSObject*)val
//{
//	QName* qName = [[QName alloc] initWithType:(@"root")];
//	XMLDocument* xmlDocument = [[XMLDocument alloc] init];
//	SimpleXMLEncoder* simpleXMLEncoder = [[SimpleXMLEncoder alloc] init:xmlDocument];
//	XMLNode* xmlNode = [simpleXMLEncoder encodeValue:val :qName :xmlDocument];
//	NSString* xmlString=[xmlDocument toString];
//	XML* xml = [[XML alloc] init:xmlString];
//	return xml;
//}
//
//+(NSMutableArray*)xmlToNSMutableArray:(XML*)val
//{
//	XMLDocument* xmlDoc = [[XMLDocument alloc] initWithType:([val toString])];
//	SimpleXMLDecoder* decoder = [[SimpleXMLDecoder alloc] init:NO];
//	NSObject* resultObj = [decoder decodeXML:xmlDoc];
//	resultObj= [self processDeserializedObject:resultObj.root]
//return resultObj as NSMutableArray;
//}
//
//+(NSObject*)processDeserializedObject:(NSObject*)obj
//{
//	//workarounds for a bunch of Xml deserialization scenarios
//	if(obj==nil)
//	{
//		return nil;
//	}
//	else if([obj hasOwnProperty:(@"list")]&& obj.list && obj.list.source && obj.list.source.item)
//	{
//		NSMutableArray* newCollection = [[NSMutableArray alloc] initWithType:(obj.list.source.item is Array?obj.list.source.item:[obj.list.source.item])];
//		NSMutableArray* realCollection = [[NSMutableArray alloc] init];
//		for(NSObject* childObject in newCollection)
//		{
//			childObject=[self processDeserializedObject:childObject];
//			[realCollection addObject:childObject];
//		}
//		obj=realCollection;
//	}
//	else
//	{
//		for(NSString* prop in obj)
//		{
//			obj[prop]=[self processDeserializedObject:(obj[prop])];
//		}
//	}
//	return obj;
//}
//
//+(NSMutableArray*)getNSMutableArray:(id)val
//{
//	if(val is NSMutableArray)
//		return val as NSMutableArray;
//	else if(val is Array)
//return [[NSMutableArray alloc] init:val as Array];
//	else
//throw [[Error alloc] initWithType:(@"Invalid Input")];
//}
//
//+(FLXSFilter*)createDateFilter:(NSString*)description :(NSString*)fld :(NSString*)dateRange :(NSDate*)start :(NSDate*)end
//{
//	FLXSFilter* filter = [[FLXSFilter alloc] init];
//	filter.filterDescrption = description;
//	filter.arguments=[[NSMutableArray alloc] initWithType:([
//{columnName:fld
//,filterOperation: [FLXSFilterExpression FILTER_OPERATION_TYPE_BETWEEN]
//,filterControlValue: dateRange!=[FLXSDateRange DATE_RANGE_CUSTOM]?dateRange:@"Custom__"+[start toString]+@"__"+[end toString]
//,expression:dateRange!=[FLXSDateRange DATE_RANGE_CUSTOM]?[self getDateRange:dateRange]:[[NSMutableArray alloc] initWithType:([start,end])]}
//])];
//	return filter;
//}
//
//+(FLXSFilter*)createListFilter:(NSString*)description :(NSString*)fld :(NSArray*)values
//{
//	FLXSFilter* filter = [[FLXSFilter alloc] init];
//	filter.filterDescrption = description;
//	filter.arguments=[[NSMutableArray alloc] initWithType:([
//{columnName:fld
//,filterOperation:values.length>1?
//[FLXSFilterExpression FILTER_OPERATION_TYPE_IN_LIST]: [FLXSFilterExpression FILTER_OPERATION_TYPE_EQUALS]
//,filterControlValue: [[NSMutableArray alloc] init:values]
//,expression:[[NSMutableArray alloc] init:values]}])];
//	return filter;
//}
//
//+(NSMutableArray*)getDateRange:(NSString*)val
//{
//	FLXSDateRange* dr=[[FLXSDateRange alloc] init:val]
//return [[NSMutableArray alloc] initWithType:([dr.startDate,dr.endDate])];
//}
//
//+(NSObject*)getGroupForColumn:(NSObject*)grid :(NSObject*)col
//{
//	//these should be interfaces
//	if(![grid hasOwnProperty:(@"groupedColumns")])
//		return nil;
//	for(NSObject* grp in grid.groupedColumns)
//	{
//		if([grp hasOwnProperty:(@"children")])
//		{
//			//self means self is a Grouped [self column:ADGCG or FDGCG]
//			if([self isChildRecursive:grp :col])
//			{
//				return grp;
//			}
//		}
//	}
//	return nil;
//}
//
//+(BOOL)isChildRecursive:(NSObject*)grp :(NSObject*)col
//{
//	BOOL result=NO;
//	for(NSObject* childGrp in grp.children)
//	{
//		if([childGrp hasOwnProperty:(@"children")])
//		{
//			result = [self isChildRecursive:childGrp :col];
//			if(result)
//				return YES;
//		}
//		else if(childGrp==col)
//		{
//			return YES;
//		}
//	}
//	return NO;
//}
//
//+(NSString*)emptyIfNull:(NSObject*)val
//{
//	if(!val)return @"";
//	[return val toString];
//}
//
//+(void)transferPrimitiveProps:(NSObject*)from :(NSObject*)to :(NSArray*)propsToExclude
//{
//	if(!propsToExclude)propsToExclude= [[NSMutableArray alloc] init]
//	NSObject* props=[ObjectUtil getClassInfo:from :nil :({@"includeReadOnly":NO})].properties;
//	for(NSString* levelProp in props) //we're cloning columns here so as to not upset the orignial grid
//	{
//		if([propsToExclude indexOf:levelProp]>=0)continue;
//		if([FLXSUIUtils isPrimitive:(from[levelProp])] || (from[levelProp] is IFactory)|| (from[levelProp] is Function))
//		{
//			if(to[levelProp]!=from[levelProp])
//			{
//				to[levelProp]=from[levelProp];
//			}
//		}
//	}
//}
//
//+(void)transferProps:(NSObject*)from :(NSObject*)to :(NSArray*)propsToTransfer
//{
//	if(!propsToTransfer)propsToTransfer= [[NSMutableArray alloc] init]
//	for(NSString* prop in propsToTransfer)
//	{
//		if([to hasOwnProperty:prop] && to[prop]!=from[prop])
//			to[prop]=from[prop];
//	}
//}
//
//+(void)transferStyles:(NSObject*)from :(NSObject*)to :(NSArray*)stylesToTransfer
//{
//	if(!stylesToTransfer)stylesToTransfer= [[NSMutableArray alloc] init]
//	for(NSString* styl in stylesToTransfer)
//	{
//		if([from getStyle:styl]!=[to getStyle:styl])
//			[to setStyle:styl :([from getStyle:styl])];
//	}
//}
//
//+(float)getRandom:(float)minNum :(float)maxNum
//{
//	[return Math ceil:([Math random] * (maxNum - minNum + 1))] + (minNum - 1);
//}
//
//+ (NSObject*)expressionCache
//{
//	return expressionCache;
//}
//+ (NSMutableArray*)_alerts
//{
//	return _alerts;
//}
//+ (int)_openWindowCount
//{
//	return _openWindowCount;
//}
+(void)raiseExceptionWithType:(NSString *)type
                   andMessage:(NSString*)message {
    NSException* myException = [NSException
            exceptionWithName:type
                       reason:message
                     userInfo:nil];
    @throw myException;
}
+ (NSString *)concatenateStrings:(NSString *) firstString, ...{
    NSMutableString *str = [[NSMutableString alloc] initWithString:firstString];
    id eachObject;
    va_list argumentList;
    if (firstString)
    {
        va_start(argumentList, firstString);
        while ((eachObject = va_arg(argumentList, id)))
        {
            [str stringByAppendingString:(NSString *) eachObject];
        }
        va_end(argumentList);
    }
    return str;
}
static const char * getPropertyType(objc_property_t property) {
    const char * attrs = property_getAttributes( property );
    if ( attrs == NULL )
        return ( NULL );

    static char buffer[256];
    const char * e = strchr( attrs, ',' );
    if ( e == NULL )
        return ( NULL );

    int len = (int)(e - attrs);
    memcpy( buffer, attrs, len );
    buffer[len] = '\0';

    return ( buffer );
}
+ (NSDictionary *)getClassInfoDictionary:(Class)paramClass{
    NSArray * classInfo = [FLXSUIUtils getClassInfo:[paramClass class]];
    NSMutableDictionary * propsDict = [[NSMutableDictionary alloc]init];
    for (FLXSLabelData* ld in classInfo){
        [propsDict setObject:ld forKey:ld.label];
    }
    return propsDict;
}


+ (NSArray *)getClassInfo:(Class)paramClass
{
    if (paramClass == NULL) {
        return nil;
    }

    NSMutableArray *results = [[NSMutableArray alloc] init];

    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(paramClass, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            const char *propType = getPropertyType(property);
            if(propType){
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            NSString *propertyType = [NSString stringWithUTF8String:propType];
            FLXSLabelData* ld = [[FLXSLabelData alloc] initWithLabel:propertyName andData:propertyType];
            [results addObject:ld];
            }
        }
    }
    free(properties);
    if([paramClass superclass]){
        NSArray* parentResults = [FLXSUIUtils getClassInfo:[paramClass superclass]];
        results=[[results arrayByAddingObjectsFromArray:parentResults] mutableCopy];
    }
    return results;
}

+(NSString *)checkSelectorSuffix:(NSString*)value :(NSString*)params{
    if(![value hasSuffix:@"::"]){
        value = [value stringByReplacingOccurrencesOfString:@":" withString:@""];
        value = [value stringByAppendingString:params];
    }
    return value;
}

+(UIWindow*) getTopLevelWindow {
    UIWindow* window = [FLXSUIUtils isIPad]?[UIApplication sharedApplication].keyWindow:nil;
    if (window==nil || window.windowLevel != UIWindowLevelNormal) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    return window;
}

//Start FLXSIEventDispatcher methods
static BOOL checked=NO;
static FLXSChecker * checker;
+ (void)initialize {
    if(!checked){
        checked= YES;
        checker=[[FLXSChecker alloc] init];
    }
}
+(void)addEventListenerOfType:(NSString *)type withTarget:(NSObject *)target andHandler:(SEL)handler andSender:(NSObject *)sender{

    [[NSNotificationCenter defaultCenter] addObserver:target
                                             selector:handler
                                                 name:type
                                               object:sender];
}

+ (BOOL)isIPad {
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}

+(void)removeEventListener:(NSString *)type withTarget:(NSObject *)target andHandler:(SEL)handler andSender:(NSObject *)sender{
    [[NSNotificationCenter defaultCenter] removeObserver:target
                                                    name:type
                                                  object:sender];
}
+(BOOL)dispatchEvent:(FLXSEvent *)event withSender:(NSObject *) sender{
    event.target = (UIView *)sender;
    NSNotification * notification = [NSNotification notificationWithName:event.type
                                                                  object:sender
                                                                userInfo:[NSDictionary dictionaryWithObject:event
                                                                                                     forKey:@"event"]
    ];


    [[NSNotificationCenter defaultCenter] postNotification:notification];
    return YES;
}

+(BOOL)isRunningIOS8OrGreater{
    return SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0");
}

+(UIViewController*)findFileOwnerForComponent:(UIView*)view{
    for (UIView* next = [view superview]; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
             return (UIViewController*)nextResponder;
        }
    }
    
    return nil;
}

//End FLXSIEventDispatcher methods
@end



