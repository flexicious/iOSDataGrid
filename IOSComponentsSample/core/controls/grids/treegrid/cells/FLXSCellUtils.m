#import "FLXSCellUtils.h"
#import "FLXSIFlexDataGridCell.h"
#import "FLXSFlexDataGridColumn.h"
#import "FLXSFlexDataGridColumnLevel.h"
#import "FLXSExtendedUIUtils.h"
#import "FLXSRowInfo.h"
#import "FLXSFlexDataGridCheckBoxColumn.h"
#import "UIView+UIViewAdditions.h"
#import "FLXSRowPositionInfo.h"
#import "FLXSFlexDataGrid.h"
#import "FLXSFlexDataGridBodyContainer.h"
#import "FLXSFlexDataGridPaddingCell.h"
#import "FLXSFlexDataGridColumnGroup.h"
#import "FLXSTriStateCheckBox.h"
#import "FLXSIFlexDataGridDataCell.h"
#import <objc/message.h>

@implementation FLXSCellUtils
+(void)drawBackground:(UIView<FLXSIFlexDataGridCell>*)cell
{



    CGContextRef context = UIGraphicsGetCurrentContext();

    FLXSFlexDataGridColumn* column=cell.columnFLXS;
	FLXSFlexDataGridColumnLevel* level=cell.level;
    BOOL result=YES;
	if(column && column.cellCustomDrawFunction!=nil)
	{
        SEL selector = NSSelectorFromString(column.cellCustomDrawFunction);
        id target = level.grid.delegate;
        NSObject * oResult  =    ((NSObject*(*)(id, SEL, UIView<FLXSIFlexDataGridCell>*))objc_msgSend)(target, selector, cell);
		if(oResult==nil)
		    return;
	}
	if(level.cellCustomBackgroundDrawFunction!=nil)
	{
        SEL selector = NSSelectorFromString(level.cellCustomBackgroundDrawFunction);
        id target = level.grid.delegate;
        NSObject * oResult  =    ((NSObject*(*)(id, SEL, UIView<FLXSIFlexDataGridCell>*))objc_msgSend)(target, selector, cell);
        if(oResult==nil)
            return;
	}
	if(result!=NO)
	{
//		float paddingX=[cell hasVerticalGridLines]?cell.verticalGridLineThickness:0;
//		float paddingY=[cell hasHorizontalGridLines]?cell.horizontalGridLineThickness:0;
		NSObject *colors = [cell getBackgroundColors];
		if([colors isKindOfClass: [NSArray class]] )
		{
			[FLXSExtendedUIUtils gradientFill:cell colors:(NSArray*)colors paddingX:0 paddingY:0];
		}
		else
		{
            CGColorRef darkColor = [(UIColor *)colors CGColor];
            CGContextSetFillColorWithColor(context, darkColor);
            CGContextFillRect(context, CGRectMake(1, 1, cell.width, cell.height));
		}
		NSObject *res=[cell getTextColors];
		if([res isKindOfClass:[UIColor class]])
		{
            if([cell.renderer respondsToSelector:NSSelectorFromString(@"textColor")]){
                [cell.renderer setValue:res forKey:@"textColor"];
            }
 		}

	}
	[self drawBorders:cell];
}

+ (id)getRolloverColor:(UIView <FLXSIFlexDataGridCell> *)cell prop:(NSString *)prop {
    //no rollover in ios
    return  nil;
}

