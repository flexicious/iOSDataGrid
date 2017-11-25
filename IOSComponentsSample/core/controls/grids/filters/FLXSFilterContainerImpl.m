#import "FLXSFilterContainerImpl.h"
#import "FLXSKeyboardEvent.h"


@implementation FLXSFilterContainerImpl

@synthesize filterControls;
@synthesize iEventDispatcher;
@synthesize tabHandled;

-(id)initWithIEventDispatcher:(UIView<FLXSIEventDispatcher> *)iEventDispatcherIn
{
	self = [super init];
	if (self)
	{
		self.filterControls = [[NSMutableArray alloc] init];
		self.tabHandled = NO;
		self.iEventDispatcher =iEventDispatcherIn;
	}
	return self;
}

-(void)resetFilterControls
{
	for(UIView <FLXSIFilterControl>* iFilterControl in self.filterControls)
	{
		[iFilterControl dispatchEvent:([[FLXSEvent alloc] initWithType:[FLXSFilterPageSortChangeEvent DESTROY]])];
	}
	[self.filterControls removeAllObjects];
}

-(void)unRegisterIFilterControl:(UIView <FLXSIFilterControl>*)iFilterControl
{
	if([[iFilterControl.filterTriggerEvent lowercaseString] isEqualToString: @"none"])
	{
		//user specified trigger event, so don't refresh on control change
	}
	else if([[iFilterControl.filterTriggerEvent lowercaseString] isEqualToString:@"enterkeyup"])
	{
        [iFilterControl removeEventListenerOfType:[FLXSEvent EVENT_KEY_UP] fromTarget:self usingHandler:@selector(onKeyUp:)];

	}
	else
	{
		//user specified trigger event, so dont refresh on control change
		if ([iFilterControl conformsToProtocol:@protocol(FLXSIDelayedChange)])
		{
            [iFilterControl removeEventListenerOfType:[FLXSEvent EVENT_DELAYED_CHANGE] fromTarget:self usingHandler:@selector(onChangeHandler:)];
		}
		else
		{
            [iFilterControl removeEventListenerOfType:[FLXSEvent EVENT_CHANGE] fromTarget:self usingHandler:@selector(onChangeHandler:)];
		}
	}
	[self.filterControls removeObjectAtIndex:([self.filterControls indexOfObject:iFilterControl])];
}

-(BOOL)isIFilterControlRegistered:(UIView <FLXSIFilterControl>*)iFilterControl
{
	return [self.filterControls containsObject:iFilterControl];
}

-(void)registerIFilterControl:(UIView <FLXSIFilterControl>*)iFilterControl
{
	[self.filterControls addObject:iFilterControl];
	if([[iFilterControl.filterTriggerEvent lowercaseString] isEqualToString:@"none"])
	{
		//user specified trigger event, so dont refresh on control change
	}
	else if([[iFilterControl.filterTriggerEvent lowercaseString] isEqualToString:@"enterkeyup"])
	{
        [iFilterControl addEventListenerOfType:[FLXSEvent EVENT_KEY_UP] usingTarget:self withHandler:@selector(onKeyUp:)];
	}
	else
	{
		//user specified trigger event, so dont refresh on control change
		if ([iFilterControl conformsToProtocol:@protocol(FLXSIDelayedChange)]  )
		{
            [iFilterControl addEventListenerOfType:[FLXSEvent EVENT_DELAYED_CHANGE] usingTarget:self withHandler:@selector(onChangeHandler:)];
		}
		else
		{
            [iFilterControl addEventListenerOfType:[FLXSEvent EVENT_CHANGE] usingTarget:self withHandler:@selector(onChangeHandler:)];
		}
	}
}


-(void)onFilterKeyUp:(FLXSKeyboardEvent*)event
{

}

-(BOOL)setFilterFocus:(NSString*)fld
{
	for(int i=0;i< [self.filterControls count];i++)
	{
		UIView <FLXSIFilterControl>* child=self.filterControls[i];
		if([child.searchField isEqualToString:fld])
		{
			if([child isKindOfClass: [UIResponder class]])
			{
                 [(UIResponder *)child becomeFirstResponder];
                return YES;
			}
		}
	}
	return NO;
}
//
//-(BOOL)setFocusOnNextFocusableControl:(int)myIndex :(BOOL)forward :(BOOL)inclusive
//{
//    UIView <FLXSIFilterControl>*  nextFilter=[self getNextFocusableFilter:myIndex :forward :inclusive];
//	if(nextFilter)
//	{
//		[self setFocusOnChild:nextFilter];
//		return YES;
//	}
//	return NO;
//}

