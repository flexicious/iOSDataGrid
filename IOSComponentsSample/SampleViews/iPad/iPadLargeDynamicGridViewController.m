//
//  iPadLargeDynamicGridViewController.m
//  IOSComponentsSample
//
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadLargeDynamicGridViewController.h"
#import "FLXSDemoVersion.h"
#import "SampleUIUtils.h"
#import "FLXSFlexiciousMockGenerator.h"

@interface iPadLargeDynamicGridViewController (){

    NSArray* colors;
    NSNumberFormatter* numberFormatter;
    int colCount;
    int rowCount;
}

@end

@interface MakeModel : NSObject
@property (nonatomic,strong)NSString* make;
@property (nonatomic,strong)NSArray* models;
@property (nonatomic,strong)NSMutableArray* children;
-(id) initWithMake:(NSString*)make andModel:(NSArray*)models;

@end
@implementation MakeModel
@synthesize make;
@synthesize models;
-(id) initWithMake:(NSString*)makeIn andModel:(NSArray*)modelsIn{
    self = [super init];
    if(self){
        self.make = makeIn;
        self.models=modelsIn;
    }
    return self;
}

@end



@implementation iPadLargeDynamicGridViewController
NSArray* makeModels=nil;


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initializeTitleOfToolBar:@"Large DynamicGrid"];
    // Do any additional setup after loading the view from its nib.
    colors=[[NSArray alloc] initWithObjects:@"Red" ,@"Yellow",@"Silver",@"Green",@"Tan",@"White",@"Blue",@"Burgundy",@"Black",@"Orange", nil];
    numberFormatter = [[NSNumberFormatter alloc] init];
    colCount=0;
    rowCount=0;
    MakeModel * toyota = [[MakeModel alloc] initWithMake:@"Toyota" andModel: [[NSArray alloc] initWithObjects:@"4Runner",@"Avalon",@"Camry",@"Celica",@"Corolla",@"Corona",@"Cressida",@"Echo",@"FJ Cruiser",@"Highlander",@"Land Cruiser",@"MR2",@"Matrix",@"Paseo",@"Pickup",@"Previa",@"Prius",@"RAV4",@"Seqouia",@"Sienna",@"Solara",@"Supra", nil]];
    MakeModel * lexus =  [[MakeModel alloc] initWithMake:@"Lexus" andModel:[[NSArray alloc] initWithObjects:@"CT",@"ES250",@"ES300",@"ES330",@"ES350",@"GS300",@"GS350",@"GS400",@"GS430",@"GS460",@"GX460",@"GX470", nil]];
    MakeModel * honda = [[MakeModel alloc] initWithMake:@"Honda" andModel:[[NSArray alloc] initWithObjects:@"Accord",@"CRV",@"CRX",@"Civic",@"Del Sol",@"Element",@"Fit",@"Insight",@"Odyssey",@"Passport",@"Pilot",@"Prelude",@"S2000", nil]];
    MakeModel * acura =  [[MakeModel alloc] initWithMake:@"Acura" andModel:[[NSArray alloc] initWithObjects:@"Integra",@"Legend",@"MDX",@"NSX",@"RDX",@"RSX",@"SLX",@"3.2TL",@"2.5TL",@"Vigor",@"ZDX", nil]];
    MakeModel * nissan = [[MakeModel alloc] initWithMake:@"Nissan" andModel:[[NSArray alloc]initWithObjects:@"200SX",@"240SX",@"300ZX",@"350Z",@"370Z",@"Altima",@"Armada",@"Cube",@"Frontier",@"GT-R",@"Juke",@"Leaf",@"Maxima",@"Murano",@"NX",@"PathFinder",@"Pickup",@"Pulsar",@"Quest", nil]];
    MakeModel * infiniti = [[MakeModel alloc] initWithMake:@"Infiniti" andModel:[[NSArray alloc]initWithObjects:@"EX35",@"FX35",@"FX45",@"G20",@"G25",@"G35",@"I30",@"I35",@"J30",@"M30", nil]];

    makeModels = [[NSArray alloc ] initWithObjects: toyota, lexus, honda, acura,nissan,infiniti,nil];
    self.flxsDataGrid.delegate=self;
    self.flxsDataGrid.preferencePersistenceKey=@"largeDynamicGrid";
    [self buildGrid];

}