+(id)getTextColors:(UIView<FLXSIFlexDataGridCell>*)cell
{
	FLXSRowInfo* rowInfo=cell.rowInfo;
	FLXSFlexDataGridColumnLevel* level = cell.level;
	FLXSFlexDataGridColumn* column = cell.columnFLXS;
	if(rowInfo&&rowInfo.isFillRow)return [cell getStyleValue:(@"color")];
	if(cell.currentTextColors)return cell.currentTextColors;
	NSObject *result;
	if(!cell.userInteractionEnabled)
	{
		result = [cell getStyleValue:(@"textDisabledColor")];
		if(result!=nil)return result;
	}
	//self will be evetually all removed in favor of grid.cellTextColorFunction
	if(column && column.cellTextColorFunction!=nil)
	{
		//result=[column cellTextColorFunction:cell];

        SEL selector = NSSelectorFromString(column.cellTextColorFunction);
        id target = level.grid.delegate;
        result =    ((NSObject*(*)(id, SEL, UIView<FLXSIFlexDataGridCell>*))objc_msgSend)(target, selector, cell);
        if(result!=nil)return result;

    }
	if(level.rowTextColorFunction!=nil)
	{
		//result=[level rowTextColorFunction:cell];
        SEL selector = NSSelectorFromString(level.rowTextColorFunction);
        id target = level.grid.delegate;
        result =    ((NSObject*(*)(id, SEL, UIView<FLXSIFlexDataGridCell>*))objc_msgSend)(target, selector, cell);
        if(result!=nil)return result;

	}
	//end
//	if([level.grid.bodyContainer getCurrentEditCell]&&
//       [[level.grid.bodyContainer getCurrentEditCell].rowInfo isEqual:cell.rowInfo])
//	{
//		NSObject * editColors=[cell getStyleValue:(@"editTextColor")] ;
//		if(editColors)
//		{
//			return editColors;
//		}
//	}
	BOOL odd=(rowInfo.rowPositionInfo.rowIndex%2 == 0);
if([cell getStyleValue:(@"alternatingTextColors")][odd?0:1]!=[cell getStyleValue:(@"textSelectedColor")])
	{
		if([level isItemSelected:rowInfo.data useExclusion:YES ])
		{
			return [cell getStyleValue:(@"textSelectedColor")];
		}
		else if(column&& [level isCellSelected:rowInfo.data column:column])
		{
			return [cell getStyleValue:(@"textSelectedColor")];
		}
	}
	if(column && [column getStyle:(@"columnTextColor")])
	{
		return [cell getStyleValue:(@"columnTextColor")];
	}
	return [cell getStyleValue:(@"alternatingTextColors")][odd?0:1];
    return  nil;
}

+(id)getBackgroundColorFromGrid:(UIView<FLXSIFlexDataGridCell>*)cell
{
	if(cell.level.grid.cellBackgroundColorFunction!=nil)
	{
		//return ([cell.level.grid cellBackgroundColorFunction:cell])

        SEL selector = NSSelectorFromString(cell.level.grid.cellBackgroundColorFunction);
        id target = cell.level.grid.delegate;
        id result =    ((id(*)(id, SEL, UIView<FLXSIFlexDataGridCell>*))objc_msgSend)(target, selector, cell);
        if(result!=nil)return result;
	}
	return nil;

}

+(id)getTextColorFromGrid:(UIView<FLXSIFlexDataGridCell>*)cell
{
	if(cell.level.grid.cellTextColorFunction!=nil)
	{
//		return ([cell.level.grid cellTextColorFunction:cell])
        SEL selector = NSSelectorFromString(cell.level.grid.cellTextColorFunction);
        id target = cell.level.grid.delegate;
        id result =    ((id(*)(id, SEL, UIView<FLXSIFlexDataGridCell>*))objc_msgSend)(target, selector, cell);
        if(result!=nil)return result;
	}
	return nil;
}