-(void)setFocusOnChild:(UIView <FLXSIFilterControl>*)child
{
    if([child isKindOfClass:[FLXSTextInput class]])
    {
        FLXSTextInput * txtInput =(FLXSTextInput *) (child );
        NSString* txt=txtInput.text;
        if(txt.length>0)                  {
            UITextPosition *newPosition = [txtInput positionFromPosition:0 offset:txt.length];
            UITextRange *newRange = [txtInput textRangeFromPosition:0 toPosition:newPosition];
            [txtInput setSelectedTextRange:newRange];
        }
        [txtInput becomeFirstResponder];
    }
}
//
//-(IFocusManagerComponent*)getNextFilter:(NSObject*)event
//{
//	int myIndex;
//	for(int i=0;i<[_filterControls length];i++)
//	{
//		UIView <FLXSIFilterControl>* child=_filterControls[i];
//		if(event.currentTarget==child)
//		{
//			myIndex=i;
//			break;
//		}
//	}
//	BOOL backward = (event.keyCode == [Keyboard LEFT]) || ((event.keyCode == [Keyboard TAB]) && event.shiftKey);
//	BOOL forward= (event.keyCode == [Keyboard RIGHT]) || (event.keyCode == [Keyboard TAB]) && !backward;
//	if(!forward&&!backward)return nil;
//}
//
//-(UIView <FLXSIFilterControl>*)getNextFocusableFilter:(int)myIndex :(BOOL)forward :(BOOL)inclusive
//{
//	if([_filterControls length]==0)return nil;
//	if(myIndex>=0 && myIndex<=[_filterControls length] && inclusive &&(_filterControls[myIndex] is IFocusManagerComponent))
//	{
//		return _filterControls[myIndex];
//	}
//	UIView <FLXSIFilterControl>* myFilter = _filterControls[myIndex];
//	if(myFilter is FLXSITriStateCheckBoxFilterControl)
//	{
//		myFilter=myFilter;
//	}
//	IFocusManagerComponent* nextFilter;
//	FLXSIExtendedDataGrid* dg=_iEventDispatcher[@"dataGrid"];
//	float myX = [dg getFilterX:myFilter];
//	for(UIView <FLXSIFilterControl>* filterControl in self._filterControls)
//	{
//		if(filterControl is IFocusManagerComponent)
//		{
//			float otherX = [dg getFilterX:filterControl];
//			if(forward)
//			{
//				if(nextFilter)
//				{
//					if((otherX<(nextFilter as FLXSIFilterControl).x)
//						&& (otherX>myX)
//						&& (filterControl is IFocusManagerComponent)
//						&& (filterControl != myFilter))
//					{
//						nextFilter = filterControl as IFocusManagerComponent;
//					}
//				}
//				else if(otherX>myX
//&& (filterControl != myFilter))
//				{
//					nextFilter = filterControl as IFocusManagerComponent;
//				}
//			}
//			else
//			{
//				//backward
//				if(nextFilter)
//				{
//					if((otherX>(nextFilter as FLXSIFilterControl).x)
//						&& (otherX<myX)
//						&& (filterControl is IFocusManagerComponent)
//						&& (filterControl != myFilter))
//					{
//						nextFilter = filterControl as IFocusManagerComponent;
//					}
//				}
//				else if(otherX<myX
//&& (filterControl != myFilter))
//				{
//					nextFilter = filterControl as IFocusManagerComponent;
//				}
//			}
//		}
//	}
//	return nextFilter;
//}

-(NSMutableArray*)getFilterControls
{
	return self.filterControls;
}

-(NSMutableArray*)getFilterArguments
{
	NSMutableArray* arguments = [[NSMutableArray alloc] init];
	for(UIView <FLXSIFilterControl>* iFilterControl in self.filterControls)
	{
		FLXSFilterExpression * filterExpression = [FLXSFilterContainerImpl getFilterExpression:iFilterControl];
		if(filterExpression!=nil)
		{
			[arguments addObject:filterExpression];
		}
	}
	return arguments;
}

