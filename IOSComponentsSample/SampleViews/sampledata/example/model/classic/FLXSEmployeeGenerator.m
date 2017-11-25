#import "FLXSEmployeeGenerator.h"
#import "FLXSEmployee.h"

@implementation FLXSEmployeeGenerator
-(NSMutableArray*)getAllDepartments
{
    return [[FLXSEmployee allDepartments] mutableCopy];
}

-(FLXSFilter*)getEmployees:(FLXSFilter*)filter
{
//	//dummy database call....
//	NSMutableArray* allEmployees = [[ArrayCollection alloc] initWithType:[Employee employees].source];
//	//code to create sql to filter, page and sort our resultset....
//	//self could be LINQ, SQL, HIBNERNATE, JDBC, Stored Procs, whatever
//	//below is just mock mechanism
//	CollectionManipulator* collectionManipulator=[[CollectionManipulator alloc] init];
//	if(filter.arguments && filter.arguments.length>0)
//		[collectionManipulator filterArrayCollection:allEmployees :filter.arguments :nil];
//	int totalRecords = allEmployees.length;
//	if (filter.sorts.length > 0)
//		[collectionManipulator sortArrayCollection:allEmployees :filter.sorts];
//	if(filter.pageIndex>-1)
//		[collectionManipulator pageArrayCollection:allEmployees :filter.pageIndex :filter.pageSize];
//	[allEmployees refresh];
//	NSMutableArray* result = [[ArrayCollection alloc] init];
//	for(NSObject* o in allEmployees)
//		[result addItem:o];
//	//self is needed on the client side to tell the pager how many
//	//pages to draw
//	filter.recordCount = totalRecords;
//	//self is the actual results to display in the [self grid:Usually just the first page of data]...
//	filter.records = result;
//	return filter;
    return nil;
}
@end

