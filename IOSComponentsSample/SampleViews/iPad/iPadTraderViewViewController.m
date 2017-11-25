//
//  iPadTraderViewViewController.m
//  IOSComponentsSample
//
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadTraderViewViewController.h"
#import "FLXSFlexiciousMockGenerator.h"
#import "FLXSDemoVersion.h"

@interface StockTicker : NSObject

@property (nonatomic,assign) int ident;
@property (nonatomic,strong) NSString* ticker;
@property (nonatomic, strong) NSString* name;
@property (nonatomic,assign) float last;
@property (nonatomic,assign) float change;
@property (nonatomic,assign) BOOL tickUp;
-(id) initWithIdent: (int)ident :(NSString*)ticker :(NSString*)name :(float)last :(float)change :(BOOL)tickup;
@end

@implementation StockTicker 
@synthesize ident;
@synthesize ticker;
@synthesize name;
@synthesize last;
@synthesize change;
@synthesize tickUp;

-(id) initWithIdent:(int)ident1 :(NSString *)ticker1 :(NSString *)name1 :(float)last1 :(float)change1 :(BOOL)tickup1{
    self = [super init];
    if (self) {
        self.ident = ident1;
        self.ticker = ticker1;
        self.name = name1;
        self.last = last1;
        self.change = change1;
        self.tickUp = tickup1;
    }
    return  self;
}


@end
@interface iPadTraderViewViewController (){
    int repeatRate;
    NSTimer* timer;
    NSMutableArray* stocks;
    
}

@end

@implementation iPadTraderViewViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    repeatRate = 12;
    timer = nil;
    stocks = [[NSMutableArray alloc] init];
    self.flxsDataGrid.delegate=self;
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSTraderView"];
    [self initializeTitleOfToolBar:@"TraderView"];

}

-(void)initializeDataGrid
{
    for (int i=0;i<10000;i++){
        int chg=[FLXSFlexiciousMockGenerator getRandom:-10 :10];
        [stocks addObject:[[StockTicker alloc] initWithIdent:i :@"TICK" :[NSString stringWithFormat:@"Ticker with symbol\t %d",i] :[FLXSFlexiciousMockGenerator getRandom:20 :30] :[[NSString stringWithFormat:@"%d\t%%",chg] floatValue] :(chg>0)]];
    }
    [stocks sortUsingSelector:NSSelectorFromString(@"ident")];
    self .flxsDataGrid.dataProviderFLXS =stocks;
}

-(void) toggleTimer:(NSNotification*)ns
{
    if (!timer)
    {
         timer = [NSTimer scheduledTimerWithTimeInterval:1/repeatRate target:self selector:@selector(updateTimerHandler)
                                         userInfo:nil repeats:YES];

    }
    else{
        [timer invalidate];
        timer=nil;
    }
}
-(void) updateTimerHandler
{

    //when this happens, we get a batch from the server that says tickers with XX ids have
    //new values...
    NSMutableArray* affectedItems = [[NSMutableArray alloc]init];
    //we just randomly update some 25 items out of the 100.
    for(int i=0;i<250;i++){
        int random=[FLXSFlexiciousMockGenerator getRandom: 0 :(int)([self.flxsDataGrid.dataProviderFLXS count]-1)];
        
        int chg =[FLXSFlexiciousMockGenerator getRandom:-10 :10];
        StockTicker* temp =(StockTicker*) [self.flxsDataGrid.dataProviderFLXS objectAtIndex:random];
        temp.last = [FLXSFlexiciousMockGenerator getRandom:20 :30];
        temp.change = chg;
        temp.tickUp = chg>0;
        [affectedItems insertObject:temp atIndex:0];
        ((StockTicker*)[self.flxsDataGrid.dataProviderFLXS objectAtIndex:random]).last= [FLXSFlexiciousMockGenerator getRandom:20 :30];
                ((StockTicker*)[self.flxsDataGrid.dataProviderFLXS objectAtIndex:random]).change=chg;
        ((StockTicker*)[self.flxsDataGrid.dataProviderFLXS objectAtIndex:random]).tickUp=chg>0;
        [affectedItems addObject:([self.flxsDataGrid.dataProviderFLXS objectAtIndex:random])];
    }
    
    //now the key here is to only update the cells that are affected.
    //this means we navigate to the row, get the affected cell, and invalidate it...
    //we go through the affectedItems, but keep in mind not all of the
    //affectedItems could be in view. So we check to see if anything is
    //drawn and if something is drawn, only then refresh it...
    
    for (StockTicker* item in affectedItems){
        //now there is a function call - getCellByRowColumn on the grid.
        //that will quickly get you the cell to update. but in this case
        //since we are updating multiple cells in each row, we will just
        //get the row to update and use its cells collection to quickly
        //update them
        
        for (FLXSRowInfo* row in self.flxsDataGrid.bodyContainer.rows){
            if(row.data==item){
                [[[row.cells objectAtIndex:2] component] refreshCell];
                [[[row.cells objectAtIndex:3] component] refreshCell];
               
            }
        }
    }
}

-(UIColor *)TraderView_getCellTextColor:(UIView<FLXSIFlexDataGridCell>*)cell{
    if(((StockTicker*)cell.rowInfo.data).tickUp)
        return [[FLXSStyleManager instance]getUIColorObjectFromHexString: 0x000000 ];
    else
        return [[FLXSStyleManager instance]getUIColorObjectFromHexString: 0xFFFFFF ];
}
-(UIColor *)TraderView_getCellBackgroundColor:(UIView<FLXSIFlexDataGridCell>*)cell{
    if(((StockTicker*)cell.rowInfo.data).tickUp)
        return [[FLXSStyleManager instance]getUIColorObjectFromHexString: 0x00FF00 ];
    else
    return [[FLXSStyleManager instance]getUIColorObjectFromHexString: 0xFF0000 ];
}
- (IBAction)toggleSwitch_ClickEvent:(id)sender {
    UITextField* tf=(UITextField*)sender;
    if (tf != nil && tf.tag == 3) {
        repeatRate = [tf.text intValue];
    }
}
- (IBAction)toggleSwitch_ValueChangedEvent:(id)sender {
    [self toggleTimer:nil];
}
- (IBAction)stepperValueChangedHandler:(id)sender {
}
-(void)tradingView_CreationComplete:(NSNotification *)ns{
    [self initializeDataGrid];
}
- (IBAction)textField_valueChangedHanlder:(id)sender {
    
}
- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [self setIPadToolBar:nil];
    [self setSwitch_start:nil];
    [self setTextField:nil];
    [self setStepper:nil];
    [super viewDidUnload];
}
@end
