//#import "PrintArea.h"
//
//
//@implementation PrintArea
//
//@synthesize _pageRecords;
//@synthesize _allRecords;
//@synthesize _currentPage;
//@synthesize _totalPages;
//@synthesize _printOptions;
//@synthesize _printComponent;
//@synthesize _printable;
//
//-(id)init
//{
//	self = [super init];
//	if (self)
//	{
//		_pageRecords = [[NSMutableArray alloc] init];
//		_allRecords = [[NSMutableArray alloc] init];
//		_currentPage = 1;
//
//	}
//	return self;
//}
//
//-(void)dealloc
//{
//	[super dealloc];
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
//}
//
//-(NSMutableArray*)pageRecords
//{
//	return _pageRecords;
//}
//
//-(void)pageRecords:(NSMutableArray*)val
//{
//	_pageRecords=val;
//}
//
//-(NSMutableArray*)allRecords
//{
//	return _allRecords;
//}
//
//-(void)allRecords:(NSMutableArray*)val
//{
//	_allRecords=val;
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
//-(UIView<FLXSIPrintComponent>*)printComponent
//{
//	return _printComponent;
//}
//
//-(void)printComponent:(UIView<FLXSIPrintComponent>*)val
//{
//	_printComponent = val;
//	if(_printComponent is IPrintDatagrid)
//	{
//		printDataGrid=_printComponent as IPrintDatagrid;
//	}
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
//-(FLXSPrintOptions*)printOptions
//{
//	return _printOptions;
//}
//
//-(void)printOptions:(FLXSPrintOptions*)val
//{
//	_printOptions=val;
//}
//
//-(UIView<FLXSIPrintDatagrid>*)printDataGrid
//{
//	return _printComponent as IPrintDatagrid;
//}
//
//-(void)printDataGrid:(UIView<FLXSIPrintDatagrid>*)val
//{
//	_printComponent=val;
//}
//
//@end
//
