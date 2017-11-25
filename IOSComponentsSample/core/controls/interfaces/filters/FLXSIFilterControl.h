#import "FLXSIDataGridFilterColumn.h"
#import "FLXSIEventDispatcher.h"
#import "FLXSVersion.h"
@protocol FLXSIExtendedDataGrid;
/**
* To be implemented by any control that can participate
* in the filtering mechanism.
*
* Each of these controls need to have a field that it should
* search on (which can be the same as the datafield or different)
* and an expression, which defaults to EQUALS, but can take any of the
* constants defined in the FilterExpression class.
*
*/
@protocol FLXSIFilterControl <FLXSIEventDispatcher>



//FLXSIFilterControl methods
@property (nonatomic, strong) NSString* searchField;
@property (nonatomic, strong) NSString* filterOperation;
@property (nonatomic, strong) NSString* filterTriggerEvent;
@property (nonatomic, strong) NSString* filterComparisonType;
@property (nonatomic, strong) NSObject <FLXSIExtendedDataGrid>* grid;
@property (nonatomic, strong) NSObject <FLXSIDataGridFilterColumn>* gridColumn;
@property (nonatomic, assign) BOOL autoRegister;
-(void)clear;
-(NSString*)getValue;
-(void)setValue:(NSObject*)val;
//End IFilter control methods


@end

