//#import "FLXSExtendedPrintController.h"
//#import "FLXSPrintOptions.h"
//
////static FLXSExtendedPrintController* _instance = [[FLXSExtendedPrintController alloc] init];
//
//@implementation FLXSExtendedPrintController
//
//@synthesize pageInfos;
//
//+(FLXSExtendedPrintController*)instance
//{
//	//return _instance;
//    return nil;
//}
//
//-(id)init
//{//next version   v1.2
////	self = [super init];
////	if (self)
////	{
////		_pageInfos = [[NSMutableArray alloc] init];
////
////	}
////	return self;
//    return nil;
//}
//
//
//- (void)print:(UIView <FLXSIPrintable> *)printable printOptions:(FLXSPrintOptions *)printOptions {
//    //next version v1.2
////	totalDirty=YES;
////	if(printOptions.printComponentRenderer==nil)
////		printOptions.printComponentRenderer = [[FLXSClassFactory alloc] init:PrintFLXSFlexDataGrid];
////	[super print:printable :printOptions];
//}
//
//- (void)printWithOptions:(UIView <FLXSIPrintable> *)printable printOptions:(FLXSPrintOptions *)printOptions {
// //	serverDataRetrieved=NO;
////	[printOptions.printedPages removeAllObjects];
////	if (printOptions.preview)
////		[self previewWithOptions:printable :printOptions];
////	else
////	{
////		[super printWithOptions:printable :printOptions];
////	}
//}
//
//-(void)onPrintComplete
//{
// //	BOOL preview=printOptions.preview;
////	[super onPrintComplete];
////	if(printOptions.printToPdf && !preview)
////	{
////		PrintPreviewEvent* pvEvent = [[PrintPreviewEvent alloc] initWithType:[PrintPreviewEvent PDF_BYTES_READY]];
////		pvEvent.printOptions=printOptions;
////		[printOptions.printable dispatchEvent:pvEvent];
////	}
//}
//
//- (FLXSPrintWindow *)createPrintWindow:(UIView <FLXSIPrintable> *)printable printOptions:(FLXSPrintOptions *)printOptions {
// //	PrintWindow* pw=[super createPrintWindow:printable :printOptions]
////var grid:FLXSIExtendedDataGrid=printable as FLXSIExtendedDataGrid;
////	FLXSIExtendedDataGrid* from= grid;
////	NSObject* to=pw.printDataGrid;
////	for(NSString* [levelProp in ObjectUtil getClassInfo:grid :([@"preferences"]) :({@"includeReadOnly":NO})].properties) //we're cloning columns here so as to not upset the orignial grid
////	{
////		if([levelProp isEqual:@"width"] || [levelProp isEqual:@"height"] ||[levelProp isEqual:@"parent"] ||[levelProp isEqual:@"owner" ] ||[levelProp isEqual:@"preferences"]
////			||[levelProp isEqual:@"columnLevel"]||[levelProp isEqual:@"columns"]  ||[levelProp isEqual:@"groupedColumns"] || [levelProp isEqual:@"columnGroups"]|| [levelProp isEqual:@"styleName"]
////			|| ([levelProp indexOf:(@"checked")]==0)
////			|| ([levelProp indexOf:(@"ScrollPosition")]>0)
////			|| [levelProp isEqual:@"pageIndex"])continue;
////		if([FLXSUIUtils isPrimitive:(from[levelProp])] || (from[levelProp] is IFactory)|| (from[levelProp] is Function))
////		{
////			if([to hasOwnProperty:levelProp]&& (to[levelProp]!=from[levelProp]))
////			{
////				to[levelProp]=from[levelProp];
////			}
////		}
////	}
////	to.percentWidth=100;
////	to.percentHeight=100;
////	to.allowInteractivity=NO;
////	to.horizontalScrollPolicy=[ScrollPolicy OFF];
////	return pw;
//    return nil;
//}
//
//- (void)setupPrintWindow:(UIView <FLXSIPrintable> *)printable printOptions:(FLXSPrintOptions *)printOptions printWindow:(FLXSPrintWindow *)printWindow {
// //	if(totalDirty)
////	{
////		FLXSIExtendedDataGrid* grid=printable as FLXSIExtendedDataGrid;
////		PrintFLXSFlexDataGrid* nestedPrintDatagrid=printWindow.printDataGrid as PrintFLXSFlexDataGrid;
////		nestedPrintDatagrid.printWindow=printWindow;
////		FLXSFlexDataGrid* treeDataGrid = grid as FLXSFlexDataGrid;
////		nestedPrintDatagrid.columnLevel=[treeDataGrid.columnLevel clone];
////		[nestedPrintDatagrid.columnLevel initializeLevel:nestedPrintDatagrid];
////		nestedPrintDatagrid.itemFilters=treeDataGrid.itemFilters;
////		nestedPrintDatagrid.enablePaging=NO;
////		nestedPrintDatagrid.forcePagerRow=NO;
////		nestedPrintDatagrid.filterVisible=NO;
////		if(printOptions.columnsToPrint.length > 0)
////		{
////			//self means user only wants to print select columns
////			[nestedPrintDatagrid showColumns:printOptions.columnsToPrint];
////		}
////		else
////		{
////			[nestedPrintDatagrid showPrintableColumns];
////		}
////		FLXSFlexDataGridPrintEvent* pe = [[FLXSFlexDataGridPrintEvent alloc] initWithType:[FLXSFlexDataGridPrintEvent BEFORE_PRINT_PROVIDER_SET] :grid as FLXSFlexDataGrid :nestedPrintDatagrid];
////		[grid dispatchEvent:pe];
////		nestedPrintDatagrid.dataProviderFLXS=[treeDataGrid getDataForPrintExport:printOptions];
////		nestedPrintDatagrid.openItems = treeDataGrid.openItems;
////		[nestedPrintDatagrid validateNow];
////		[self calculateTotalPages:([grid getDataProvider]) :NO];
////		//run the print.
////		grid.lastPrintOptionsString = [printOptions toPersistenceString:grid];
////		int index=0;
////		for(FLXSFlexDataGridColumn* [col in nestedPrintDatagrid.columnLevel getVisibleColumns])
////		{
////			col.width = printOptions.columnWidths.length>index?
////printOptions.columnWidths[index++]:col.width ;
////			if(col.columnWidthMode==[FLXSFlexDataGridColumn COLUMN_WIDTH_MODE_PERCENT])
////				col.columnWidthMode=[FLXSFlexDataGridColumn COLUMN_WIDTH_MODE_NONE]
////		}
////		pe = [[FLXSFlexDataGridPrintEvent alloc] initWithType:[FLXSFlexDataGridPrintEvent BEFORE_PRINT] :grid as FLXSFlexDataGrid :nestedPrintDatagrid];
////		[grid dispatchEvent:pe];
////		if(printOptions.stylesToTransfer && printOptions.stylesToTransfer.length>0)
////		{
////			for(NSString* styleToTransfer in printOptions.stylesToTransfer)
////			{
////				Array* colsFrom=pe.grid.printableColumns;
////				Array* colsTo=pe.printGrid.printableColumns;
////				/*colsTo[1[] setStyle:(@"textAlign") :(colsFrom[1[] getStyle:(@"textAlign")])]
////						colsTo[2[] setStyle:(@"textAlign") :(colsFrom[2[] getStyle:(@"textAlign")])]*/
////for (int colIndex=0; colIndex<colsFrom.length;colIndex++)
////				{
////					if(colsTo.length>colIndex && colsFrom.length>colIndex)
////					{
////						colsTo[colIndex[] setStyle:styleToTransfer :(colsFrom[colIndex[] getStyle:styleToTransfer])]
////					}
////				}
////			}
////		}
////	}
//}
//
//-(float)getBodyContainerHeight:(NSString*)page
//{
// //	PrintWindow* printWindow = _printWindow;
////	PrintFLXSFlexDataGrid* nestedPrintDatagrid=printWindow.printDataGrid as PrintFLXSFlexDataGrid;
////	float chromeHeight=nestedPrintDatagrid.headerHeight+nestedPrintDatagrid.footerRowHeight;
////	PrintOptions* printOptions=_printOptions;
////	float surroundingHeights= [self parseFloat:([printWindow getStyle:(@"paddingTop")])]+
////[self parseFloat:([printWindow getStyle:(@"paddingBottomFLXS")])]+
////((printOptions.includePrintHeader && ([page isEqual:@"first"]||[page isEqual:@"single"]))?printWindow.printerHeader.height:0)+
////((printOptions.includePrintFooter && ([page isEqual:@"last"]||[page isEqual:@"single"]))?printWindow.printerFooter.height:0)+
////(printOptions.includePageHeader?printWindow.pageHeader.height:0)+
////(printOptions.includePageFooter?printWindow.pageFooter.height:0)+
////(chromeHeight);
////	return printWindow.height-surroundingHeights;
//    return 0;
//}
//
//- (void)calculateTotalPages:(NSObject *)iCollectionView hasColumnGroups:(BOOL)hasGrouped {
// //	totalDirty=NO;
////	PrintWindow* printWindow = _printWindow;
////	[printWindow showSinglePage:YES];
////	PrintFLXSFlexDataGrid* nestedPrintDatagrid=printWindow.printDataGrid as PrintFLXSFlexDataGrid;
////	float chromeHeight=nestedPrintDatagrid.headerHeight+nestedPrintDatagrid.footerRowHeight;
////	float firstPageGridHt=[self getBodyContainerHeight:(@"single")];
////	float contentHeight=[nestedPrintDatagrid.bodyContainer calculateTotalHeight];
////	_pageInfos= [[NSMutableArray alloc] init]
////	Array* itemPositions= [nestedPrintDatagrid.bodyContainer getItemVerticalPositions]
////
////if(firstPageGridHt>contentHeight)
////	{
////		//self means there is just one page.
////		printWindow.totalPages=1;
////		if(itemPositions.length>0)
////			_pageInfos=[[itemPositions[0],itemPositions[itemPositions.length-1],firstPageGridHt]]
////	}
////	else
////	{
////		firstPageGridHt=[self getBodyContainerHeight:(@"first")];
////		float middlePageGridHt=[self getBodyContainerHeight:(@"middle")];
////		float lastPageGridHt=[self getBodyContainerHeight:(@"last")];
////		float currentGridHt=firstPageGridHt;
////		float covered=0;
////		[itemPositions sortOn:(@"verticalPosition") :[Array NUMERIC]];
////		Array* currentPageInfo= [[NSMutableArray alloc] init]
////		FLXSRowPositionInfo* lastPost;
////		FLXSRowPositionInfo* pageStart;
////		for(FLXSRowPositionInfo* pos in itemPositions)
////		{
////			if(currentPageInfo.length==0)
////			{
////				[currentPageInfo addObject:pos];
////				pageStart=pos;
////			}
////			if((pos.verticalPositionPlusHeight-pageStart.verticalPosition)>currentGridHt)
////			{
////				covered=pos.verticalPositionPlusHeight;
////				pageStart=pos;
////				[currentPageInfo addObject:lastPost];
////				[currentPageInfo addObject:covered];
////				currentGridHt=middlePageGridHt;
////				[_pageInfos addObject:currentPageInfo];
////				currentPageInfo=[pos];
////			}
////			lastPost=pos;
////		}
////		if(currentPageInfo.length==1)
////		{
////			covered+=currentGridHt;
////			[currentPageInfo addObject:(itemPositions[itemPositions.length-1])]
////[currentPageInfo addObject:covered];
////			[_pageInfos addObject:currentPageInfo];
////		}
////		if((_pageInfos[[_pageInfos length]-1][1].verticalPositionPlusHeight-_pageInfos[[_pageInfos length]-1][0].verticalPosition)>lastPageGridHt)
////		{
////			printWindow.totalPages=[_pageInfos length]+1;
////		}
////		else
////printWindow.totalPages=[_pageInfos length];
////		nestedPrintDatagrid.totalPagesHeight=covered;
////	}
//}
//
//- (void)generatePreview:(UIView <FLXSIPrintPreview> *)printPreview printWindow:(FLXSPrintWindow *)printWindow {
// //    [super generatePreview:printPreview :printWindow];
////	if(printWindow.printOptions.printToPdf)
////	{
////		printPreview[@"BTN_PRT_1"].label=@"Generate PDF";
////	}
////	[[_printOptions availableColumns] removeAllObjects];
////	int colIndex=0;
////	for(NSObject* [col in _extendedDataGrid getPrintableColumns:printOptions])
////	{
////		NSString* colName=col.headerText ? col.headerText : col.dataFieldFLXS ? col.dataFieldFLXS : ('Column ' + (colIndex + 1));
////		NSString* colLabel = [Exporter getColumnHeader:col :colIndex];
////		[[_printOptions availableColumns] addObject:({'displayName':colLabel) :('name':colName})];
////		colIndex++;
////	}
////	printPreview[@"cbxColumns"].labelField=@"displayName";
////	printPreview[@"cbxColumns"].dataProviderFLXS= [_printOptions availableColumns];
////	printPreview[@"cbxColumns"[] validateNow];
////	NSMutableArray* cols=[FLXSUIUtils extractPropertyValues:[_printOptions columnsToPrint] :'name'];
////	if(cols.length>0)
////		printPreview[@"cbxColumns"].selectedValues=cols;
////	printPreview[@"cbxColumns"].dataFieldFLXS=@"headerText";
////	printPreview[@"cbxColumns"].dataProviderFLXS= [_extendedDataGrid getPrintableColumns:printOptions];
////	printPreview[@"cbxColumns"[] validateNow];
////	if(printWindow.printOptions.columnsToPrint.source.length>0)
////					printPreview[@"cbxColumns"].selectedItems = printWindow.printOptions.columnsToPrint.source;
//}
//
//-(void)gotoCurrentPage
//{
// //    PrintWindow* printWindow = _printWindow;
////	PrintFLXSFlexDataGrid* nestedPrintDatagrid=printWindow.printDataGrid as PrintFLXSFlexDataGrid;
////	[nestedPrintDatagrid showPositions:(_pageInfos[printWindow.currentPage-1])];
//}
//
//-(FLXSFlexDataGrid*)grid
//{
// //	return self._extendedDataGrid;
//return nil;
//}
//
//-(FLXSPrintOptions*)printOptions
//{
// 	//return _printOptions;
//    return nil;
//}
//
//+ (FLXSExtendedPrintController*)_instance
//{
//	//return _instance;
//    return nil;
//}
//@end
//