+(id)getBackgroundColors:(UIView<FLXSIFlexDataGridCell>*)cell
{
	FLXSRowInfo* rowInfo=cell.rowInfo;
	FLXSFlexDataGridColumnLevel* level = cell.level;
	FLXSFlexDataGridColumn* column = cell.columnFLXS;
	BOOL odd=(rowInfo.rowPositionInfo.rowIndex%2 ==0);
    if(rowInfo&&rowInfo.isFillRow)
	{
		return level.grid.enableFillerRows?[cell getStyleValue:(@"alternatingItemColors")][odd?0:1]:
                [level.grid getStyle:(@"backgroundColor")];
	}
	NSObject * result;
	if(!cell.userInteractionEnabled)
	{
		result = [cell getStyleValue:(@"selectionDisabledColor")];
		if(![result isEqual:@"nil"] && result!=nil)
			return result;
	}
	if(column && column.cellBackgroundColorFunction!=nil)
	{
		//result=[column cellBackgroundColorFunction:cell];
        SEL selector = NSSelectorFromString(column.cellBackgroundColorFunction);
        id target = cell.level.grid.delegate;
        id result =    ((id(*)(id, SEL, UIView<FLXSIFlexDataGridCell>*))objc_msgSend)(target, selector, cell);
        if(result!=nil)return result;
	}
	if(level.rowBackgroundColorFunction!=nil)
	{
		//result=[level rowBackgroundColorFunction:cell];
        SEL selector = NSSelectorFromString(level.rowBackgroundColorFunction);
        id target = cell.level.grid.delegate;
        id result =    ((id(*)(id, SEL, UIView<FLXSIFlexDataGridCell>*))objc_msgSend)(target, selector, cell);
		if(result!=nil)return result;
	}
	if(level.grid.hasErrors && [level.grid getError:rowInfo.data])
	{
		return [cell getStyleValue:(@"errorBackgroundColor")];
	}
//	if(level.grid.enableEditRowHighlight && [level.grid.bodyContainer getCurrentEditCell]&&
//		[[level.grid.bodyContainer getCurrentEditCell].rowInfo isEqual:cell.rowInfo])
//	{
//		NSArray* editColors=[cell getStyleValue:(@"editItemColors")];
//		if(editColors)
//		{
//			return editColors;
//		}
//	}
	if(cell.currentBackgroundColors)return cell.currentBackgroundColors;
	if(level.grid.hasErrors && [level.grid getError:rowInfo.data])
	{
		return [cell getStyleValue:(@"errorBackgroundColor")];
	}
	else if([level isItemSelected:rowInfo.data useExclusion:YES ] && level.grid.isRowSelectionMode)
	{
		return [cell getStyleValue:(@"selectionColorFLXS")];
	}
	else if(column&& [level isCellSelected:rowInfo.data column:column])
	{
		return [cell getStyleValue:(@"selectionColorFLXS")];
	}
	else if(column && [column isValidStyleValue:([column getStyle:(@"backgroundColor")])])
	{
		return [column getStyle:(@"backgroundColor")];
	}
	return [cell getStyleValue:(@"alternatingItemColors")][odd?0:1];
}

+(void)drawBorders:(UIView<FLXSIFlexDataGridCell>*)cell
{

    FLXSRowInfo* rowInfo=cell.rowInfo;
	FLXSFlexDataGridColumnLevel* level = cell.level;
	FLXSFlexDataGridColumn* column = cell.columnFLXS;
	float paddingY=[cell hasHorizontalGridLines]?1:0;
//	NSObject * result;
    CGContextRef context = UIGraphicsGetCurrentContext();

//	UIView* cellComp = cell;
//	NSString* errStr=cellComp?cellComp.errorString:@"";
//	if(errStr)
//	{
//		cellComp.errorString=@"";
//	}
	if(level.grid.hasErrors)
	{
		if(column )
		{
			NSDictionary* err=(NSDictionary*)[level.grid getError:rowInfo.data];
			if(err && [err valueForKey:column.dataFieldFLXS]!=nil)
			{
                CGContextSetStrokeColorWithColor(context, [((UIColor *)[level.grid getStyle:(@"errorBorderColor")])CGColor]);
                CGContextSetLineWidth(context, 1);
                CGContextStrokeRect(context, CGRectMake(2, 2, cell.width-2, cell.height-2));
                return;
			}
		}
	}

	if(column && column.cellBorderFunction!=nil)
	{
		//result=[column cellBorderFunction:cell];
        SEL selector = NSSelectorFromString(column.cellBorderFunction);
        id target = cell.level.grid.delegate;
        id result =    ((id(*)(id, SEL, UIView<FLXSIFlexDataGridCell>*))objc_msgSend)(target, selector, cell);
        if(result==nil)return;
	}
	if(level.cellBorderFunction!=nil)
	{
		//result=[level cellBorderFunction:cell];
        SEL selector = NSSelectorFromString(level.cellBorderFunction);
        id target = cell.level.grid.delegate;
        id result =    ((id(*)(id, SEL, UIView<FLXSIFlexDataGridCell>*))objc_msgSend)(target, selector, cell);
        if(result==nil)return;
	}
	if([cell hasHorizontalGridLines])
	{

        CGContextSetStrokeColorWithColor(context, [cell.horizontalGridLineColor CGColor]);
        CGContextSetLineWidth(context, cell.horizontalGridLineThickness );
        CGContextMoveToPoint(context, 0,cell.height-paddingY); //start at this point
        CGContextAddLineToPoint(context, cell.frame.size.width, cell.height-paddingY); //draw to this point
        CGContextStrokePath(context);
	}
	if(cell.drawTopBorder)
	{

        CGContextSetStrokeColorWithColor(context, [cell.horizontalGridLineColor CGColor]);
        CGContextSetLineWidth(context, cell.horizontalGridLineThickness );
        CGContextMoveToPoint(context, 0,0); //start at this point
        CGContextAddLineToPoint(context, cell.width, 0); //draw to this point
        CGContextStrokePath(context);
	}

    [cell drawRightBorder:cell.width unscaledHeight:cell.height];

}

