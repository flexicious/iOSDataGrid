#import "FLXSVersion.h"
#import "FLXSIFilterControl.h"
#import "FLXSIFilterControlContainer.h"
#import "FLXSIDataGridFilterColumn.h"
#import "FLXSIExtendedDataGrid.h"

/**
	 * @private
	 */
@interface FLXSFilterControlImpl : NSObject
{

}

@property (nonatomic, weak) UIView <FLXSIFilterControl>* iFilterControl;
@property (nonatomic, assign) BOOL registered;
@property (nonatomic, strong) NSString* searchField;
@property (nonatomic, strong) NSString* filterOperation;
@property (nonatomic, weak) NSObject <FLXSIExtendedDataGrid>* grid;
@property (nonatomic, weak) NSObject<FLXSIDataGridFilterColumn> * gridColumn;
@property (nonatomic, strong) NSString* filterComparisonType;
@property (nonatomic, strong) NSString* filterTriggerEvent;
@property (nonatomic, strong) NSString*dataFieldFLXS;
@property (nonatomic, assign) BOOL autoRegister;

-(id)initWithFilterControl:(UIView <FLXSIFilterControl>*)iFilterControl;
-(void)register:(NSObject <FLXSIFilterControlContainer>*)container;
@end

