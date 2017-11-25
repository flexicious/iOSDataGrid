#import "FLXSEmployee.h"
#import "FLXSDemoVersion.h"

static  NSArray* allDepartments = nil;//[[NSMutableArray alloc] initWithType: ([{@"data":@"IT", @"label":@"IT"}, {@"data":@"Accounting", @"label":@"Accounting"}, {@"data":@"Sales", @"label":@"Sales"}, {@"data":@"HR", @"label":@"HR"}])];
static  NSArray* areaCodes = nil;//[@"201",@"732",@"212",@"646"] ;
static  NSArray* streetTypes = nil;//[@"Ave",@"Blvd",@"Rd",@"St",@"Lane"];
static  NSArray* streetNames = nil;//[@"Park",@"West",@"Newark",@"King",@"Gardner"];
static  NSArray* cities = nil;//[@"Grand Rapids",@"Albany",@"Stroudsburgh",@"Barrie",@"Springfield"];
static  NSArray* allStates=nil;
static float indexFLXS = 1;
static NSMutableArray* employees;

@implementation FLXSEmployee

@synthesize firstName;
@synthesize lastName;
@synthesize employeeId;
@synthesize hireDate;
@synthesize stateCode;
@synthesize address;
@synthesize phoneNumber;
@synthesize annualSalary;
@synthesize isActive;
@synthesize department;
@synthesize departmentId;
@synthesize addresses;

+(FLXSEmployee *)createNullEmployee
{
	FLXSEmployee * employee = [[FLXSEmployee alloc] init];
	employee.firstName = nil;
	employee.lastName = nil;
	employee.hireDate=nil;
	employee.employeeId=indexFLXS++;
	employee.phoneNumber = nil;
	employee.isActive= [FLXSEmployee getRandom:1 :2]==1;
	employee.department=nil;
	employee.stateCode=nil;
	return employee;
}

+(FLXSEmployee *)createEmployee:(NSString*)fName :(NSString*)hDate :(NSString*)lName
{
	FLXSEmployee * employee = [[FLXSEmployee alloc] init];
	employee.firstName = fName;
	employee.lastName = lName;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"MM/DD/YYYY";
    employee.hireDate= [fmt dateFromString:hDate];
	employee.employeeId=indexFLXS++;
     employee.phoneNumber = [NSString stringWithFormat:@"%@-%i-%i",[areaCodes objectAtIndex:[FLXSEmployee getRandom:0 :3]],
                     [FLXSEmployee getRandom:100 :999],[FLXSEmployee getRandom:1000 :9999]];
 	employee.isActive= [FLXSEmployee getRandom:1 :2]==1;
	employee.annualSalary=[FLXSEmployee getRandom:50000 :100000];
	employee.department=((FLXSLabelData *)[allDepartments objectAtIndex:[FLXSEmployee getRandom:0 :3]]).data;
	FLXSLabelData* state = [allStates objectAtIndex:[FLXSEmployee getRandom:0 :3]];
	employee.stateCode=state.data;
	employee.address= [self createAddress:state.data];
	int max = [FLXSEmployee getRandom:1 :4];
	for(int i=0;i<max;i++)
		[employee.addresses addObject:([self createAddress:(((FLXSLabelData *)[allStates objectAtIndex:[FLXSEmployee getRandom:0 :3]]).data)])];
	return employee;
}

+(FLXSClassicAddress *)createAddress:(NSString*)stateCode
{
	FLXSClassicAddress * address =[[FLXSClassicAddress alloc] init];
    int randomFloat =[FLXSEmployee getRandom:100 :999];
    NSString * streetName = [streetNames objectAtIndex:[FLXSEmployee getRandom:0 :(int)([streetNames count]-1)]];
    NSString * streetType = [streetTypes objectAtIndex:[FLXSEmployee getRandom:0 :(int)([streetTypes count]-1)]];
    address.street1 =  [NSString stringWithFormat:@"%i %@ %@",randomFloat,streetName,streetType];

	address.city=[cities objectAtIndex:[FLXSEmployee getRandom:0 :(int)([cities count]-1)]];
	address.state=stateCode;
	address.country=@"USA";
	address.apartmentNumber = [FLXSEmployee getRandom:1 :15];
	address.street2= [@"Apt " stringByAppendingFormat:@"%f",address.apartmentNumber];
   
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:[FLXSEmployee getRandom:1 :28]];
    [comps setMonth:[FLXSEmployee getRandom:0 :11]];
    [comps setYear:[FLXSEmployee getRandom:2000 :2005]];
    address.validFrom = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
    [comps setDay:[FLXSEmployee getRandom:1 :28]];
    [comps setMonth:[FLXSEmployee getRandom:0 :11]];
    [comps setYear:[FLXSEmployee getRandom:2005 :2010]];
    address.validTo = [[NSCalendar currentCalendar] dateFromComponents:comps];
	
	return address;
}
-(NSString*)displayName
{
    return [NSString stringWithFormat:@"%@\t%@", self.firstName, self.lastName];

}

-(NSString*)details
{
    return nil;
}

-(NSString*)city
{
	return address.city;
}


+(int)getRandom:(int)minNum :(int)maxNum
{
    return minNum + arc4random() % (maxNum - minNum);
}

-(NSString*)departmentManual
{
	return department;
}

-(NSString*)departmentParameterized
{
	return department;
}