+ (id)getStyleValue:(UIView <FLXSIFlexDataGridCell> *)cell styleProp:(NSString *)styleProp {
	NSObject * result = cell.columnFLXS ? [cell.columnFLXS getStyleValue:styleProp]:[cell.level getStyleValue:styleProp];
	return result;
}

+(void)drawRightBorder:(UIView<FLXSIFlexDataGridCell>*)cell
{

	if([cell isKindOfClass:[FLXSFlexDataGridPagerCell class]])return;
	if(cell.columnFLXS)
	{
		if(cell.columnFLXS.isLastUnLocked || cell.columnFLXS.isLastRightLocked)
		{
			return;
		}
	}
	float paddingX=[cell hasVerticalGridLines]?cell.verticalGridLineThickness:0;
	float paddingY=[cell hasHorizontalGridLines]?cell.horizontalGridLineThickness:0;
	FLXSFlexDataGridColumnGroupCell* cgc= [cell isKindOfClass:[FLXSFlexDataGridColumnGroupCell class]]?(FLXSFlexDataGridColumnGroupCell*)(cell):nil;
	FLXSFlexDataGridPaddingCell* sbp=[cell isKindOfClass:[FLXSFlexDataGridPaddingCell class]]?((FLXSFlexDataGridPaddingCell*)cell):nil;
	if(cgc && cgc.background)return;
	if([cell hasVerticalGridLines])
	{
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(context, [cell.verticalGridLineColor CGColor]);
        CGContextSetLineWidth(context, cell.verticalGridLineThickness );

 		if(sbp)
		{
			if(sbp.scrollBarPad)
			{
                CGContextMoveToPoint(context, 0,0); //start at this point
                CGContextAddLineToPoint(context, 0, cell.height-paddingY); //draw to this point
			}
		}
		else if(cgc)
		{
			FLXSFlexDataGridColumn* colBeforeMe;
			BOOL drawLeftBorder=YES;
			FLXSFlexDataGridColumn* startCol=cgc.columnGroup?cgc.columnGroup.startColumn:nil;
			if(startCol && startCol.colIndex>0)
			{
				colBeforeMe = [startCol.level getVisibleColumns :nil][startCol.colIndex-1];
				if(colBeforeMe&&colBeforeMe.columnGroup&&colBeforeMe.columnGroup.endColumn==colBeforeMe)
				{
					drawLeftBorder=NO;
				}
			}
			if(drawLeftBorder)
			{
                CGContextMoveToPoint(context, 0,0); //start at this point
                CGContextAddLineToPoint(context, 0, cell.height-paddingY); //draw to this point
			}
			if(cgc.columnGroup.endColumn.isLastUnLocked || cgc.columnGroup.endColumn.isLastRightLocked)
			{
				return;
			}
		}
        CGContextMoveToPoint(context, cell.width-paddingX,0); //start at this point
        CGContextAddLineToPoint(context, cell.width-paddingX, cell.height-paddingY); //draw to this point
        CGContextStrokePath(context);
	}
}