-(void)buildGrid
{
    
    numberFormatter.minimumFractionDigits=0;
    colCount=0;
    NSMutableArray* dp = [[NSMutableArray alloc] init];
    NSMutableArray* gridCgs = [[NSMutableArray alloc] init];
    NSMutableArray*  allCols = [[NSMutableArray alloc] init];
    FLXSFlexDataGridColumn* mCol= [[FLXSFlexDataGridColumn alloc] init];
    mCol.headerText = @"Make";
    mCol.dataFieldFLXS = @"make";
    mCol.width=100;
    mCol.columnLockMode=@"left";
    [gridCgs addObject:mCol];
   
    mCol = [[FLXSFlexDataGridColumn alloc] init];
    mCol.headerText = @"Model";
    mCol.dataFieldFLXS = @"model";
    mCol.width=100;
    mCol.columnLockMode=@"left";
    [gridCgs addObject:mCol];
    mCol = [[FLXSFlexDataGridColumn alloc] init];
    mCol.headerText = @"Color";
    mCol.dataFieldFLXS = @"color";
    mCol.width=100;
    mCol.columnLockMode=@"left";
    [gridCgs addObject:mCol];
    for (MakeModel* mt in makeModels){
        NSMutableDictionary * mk = [[NSMutableDictionary alloc] init];
        [dp addObject:mk];
        [mk setObject:mt.make forKey:@"make"];
        NSMutableArray * children = [[NSMutableArray alloc]init];
        [mk setObject:children forKey:@"children"];
        for (NSString*  mod in mt.models){
            NSMutableDictionary * modDic = [[NSMutableDictionary alloc] init];
            [modDic setObject:mod forKey:@"model"];
            [children addObject:modDic];
        }
   }
    for(int i=2000;i<=2012;i++){
        
        FLXSFlexDataGridColumnGroup *ycg = [[FLXSFlexDataGridColumnGroup alloc] init];
        [gridCgs insertObject:ycg atIndex:0];
        ycg.enableExpandCollapse=true;
        ycg.headerText = [NSString stringWithFormat:@"%d", i];
        for (int j=1;j<=4;j++){
            FLXSFlexDataGridColumnGroup  *qcg = [[FLXSFlexDataGridColumnGroup alloc] init];
            [ycg.columnGroups insertObject:qcg atIndex:0];
            qcg.enableExpandCollapse=true;
            qcg.headerText = [ycg.headerText stringByAppendingFormat:@"-Q\t%d",j];
            NSMutableArray* qCols = [[NSMutableArray alloc] init];
            for(NSString* month in [self getMonths:j ]){
                mCol = [[FLXSFlexDataGridColumn alloc] init];
                mCol.headerText = [ycg.headerText stringByAppendingFormat:@"\t%@ " , month];
                mCol.dataFieldFLXS =[ qcg.headerText  stringByAppendingFormat:@"%@%@" ,ycg.headerText ,month];
                mCol.footerOperation = @"sum";
                mCol.footerAlign=NSTextAlignmentRight;
                mCol.editable=true;
                //mCol.isEditableFunction=[ NSString stringWithFormat:@"%c",[self  isEditable:mCol]];
                mCol.footerFormatter = numberFormatter;
                mCol.labelFunction = @"dataGridFormatNumberLabelFunction";
                //mCol.useHandCursor = true
                mCol.footerOperationPrecision = 0;
                mCol.width=90;
                [mCol setStyle:@"textAlign" :@"right" ];
                [qCols insertObject:mCol atIndex:0];
                [allCols insertObject:mCol atIndex:0];
                colCount++;
            }
            qcg.columns=qCols;
        }
    }
    
    for (NSDictionary* dpItem in dp){
        for (NSMutableDictionary* model in [dpItem objectForKey:@"children"]){
            NSMutableArray* modelChildren = [[NSMutableArray alloc] init];
            [model setObject:modelChildren forKey:@"children"];
            for (NSString* cl in colors){
                NSMutableDictionary * colorDic = [[NSMutableDictionary alloc]init];
                [colorDic setObject:cl forKey:@"color"];
                [modelChildren addObject: colorDic];
                for(mCol in allCols){
                    [colorDic setObject:[NSNumber numberWithFloat:[FLXSFlexiciousMockGenerator getRandom:100 :1000]] forKey:mCol.dataFieldFLXS];
                }
                rowCount++;
            }
        }
    }
    for (mCol in allCols){
        for (NSMutableDictionary * dpItem in dp){
            float total=0;
            for (NSMutableDictionary * model in [dpItem objectForKey:@"children"]){
                float modeltotal=0;
                for ( NSMutableDictionary* color in [model objectForKey:@"children"]){
                    modeltotal+= [[color objectForKey:mCol.dataFieldFLXS] floatValue];
                }
                [model setObject:[NSNumber numberWithFloat:modeltotal] forKey:mCol.dataFieldFLXS];
                total+=modeltotal;
            }
            [dpItem setObject:[NSNumber numberWithFloat:total] forKey:mCol.dataFieldFLXS];
        }
    }
    self.flxsDataGrid.columnLevel.groupedColumns = gridCgs;
    self.flxsDataGrid.columnLevel.childrenField=@"children";
    self.flxsDataGrid.columnLevel.nextLevel =[[FLXSFlexDataGridColumnLevel alloc]init];
    self.flxsDataGrid.columnLevel.nextLevel.reusePreviousLevelColumns=true;
    self.flxsDataGrid.columnLevel.nextLevel.childrenField=@"children";
    self.flxsDataGrid.columnLevel.nextLevel.nextLevel = [[FLXSFlexDataGridColumnLevel alloc]init];
    self.flxsDataGrid.columnLevel.nextLevel.nextLevel.reusePreviousLevelColumns=true;
    self.flxsDataGrid.dataProviderFLXS =dp;
}

