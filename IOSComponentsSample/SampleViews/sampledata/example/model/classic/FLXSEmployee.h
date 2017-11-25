
#import "FLXSEmployee.h"

#import "FLXSClassicAddress.h"

@interface FLXSEmployee : NSObject
{

}

@property (nonatomic, strong) NSString* firstName;
@property (nonatomic, strong) NSString* lastName;
@property (nonatomic, assign) float employeeId;
@property (nonatomic, strong) NSDate* hireDate;
@property (nonatomic, strong) NSString* stateCode;
@property (nonatomic, strong) FLXSClassicAddress * address;
@property (nonatomic, strong) NSString* phoneNumber;
@property (nonatomic, assign) float annualSalary;
@property (nonatomic, assign) BOOL isActive;
@property (nonatomic, strong) NSString* department;
@property (nonatomic, assign) float departmentId;
@property (nonatomic, strong) NSMutableArray* addresses;

+(FLXSEmployee *)createNullEmployee;
+(FLXSEmployee *)createEmployee:(NSString*)fName :(NSString*)hDate :(NSString*)lName;
+(FLXSClassicAddress *)createAddress:(NSString*)stateCode;
-(NSString*)details;
-(NSString*)city;
+(int)getRandom:(int)minNum :(int)maxNum;
-(NSString*)departmentManual;
-(NSString*)departmentParameterized;
-(NSString*)hireDateString;
 +(NSMutableArray*)getAllEmployees;

+ (NSMutableArray*)allDepartments;
+ (NSMutableArray*)areaCodes;
+ (NSMutableArray*)streetTypes;
+ (NSMutableArray*)streetNames;
+ (NSMutableArray*)cities;
+ (NSMutableArray*)allStates;
+ (float)index;
+ (NSMutableArray*)employees;
@end