- (void)setFilterValue:(NSString *)column value:(NSObject *)value {
	for(UIView <FLXSIFilterControl>* iFilterControl in self.filterControls)
	{
		if([iFilterControl.searchField isEqualToString: column])
		{
			[iFilterControl setValue:value];
		}
	}
}

-(NSObject*)getFilterValue:(NSString*)column
{
	for(UIView <FLXSIFilterControl>* iFilterControl in self.filterControls)
	{
		if([iFilterControl.searchField isEqualToString: column]){
            return [iFilterControl getValue];
		}
	}
	return nil;
}

-(BOOL)hasField:(NSString*)column
{
	for(UIView <FLXSIFilterControl>* iFilterControl in self.filterControls)
	{
		if([iFilterControl.searchField isEqualToString:column])
		{
			return YES;
		}
	}
	return NO;
}

-(void)processFilter
{
	[self onChangeHandler:nil];
}

-(void)clearFilter:(NSString*)col
{
	for(UIView <FLXSIFilterControl>* iFilterControl in self.filterControls)
	{
		if(col==nil || [col isEqualToString:iFilterControl.searchField])
			[iFilterControl clear];
	}
	[self onChangeHandler:nil];
}

-(void)onKeyUp:(FLXSKeyboardEvent*)event

{
	if([event.keyCode isEqualToString:@"\n"])
	{
		[self onChangeHandler:(NSNotification*)event];
	}
}

-(void)onChangeHandler:(NSNotification*)ns
{
    FLXSEvent* event =(FLXSEvent*) [ns.userInfo objectForKey:@"event"];
	FLXSFilter * filter =  [[FLXSFilter alloc] init];
	filter.arguments=[self getFilterArguments];
	FLXSFilterPageSortChangeEvent * filterPageSortChangeEvent= [[FLXSFilterPageSortChangeEvent alloc]
            initWithType:[FLXSFilterPageSortChangeEvent FILTER_CHANGE]
            :filter
            :YES
            :YES];
    filterPageSortChangeEvent.triggerEvent = event;
	[self.iEventDispatcher dispatchEvent:filterPageSortChangeEvent];
}