-(NSString*)hireDateString
{
	return self.employeeId==5? @"":self.hireDate?[self.hireDate description]:nil;
}


+(NSMutableArray*)getAllEmployees
{
	return [employees mutableCopy];
}


+ (NSMutableArray*)allDepartments
{
    if(!allDepartments){
        //allDepartments = [NSMutableArray alloc] initWithType: ([{@"data":@"IT", @"label":@"IT"}, {@"data":@"Accounting",
        // @"label":@"Accounting"}, {@"data":@"Sales", @"label":@"Sales"}, {@"data":@"HR", @"label":@"HR"}])];
        allDepartments = [[NSMutableArray alloc] initWithObjects:
                [[FLXSLabelData alloc] initWithLabel:@"IT" andData:@"IT"],
                [[FLXSLabelData alloc] initWithLabel:@"Accounting" andData:@"Accounting"],
                        [[FLXSLabelData alloc] initWithLabel:@"Sales" andData:@"Sales"],
                        [[FLXSLabelData alloc] initWithLabel:@"HR" andData:@"HR"],
                        nil

        ];
    }
	return (NSMutableArray*)allDepartments;
}
+ (NSArray*)areaCodes
{
    if(!areaCodes){
        areaCodes = [[NSArray alloc] initWithObjects: @"201",@"732",@"212",@"646",nil];
    }
	return areaCodes;
}
+ (NSArray*)streetTypes
{
    if(!streetTypes){
        streetTypes = [[NSArray alloc] initWithObjects: @"Ave",@"Blvd",@"Rd",@"St",@"Lane",nil];
    }
    return streetTypes;
}
+ (NSArray*)streetNames
{
    if(!streetNames){
        streetNames= [[NSArray alloc] initWithObjects:@"Park",@"West",@"Newark",@"King",@"Gardner",nil];
    }
	return streetNames;
}
+ (NSArray*)cities
{
    if(!cities){
        cities=[[NSArray alloc] initWithObjects:@"Grand Rapids",@"Albany",@"Stroudsburgh",@"Barrie",@"Springfield",nil];
    }
	return cities;
}
+ (NSMutableArray*)allStates
{
    if(!allStates){
        allStates = [[NSMutableArray alloc] initWithObjects:
                [[FLXSLabelData alloc] initWithLabel:@"New Jersey" andData:@"NJ"],
                [[FLXSLabelData alloc] initWithLabel:@"New York" andData:@"NY"],
                [[FLXSLabelData alloc] initWithLabel:@"Texas" andData:@"TX"],
                [[FLXSLabelData alloc] initWithLabel:@"California" andData:@"CA"],
                nil

        ];
    }
	return (NSMutableArray*)allStates;
}
+ (float)index
{
	return indexFLXS;
}
+ (NSMutableArray*)employees
{
    if(!employees){
        employees = [[NSMutableArray alloc] init];
        [FLXSEmployee allDepartments] ;
        [FLXSEmployee areaCodes] ;
        [FLXSEmployee streetTypes] ;
        [FLXSEmployee streetNames] ;
        [FLXSEmployee cities] ;
        [FLXSEmployee allStates] ;

        [employees addObject:[FLXSEmployee createEmployee: @"Brice": @"06/03/1996":@"Rittwage"]];
        [employees addObject:[FLXSEmployee createEmployee: @"CHUN-FEN": @"01/28/2002":@"Hukill"]];


        [employees addObject:[FLXSEmployee createEmployee: @"Takahiro\"s": @"06/22/2008":@"Aksu"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Corinthians": @"02/19/2005":@"Orchard"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Karna": @"09/27/2003":@"Arledge"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Takehisa": @"07/29/1998":@"Akmanligil"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Ranjana": @"10/09/2007":@"Anupoju"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Erico": @"10/10/2004":@"Riddell"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Llora": @"07/14/1999":@"Lovig"]];
        [employees addObject:[FLXSEmployee createEmployee: @"TIBBY": @"07/28/2005":@"Iburg"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Masanori": @"02/18/2009":@"ASENCIO"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Jeevan": @"01/10/2007":@"EEddddy@"]];
        [employees addObject:[FLXSEmployee createEmployee: @"FAYIZ": @"06/04/2000":@"Ayman"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Rassoul": @"07/06/1999":@"Asaba"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Emerito": @"09/06/2001":@"Meussner"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Luigia": @"02/23/2004":@"Uisprapassorn"]];

        [employees addObject:[FLXSEmployee createEmployee: @"Gwenda": @"05/14/1999":@"Weilert"]];
        [employees addObject:[FLXSEmployee createEmployee: @"datatel2": @"08/22/2005":@"Atmaja"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Silvana": @"12/21/1998":@"Illiano"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Beaul": @"10/23/2000":@"Eagle"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Pamala": @"10/29/2003":@"Amott"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Roberta": @"02/11/2002":@"Obohoski"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Khiem": @"07/14/2001":@"Hirji"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Corbin": @"04/23/2003":@"Orlandella"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Peg": @"06/10/1999":@"Egelston"]];
        [employees addObject:[FLXSEmployee createEmployee: @"GURAVA": @"09/07/2006":@"Urban"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Gregory": @"09/14/2004":@"Renca"]];
        [employees addObject:[FLXSEmployee createEmployee: @"YVELINE": @"09/13/2001":@"Vellos Coker"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Ginina": @"09/12/2009":@"Inyang"]];
        [employees addObject:[FLXSEmployee createEmployee: @"YUN": @"03/07/2007":@"UNGCO"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Berdine": @"10/02/2002":@"Ericksen"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Surendra": @"08/10/2009":@"URISH"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Wei-Cheng": @"05/07/2002":@"EIGER FACP"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Lie-Jun": @"05/09/2005":@"Iek"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Bajaji": @"01/08/1997":@"Ajmani"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Dariush": @"10/17/2006":@"ARTIFICIO"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Suzahne": @"02/03/2009":@"Uzal"]];
        [employees addObject:[FLXSEmployee createEmployee: @"CATOR": @"08/06/1999":@"Athuluru"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Joye": @"11/27/1999":@"Oyler"]];

        [employees addObject:[FLXSEmployee createEmployee: @"Beng": @"09/15/2009":@"Ender"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Patience": @"12/16/1998":@"Atluri"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Saiful": @"08/01/1999":@"Aiello"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Stefan": @"09/19/2001":@"Tewell"]];
        [employees addObject:[FLXSEmployee createEmployee: @"nazneen": @"10/20/1997":@"AZANCOT"]];

        [employees addObject:[FLXSEmployee createEmployee: @"Hironori": @"07/29/1997":@"Irudhayanathan"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Radhika": @"05/29/2007":@"Adeva"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Beau": @"04/26/1996":@"Eady"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Edyth": @"05/06/1999":@"Dygean"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Spyridon": @"11/14/2004":@"Pyzik"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Saekyu": @"06/18/2008":@"Aekka"]];
        [employees addObject:[FLXSEmployee createEmployee: @"MATTKE": @"07/11/2006":@"Atlmayer"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Liang": @"12/25/2007":@"Iacovana"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Raffoul": @"05/01/2002":@"Afflebach"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Tavia": @"03/28/2001":@"AVENIDO"]];

        [employees addObject:[FLXSEmployee createEmployee: @"Wacira": @"08/03/2005":@"Ack"]];

        [employees addObject:[FLXSEmployee createEmployee: @"Andria": @"01/08/2006":@"Ndlovu"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Pug": @"11/13/1999":@"Ugalde"]];
        [employees addObject:[FLXSEmployee createEmployee: @"SHRUTI": @"02/14/2008":@"Hrycko"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Yong-Hwa": @"03/03/2002":@"Ontjes"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Yosseph": @"03/03/1998":@"Osinuga"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Shih-Tse": @"04/05/2000":@"High"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Thommie": @"10/16/2006":@"HOMCY"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Bell": @"01/11/2005":@"Elenbogen"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Madireddy": @"11/20/2008":@"ADAD"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Estle": @"07/14/2004":@"Stringer"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Katheleen": @"01/21/2008":@"Atturu"]];
        [employees addObject:[FLXSEmployee createEmployee: @"VENKATESWARLU": @"10/07/2003":@"Englehart"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Andres": @"06/04/1998":@"Ndungu"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Roseline": @"01/01/2002":@"Osteen"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Jolyne": @"02/03/1999":@"Oldmixon"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Rennie": @"07/22/1999":@"ENESCU"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Jamshid": @"02/04/1999":@"Amir"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Harmeet": @"12/23/2008":@"Aramburu"]];
        [employees addObject:[FLXSEmployee createEmployee: @"PANNEE": @"05/08/1996":@"Andoh"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Vernelle": @"08/05/2004":@"Erwin"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Bentley": @"08/15/2007":@"Englerth"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Renu": @"03/23/2003":@"Engel"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Kamal": @"10/04/1997":@"Ameer"]];

        [employees addObject:[FLXSEmployee createEmployee: @"TZYY-SHUH": @"09/10/2006":@"Zyne"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Tobias": @"01/09/1997":@"Obando Lopez"]];
        [employees addObject:[FLXSEmployee createEmployee: @"MAHAYSAK": @"06/09/2005":@"AHARONI"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Pryor": @"03/23/2004":@"Ryder"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Harikishan": @"11/26/2007":@"ARTAN"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Bhagwan": @"03/16/2000":@"Harts"]];
        [employees addObject:[FLXSEmployee createEmployee: @"SOON": @"06/01/2000":@"OOSTHUIZEN"]];
        [employees addObject:[FLXSEmployee createEmployee: @"SAICHOL": @"07/01/1997":@"Aisenberg"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Glenda": @"02/23/2008":@"Leil"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Keenan": @"05/03/2002":@"EEddddy@"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Lura": @"05/17/1996":@"Urschel"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Vikrant": @"03/24/1998":@"Ikpirijar"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Llal": @"06/02/1997":@"LAMPROS"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Elia": @"04/10/2001":@"Liscum"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Yogesh": @"12/13/2003":@"Ogilvie"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Protima": @"07/24/2001":@"Roeseler"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Chubby": @"01/03/1997":@"Huling"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Jean-Patrick": @"09/06/1998":@"Easler"]];
        [employees addObject:[FLXSEmployee createEmployee: @"IMTYAZ": @"12/18/1999":@"Mthalane"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Ayoka": @"07/15/2008":@"Young"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Aravind": @"01/27/2000":@"Raichlin"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Dwight": @"08/14/1998":@"Wichmann"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Reigo": @"12/22/2006":@"Eisner"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Squiz": @"02/15/1997":@"Quintanilla Attorney"]];
        [employees addObject:[FLXSEmployee createEmployee: @"KEIJO": @"06/12/2005":@"eichen"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Monema": @"09/13/1996":@"Onaifo"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Gwendolyn": @"10/04/2008":@"Weatherspoon"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Navid": @"06/02/2005":@"Avendula"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Marek": @"10/16/2007":@"Armott"]];
        [employees addObject:[FLXSEmployee createEmployee: @"BRIJPAL": @"09/13/2007":@"Ridzik"]];
        [employees addObject:[FLXSEmployee createEmployee: @"CEYHAN": @"03/13/2008":@"Eyerman"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Naohisas": @"05/20/2001":@"Aoyagi"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Trew": @"08/26/2006":@"Reichenbach-Schweers"]];

        [employees addObject:[FLXSEmployee createEmployee: @"Rueben": @"11/10/1997":@"Uemoto"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Gopal": @"09/12/1998":@"Opinya"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Lisenne": @"01/23/2006":@"Ishizaka"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Bushra": @"04/27/2006":@"Usen"]];
        [employees addObject:[FLXSEmployee createEmployee: @"FAOUZI": @"01/27/2001":@"Aoe"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Osbaldo": @"12/29/2005":@"Sblendorio"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Dorcas": @"02/11/1997":@"Ornstein"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Normie": @"02/09/2007":@"Ortolani"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Chen": @"05/05/2006":@"Hennan"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Hussian": @"04/16/2004":@"User3"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Piyush": @"11/13/2005":@"IYADOMI"]];
        [employees addObject:[FLXSEmployee createEmployee: @"GAUDENCIO": @"11/14/1998":@"Aumack"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Swiki": @"10/03/1999":@"Wihtol"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Vasthie": @"07/11/2001":@"Ashurian"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Ryuji": @"07/25/2008":@"YUHAS"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Carie": @"06/06/2003":@"ARGODALE"]];
        [employees addObject:[FLXSEmployee createEmployee: @"EVELIN": @"04/18/1999":@"VENEREO"]];
        [employees addObject:[FLXSEmployee createEmployee: @"WOO": @"08/21/2004":@"OOSTHUIZEN"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Caddie": @"01/21/2005":@"Adler"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Gabriel": @"11/03/1999":@"Abushady"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Kamatchi": @"03/04/2002":@"Ambrosey"]];
        [employees addObject:[FLXSEmployee createEmployee: @"MITSUGU": @"08/03/2008":@"Italiene"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Pratyush": @"09/29/2000":@"Raleigh"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Ritu": @"02/04/2008":@"Itagaki"]];
        [employees addObject:[FLXSEmployee createEmployee: @"ROARK": @"10/20/2004":@"Oaferina"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Lugean": @"03/01/2000":@"Ugbaja"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Remy": @"03/17/2001":@"Emerick"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Narsimha": @"06/24/2007":@"Arterbury"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Derrek": @"08/15/2002":@"Ereckson"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Dennette": @"07/24/2008":@"Endl"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Ezio": @"05/23/1996":@"ZICHICHI"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Sanjay": @"03/14/2006":@"Anksorus"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Shen-Shin": @"05/14/2000":@"Hermann"]];

        [employees addObject:[FLXSEmployee createEmployee: @"Siw": @"06/03/2002":@"Iwamoto"]];
        [employees addObject:[FLXSEmployee createEmployee: @"MANASA": @"07/27/1998":@"ANTHINY"]];
        [employees addObject:[FLXSEmployee createEmployee: @"MIRIAN": @"10/19/2004":@"IRANIESQ"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Mohan": @"01/31/2001":@"Ohnishi"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Dynah": @"11/07/2007":@"YNAYA"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Jerome": @"03/30/1996":@"Erwin Manager"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Tori": @"12/03/2001":@"ORTLIEB"]];
        [employees addObject:[FLXSEmployee createEmployee: @"ccccccc": @"07/17/2008":@"ccccccc"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Myriam": @"03/20/2006":@"Yribarren"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Yukie": @"11/05/2002":@"Ukpokodu"]];
        [employees addObject:[FLXSEmployee createEmployee: @"ACHYUT": @"04/10/2003":@"Cheetham"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Barri": @"10/08/1998":@"Arulmoli"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Gamaliel": @"06/16/1999":@"Amiri"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Benji": @"09/11/1997":@"Engles"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Hidetoshi": @"01/03/2009":@"Idzior"]];
        [employees addObject:[FLXSEmployee createEmployee: @"ACAROL": @"11/10/1999":@"Carmell"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Yaw": @"07/27/2009":@"Awadalla"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Federico": @"10/21/1997":@"Edgell"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Darvia": @"05/26/2003":@"Arseniev"]];
        [employees addObject:[FLXSEmployee createEmployee: @"BHAT": @"03/29/1997":@"Hanlon"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Ramkumar": @"09/18/2000":@"Amabile"]];
        [employees addObject:[FLXSEmployee createEmployee: @"AUGUSTIN": @"06/20/2000":@"Ugalde"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Sassan": @"02/18/2004":@"Askin"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Sebastian": @"04/27/2002":@"Ebato"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Juliann": @"08/23/2009":@"ULISLAM"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Lhea": @"07/04/2005":@"Heady"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Tamyan": @"10/27/1998":@"AMBATIPUDI"]];

        [employees addObject:[FLXSEmployee createEmployee: @"Yongmin": @"09/23/2005":@"Ondrusek"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Satheeshkumar": @"03/30/1998":@"ATISHA"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Sudarsan": @"11/20/2007":@"Udagawa"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Phuntsok": @"04/18/2009":@"Huebert"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Nikki": @"06/22/2003":@"Ikpirijar"]];


        [employees addObject:[FLXSEmployee createEmployee: @"Stubby": @"03/09/2005":@"Tuhacek"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Maralene": @"04/23/1999":@"Arnsberg"]];
        [employees addObject:[FLXSEmployee createEmployee: @"NILAM": @"09/14/2003":@"ILYEON"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Artur": @"04/14/2003":@"rtrt"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Iza": @"10/06/2007":@"Zagury"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Syed": @"06/17/1998":@"Yetkin"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Nanci": @"05/05/2002":@"Anglum"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Kiley": @"08/15/2000":@"ILLOULIAN"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Irene": @"01/25/1999":@"Rettig"]];
        [employees addObject:[FLXSEmployee createEmployee: @"prescila": @"05/02/2006":@"Renolds"]];
        [employees addObject:[FLXSEmployee createEmployee: @"AttorneyLionel": @"07/04/1997":@"ttgfgyu"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Georgan": @"06/09/2004":@"Eovaldi"]];
        [employees addObject:[FLXSEmployee createEmployee: @"RAJKUMAR": @"02/16/2007":@"AJAYI"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Thearlene": @"10/16/2000":@"Herrman"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Beverly": @"11/27/1997":@"Everett"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Buttons": @"07/14/2009":@"Utley"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Kelby": @"06/29/2000":@"Elmer"]];
        [employees addObject:[FLXSEmployee createEmployee: @"djeffe5763": @"05/07/2001":@"Jez"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Moriah": @"04/07/2002":@"Oranzo"]];
        [employees addObject:[FLXSEmployee createEmployee: @"UMAKANT": @"04/28/2005":@"Marzola"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Stefano": @"09/14/2003":@"Tenant"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Tomas": @"09/22/1997":@"Omrani"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Cordelia": @"08/05/2003":@"ORENTREICH"]];
        [employees addObject:[FLXSEmployee createEmployee: @"LaTonia": @"09/27/2005":@"Athar"]];
        [employees addObject:[FLXSEmployee createEmployee: @"DECATUR": @"11/10/2003":@"Economou"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Mostapha": @"07/06/1998":@"Osmani"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Minhui": @"08/31/2006":@"Iniguez"]];
        [employees addObject:[FLXSEmployee createEmployee: @"SHINSAENG": @"03/04/2009":@"Hirsche"]];
        [employees addObject:[FLXSEmployee createEmployee: @"CHRISTOPHE": @"06/29/2008":@"Hrusovsky"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Marygrace": @"02/23/2001":@"Armes"]];
        [employees addObject:[FLXSEmployee createEmployee: @"ZAIN": @"01/26/2002":@"AITON"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Ina": @"04/30/2008":@"Navar"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Camella": @"08/22/1996":@"Amsz"]];

        [employees addObject:[FLXSEmployee createEmployee: @"Sameera": @"06/17/2004":@"Ambhore"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Joy": @"12/05/1998":@"Oyler"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Venk": @"09/21/1996":@"Enrique"]];
        [employees addObject:[FLXSEmployee createEmployee: @"BAOKUN": @"08/03/1998":@"Aoshima"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Sachin": @"09/03/1996":@"Acree"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Merea": @"10/24/2004":@"Ereli"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Terasa": @"08/30/1998":@"Erstad"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Clare": @"05/30/2007":@"Lacquement"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Esseye": @"06/30/2000":@"SSRINIVASAN"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Viola": @"03/23/2005":@"Iovino"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Robertine": @"09/25/2000":@"Oberkfell"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Roshan": @"10/13/1997":@"Osinuga"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Pamuan": @"12/09/1997":@"Amico"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Bertine": @"11/29/1999":@"EROGLU"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Mozella": @"10/08/1998":@"Ozumba"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Tetsuya": @"04/06/1998":@"Etter"]];
        [employees addObject:[FLXSEmployee createEmployee: @"KLAAS": @"03/15/2004":@"LaMacchia"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Ilaha": @"09/06/2004":@"Lauzerique"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Julio": @"10/30/1998":@"Uluc"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Yamile": @"09/28/2003":@"Amey"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Subhabrato": @"01/13/2003":@"Uber"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Moti": @"01/18/2001":@"Oton"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Ronan": @"11/17/1996":@"Oniani"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Maple": @"07/27/2004":@"Apelewitch"]];
        [employees addObject:[FLXSEmployee createEmployee: @"LAZELL": @"07/22/2004":@"Azmi"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Norose": @"10/14/1997":@"OROURKE"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Demesha": @"05/10/1997":@"Emandi"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Carin": @"11/29/2004":@"Aranda"]];

        [employees addObject:[FLXSEmployee createEmployee: @"Emmet": @"12/12/2003":@"mmpark79"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Deuk": @"11/21/2007":@"Eustis"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Hangwoo": @"07/20/2004":@"and Berger"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Carol-Anne": @"08/11/1996":@"Arifin"]];
        [employees addObject:[FLXSEmployee createEmployee: @"ATEF": @"06/17/2005":@"test4"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Somsri": @"07/24/1999":@"Omwenga"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Bertina": @"06/09/2006":@"Erker"]];

        [employees addObject:[FLXSEmployee createEmployee: @"Wendolyne": @"12/28/2006":@"Ennist"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Minor": @"06/06/1997":@"Ingram"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Chacko": @"11/16/2007":@"Hatchel"]];

        [employees addObject:[FLXSEmployee createEmployee: @"Ramanarao": @"11/18/2006":@"Amy"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Francesca": @"03/30/2003":@"Rajca"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Hammond": @"05/27/1998":@"Amey"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Benda": @"09/02/2002":@"Enzenroth"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Laureen": @"11/18/2005":@"Auber"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Lias": @"02/21/1996":@"Iannotta"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Emile": @"03/31/1996":@"Mitsunari"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Valy": @"05/29/2001":@"ALBERENGA"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Hiroki": @"11/21/1996":@"Irvin"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Harpeet": @"06/21/2000":@"Areton"]];
        [employees addObject:[FLXSEmployee createEmployee: @"FAYEZ": @"05/03/2009":@"Aybar-Llenas"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Gerti": @"01/08/2007":@"Ernevad"]];

        [employees addObject:[FLXSEmployee createEmployee: @"LICHENG": @"05/08/2001":@"Ice"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Callecia": @"03/01/2004":@"Allveri"]];
        [employees addObject:[FLXSEmployee createEmployee: @"NAM": @"05/08/2007":@"Amorose"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Stamatina": @"12/31/2000":@"TALLAPRAGAD"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Lucile": @"08/05/2000":@"Ucles"]];

        [employees addObject:[FLXSEmployee createEmployee: @"Kaven": @"07/26/1999":@"Averbach"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Anisur": @"03/19/2008":@"Nicolau"]];
        [employees addObject:[FLXSEmployee createEmployee: @"UNA": @"12/27/1997":@"Naqvi"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Runelvys": @"01/02/2009":@"Understahl"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Kristelle": @"09/20/1999":@"Richards-Kortum"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Abolghasem": @"04/19/2007":@"Bool"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Chris": @"08/30/2007":@"Hriniak"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Chutuoc": @"03/29/2002":@"HUGUES"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Nettie": @"07/31/2000":@"Etten"]];

        [employees addObject:[FLXSEmployee createEmployee: @"Aswathy": @"05/28/1997":@"Swiech"]];

        [employees addObject:[FLXSEmployee createEmployee: @"Kourosh": @"10/03/2003":@"Ouchi"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Jenanne": @"06/16/1996":@"Engels-Churchill"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Darlan": @"07/05/2007":@"ARMATAS"]];
        [employees addObject:[FLXSEmployee createEmployee: @"NAFEESUNNISA": @"11/10/2005":@"Afflebach"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Candra": @"07/09/2004":@"Ansloan"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Seynabou": @"03/16/2001":@"Eyring"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Nicer": @"04/13/1996":@"Ickes"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Marini": @"05/17/2003":@"Arden"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Pussy": @"08/11/2001":@"USI"]];
        [employees addObject:[FLXSEmployee createEmployee: @"JUGAL": @"09/12/2002":@"Ugino"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Marketing": @"03/11/2000":@"Aresco"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Meenakshi": @"03/16/2006":@"Eells"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Basit": @"05/15/1996":@"Astorino"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Antonio": @"03/13/1996":@"Ntakirutimana"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Sean": @"05/24/2005":@"Eagles"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Maryse": @"02/14/2007":@"Archer"]];
        [employees addObject:[FLXSEmployee createEmployee: @"smc01": @"10/06/2005":@"McCandless"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Sabyasachi": @"07/14/2004":@"Abrazhevich"]];
        [employees addObject:[FLXSEmployee createEmployee: @"GIOVANNI": @"02/04/1998":@"Iosifides"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Lukeman": @"07/27/2005":@"Ukman"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Udell": @"06/13/2006":@"DEL VECCHIO"]];
        [employees addObject:[FLXSEmployee createEmployee: @"RASHIDA": @"07/12/2004":@"ASWAD"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Ivo": @"07/31/2008":@"Vohden"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Sugnana": @"03/03/2004":@"Ugalde"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Yuhong": @"07/16/2004":@"Uhlenkamp"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Pierre": @"12/22/2008":@"Iennaco"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Cyd": @"04/03/1996":@"Yde"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Sukumar": @"08/25/1997":@"Uku"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Pinfen": @"11/12/2007":@"Inami"]];
        [employees addObject:[FLXSEmployee createEmployee: @"LaCinda": @"06/01/2004":@"Accardo"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Yasukazu": @"08/05/2008":@"Ashman"]];
        [employees addObject:[FLXSEmployee createEmployee: @"THEMIS": @"04/17/2004":@"Heiser"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Jitender": @"03/17/2004":@"ITAKURA"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Tam": @"06/02/2001":@"Amble"]];
        [employees addObject:[FLXSEmployee createEmployee: @"JEETA": @"03/09/2008":@"Eells"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Wickey": @"04/13/2002":@"Ichinomiya"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Rajko": @"06/04/2009":@"Ajith"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Ranvir": @"07/07/1996":@"Antiuk"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Dror": @"09/03/2002":@"Rodriguez-Bernier"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Kamella": @"06/22/2002":@"Amier"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Mukul": @"01/05/2007":@"Ukpokodu"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Vaidhyanathan": @"11/05/1999":@"AIVAZIAN"]];
        [employees addObject:[FLXSEmployee createEmployee: @"JIAYUAN": @"12/16/2001":@"Iannello"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Curtice": @"04/06/2007":@"URBANCZYK"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Leven": @"03/23/1999":@"Eveland"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Cirrie": @"04/10/2009":@"Irby"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Eunis": @"02/08/2007":@"Underhill"]];
        [employees addObject:[FLXSEmployee createEmployee: @"ITI": @"01/20/2008":@"Tinklenberg"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Kayley": @"05/04/2000":@"Ayer"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Renetta": @"08/25/2005":@"Enyenihi"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Edyta": @"02/20/2007":@"Dyck"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Milana": @"09/22/2004":@"Iles"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Hui": @"06/06/2004":@"Uitz"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Shareen": @"11/12/1999":@"Harte"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Melgar": @"06/21/1998":@"Elsberg"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Abu": @"01/10/2004":@"Buggeln"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Lovissa": @"01/13/1999":@"Ovena"]];
        [employees addObject:[FLXSEmployee createEmployee: @"HanJu": @"06/16/1998":@"Andrieu"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Daman": @"07/09/2006":@"Amodio"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Orell": @"05/07/2002":@"Regis-Brito"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Moxie": @"12/02/2003":@"Oxciano"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Vik": @"08/26/2004":@"IKE"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Vaunceil": @"07/03/2001":@"Aumiller"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Liese": @"06/29/1999":@"Iek"]];

        [employees addObject:[FLXSEmployee createEmployee: @"Tirk": @"06/09/1997":@"Ireland"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Omiga": @"08/12/2009":@"Miksis"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Chiao": @"01/15/2005":@"Hiznay"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Takahito": @"05/26/2001":@"Akaike"]];
        [employees addObject:[FLXSEmployee createEmployee: @"JUNGJIN": @"03/16/2005":@"Unno"]];
        [employees addObject:[FLXSEmployee createEmployee: @"SAJAD": @"01/08/2003":@"Ajenstat"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Haifa": @"06/13/1996":@"AITON"]];


        [employees addObject:[FLXSEmployee createEmployee: @"Jianliang": @"04/07/2000":@"iavicoli"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Mohgan": @"09/01/2006":@"Ohrn-Hicks"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Yelena": @"05/08/2009":@"Elkhoury"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Rebeca": @"09/07/2005":@"Eberhart"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Gill": @"03/24/2007":@"ILER"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Regis": @"01/26/1998":@"Eggleton"]];
        [employees addObject:[FLXSEmployee createEmployee: @"PollyAnn": @"09/17/2005":@"Olguin"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Elliott": @"09/10/2001":@"Llyod"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Roxene": @"08/15/1998":@"Oxnevad"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Rufus": @"07/27/2006":@"UFFORD"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Rhiannon": @"03/25/1996":@"Higaki"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Kalpesh": @"03/03/2009":@"ALURI"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Elart": @"04/14/2009":@"Lacuesta"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Balasaheb": @"02/20/1996":@"Almus"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Tonmoy": @"06/10/1999":@"Ontiveros"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Efren": @"05/20/1999":@"Franzini"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Dragon": @"12/05/2003":@"Raghunandan"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Quinette": @"04/23/2003":@"Uittenbogaard"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Pedro": @"02/26/2006":@"Edmondson"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Loraine": @"06/08/2001":@"Orlando"]];
        [employees addObject:[FLXSEmployee createEmployee: @"BAZIEL": @"06/24/1999":@"Azeem"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Rechelle": @"02/03/2003":@"Eckhart"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Pinti": @"08/05/2003":@"Insley"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Candis": @"09/12/2004":@"Andrulewicz"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Derak": @"11/15/2004":@"Ertem"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Darcie": @"07/20/2006":@"Arslanian"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Enos": @"04/17/2004":@"Noreika"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Karin": @"04/10/2008":@"Armendariz"]];

        [employees addObject:[FLXSEmployee createEmployee: @"Hanu": @"12/11/2006":@"Andreoni"]];
        [employees addObject:[FLXSEmployee createEmployee: @"SANJA": @"02/24/2003":@"Andersson"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Vanburn": @"09/21/2009":@"Anliker"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Tiffanie": @"10/20/2000":@"Ifurung"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Gayle": @"03/10/1999":@"Ayer"]];
        [employees addObject:[FLXSEmployee createEmployee: @"RANJANI": @"06/04/2002":@"ANGELUCCI"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Cordula": @"10/06/2001":@"Ortmeier"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Mourad": @"08/28/1997":@"Ourtiague"]];
        [employees addObject:[FLXSEmployee createEmployee: @"ROITH": @"01/28/2005":@"Oishi"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Gerd": @"07/26/2009":@"Erstling"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Ogbonna": @"04/25/2001":@"Gbalekuma"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Weihua": @"06/11/2007":@"EIK"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Ralf": @"05/24/2005":@"Althouse"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Loann": @"10/05/2000":@"Oana"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Jayshree": @"06/04/1999":@"Ayatollahzadeh"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Natsumi": @"12/07/2003":@"Athota"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Deann": @"02/20/2001":@"Earls"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Barclay": @"01/19/1998":@"Arrabelli"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Asim": @"10/03/2005":@"Sider"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Eliyahy": @"07/24/2007":@"Lipon"]];


        [employees addObject:[FLXSEmployee createEmployee: @"Timothye": @"10/05/1997":@"Imburgia"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Mehdi": @"02/05/2008":@"Ehmen"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Tameka": @"08/24/2009":@"Amorim"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Leflora": @"11/28/2008":@"Efting"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Meeta": @"11/11/1997":@"Eechambadi"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Milham": @"03/14/1998":@"ILENE"]];

        [employees addObject:[FLXSEmployee createEmployee: @"Anex": @"01/21/1996":@"Nelson"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Kanitha": @"07/14/2002":@"Anstine"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Daykin": @"07/25/2008":@"Aybar-Llenas"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Wendi": @"10/11/2000":@"ENGEMAN"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Ulysses": @"12/12/2004":@"Lyle"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Dena": @"10/17/2001":@"Engelbrecht"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Dietrich": @"11/23/2002":@"Ierullo"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Malia": @"09/14/2008":@"Alessi"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Susheela": @"01/08/1999":@"Usedly"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Young-Gurl": @"11/17/2004":@"Ourtiague"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Adele": @"02/18/2000":@"Detrick"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Pao": @"08/04/2001":@"AONUMA"]];

        [employees addObject:[FLXSEmployee createEmployee: @"Mosen": @"06/17/1996":@"OSELLAME"]];
        [employees addObject:[FLXSEmployee createEmployee: @"WAHEED": @"01/03/2006":@"Ahlschwede"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Nanavaty": @"05/17/2000":@"Antonangeli"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Yuping": @"04/25/2001":@"Upadhyayula"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Lambertus": @"03/22/2007":@"Ameer"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Kanwal": @"03/21/2007":@"Ando"]];
        [employees addObject:[FLXSEmployee createEmployee: @"SHIGEYUKI": @"07/12/1996":@"Hitt"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Toyin": @"01/28/2006":@"Oyer"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Wenchin": @"02/18/2007":@"Engfer"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Heidi": @"03/18/2002":@"Eide"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Aurea": @"02/14/2007":@"Urso"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Bethanne": @"01/09/1997":@"Etie"]];



        [employees addObject:[FLXSEmployee createEmployee: @"Muftah": @"09/12/2008":@"UFRET"]];
        [employees addObject:[FLXSEmployee createEmployee: @"HIDEHIRO": @"09/23/2006":@"Idriss"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Isaiah": @"02/24/2003":@"Saurer"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Ailla": @"02/23/2000":@"Ilagan"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Nikhil": @"11/21/2001":@"IKEGAYA"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Gilberta": @"05/16/1998":@"ILANGO"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Hsuan": @"11/29/2002":@"Sussillo"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Pravee": @"08/28/2009":@"Rahn"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Shirlie": @"03/17/1996":@"Hinnergardt"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Roscoe": @"02/10/2002":@"Osterli"]];

        [employees addObject:[FLXSEmployee createEmployee: @"Kandan": @"06/04/2004":@"Annunziata"]];
        [employees addObject:[FLXSEmployee createEmployee: @"EDUVIGIS": @"05/26/2007":@"Dushey"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Sreekumar": @"02/22/2006":@"Reznikov"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Sang-Tack": @"04/03/1996":@"Anjanappa"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Margerete": @"07/28/2000":@"Arana"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Medhat": @"07/04/2000":@"EDNALDO"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Roann": @"10/05/2000":@"Oana"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Tyrus": @"10/06/1996":@"Yribarren"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Sharda": @"09/06/1997":@"Hannon"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Doo-Sung": @"07/17/2006":@"Oosterman"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Dilcia": @"02/14/2007":@"ILLURI"]];
        [employees addObject:[FLXSEmployee createEmployee: @"YASUNORI": @"03/22/1999":@"ashachauhan"]];

        [employees addObject:[FLXSEmployee createEmployee: @"Pascual": @"07/24/1998":@"Aspromonte"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Guruprasath": @"10/21/2006":@"UR REHMAN"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Branch": @"04/25/2001":@"Rapien"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Karilyn": @"04/09/2006":@"Arens"]];
        [employees addObject:[FLXSEmployee createEmployee: @"PRITH": @"03/24/2006":@"Riley-Nowlin"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Bao": @"05/27/2005":@"Aoe"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Syamala": @"03/03/2001":@"YASUNAGA"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Roanna": @"11/20/1998":@"Oakcrum"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Dustin": @"09/22/1999":@"Usowski"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Nathan": @"09/11/2008":@"Atwell"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Marshan": @"02/24/2003":@"ARGIZ"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Jonus": @"09/27/2008":@"Onodera"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Nick": @"08/13/2003":@"ICHIHARA"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Matty": @"01/14/2001":@"ATHY"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Bethan": @"03/07/2004":@"Etinoff-Gordon"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Uohn": @"09/10/2006":@"Ohrstrom"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Stanlee": @"12/11/1998":@"Taillon"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Loyce": @"06/06/2009":@"Oyenuga"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Yubin": @"10/14/2004":@"Ubieta"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Tarif": @"08/21/2002":@"Arnould"]];
        [employees addObject:[FLXSEmployee createEmployee: @"Hayden": @"11/09/2008":@"Ayer"]];
    }
	return employees;
}
@end

