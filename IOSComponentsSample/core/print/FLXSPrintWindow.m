//#import "PrintWindow.h"
//#import "Object.h"
//#import "Number.h"
//#import "PrintPreviewEvent.h"
//
//
//@implementation PrintWindow#import "FLXSPrintOptions.h"
//
//@synthesize rowsOnPage;
//@synthesize _printOptions;
//@synthesize _printComponent;
//@synthesize _printable;
//@synthesize _printComponentRenderer;
//@synthesize _printDataGridDirty;
//@synthesize _printerHeader;
//@synthesize _reportHeaderRenderer;
//@synthesize _printerHeaderDirty;
//@synthesize _printerFooter;
//@synthesize _reportFooterRenderer;
//@synthesize _printerFooterDirty;
//@synthesize _pageHeader;
//@synthesize _pageHeaderRenderer;
//@synthesize _pageHeaderDirty;
//@synthesize _pageFooter;
//@synthesize _pageFooterRenderer;
//@synthesize _pageFooterDirty;
//@synthesize _currentPage;
//@synthesize _pageRecordsDirty;
//@synthesize _totalPages;
//@synthesize firstPageRowCount;
//@synthesize middlePageRowCount;
//@synthesize showing;
//
//-(id)init
//{
//	self = [super init];
//	if (self)
//	{
//		rowsOnPage = [[NSMutableArray alloc] init];
//		_printComponentRenderer = [[FLXSClassFactory alloc] init:ExtendedPrintDataGrid];
//		_printDataGridDirty = NO;
//		_reportHeaderRenderer = [[FLXSClassFactory alloc] init:PrinterHeader];
//		_printerHeaderDirty = NO;
//		_reportFooterRenderer = [[FLXSClassFactory alloc] init:PrinterFooter];
//		_printerFooterDirty = NO;
//		_pageHeaderRenderer = [[FLXSClassFactory alloc] init:PageHeader];
//		_pageHeaderDirty = NO;
//		_pageFooterRenderer = [[FLXSClassFactory alloc] init:PageFooter];
//		_pageFooterDirty = NO;
//		_currentPage = 1;
//		_pageRecordsDirty = NO;
//		showing = @"none";
//
//		self.strong) NSString* verticalScrollPolicy = [ScrollPolicy OFF];
//		self.horizontalScrollPolicy = [ScrollPolicy OFF];
//		[self setStyle:(@"verticalGap") :(@"0")];
//	}
//	return self;
//}
//
//-(void)dealloc
//{
//	[super dealloc];
//}
//
//-(void)createChildren
//{
//	[super createChildren];
//	if (!printerHeader)
//	{
//		printerHeader = [reportHeaderRenderer generateInstance] as IPrintArea;
//	}
//	if (!pageHeader)
//	{
//		pageHeader = [pageHeaderRenderer generateInstance] as IPrintArea;
//	}
//	if (!printComponent)
//	{
//		printComponent = [printComponentRenderer generateInstance] as IPrintComponent;
//	}
//	if (!pageFooter)
//	{
//		pageFooter = [pageFooterRenderer generateInstance] as IPrintArea;
//	}
//	if (!printerFooter)
//	{
//		printerFooter = [reportFooterRenderer generateInstance] as IPrintArea;
//	}
//}
//
//-(void)removeIfExists:(NSObject*)val
//{
//	UIView* obj = val as DisplayObject;
//	if(obj && [self contains:obj] )
//	{
//		[self removeChild:obj];
//	}
//}
//
//-(UIView<FLXSIPrintArea>*)printerHeader
//{
//	return _printerHeader;
//}
//
//-(void)printerHeader:(UIView<FLXSIPrintArea>*)val
//{
//	[self removeIfExists:val];
//	_printerHeader = val;
//	_printerHeaderDirty = YES;
//	[self invalidateProperties];
//	[self setNeedsDisplay];
//}
//
//-(FLXSClassFactory*)reportHeaderRenderer
//{
//	return _reportHeaderRenderer;
//}
//
//-(void)reportHeaderRenderer:(FLXSClassFactory*)val
//{
//	_reportHeaderRenderer=val;
//	printerHeader = [reportHeaderRenderer generateInstance] as IPrintArea;
//}
//
//-(UIView<FLXSIPrintArea>*)printerFooter
//{
//	return _printerFooter;
//}
//
//-(void)printerFooter:(UIView<FLXSIPrintArea>*)val
//{
//	[self removeIfExists:val];
//	_printerFooter = val;
//	_printerFooterDirty = YES;
//	[self invalidateProperties];
//	[self setNeedsDisplay];
//}
//
//-(FLXSClassFactory*)reportFooterRenderer
//{
//	return _reportFooterRenderer;
//}
//
//-(void)reportFooterRenderer:(FLXSClassFactory*)val
//{
//	_reportFooterRenderer=val;
//	printerFooter = [reportFooterRenderer generateInstance] as IPrintArea;
//}
//
//-(UIView<FLXSIPrintArea>*)pageFooter
//{
//	return _pageFooter;
//}
//
//-(void)pageFooter:(UIView<FLXSIPrintArea>*)val
//{
//	[self removeIfExists:val];
//	_pageFooter = val;
//	_pageFooterDirty = YES;
//	[self invalidateProperties];
//	[self setNeedsDisplay];
//}
//
//-(FLXSClassFactory*)pageFooterRenderer
//{
//	return _pageFooterRenderer;
//}
//
//-(void)pageFooterRenderer:(FLXSClassFactory*)val
//{
//	_pageFooterRenderer=val;
//	pageFooter = [pageFooterRenderer generateInstance] as IPrintArea;
//}
//
//-(FLXSClassFactory*)pageHeaderRenderer
//{
//	return _pageHeaderRenderer;
//}
//
//-(void)pageHeaderRenderer:(FLXSClassFactory*)val
//{
//	_pageHeaderRenderer=val;
//	pageHeader = [pageHeaderRenderer generateInstance] as IPrintArea;
//}
//
//-(UIView<FLXSIPrintArea>*)pageHeader
//{
//	return _pageHeader;
//}
//
//-(void)pageHeader:(UIView<FLXSIPrintArea>*)val
//{
//	[self removeIfExists:val];
//	_pageHeader = val;
//	_pageHeaderDirty = YES;
//	[self invalidateProperties];
//	[self setNeedsDisplay];
//}
//
//-(UIView<FLXSIPrintComponent>*)printComponent
//{
//	return _printComponent;
//}
//
//-(void)printComponent:(UIView<FLXSIPrintComponent>*)val
//{
//	_printComponent = val;
//	[self removeIfExists:val];
//	if(_printComponent is IPrintDatagrid)
//	{
//		_printComponent = val;
//		IPrintDatagrid* pdg = printComponent as IPrintDatagrid;
//		[pdg setResizableColumns:YES];
//		[pdg addEventListener:[DataGridEvent COLUMN_STRETCH] :onColumnResize :NO :0 :YES];
//		if(pdg[@"hasOwnProperty"](@"groupedColumns"))
//		{
//			[pdg addEventListener:(@"itemOpen") :onItemOpen :NO :0 :YES];
//			[pdg addEventListener:(@"itemClose") :onItemOpen :NO :0 :YES];
//		}
//	}
//	val.percentHeight=100;
//	val.percentWidth=100;
//	_printDataGridDirty = YES;
//	[self invalidateProperties];
//	[self setNeedsDisplay];
//}
//
//-(UIView<FLXSIPrintDatagrid>*)printDataGrid
//{
//	return _printComponent as IPrintDatagrid;
//}
//
//-(FLXSClassFactory*)printComponentRenderer
//{
//	return _printComponentRenderer;
//}
//
//-(void)printComponentRenderer:(FLXSClassFactory*)val
//{
//	_printComponentRenderer=val;
//	printComponent = [printComponentRenderer generateInstance] as IPrintComponent;
//}
//
//-(void)commitProperties
//{
//	[super commitProperties];
//	if (_printerHeaderDirty)
//	{
//		_printerHeaderDirty= NO;
//		[self addChild:printerHeader as DisplayObject];
//	}
//	if (_pageHeaderDirty)
//	{
//		_pageHeaderDirty= NO;
//		[self addChild:pageHeader as DisplayObject];
//	}
//	if (_printDataGridDirty)
//	{
//		_printDataGridDirty = NO;
//		[self addChild:printComponent as DisplayObject];
//	}
//	if (_pageFooterDirty)
//	{
//		_pageFooterDirty= NO;
//		[self addChild:pageFooter as DisplayObject];
//	}
//	if (_printerFooterDirty)
//	{
//		_printerFooterDirty= NO;
//		[self addChild:printerFooter as DisplayObject];
//	}
//	if(_pageRecordsDirty)
//	{
//		_pageRecordsDirty=NO;
//		if(printDataGrid)
//		{
//			NSMutableArray* currentRecords=[[NSMutableArray alloc] init];
//			NSMutableArray* allRecords=[[NSMutableArray alloc] init];
//			if([printDataGrid getDataProvider] is ICollectionView)
//			{
//				ICollectionView* iCollectionView = [printDataGrid getDataProvider] as ICollectionView;
//				if(!(iCollectionView is IHierarchicalCollectionView))
//				{
//					int pageStart = [self getPageStart];
//					int pageEnd = [self getPageEnd];
//					for(int index=pageStart;index<pageEnd;index++)
//					{
//						[currentRecords addObject:(iCollectionView[index])];
//					}
//					for(NSObject* record in iCollectionView)
//					{
//						[allRecords addObject:record];
//					}
//				}
//			}
//			for(IPrintArea* printArea in printAreas)
//			{
//				printArea.currentPage= _currentPage;
//				printArea.pageRecords = currentRecords;
//				printArea.allRecords = allRecords;
//			}
//		}
//	}
//	for(IPrintArea* printArea1 in printAreas)
//	{
//		printArea1.totalPages = totalPages;
//		printArea1.printOptions = printOptions;
//		printArea1.printComponent = printComponent;
//		printArea1.printable= printable;
//	}
//}
//
//-(int)getPageStart
//{
//	if(rowsOnPage.length>0)
//	{
//		int pageStart;
//		//for variable row height
//		for(int i=1;i<currentPage;i++)
//		{
//			pageStart+=rowsOnPage[i-1];
//		}
//		return pageStart;
//	}
//	else
//return currentPage==1?0:currentPage==2?firstPageRowCount:(middlePageRowCount*(currentPage-2))+firstPageRowCount;
//}
//
//-(int)getPageEnd
//{
//	ICollectionView* iCollectionView = [printDataGrid getDataProvider] as ICollectionView;
//	int pageEnd = [self getPageStart] + (rowsOnPage.length>0?rowsOnPage[currentPage-1]
//:(currentPage==1?firstPageRowCount:middlePageRowCount));
//	pageEnd = pageEnd> iCollectionView.length?iCollectionView.length:pageEnd;
//	return pageEnd;
//}
//
//-(void)callValidate
//{
//	[self validateNow];
//	if(printComponent)
//	{
//		float currentHt=printComponent.height;
//		float newHt = [self getGridHeight];
//		if(currentHt!=newHt)
//		{
//			printComponent.height=newHt;
//			[self validateNow];
//		}
//	}
//}
//
//-(float)getGridHeight
//{
//	return self.height-
//((printerHeader && printerHeader.includeInLayout)?printerHeader.height:0)-
//((printerFooter && printerFooter.includeInLayout)?printerFooter.height:0)-
//((pageHeader && pageHeader.includeInLayout)?pageHeader.height:0)-
//((pageFooter && pageFooter.includeInLayout)?pageFooter.height:0)-
//[self getStyle:(@"paddingTop")]-[self getStyle:(@"paddingBottomFLXS")];
//}
//
//-(void)showFirstPage:(BOOL)validate
//{
//	if([showing isEqual:@"first"])return;
//	showing=@"first"
//[self showHide:printerFooter :NO];
//	[self showHide:printerHeader :printOptions.includePrintHeader];
//	[self showHide:pageHeader :printOptions.includePageHeader];
//	[self showHide:pageFooter :printOptions.includePageFooter];
//	if(validate)
//		[self callValidate];
//}
//
//-(void)showLastPage:(BOOL)validate
//{
//	if([showing isEqual:@"last"])return;
//	showing=@"last"
//[self showHide:printerFooter :printOptions.includePrintFooter];
//	[self showHide:printerHeader :NO];
//	[self showHide:pageHeader :printOptions.includePageHeader];
//	[self showHide:pageFooter :printOptions.includePageFooter];
//	if(validate)[self callValidate];
//}
//
//-(void)showMiddlePage:(BOOL)validate
//{
//	if([showing isEqual:@"middle"])return;
//	showing=@"middle"
//[self showHide:printerFooter :NO];
//	[self showHide:printerHeader :NO];
//	[self showHide:pageHeader :printOptions.includePageHeader];
//	[self showHide:pageFooter :printOptions.includePageFooter];
//	if(validate)[self callValidate];
//}
//
//-(void)showSinglePage:(BOOL)validate
//{
//	if([showing isEqual:@"single"])return;
//	showing=@"single"
//[self showHide:printerFooter :printOptions.includePrintFooter];
//	[self showHide:printerHeader :printOptions.includePrintHeader];
//	[self showHide:pageHeader :printOptions.includePageHeader];
//	[self showHide:pageFooter :printOptions.includePageFooter];
//	if(validate)[self callValidate];
//}
//
//-(void)showHide:(NSObject*)val :(BOOL)showHide
//{
//	UIView* obj=val as UIComponent;
//	if(obj && (obj.visible != showHide))
//	{
//		obj.visible = showHide;
//		obj.includeInLayout= showHide;
//	}
//}
//
//-(int)currentPage
//{
//	return _currentPage;
//}
//
//-(void)currentPage:(int)val
//{
//	_currentPage=val;
//	_pageRecordsDirty=YES;
//	[self invalidateProperties];
//}
//
//-(int)totalPages
//{
//	return _totalPages;
//}
//
//-(void)totalPages:(int)val
//{
//	_totalPages=val;
//	[self invalidateProperties];
//}
//
//-(FLXSFlexDataGrid*)extendedDataGrid
//{
//	return _printable as FLXSIExtendedDataGrid;
//}
//
//-(void)extendedDataGrid:(FLXSFlexDataGrid*)val
//{
//	_printable=val;
//}
//
//-(UIView<FLXSIPrintable>*)printable
//{
//	return _printable as IPrintable;
//}
//
//-(void)printable:(UIView<FLXSIPrintable>*)val
//{
//	_printable=val;
//}
//
//-(void)printOptions:(FLXSPrintOptions*)val
//{
//	_printOptions=val;
//}
//
//-(FLXSPrintOptions*)printOptions
//{
//	return _printOptions;
//}
//
//-(NSArray*)printAreas
//{
//	NSMutableArray* array = [[NSMutableArray alloc] init];
//	if(printerHeader)
//		[array addObject:printerHeader];
//	if(printerFooter)
//		[array addObject:printerFooter];
//	if(pageHeader)
//		[array addObject:pageHeader];
//	if(pageFooter)
//		[array addObject:pageFooter];
//	return array.source;
//}
//
//-(void)onColumnResize:(FLXSEvent*)event
//{
//	[printOptions.columnWidths removeAllObjects];
//	for(NSObject* [col in printDataGrid getColumns])
//	{
//		if(col.visible)
//			[printOptions.columnWidths addObject:col.width];
//	}
//	[document dispatchEvent:([[PrintPreviewEvent alloc] initWithType:[PrintPreviewEvent COLUMNS_RESIZED]])];
//	if(printDataGrid.variableRowHeight)//self could reset our page count...
//	{
//		[document dispatchEvent:([[PrintPreviewEvent alloc] initWithType:[PrintPreviewEvent DATAGRID_RECREATE_REQUIRED]])];
//		//we need to reset the column size after we recreate grid:
//		printDataGrid.horizontalScrollPolicy=@"on";
//		int index=0;
//		for(NSObject* [newCol in printDataGrid getColumns])
//		{
//			if(newCol.visible)
//				newCol.width = printOptions.columnWidths[index++];
//		}
//		printDataGrid.horizontalScrollPolicy=@"off";
//	}
//}
//
//-(void)onItemOpen:(FLXSEvent*)event
//{
//	[document dispatchEvent:([[PrintPreviewEvent alloc] initWithType:[PrintPreviewEvent DATAGRID_RECREATE_REQUIRED]])];
//}
//
//@end
//