-(BOOL)isEditable:(UIView<FLXSIFlexDataGridDataCell>*)cell{
    return (cell.level.nestDepth==3);
}
-(NSArray*) getMonths:(int)j
{
    if(j==1){
        return [[NSArray alloc] initWithObjects:@"Jan", @"Feb", @"Mar",nil];
    }else if(j==2){
        return [[NSArray alloc] initWithObjects:@"Apr", @"May", @"June", nil];
    }else if(j==3){
        return [[NSArray alloc]initWithObjects:@"Jul", @"Aug", @"Sep",nil];
    }else if(j==4){
        return [[NSArray alloc]initWithObjects:@"Oct", @"Nov", @"Dec",nil];
    }
    return [[NSArray alloc]init];
}
-(NSString*)dataGridFormatNumberLabelFunction:(NSDictionary*)item :(FLXSFlexDataGridColumn*)dgColumn
{
    NSObject * result= [item objectForKey:dgColumn.dataFieldFLXS];
    if([result isKindOfClass:[NSNumber class] ]){
        return [SampleUIUtils formatCurrency:[((NSNumber *) result) floatValue]];
    }
    else
    return [[item objectForKey:dgColumn.dataFieldFLXS] description];
}

-(NSString*)formatCurrency:(NSNumber*)number :(NSString*)param1
{
    return [SampleUIUtils formatCurrency:[number floatValue]];
}

- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [self setIPadToolBar:nil];
    [super viewDidUnload];
}
@end
