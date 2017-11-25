//#import "FLXSPrintController.h"
//#import "FLXSFlexDataGrid.h"
//#import "FLXSPrintOptions.h"
//
////static FLXSPrintController* _instance = [[FLXSPrintController alloc] init];
//@implementation FLXSPrintController
//
////@synthesize _extendedDataGrid;
////@synthesize _printWindow;
////@synthesize _printOptions;
////@synthesize totalDirty;
////@synthesize printJob;
////@synthesize serverDataRetrieved;
////@synthesize worker;
////@synthesize _pageShown;
//
//+(FLXSPrintController*)instance
//{
//	//return _instance;
//    return  nil;
//}
//
//-(id)init
//{
////	self = [super init];
////	if (self)
////	{
////		totalDirty = YES;
////		serverDataRetrieved = NO;
////		_pageShown = NO;
////
////	}
////	return self;
//    return  nil;
//}
//
//
//
//-(FLXSPrintOptions*)printOptions
//{
//	return _printOptions;
//}
//
//- (void)print:(UIView <FLXSIPrintable> *)printable printOptions:(FLXSPrintOptions *)printOptions {
////	if(printOptions.asynch && ! printOptions.preview)
////	{
////		printOptions.preview=YES;
////	}
////	[printOptions.availableColumns removeAllObjects];
////	[printOptions.columnsToPrint removeAllObjects];
////	[printOptions.columnWidths removeAllObjects];
////	FLXSIExtendedDataGrid* grid=printable as FLXSIExtendedDataGrid;
////	//If no print options, create default.
////	if (printOptions == nil)
////		printOptions=[[PrintOptions alloc] init];
////	printOptions.extendedDataGrid=grid;
////	if([grid.preferencesToPersist indexOf:[FLXSConstants PERSIST_PRINT_SETTINGS]])
////	{
////		NSString* preferences=grid.lastPrintOptionsString?grid.lastPrintOptionsString:grid.persistedPrintOptionsString;
////		if(preferences)
////			[printOptions loadFromPersistedString:grid :preferences];
////	}
////	int colIndex=0;
////	if(printOptions.hideHiddenColumns)
////	{
////		[printOptions.columnsToPrint removeAllObjects];
////	}
////	colIndex=0;
////	for(NSObject* [col in grid getPrintableColumns:printOptions])
////	{
////		NSString* colName=col.uniqueIdentifier;
////		NSString* colLabel=[Exporter getColumnHeader:col :(colIndex++)];
////		[printOptions.availableColumns addObject:({'name':colName) :('label':colLabel})];
////		if(printOptions.hideHiddenColumns)
////		{
////			if(col.visible)
////			{
////				[printOptions.columnsToPrint addObject:({'name':colName) :('label':colLabel})];
////			}
////		}
////		colIndex++;
////	}
////	_extendedDataGrid=grid;
////	_printOptions=printOptions;
////	_printOptions.printExportParameters=[_extendedDataGrid printExportParameters];
////	NSObject* printView=[printOptions.printOptionsViewrenderer generateInstance];
////	//self is the options popup
////	printView.grid=_extendedDataGrid;
////	printView.printOptions=printOptions;
////	[printView addEventListener:[FLXSEvent CLOSE] :onPrintOptionsClose :NO :0 :YES];
////	if([_printOptions showColumnPicker])
////	{
////		//if user clicks ok, print/preview
////		NSObject* popupParent=printOptions.popupParent;
////		if(!popupParent)popupParent=[FLXSUIUtils getTopLevelApplication];
////		[FLXSUIUtils addPopUp:printView as IFlexDisplayObject :popupParent as DisplayObject :printOptions.modalWindows :nil :nil :(printable.useModuleFactory?printable.moduleFactory:nil)];
////	}
////	else
////	{
////		NSObject* evt =
////		{
////			target:printView,detail:[Alert OK]
////		}
////		;
////		[self onPrintOptionsClose:evt];
////	}
//}
//
//-(void)onPrintOptionsClose:(NSObject*)event
//{
////	[(event.target as FLXSIEventDispatcher) removeEventListener:[FLXSEvent CLOSE] :onPrintOptionsClose];
////	if (event.detail == [Alert OK])
////	{
////		if([[_extendedDataGrid filterPageSortMode] isEqual:@"server"] &&
////			(printOptions.printExportOption==[FLXSPrintExportOptions PRINT_EXPORT_ALL_PAGES] ||
////			printOptions.printExportOption==[FLXSPrintExportOptions PRINT_EXPORT_SELECTED_PAGES]) &&
////			!serverDataRetrieved)
////		{
////			//here, we're in server mode, user has asked us to print data that we dont have.
////			//so go back to server, get the data, and then continue.
////			PrintExportFilter* printExportFilter=[[PrintExportFilter alloc] init];
////			[printExportFilter copyFrom:([_extendedDataGrid createFilter])];
////			printExportFilter.printExportOptions=printOptions;
////			[_extendedDataGrid addEventListener:[PrintExportDataRequestEvent PRINT_EXPORT_DATA_RECD] :onPrintRequestDataRecieved :NO :0 :YES];
////			PrintExportDataRequestEvent* printExportDataRequestEvent=[[PrintExportDataRequestEvent alloc] initWithType:[PrintExportDataRequestEvent PRINT_EXPORT_DATA_REQUEST] :printExportFilter];
////			[_extendedDataGrid dispatchEvent:printExportDataRequestEvent];
////			return;
////		}
////		else//we have all the data...
////[self printWithOptions:_extendedDataGrid :event.target.printOptions];
////	}
//}
//
//-(BOOL)checkColumn:(NSObject*)col :(FLXSPrintOptions*)printOptions
//{
////	if (!printOptions.columnsToPrint || printOptions.columnsToPrint.length == 0)
////	{
////		return YES;
////	}
////	else
////	{
////		for(NSObject* colName in printOptions.columnsToPrint)
////		{
////			if ((colName.name == col.dataFieldFLXS) || (colName.name == col.headerText))
////			{
////				return YES;
////			}
////		}
////	}
//	return NO;
//}
//
//- (void)setupPrintWindow:(UIView <FLXSIPrintable> *)printable printOptions:(FLXSPrintOptions *)printOptions printWindow:(FLXSPrintWindow *)printWindow {
////	FLXSIExtendedDataGrid* grid=printable as FLXSIExtendedDataGrid;
////	Array* cols= [[NSMutableArray alloc] init]
////	BOOL hasColumnGroups=NO;
////	Array* existingCols = grid[@"hasOwnProperty"](@"groupedColumns")&&grid[@"groupedColumns"]&&grid[@"groupedColumns"].length>0?grid[@"groupedColumns"]:[grid getPrintableColumns:printOptions];
////	for(NSObject* col in existingCols)
////	{
////		if([col hasOwnProperty:(@"children")])
////		{
////			hasColumnGroups=YES;
////			break;
////		}
////	}
////	if([printWindow.printDataGrid getColumns].length==0)
////	{
////		for(col in existingCols)
////		{
////			if((col.visible || !printOptions.hideHiddenColumns)
////				&& (![col hasOwnProperty:(@"excludeFromPrint")] || !col.excludeFromPrint)
////				&& (![col hasOwnProperty:(@"uniqueIdentifier")] ||  printOptions.columnsToPrint.length==0
////				|| [FLXSUIUtils doesArrayContainObjectValue:printOptions.columnsToPrint :(@"name") :col.uniqueIdentifier])
////				)
////				[self cloneColumn:cols :col];
////		}
////		if(hasColumnGroups)
////		{
////			printWindow.printDataGrid[@"groupedColumns"]=[cols slice];
////			//columns to print
////		}
////		else
////[printWindow.printDataGrid setColumns:([cols slice])];
////		//columns to print
////	}
////	[printWindow validateNow];
////	Array* propetiesToTransfer = [@"variableRowHeight",@"rowHeight",@"showHeaders"
////,@"wordWrap",@"iconFunction"];
////	if(!hasColumnGroups)
////		[propetiesToTransfer addObject:(@"headerHeight")];
////	for(NSString* propToTransfer in propetiesToTransfer)
////	{
////		if(grid[@"hasOwnProperty"](propToTransfer))
////			printWindow.printDataGrid[propToTransfer]=grid[propToTransfer];
////	}
////	if(grid is AdvancedDataGrid)
////	{
////		AdvancedDataGrid* adg = grid as AdvancedDataGrid;
////		PrintAdvancedDataGrid* printAdg = printWindow.printDataGrid as PrintAdvancedDataGrid;
////		if(printAdg!=nil && (printAdg.rendererProviders.length!= adg.rendererProviders.length))
////		{
////			for(AdvancedDataGridRendererProvider* rendererProdivder in adg.rendererProviders)
////			{
////				[printAdg.rendererProviders addObject:rendererProdivder];
////			}
////		}
////	}
////	int index=0;
////	NSString* policy = printWindow.printDataGrid.horizontalScrollPolicy;
////	printWindow.printDataGrid.horizontalScrollPolicy=@"on";
////	for(col in cols)
////	{
////		col.width = printOptions.columnWidths.length>index?
////    printOptions.columnWidths[index++]:col.width ;
////	}
////	for([col in printWindow.printDataGrid getColumns])
////	{
////		col.visible = printOptions.columnsToPrint.length==0|| [FLXSUIUtils doesArrayContainObjectValue:printOptions.columnsToPrint :(@"name") :col.uniqueIdentifier];
////	}
////	printWindow.printDataGrid.horizontalScrollPolicy=policy;
////	ICollectionView* iCollectionView=[grid getDataProvider] as ICollectionView;
////	if (printOptions.printExportOption == [FLXSPrintExportOptions PRINT_EXPORT_CURRENT_PAGE])
////	{
////		//if we are printing the current page, just give the print grid the source grids data provider,
////		//so it will preserve all the state
////		iCollectionView=[grid getDataProvider] as ICollectionView;
////	}
////	else if (printOptions.printExportOption == [FLXSPrintExportOptions PRINT_EXPORT_SELECTED_RECORDS])
////	{
////		//if we are printing only the checked records, we already have what we need to print
////		iCollectionView=grid.selectedObjects as ICollectionView;
////	}
////	else
////	{
////		//if we are in server mode, we dont have all the records, so ask the server for data.
////		if (grid.filterPageSortMode isEqual: @"server")
////		{
////			iCollectionView=grid.printExportData as ICollectionView;
////		}
////		else
////		{
////			CollectionManipulator* collectionManipulator=[grid createCollectionManipulator];
////			//we are in client mode, so we have all the data, we just need to filter and sort it.
////			IAdvancedExtendedDataGrid* eadg=grid as IAdvancedExtendedDataGrid;
////			if(iCollectionView is IHierarchicalCollectionView && eadg!=nil)
////			{
////				if(grid.enablePaging)
////					[collectionManipulator pageNSMutableArray:iCollectionView :(-1) :grid.pageSize :YES :([-1,-1]) :([eadg getUnderlyingSource])];
////			}
////			else
////			{
////				iCollectionView=grid.dataProviderNoPaging as ICollectionView;
////				//lets create a copy of the collection, so we dont mess up the original grid.
////				NSMutableArray* tempCollection=[[NSMutableArray alloc] init];
////				for(NSObject* obj in iCollectionView)
////					[tempCollection addObject:obj];
////				tempCollection.sort=iCollectionView.sort;
////				iCollectionView=tempCollection;
////			}
////			//apply the grids paging and filtering.
////			if (grid.enableFilters )
////			{
////				NSMutableArray* filterArgs=[grid getFilterArguments];
////				[collectionManipulator filterNSMutableArray:iCollectionView :filterArgs];
////			}
////			if (printOptions.printExportOption == [FLXSPrintExportOptions PRINT_EXPORT_SELECTED_PAGES] && grid.enablePaging)
////			{
////				//if user specified to print only X pages of grid data
////				[collectionManipulator pageNSMutableArray:iCollectionView :(-1) :grid.pageSize :YES :([printOptions.pageFrom, printOptions.pageTo]) :(eadg&&[eadg getDataProvider] is IHierarchicalCollectionView?
////[eadg getUnderlyingSource]:nil)];
////			}
////		}
////	}
////	[self calculateTotalPages:iCollectionView :hasColumnGroups];
////	//run the print.
////	grid.lastPrintOptionsString = [printOptions toPersistenceString:grid];
////	PrintPreviewEvent* pe = [[PrintPreviewEvent alloc] initWithType:[PrintPreviewEvent BEFORE_PRINT]];
////	pe.printOptions=printOptions;
////	[grid dispatchEvent:pe];
//}
//
//-(void)cloneColumn:(NSArray*)cols :(NSObject*)col
//{
////	//we're cloning the column here, because we need to give it to the PrintDataGrid
////	//to layout itself. If we just used the DataGrid columns they would become resize
////	//with the print grid.
////	var newCol:*;
////	if(col is IFactory)
////	{
////		//scenario when the concrete class is a derivative of EDGC or EADGC and potentially in a different swc.
////		newCol = [(col as IFactory) generateInstance];
////	}
////	else
////	{
////		Class* clazz=((Class*)([self getDefinitionByName:([ObjectUtil getClassInfo:col].name)]));
////		newCol=[[clazz alloc] init];
////	}
////	NSObject* colCopy;
////	try
////	{
////		colCopy = [ObjectUtil copy:col]
////	}
////	[self catch:(e:Error)]
////	{
////		colCopy = col;
////	}
////	for(NSString* colProp in colCopy) //we're cloning columns here so as to not upset the orignial grid
////	{
////		if (col[colProp] && colProp != @"width" && colProp != @"owner" && colProp != @"children"
////			 &&[newCol hasOwnProperty:colProp])
////			newCol[colProp]=col[colProp];
////		//we want to clone all properties except the width and owner
////		//do not want sort in preview
////		newCol.sortable=NO;
////	}
////	[FlexVersionSpecific transferColumnStyles:col :newCol];
////	[cols addObject:newCol];
////	if([col hasOwnProperty:(@"children")])
////	{
////		for(NSObject* child in col.children)
////		{
////			[self cloneColumn:newCol.children :child];
////		}
////	}
//}
//
//- (void)calculateTotalPages:(NSObject *)iCollectionView hasColumnGroups:(BOOL)hasColumnGroups {
////	if(!totalDirty)return;
////	totalDirty=NO;
////	//iterate through the PRINT pages. Not to be confused with
////	//the DataGrid pages. If you setup the grid to show 50 records
////	//per page, that means a grid of 100 records will have 2 pages
////	//but if you request a print, and one page depending on page
////	//size/orientation can only print 25 records, then there will be
////	//4 print pages.
////	PrintWindow* printWindow = _printWindow;
////	[printWindow.printDataGrid setDataProvider:iCollectionView];
////	int totalPages=1;
////	int firstPageRowCount=0;
////	int middlePageRowCount=0;
////	[printWindow.rowsOnPage removeAllObjects];
////	if(iCollectionView is IHierarchicalCollectionView || printWindow.printDataGrid.variableRowHeight || hasColumnGroups)
////	{
////		//in case of hierarchical views, we have no option
////		//but to print the images in memory to figure out how many
////		//pages of print data we have....
////		[printWindow showSinglePage];
////		if (!printWindow.printDataGrid.validNextPage)
////		{
////			//everything was able to fit in 1 page.
////			totalPages=1;
////			firstPageRowCount=printWindow.printDataGrid.rowCount;
////			[printWindow.rowsOnPage addObject:printWindow.printDataGrid.rowCount];
////		}
////		else
////		{
////			[printWindow showFirstPage];
////			[printWindow.rowsOnPage addObject:printWindow.printDataGrid.rowCount];
////			while(printWindow.printDataGrid.validNextPage)
////			{
////				if(totalPages==1)
////				{
////					firstPageRowCount=printWindow.printDataGrid.rowCount;
////				}
////				else
////				{
////					middlePageRowCount=printWindow.printDataGrid.rowCount;
////				}
////				if (!printWindow.printDataGrid.validNextPage)
////					[printWindow showLastPage];
////				else
////[printWindow showMiddlePage];
////				[printWindow.printDataGrid nextPage];
////				[printWindow.rowsOnPage addObject:printWindow.printDataGrid.rowCount];
////				totalPages++;
////			}
////		}
////	}
////	else
////	{
////		//for regular non hierarchical views, we make some estimations
////		//to optimize the total Pages.
////		[printWindow showSinglePage];
////		if (!printWindow.printDataGrid.validNextPage)
////		{
////			//everything was able to fit in 1 page.
////			totalPages=1;
////			firstPageRowCount=printWindow.printDataGrid.rowCount;
////		}
////		else
////		{
////			[printWindow showFirstPage];
////			firstPageRowCount=printWindow.printDataGrid.rowCount;
////			//there is atleast 2 pages...
////			[printWindow.printDataGrid nextPage];
////			[printWindow showMiddlePage];
////			middlePageRowCount=printWindow.printDataGrid.rowCount;
////			[printWindow.printDataGrid validateNow];
////			if (printWindow.printDataGrid.validNextPage)
////			{
////				//there are more than  2 pages...
////				//at self point, we know how many rows on first page, how many on middle pages....
////				//so, the total number of pages [self is:((totalRecords - recordsOnFirstPage)/recordsOnMiddlePage)]+1
////				totalPages = ((iCollectionView.length-firstPageRowCount)/middlePageRowCount)+2;
////			}
////			else
////			{
////				//there are only 2 pages..
////				totalPages=2;
////				//middle page is the last page.
////				[printWindow showLastPage];
////				if (printWindow.printDataGrid.validNextPage)
////				{
////					middlePageRowCount=printWindow.printDataGrid.rowCount;
////					totalPages=3;
////				}
////			}
////		}
////		printWindow.firstPageRowCount=firstPageRowCount;
////		printWindow.middlePageRowCount=middlePageRowCount;
////		//there is a situation that when you add the height of the report footer, we may run over
////		//into an additional page, so calculate that
////		if([self calculateSpillover:printWindow :printOptions :iCollectionView :(totalPages==1?@"first":@"last")])
////			totalPages++;
////	}
////	printWindow.totalPages=totalPages;
////	//just so we know in advance what the total number of pages is.
////	[printWindow.printDataGrid setDataProvider:iCollectionView];
////	[printWindow validateNow];
//}
//
//- (BOOL)calculateSpillover:(FLXSPrintWindow *)printWindow printOptions:(FLXSPrintOptions *)printOptions iCollectionView:(NSObject *)iCollectionView whichPage:(NSString *)whichPage {
////	/*int recordsOnpPage= [whichPage isEqual:@"first"]?printWindow.firstPageRowCount:[whichPage isEqual:@"middle"]
////									?printWindow.middlePageRowCount:(((iCollectionView.length-printWindow.firstPageRowCount)%printWindow.middlePageRowCount));
////	int availableHeight =
////				printWindow.height - (
////					(printOptions.includePrintHeader?printWindow.printerHeader.height:0)
////					+(printOptions.includePrintFooter?printWindow.printerFooter.height:0)
////					+(printOptions.includePageHeader?printWindow.pageHeader.height:0)
////					+(printOptions.includePageFooter?printWindow.pageFooter.height:0)
////					+(printWindow.printDataGrid.headerHeight)
////					+(printWindow.printDataGrid.rowHeight * recordsOnpPage)
////					+ (printOptions.windowStyleProperties[@"paddingTop"]?((float)(printOptions.windowStyleProperties[@"paddingTop"])):0)
////					+ (printOptions.windowStyleProperties[@"paddingBottomFLXS"]?((float)(printOptions.windowStyleProperties[@"paddingBottomFLXS"])):0));
////	return (availableHeight<printWindow.printerFooter.height);
////	*/
////return NO;
//    return NO;
//}
//
//- (FLXSPrintWindow *)createPrintWindow:(UIView <FLXSIPrintable> *)printable printOptions:(FLXSPrintOptions *)printOptions {
////	totalDirty=YES;
////	PrintWindow* printWindow=[self instantiatePrintWindow];
////	printWindow.printable=printable;
////	printWindow.printOptions=printOptions;
////	printOptions.printComponentRenderer=[printable createPrintComponentFactory];
////	/*if (grid is AdvancedDataGrid && !printOptions.printComponentRenderer)
////	{
////		//Print Data Grid for ExtendedAdvancedDataGrid
////				printOptions.printComponentRenderer=[[FLXSClassFactory alloc] init:ExtendedAdvancedPrintDataGrid];
////	}
////	*/
//////sets the properties of the print page
////for(NSString* key in printOptions.windowStyleProperties)
////	{
////		[printWindow setStyle:key :(printOptions.windowStyleProperties[key])];
////	}
////	//client code should not need to override self
////	if (printOptions.printComponentRenderer)
////		printWindow.printComponentRenderer=printOptions.printComponentRenderer;
////	printOptions.printComponent = printWindow.printComponent;
////	//The regular header and footer renderers.
////	printWindow.reportHeaderRenderer=printOptions.reportHeaderRenderer;
////	printWindow.reportFooterRenderer=printOptions.reportFooterRenderer;
////	printWindow.pageHeaderRenderer=printOptions.pageHeaderRenderer;
////	printWindow.pageFooterRenderer=printOptions.pageFooterRenderer;
////	_printWindow=printWindow;
////	return printWindow;
//    return  nil;
//}
//
//-(FLXSPrintWindow*)instantiatePrintWindow
//{
//	//return [[PrintWindow alloc] init];
//    return  nil;
//}
//
//-(void)onPrintRequestDataRecieved:(FLXSEvent*)event
//{
////	//now we have the data we need, set the flag that we dont need
////	//to get data, remove the listener, and continue
////	[_extendedDataGrid removeEventListener:[PrintExportDataRequestEvent PRINT_EXPORT_DATA_RECD] :onPrintRequestDataRecieved];
////	serverDataRetrieved=YES;
//}
//
//- (void)printWithOptions:(UIView <FLXSIPrintable> *)printable printOptions:(FLXSPrintOptions *)printOptions {
////	serverDataRetrieved=NO;
////	_printOptions=printOptions;
////	[printOptions.printedPages removeAllObjects];
////	if (printOptions.preview && !printOptions.printToPdf)
////	{
////		[self previewWithOptions:printable :printOptions];
////		return ;
////	}
////	if (!printJob &&!printOptions.printToPdf)
////	{
////		printJob=[[FlexPrintJob alloc] init];
////		printJob.printAsBitmap = printOptions.printAsBitmap;
////	}
////	if (printOptions.printToPdf || [printJob start] )
////	{
////		if(!printOptions.printToPdf)
////		{
////			PrintPreviewEvent* pvEvent = [[PrintPreviewEvent alloc] initWithType:[PrintPreviewEvent PRINT_JOB_CREATED]];
////			pvEvent.printOptions=printOptions;
////			pvEvent.printJob = printJob;
////			[printOptions.printable dispatchEvent:pvEvent];
////		}
////		if(printOptions.printToPdf && printOptions.printable.pdfPrinter)
////		{
////			[printOptions.printable.pdfPrinter beginDocument:printOptions];
////		}
////		if(printOptions.asynch && printOptions.previewWindow)
////		{
////			[printOptions.previewWindow.content removeAllChildren];
////			printOptions.printContainer=printOptions.previewWindow.content;
////		}
////		PrintWindow* printWindow=[self createPrintWindow:printable :printOptions];
////		[FLXSUIUtils addChild:(printOptions.printContainer!=nil?printOptions.printContainer
////:printable.parentDocument) :printWindow];
////		printWindow.width=printJob?printJob.pageWidth:printOptions.pageSize.width;
////		printWindow.height=printJob?printJob.pageHeight:printOptions.pageSize.height;
////		[self setupPrintWindow:printable :printOptions :printWindow];
////		printWindow.currentPage=1;
////		if(printOptions.asynch && printOptions.previewWindow)
////		{
////			if (worker)
////			{
////				if(printOptions.asynchDelayCapture)
////				{
////					[worker removeEventListener:[TimerEvent TIMER] :onPrintWorkerTimerDelayedAsych];
////				}
////				else
////				{
////					[worker removeEventListener:[TimerEvent TIMER] :onPrintWorkerTimer];
////				}
////				[worker stop];
////				worker = nil;
////			}
////			worker = [[Timer alloc] init:printOptions.asynchTimeInterval];
////			if(printOptions.asynchDelayCapture)
////			{
////				[worker addEventListener:[TimerEvent TIMER] :onPrintWorkerTimerDelayedAsych];
////			}
////			else
////			{
////				[worker addEventListener:[TimerEvent TIMER] :onPrintWorkerTimer];
////			}
////			[worker start];
////		}
////		else
////		{
////			[self onPrintWorkerTimer:nil];
////		}
////	}
////	else
////	{
////		printJob=nil;
////		if(printOptions.previewWindow)
////		{
////			NSObject* pw = printOptions.previewWindow;
////			if(pw && [pw hasOwnProperty:(@"isPrinting")])
////			{
////				pw.isPrinting=NO;
////			}
////		}
////	}
//}
//
//-(void)onPrintWorkerTimer:(FLXSEvent*)event
//{
////	BOOL done=NO;
////	PrintWindow* printWindow = _printWindow;
////	if(printWindow.currentPage<=printWindow.totalPages)
////	{
////		[self printCurrentPage:YES];
////		if(printWindow.currentPage==printWindow.totalPages)
////		{
////			done=YES;
////		}
////		else
////printWindow.currentPage++;
////		if(printOptions.asynch && printOptions.previewWindow)
////		{
////			//do nothing, we will come back to self method once the UI is updated.
////			printOptions.previewWindow.progress=printWindow.currentPage+@"|"+printWindow.totalPages;
////		}
////		else
////		{
////			if(!done)
////				[self onPrintWorkerTimer:nil];
////		}
////	}
////	else
////	{
////		done=YES;
////	}
////	if(done)
////	{
////		[self onPrintComplete]
////if(printOptions.asynch && worker)
////		{
////			[worker removeEventListener:[TimerEvent TIMER] :onPrintWorkerTimer];
////			[worker stop];
////			worker = nil;
////		}
////	}
//}
//
//-(void)printCurrentPage:(BOOL)add
//{
////	PrintWindow* printWindow = _printWindow;
////	printWindow.currentPage = printWindow.currentPage;
////	if (printWindow.totalPages > 1)
////	{
////		if (printWindow.currentPage == 1)
////			[printWindow showFirstPage:YES];
////		else if (printWindow.currentPage == printWindow.totalPages)
////[printWindow showLastPage:YES];
////		else
////[printWindow showMiddlePage:YES];
////		if(add)
////		{
////			[self gotoCurrentPage];
////			[printWindow validateNow]
////[self addCurrentPage];
////		}
////	}
////	else
////	{
////		[printWindow showSinglePage:YES];
////		if(add)
////		{
////			[self gotoCurrentPage];
////			[printWindow validateNow]
////[self addCurrentPage];
////		}
////	}
//}
//
//-(void)onPrintWorkerTimerDelayedAsych:(FLXSEvent*)event
//{
////	BOOL done=NO;
////	PrintWindow* printWindow = _printWindow;
////	if(_pageShown)
////	{
////		[self addCurrentPage];
////		printWindow.currentPage++;
////	}
////	if((printWindow.currentPage>printWindow.totalPages)&&_pageShown)
////	{
////		done=YES;
////		[self onPrintComplete]
////[worker removeEventListener:[TimerEvent TIMER] :onPrintWorkerTimerDelayedAsych];
////		[worker stop];
////		worker = nil;
////		return;
////	}
////	if(printWindow.currentPage<=printWindow.totalPages)
////	{
////		[self printCurrentPage:NO]
////_pageShown=YES;
////		[self gotoCurrentPage];
////		[printWindow validateNow]
//////do nothing, we will come back to self method once the UI is updated.
////printOptions.previewWindow.progress=printWindow.currentPage+@"|"+printWindow.totalPages;
////	}
//}
//
//-(void)onPrintComplete
//{
////	printOptions.preview=printOptions.wasPreview;
////	if([_printWindow parent])
////		[FLXSUIUtils removeChild:[_printWindow parent] :_printWindow];
////	// Send the job to the printer.
////	if(!printOptions.printToPdf)
////	{
////		[printJob send];
////		printJob=nil;
////	}
////	PrintPreviewEvent* pe = [[PrintPreviewEvent alloc] initWithType:[PrintPreviewEvent AFTER_PRINT]];
////	pe.printOptions=printOptions;
////	[printOptions.printable dispatchEvent:pe];
////	if(printOptions.previewWindow)
////	{
////		[FLXSUIUtils removePopUp:printOptions.previewWindow]
////printOptions.previewWindow=nil;
////	}
////	if(printOptions.printToPdf && printOptions.printable.pdfPrinter)
////	{
////		[printOptions.printable.pdfPrinter endDocument:printOptions];
////	}
////	_pageShown=NO;
//}
//
//-(void)addCurrentPage
//{
////	if(printOptions.printToPdf)
////	{
////		Image* img=[self convertToImage:_printWindow :_printOptions];
////		if(printOptions.printable.pdfPrinter)
////		{
////			if(printOptions.previewWindow)
////			{
////				[printOptions.previewWindow.content addChild:img];
////				[printOptions.previewWindow validateNow];
////				[printOptions.printable.pdfPrinter addPage:img :printOptions];
////				[printOptions.previewWindow.content removeChild:img];
////			}
////			else
////			{
////				[FLXSUIUtils addChild:([FLXSUIUtils getTopLevelApplication]) :img];
////				[FLXSUIUtils getTopLevelApplication[] validateNow];
////				[printOptions.printable.pdfPrinter addPage:img :printOptions];
////				[FLXSUIUtils removeChild:([FLXSUIUtils getTopLevelApplication]) :img];
////			}
////		}
////		else
////		{
////			[printOptions.printedPages addObject:img];
////		}
////	}
////	else
////	{
////		if([_printWindow printDataGrid].rowCount==0)
////		{
////			[[_printWindow printDataGrid] validateNow];
////		}
////		[printJob addObject:_printWindow :[FlexPrintJobScaleType FILL_PAGE]];
////	}
//}
//
//- (UIImage *)convertToImage:(UIView *)object printOptions:(FLXSPrintOptions *)printOptions {
//	//in the preview mode, we render an image of each page of data to the preview window
////	Image* image=[[Image alloc] init];
////	int paperWidth=printOptions.pageSize.width;
////	int paperHeight=printOptions.pageSize.height;
////	image.width=paperWidth;
////	image.height=paperHeight;
////	int zoom=1;
////	BitmapData* bd=[[BitmapData alloc] initWithType:(paperWidth * zoom) :(paperHeight * zoom) :NO];
////	Matrix* m=[[Matrix alloc] init];
////	[bd draw:object :m];
////	image.source=[[Bitmap alloc] init:bd :[PixelSnapping ALWAYS] :YES];
////	return image;
//    return nil;
//}
//
//- (void)previewWithOptions:(UIView <FLXSIPrintable> *)printable printOptions:(FLXSPrintOptions *)printOptions {
////	_extendedDataGrid=printable as FLXSIExtendedDataGrid;
////	_printOptions=printOptions;
////	PrintWindow* printWindow=[self createPrintWindow:printable :printOptions];
////	if (!printOptions.printPreviewViewrenderer)
////	{
////		//user may override self if needed.
////		printOptions.printPreviewViewrenderer=[[FLXSClassFactory alloc] init:PrintPreview];
////	}
////	IPrintPreview* printPreview=[printOptions.printPreviewViewrenderer generateInstance];
////	printOptions.previewWindow = printPreview;
////	printPreview.height= [FLXSUIUtils getTopLevelApplication].screen.height - 50;
////	[printPreview addEventListener:[PrintPreviewEvent PAGE_OPTIONS_CHANGED] :onPreviewPageOptionsChanged :NO :0 :YES];
////	[printPreview addEventListener:[PrintPreviewEvent PAGE_INDEX_CHANGED] :onPreviewPageIndexChanged :NO :0 :YES];
////	[printPreview addEventListener:[PrintPreviewEvent COLUMNS_CHANGED] :onPreviewColumnsChanged :NO :0 :YES];
////	[printPreview addEventListener:[PrintPreviewEvent DATAGRID_RECREATE_REQUIRED] :onDataGridRecreateRequest :NO :0 :YES];
////	[printPreview addEventListener:[PrintPreviewEvent COLUMNS_RESIZED] :onDataGridColumnsResized :NO :0 :YES];
////	[printPreview addEventListener:[PrintPreviewEvent PRINT_REQUESTED] :onPreviewPrintRequested :NO :0 :YES];
////	[printPreview addEventListener:(@"popupRemoved") :onPreviewClose :NO :0 :YES];
////	NSObject* popupParent=printOptions.popupParent;
////	if(!popupParent)popupParent=[FLXSUIUtils getTopLevelApplication];
////	[FLXSUIUtils addPopUp:printPreview :popupParent as DisplayObject :printOptions.modalWindows :nil :nil :(printable.useModuleFactory?printable.moduleFactory:nil)];
////	printPreview.printOptions=printOptions;
////	[self generatePreview:printPreview :printWindow];
////	[PopUpManager centerPopUp:printPreview];
//}
//
//-(void)onPreviewClose:(FLXSEvent*)event
//{
////	if(_extendedDataGrid&&[_extendedDataGrid enablePaging]
////		&& [_extendedDataGrid getDataProvider] is HierarchicalCollectionView
////		&& _extendedDataGrid is IAdvancedExtendedDataGrid
////		&&[[_extendedDataGrid filterPageSortMode] isEqual: @"client"]
////		)
////	{
////		[_extendedDataGrid processFilter];
////	}
//}
//
//-(void)onPreviewPrintRequested:(FLXSEvent*)event
//{
////	_printOptions.wasPreview=[_printOptions preview];
////	_printOptions.preview=NO;
////	[self printWithOptions:(_extendedDataGrid?_extendedDataGrid:[_printOptions printable]) :_printOptions];
//}
//
//-(void)onPreviewPageOptionsChanged:(FLXSEvent*)event
//{
////	IPrintPreview* printPreview=(event.target as IPrintPreview);
////	printPreview.currentPage=1;
////	[self generatePreview:printPreview :([self createPrintWindow:(_extendedDataGrid?_extendedDataGrid:[_printOptions printable]) :printOptions])];
////	[PopUpManager centerPopUp:printPreview];
//}
//
//-(void)onPreviewPageIndexChanged:(FLXSEvent*)event
//{
////	IPrintPreview* printPreview=(event.target as IPrintPreview);
////	[self generatePreview:printPreview :_printWindow];
//}
//
//-(void)onPreviewColumnsChanged:(FLXSEvent*)event
//{
////	[[_printOptions columnWidths] removeAllObjects];
////	[self onDataGridRecreateRequest:event];
//}
//
//-(void)onDataGridColumnsResized:(FLXSEvent*)event
//{
//	//_extendedDataGrid.lastPrintOptionsString = [_printOptions toPersistenceString:_extendedDataGrid];
//}
//
//-(void)onDataGridRecreateRequest:(FLXSEvent*)event
//{
////	IPrintPreview* printPreview=(event.target as IPrintPreview);
////	printPreview.currentPage=1;
////	[self generatePreview:printPreview :([self createPrintWindow:(_extendedDataGrid?_extendedDataGrid:[_printOptions printable]) :printOptions])];
//}
//
//- (void)generatePreview:(UIView <FLXSIPrintPreview> *)printPreview printWindow:(FLXSPrintWindow *)printWindow {
////	PageSize* pageSize=[_printOptions pageSize];
////	[printPreview.content removeAllChildren];
////	[printPreview.content addChild:printWindow];
////	printWindow.width=printOptions.pageSize.width;
////	printWindow.height=printOptions.pageSize.height;
////	[self setupPrintWindow:printWindow.printable :printOptions :printWindow];
////	if (printWindow.totalPages > 1)
////	{
////		if (printPreview.currentPage == 1)
////			[printWindow showFirstPage:NO];
////		else if (printPreview.currentPage == printPreview.totalPages)
////[printWindow showLastPage:NO];
////		else
////[printWindow showMiddlePage:NO];
////	}
////	else
////	{
////		[printWindow showSinglePage:NO];
////	}
////	printPreview.totalPages=printWindow.totalPages;
////	printWindow.currentPage=printPreview.currentPage;
////	BOOL needToReEnter=printWindow.printDataGrid&&(printWindow.printDataGrid.printListItems.length==0);
////	if(needToReEnter)
////	{
////		[printWindow.printDataGrid gotoRow:0];
////		[printWindow validateNow]
////if(printWindow.printDataGrid.validNextPage)
////[printWindow.printDataGrid nextPage];
////		[printWindow validateNow]
////[printWindow.printDataGrid gotoRow:([printWindow getPageStart])];
////	}
////	else
////	{
////		[self gotoCurrentPage];
////	}
////	[printWindow callValidate];
////	printPreview.content.width=printOptions.pageSize.width + 25;
////	//[FLXSUIUtils removeChild:[_extendedDataGrid parentDocument] :printWindow];
////	if(printOptions.extendedDataGrid)
////	{
////		PrintPreviewEvent* pe = [[PrintPreviewEvent alloc] initWithType:[PrintPreviewEvent AFTER_PRINT]];
////		pe.printOptions=printOptions;
////		[pe.printOptions.extendedDataGrid dispatchEvent:pe];
////	}
//}
//
//-(void)gotoCurrentPage
//{
//	//[[_printWindow printDataGrid] gotoRow:([_printWindow getPageStart])];
//}
//
//+ (FLXSPrintController*)_instance
//{
//	//return _instance;
//    return  nil;
//}
//@end
//