+(void)refreshCell:(UIView<FLXSIFlexDataGridCell>*)cell
{
	cell.backgroundDirty=YES;
	FLXSRowInfo* rowInfo=cell.rowInfo;
	if(rowInfo.isFillRow)return;
	FLXSFlexDataGridColumnLevel* level = cell.level;
	FLXSFlexDataGridColumn* column = cell.columnFLXS;
	BOOL enabled=YES;
	if(column )
	{
		cell.text = [column itemToLabel:rowInfo.data :cell];
		if(![FLXSUIUtils nullOrEmpty:column.cellDisabledFunction]){
            SEL selector = NSSelectorFromString(column.cellDisabledFunction);
            id target = level.grid.delegate;
            NSNumber * oResult  =    ((NSNumber*(*)(id, SEL, UIView<FLXSIFlexDataGridCell>*))objc_msgSend)(target, selector, cell);
            enabled= ![oResult boolValue];
        }
	}
	if(![FLXSUIUtils nullOrEmpty:level.rowDisabledFunction])
	{
        SEL selector = NSSelectorFromString(level.rowDisabledFunction);
        id target = level.grid.delegate;
        //NSNumber * oResult  =    objc_msgSend(target, selector, cell,rowInfo.data);
        NSNumber* (*response)(id,SEL,UIView<FLXSIFlexDataGridCell>*, NSObject *) = (NSNumber* (*)(id,SEL,UIView<FLXSIFlexDataGridCell>*, NSObject *) ) objc_msgSend;
        NSNumber * returnValue = response(target,selector, cell, rowInfo.data);
        enabled= ![returnValue boolValue];
	}
	NSObject* renderer=cell.renderer;
	if(!([column isKindOfClass:[FLXSFlexDataGridCheckBoxColumn class]]) && [renderer respondsToSelector:NSSelectorFromString(@"data")])
        [renderer setValue:rowInfo.data forKey:@"data"];

    if([renderer respondsToSelector:NSSelectorFromString(@"enabled")]){
        [renderer setValue:[NSNumber numberWithBool:enabled] forKey:@"enabled"];
    }
    if(cell.userInteractionEnabled!=enabled){
        cell.userInteractionEnabled=enabled;
    }
}

+ (void)setRendererSize:(UIView *)cellRenderer width:(float)w height:(float)h {
	UIView<FLXSIFlexDataGridCell>* cell= [cellRenderer.superview conformsToProtocol:@protocol(FLXSIFlexDataGridDataCell)]?(UIView<FLXSIFlexDataGridCell>*)cellRenderer.superview:nil;
	float borderW=cell&&[cell hasVerticalGridLines]?cell.verticalGridLineThickness:0;
    float borderH=cell&&[cell hasHorizontalGridLines]?cell.horizontalGridLineThickness:0;
    [cellRenderer setActualSizeWithWidth:w - borderW andHeight:h - borderH];

}

+ (NSString *)capitalizeFirstLetterIfPrefix:(NSString *)prefix val:(NSString *)val {
    return (prefix&&prefix.length)>0? [self doCap:val] :val;
}

+(NSString*)doCap:(NSString*)val
{
    return [[[val substringWithRange:NSMakeRange(0, 1)] uppercaseString] stringByAppendingString:[val substringWithRange:NSMakeRange(1, val.length-1)]];
}

+ (void)initializeCheckBoxRenderer:(UIView <FLXSIFlexDataGridCell> *)cell level:(FLXSFlexDataGridColumnLevel *)level {

	FLXSTriStateCheckBox* renderer= (FLXSTriStateCheckBox*)cell.renderer;
	FLXSFlexDataGridCheckBoxColumn* col = (FLXSFlexDataGridCheckBoxColumn* )cell.columnFLXS;
	if(!renderer || !col)return;
	renderer.enableDelayChange=NO;
	//we dont want the delay timer
	renderer.radioButtonMode=col.radioButtonMode||level.enableSingleSelect;
	if(level.grid.enableSelectionExclusion)
	{
		renderer.selectedState= [level getCheckBoxStateBasedOnExclusion:cell.rowInfo.data useBubble:YES checkDisabled:YES ];
	}
	else
	{
		if(level.grid.enableTriStateCheckbox )
		{
			if([level isItemSelected:cell.rowInfo.data useExclusion:YES ])
			{
				renderer.selectedState=[FLXSTriStateCheckBox STATE_CHECKED];
			}
			else if(level.nextLevel&& [level.nextLevel areAnySelected:([level getChildren:cell.rowInfo.data filter:NO page:NO sort:NO ]) recursive:YES ])
			{
				if(level.nextLevel&&level.nextLevel.enableSingleSelect)
					renderer.selectedState=[FLXSTriStateCheckBox STATE_CHECKED];
				else
                    renderer.selectedState=[FLXSTriStateCheckBox STATE_MIDDLE];
			}
			else
			{
				renderer.selectedState=[FLXSTriStateCheckBox STATE_UNCHECKED];
			}
		}
		else
            renderer.checked = [level isItemSelected:cell.rowInfo.data useExclusion:YES ];
	}
	if(col.enableLabelAndCheckBox)
	{
		if([cell conformsToProtocol:@protocol(FLXSIFlexDataGridDataCell)])
		{
			renderer.title=[col itemToLabel:cell.rowInfo.data :cell];
		}
	}
}

@end

