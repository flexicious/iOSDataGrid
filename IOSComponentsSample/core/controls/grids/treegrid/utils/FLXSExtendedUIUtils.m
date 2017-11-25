#import "FLXSExtendedUIUtils.h"
#import "FLXSFlexDataGridColumnLevel.h"
#import "FLXSFilter.h"
#import "FLXSFlexDataGrid.h"
#import "FLXSFilterExpression.h"
#import "FLXSFilterSort.h"
#import <objc/message.h>


@implementation FLXSExtendedUIUtils

+(NSString*)toString:(NSObject*)host
{
	if(host!=nil)return[ host description];
	return @"";
}

+ (id)resolveExpression:(NSObject *)host expression:(NSString *)expression valueToApply:(NSObject *)valueToApply returnUndefinedIfPropertyNotFound:(BOOL)returnUndefinedIfPropertyNotFound applyNullValues:(BOOL)applyNullValues {

    BOOL isDictionary = [host isKindOfClass:[NSDictionary class]];
    NSMutableDictionary * dic = isDictionary?(NSMutableDictionary *)host:nil;

    if (nil == expression || [expression isEqual: @""])
	{
		return host;
	}
	if ([expression rangeOfString:(@".")].location == NSNotFound && [expression rangeOfString:(@"[")].location == NSNotFound)
	{
		if ((host!=nil) &&
                (
                (
                        (isDictionary)||
                        [host respondsToSelector:NSSelectorFromString(expression)]
                 )
                        || valueToApply!=nil))
		{
			if(valueToApply!=nil || applyNullValues){
                if(isDictionary){
                    if(valueToApply!=nil){
                        [dic setObject:valueToApply forKey:expression];
                    }
                }
                else
                    [host setValue:valueToApply forKey:expression];
            }
			NSObject* result= isDictionary?[dic objectForKey:expression]:[host valueForKey:expression];
            if(isDictionary && [result isKindOfClass:[NSDictionary class]]){
               NSDictionary * resultDictionary =  ((NSDictionary *)result);
               if(resultDictionary.allValues.count==1 && [[resultDictionary.allKeys objectAtIndex:0] isEqual:@"text"]){
                   result = [resultDictionary.allValues objectAtIndex:0];
                   if([result isKindOfClass:[NSString class]]){
                       result = [((NSString *)result) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                   }
               }
            }
			return result;
		}
		return returnUndefinedIfPropertyNotFound? nil :nil;
	}
	NSArray* fields = [expression componentsSeparatedByString:(@".")];
	NSObject* endpointData = host;
	int i = 0;
	for(NSString* field in fields)
	{
		i++;
		if ([field rangeOfString:(@"[")].location != NSNotFound)
		{
			NSString* indexString = [field substringWithRange:NSMakeRange([field rangeOfString:@"["].location+1, [field rangeOfString:@"]"].location)];
            NSString *epProperty = [field substringWithRange:NSMakeRange(0, [field rangeOfString:@"["].location)];
            endpointData = [endpointData valueForKey:epProperty];
            if ([indexString floatValue] <= ((NSArray *)(endpointData)).count - 1)
			{
				endpointData = [(NSArray*) endpointData objectAtIndex:[indexString integerValue]];
			}
			else
			{
				return @"";
			}
		}
		else if (endpointData != nil && i <= fields.count)
		{
            if(isDictionary){
                return [FLXSExtendedUIUtils resolveExpression:endpointData expression:field valueToApply:valueToApply returnUndefinedIfPropertyNotFound:returnUndefinedIfPropertyNotFound applyNullValues:applyNullValues];
            }
			else if ([endpointData respondsToSelector:NSSelectorFromString(field)])
			{
				if(((valueToApply!=nil || applyNullValues)) && (i==fields.count)){
					[endpointData setValue:valueToApply forKey:field];
                }
                endpointData = [endpointData valueForKey:field];
			}
			else
			{
				return returnUndefinedIfPropertyNotFound?nil:nil;
			}
		}
	}
	return endpointData;
}

+ (NSArray *)sortArray:(NSArray *)arrayIn sorts:(NSArray *)sorts delegateForSortCompareFunctions:(id)delegateForSortCompareFunctions {
	NSMutableArray* array = [arrayIn mutableCopy];

    if([array count]==0)return array;
//	NSObject* modelItem = array[0];
    NSMutableArray *sortDescriptors = [[NSMutableArray alloc] initWithCapacity:[sorts count]];
    for(FLXSFilterSort* srt in sorts)
	{
//        SEL sel=NSSelectorFromString(srt.sortColumn);
		//if([modelItem respondsToSelector:sel] || (srt.sortCompareFunction!=nil))
		{
            __weak NSString *blockSafeSortCol = srt.sortColumn;
            __weak NSString *blockSafeSortCompareFunction = srt.sortCompareFunction;
            __weak id blockSafeDelegateForSortCompareFunctions = delegateForSortCompareFunctions;

            NSSortDescriptor * sortByRank =

                    [NSSortDescriptor sortDescriptorWithKey:nil
                                                  ascending:srt.isAscending
                                                 comparator:
                                                         !([FLXSUIUtils nullOrEmpty:srt.sortCompareFunction])?
                            ^(id obj1, id obj2) {
                        SEL selector = NSSelectorFromString(blockSafeSortCompareFunction);
                        NSComparisonResult result=((NSComparisonResult(*)(id, SEL, id,id))objc_msgSend)(blockSafeDelegateForSortCompareFunctions, selector, obj1,obj2);
                       
                        return result;
                    }
                            :srt.sortNumeric?^(id obj1, id obj2) {
                                                         obj1 = [FLXSExtendedUIUtils resolveExpression:obj1 expression:blockSafeSortCol valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ];
                                                         obj2 = [FLXSExtendedUIUtils resolveExpression:obj2 expression:blockSafeSortCol valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ];


                                                         if ([obj1 floatValue] > [obj2 floatValue]) {
                                                             return (NSComparisonResult)NSOrderedDescending;
                                                         }

                                                         if ([obj1 floatValue] < [obj2 floatValue]) {
                                                             return (NSComparisonResult)NSOrderedAscending;
                                                         }
                                                         return (NSComparisonResult)NSOrderedSame;

                                                     } :
                                                         srt.sortCaseInsensitive?  ^(id obj1, id obj2) {
                                                             obj1 = [[[FLXSExtendedUIUtils resolveExpression:obj1 expression:blockSafeSortCol valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ] description] lowercaseString];
                                                             obj2 = [[[FLXSExtendedUIUtils resolveExpression:obj2 expression:blockSafeSortCol valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ] description] lowercaseString];

                                                             return [obj1 compare:obj2];
//                                                             if (obj1  > obj2) {
//                                                                 return (NSComparisonResult)NSOrderedDescending;
//                                                             }
//
//                                                             if (obj1  < obj2) {
//                                                                 return (NSComparisonResult)NSOrderedAscending;
//                                                             }
//                                                             return (NSComparisonResult)NSOrderedSame;
                                                         }
                                                            :^(id obj1, id obj2) {

                                                             obj1 = [FLXSExtendedUIUtils resolveExpression:obj1 expression:blockSafeSortCol valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ];
                                                             obj2 = [FLXSExtendedUIUtils resolveExpression:obj2 expression:blockSafeSortCol valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ];
                                                             return [obj1 compare:obj2];
//                                                             if (obj1 > obj2) {
//                                                                 return (NSComparisonResult)NSOrderedDescending;
//                                                             }
//                                                             if (obj1 < obj2) {
//                                                                 return (NSComparisonResult)NSOrderedAscending;
//                                                             }
//                                                             return (NSComparisonResult)NSOrderedSame;
                                                         }

                    ];

            [sortDescriptors addObject:sortByRank];
        };
    }

    [array sortUsingDescriptors:sortDescriptors];
    return array;
}

+(UIColor *)getColorName:(UInt32)hex
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;

    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

+ (NSArray *)pageArray:(NSArray *)arrayIn pageIndex:(int)pageIndex pageSize:(int)pageSize {
    int totalRecords= (int)[arrayIn count];
    int pageStart= ((pageIndex)* pageSize);
	int pageEnd= (pageStart+pageSize)>totalRecords-1?totalRecords-1:pageStart+pageSize-1;
	NSMutableArray * newFlat= [[NSMutableArray alloc] init];
	for (int i=pageStart;i<=pageEnd;i++)
		[newFlat addObject:(arrayIn[i])];
	return newFlat;
}

+ (NSArray *)pageArrayByPageNumbers:(NSArray *)arrayIn pageIndexes:(NSArray *)pageIndexes pageSize:(int)pageSize {
	int totalRecords= (int)[arrayIn count];
	int pageIndex= [[pageIndexes objectAtIndex:0] intValue]>0? [pageIndexes[0] intValue] -1:0;
	if(pageIndexes[0]>=pageIndexes[1])
		return [self pageArray:arrayIn pageIndex:pageIndex pageSize:pageSize];
	int pageStart= ((pageIndex)* pageSize);
	int spanSize= (int)(pageSize*([pageIndexes[1] integerValue] -pageIndex));
	int pageEnd= (pageStart+spanSize)>totalRecords-1?totalRecords-1:pageStart+spanSize-1;
    NSMutableArray * newFlat= [[NSMutableArray alloc] init];
	for (int i=pageStart;i<=pageEnd;i++)
		[newFlat addObject:([arrayIn objectAtIndex:i ])];
	return newFlat;
}

+ (NSArray *)filterArray:(NSArray *)arrayIn filter:(FLXSFilter *)filter grid:(FLXSFlexDataGrid *)grid level:(FLXSFlexDataGridColumnLevel *)level hideIfNoChildren:(BOOL)hideIfNoChildren {
	NSMutableArray* retVal= [[NSMutableArray alloc] init];
	for(NSObject* obj in arrayIn)
	{
        if([self filterRecursive:(NSArray *)obj filter:filter level:level hideIfNoChildren:hideIfNoChildren])
		{
			[retVal addObject:obj];
		}
	}
	return retVal;
}

+ (BOOL)filterRecursive:(NSArray *)obj filter:(FLXSFilter *)filter level:(FLXSFlexDataGridColumnLevel *)level hideIfNoChildren:(BOOL)hideIfNoChildren {
    //next version selector
//	if(level.grid.globalFilterMatchFunction!=nil)
//	{
//		return [level.grid globalFilterMatchFunction:obj];
//	}
	if(([filter.arguments count] >0 && (level.nestDepth==1 || level.reusePreviousLevelColumns)) || (level.hasFilterFunction))
	{
		BOOL match=YES;
		if([filter.arguments count] >0 && (level.nestDepth==1 || level.reusePreviousLevelColumns))
		{
			//match filter
			for(FLXSFilterExpression* fExp in filter.arguments)
			{
				if(level.grid.filterExcludeObjectsWithoutMatchField)
				{
					if(fExp.columnName && obj && ![obj respondsToSelector:NSSelectorFromString(fExp.columnName)])
					{
						match=NO;
						break;
					}
				}
				if(![fExp isMatch:obj grid:level.grid])
				{
					match=NO;
					break;
				}
			}
		}
		if(![FLXSUIUtils nullOrEmpty:level.filterFunction] && match)
		{
            //match filterFunction
            //match=[level filterFunction:obj];
            SEL selector = NSSelectorFromString(level.filterFunction);
            id target = level.grid.delegate;
            id result =    ((id(*)(id, SEL, NSObject *))objc_msgSend)(target, selector, obj);
            match = [result boolValue];
        }
		if(!level.nextLevel)
			return match;
		//now we know if I matched.
		if(match)
		{
			if(hideIfNoChildren)
			{
                NSArray*    children= [level getChildren:obj filter:NO page:NO sort:NO ];
				for(NSObject* child in children)
				{
					if([self filterRecursive:(NSArray *)child filter:filter level:level.nextLevel hideIfNoChildren:hideIfNoChildren])
					{
						return YES;
						//I matched and atleast one of my children matched.
					}
				}
				return NO;
				//either I do not have children, or none of them matched.
			}
			else
return YES;
			//hideIfNoChildren=NO and I matched
		}
		else
		{
			BOOL recurse=NO;
			for(FLXSFilterExpression* exp in filter.arguments)
			{
				if(exp.recurse)
				{
					recurse=YES;
					break;
				}
			}
			if(recurse)
			{
				//i didnt match, but did any of my children match?
                NSArray* children1= [level getChildren:obj filter:NO page:NO sort:NO ];
				for(NSObject* child1 in children1)
				{
					if([self filterRecursive:(NSArray *)child1 filter:filter level:level.nextLevel hideIfNoChildren:hideIfNoChildren])
					{
						return YES;
						//I didnt match but atleast one of my children matched.
					}
				}
				return NO;
				//i did not match, none of my children did either
			}
			else
                return NO;
			//i did not match, and there are no recursing expressions.
		}
	}
	else
	{
		//nothing to filter
		return YES;
	}
}

+ (BOOL)recursiveMatch:(NSArray *)items filter:(FLXSFilter *)filter grid:(FLXSFlexDataGrid *)grid level:(FLXSFlexDataGridColumnLevel *)level recursingExpression:(FLXSFilterExpression *)recursingExpression {
	for(NSObject* obj in items)
	{
		if([recursingExpression isMatch:obj grid:grid])
			return YES;
		else if(level)
		{
			if([self recursiveMatch:([level getChildren:obj filter:NO page:NO sort:NO ]) filter:filter grid:grid level:level.nextLevel recursingExpression:recursingExpression])
			{
				return YES;
			}
		}
	}
	return NO;
}

+ (NSArray *)filterArrayFlat:(NSArray *)arrayIn filter:(FLXSFilter *)filter {
    NSMutableArray* retVal= [[NSMutableArray alloc] init];
	for(NSObject* obj in arrayIn)
	{
		for(FLXSFilterExpression* fExp in filter.arguments)
		{
			if([fExp isMatch:obj grid:nil ])
			{
				[retVal addObject:obj];
			}
		}
	}
	return retVal;
}

+ (NSArray *)filterPageSort:(NSArray *)flat filter:(FLXSFilter *)filter pages:(NSArray *)pages flatFilter:(BOOL)flatFilter {
	if([filter.sorts count] >0)
	{
		NSArray* flatCol= [flat mutableCopy];
		flatCol = [self sortArray:flatCol sorts:filter.sorts delegateForSortCompareFunctions:filter.delegateForSortCompareFunctions];

		flat= [flatCol mutableCopy];
	}
	if([filter.arguments count] >0)
	{
		flat = flatFilter? [self filterArrayFlat:flat filter:filter] : [self filterArray:flat filter:filter grid:nil level:nil hideIfNoChildren:NO ];
	}
	filter.recordCount= (int)[flat count];
	if(filter.pageIndex>=0)
	{
		if(pages)
			flat = [self pageArrayByPageNumbers:flat pageIndexes:pages pageSize:filter.pageSize];
		else
        flat = [self pageArray:flat pageIndex:filter.pageIndex pageSize:filter.pageSize];
	}
	return flat;
}

+(float)nanToZero:(id)input
{
	return isnan([input floatValue])?0: [input floatValue];
}

+ (void)gradientFill:(UIView *)comp colors:(NSArray *)colorsIn paddingX:(int)paddingX paddingY:(int)paddingY {
     CGContextRef context = UIGraphicsGetCurrentContext();

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };

    NSArray *colors = @[(__bridge id) ((UIColor *) colorsIn[0]).CGColor, (__bridge id) ((UIColor *) colorsIn[1]).CGColor];

    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);

    CGRect rect = comp.bounds;
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));

    CGContextSaveGState(context);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);

    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);

}

+ (BOOL)isInUIHierarchy:(UIView *)child parent:(UIView *)parent {
    UIView* childParent=child.superview;
	while(childParent)
	{
		if([childParent isEqual: parent])
			return YES;
		childParent=childParent.superview;
	}
	return NO;
}
@end