+(FLXSFilterExpression *)getFilterExpression:(UIView <FLXSIFilterControl>*)iFilterControl
{
	//if(!iFilterControl.enabled)return nil;
	NSObject* expression;
	FLXSFilterExpression * filterExpression=  [[FLXSFilterExpression alloc] init];
    	filterExpression.columnName=iFilterControl.searchField;
	filterExpression.filterOperation=iFilterControl.filterOperation;
	filterExpression.wasContains = ([filterExpression.filterOperation isEqual:[FLXSFilterExpression FILTER_OPERATION_TYPE_CONTAINS]]);
	filterExpression.filterComparisonType=iFilterControl.filterComparisonType;
	filterExpression.filterControl=iFilterControl;
	filterExpression.filterControlValue = [iFilterControl getValue];
	if ([iFilterControl conformsToProtocol:@protocol(FLXSICustomMatchFilterControl)])
	{
		filterExpression.columnName =iFilterControl.searchField;
		filterExpression.filterControl=iFilterControl;
		filterExpression.expression=filterExpression.filterControlValue;
		return filterExpression;
	}
	else if ([iFilterControl conformsToProtocol:@protocol(FLXSIDynamicFilterControl)])
	{
		UIView <FLXSIDynamicFilterControl>* iDynamicFilterControl=(UIView <FLXSIDynamicFilterControl>*)(iFilterControl);
		filterExpression=iDynamicFilterControl.filterExpression;
		if(filterExpression ==nil)return nil;
		filterExpression.columnName =iFilterControl.searchField;
		filterExpression.filterComparisonType=iFilterControl.filterComparisonType;
		filterExpression.filterControl=iFilterControl;
		return filterExpression;
	}
 	else if ([iFilterControl conformsToProtocol:@protocol(FLXSIRangeFilterControl)] )
	{
		filterExpression.filterOperation=[FLXSFilterExpression FILTER_OPERATION_TYPE_BETWEEN];
        UIView <FLXSIRangeFilterControl>* iRangeFilterControl=(UIView<FLXSIRangeFilterControl>*)iFilterControl;
		if(iRangeFilterControl.searchRangeStart == nil || iRangeFilterControl.searchRangeEnd== nil )
			return nil;
		expression=[[NSMutableArray alloc] init];
		[((NSMutableArray *)expression) addObject:iRangeFilterControl.searchRangeStart];
		[((NSMutableArray *)expression) addObject:iRangeFilterControl.searchRangeEnd];
	}
	else if ([iFilterControl conformsToProtocol:@protocol(FLXSISingleSelectFilterControl)])
	{
        UIView <FLXSISingleSelectFilterControl>*  iSingleSelectFilterControl=( UIView <FLXSISingleSelectFilterControl>*)iFilterControl;
		if (iSingleSelectFilterControl.selectedItem == nil
                || [iSingleSelectFilterControl.selectedItem isEqual:iSingleSelectFilterControl.addAllItemText]
			    || [iSingleSelectFilterControl.selectedItem valueForKey:iSingleSelectFilterControl.dataFieldFLXS]== nil
                || [[iSingleSelectFilterControl.selectedItem valueForKey:iSingleSelectFilterControl.dataFieldFLXS] isEqual:iSingleSelectFilterControl.addAllItemText]
             )
			return nil;
		expression= [iSingleSelectFilterControl.selectedItem valueForKey:iSingleSelectFilterControl.dataFieldFLXS];
	}
	else if ([iFilterControl conformsToProtocol:@protocol(FLXSIMultiSelectFilterControl)])
	{
        UIView <FLXSIMultiSelectFilterControl>*  iMultiSelectFilterControl=( UIView <FLXSIMultiSelectFilterControl>*)iFilterControl;
		expression=[[NSMutableArray alloc] init];
		filterExpression.filterOperation=[FLXSFilterExpression FILTER_OPERATION_TYPE_IN_LIST];
		for(NSObject* obj in iMultiSelectFilterControl.selectedItems)
		{
			if (obj != nil)
			{
				if (![obj respondsToSelector:NSSelectorFromString(iMultiSelectFilterControl.dataFieldFLXS)]
					|| [[obj valueForKey:iMultiSelectFilterControl.dataFieldFLXS] isEqual: iMultiSelectFilterControl.addAllItemText])
					return nil;
				[((NSMutableArray *)expression) addObject:[obj valueForKey:iMultiSelectFilterControl.dataFieldFLXS] ];
			}
		}
		if(((NSMutableArray *)expression) .count==0)return nil;
		expression=expression;
	}
	else if ([iFilterControl conformsToProtocol:@protocol(FLXSITextFilterControl)] )
	{
		if(filterExpression.filterOperation == nil)
			filterExpression.filterOperation = [FLXSFilterExpression FILTER_OPERATION_TYPE_BEGINS_WITH];
        UIView <FLXSITextFilterControl>*  iTextFilterControl=( UIView <FLXSITextFilterControl>*)iFilterControl;
		if(iTextFilterControl.text.length==0)
			return nil;
		expression= iTextFilterControl.text;
	}
	else if ([iFilterControl conformsToProtocol:@protocol(FLXSITriStateCheckBoxFilterControl)])
	{
        UIView <FLXSITriStateCheckBoxFilterControl>*  iTriStateCheckBoxFilterControl=( UIView <FLXSITriStateCheckBoxFilterControl>*)iFilterControl;

		if([iTriStateCheckBoxFilterControl.selectedState isEqual:@"middle"])
			return nil;
		expression= [NSNumber numberWithBool: [iTriStateCheckBoxFilterControl.selectedState isEqual:@"checked"]];
	}
	else if ([iFilterControl conformsToProtocol:@protocol(FLXSISelectedBitFilterControl)])
	{
        UIView <FLXSISelectedBitFilterControl>*  iSelectedBitFilterControl=( UIView <FLXSISelectedBitFilterControl>*)iFilterControl;
        expression= [NSNumber numberWithBool: iSelectedBitFilterControl.selected];
	}
	if(filterExpression.filterOperation == nil)
		filterExpression.filterOperation = [FLXSFilterExpression FILTER_OPERATION_TYPE_EQUALS];
	filterExpression.expression = expression;
	filterExpression.filterControlValue = [iFilterControl getValue];
	if(iFilterControl.gridColumn && iFilterControl.gridColumn.enableRecursiveSearch)
		filterExpression.recurse=iFilterControl.gridColumn.enableRecursiveSearch;
	return filterExpression;
}

@end

