//
//  iPadDynamicGroupingViewController.m
//  IOSComponentsSample
//
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadDynamicGroupingViewController.h"
#import "FLXSBusinessService.h"

@interface iPadDynamicGroupingViewController ()
@end

@implementation iPadDynamicGroupingViewController

NSArray * flatResult;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.flxsDataGrid.delegate=self;
        
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSDynamicGrouping"];
    [self initializeTitleOfToolBar:@"Dynamic Grouping"];
   
    self.comboBox.dataFieldFLXS =@"dataFieldFLXS";
    self.comboBox.labelField=@"headerText";
    self.comboBox.addAllItem = NO;
    self.comboBox.dataProviderFLXS = [self getFiltered:self.flxsDataGrid.columns];
    self.comboBox.selectedIndex=0;
    
    [self.comboBox addEventListenerOfType:[FLXSComboBox EVENT_CHANGE] usingTarget:self withHandler:@selector(comboBox_ClickEvent:)];
    self.comboBox.selectedIndex=1;
    self.comboBox.text = @"State";
}
-(void)comboBox_ClickEvent:(NSNotification*)ns{
    FLXSComboBox* comboBox = (FLXSComboBox*)((FLXSEvent *) [ns.userInfo objectForKey:@"event"]).target;
    [self groupBy:comboBox.selectedValue];
}
-(void)dynamicGrouping_CreationComplete:(NSNotification*)ns
{
     [[FLXSBusinessService getInstance] getAllLineItems:@selector(getAllLineItems_result:) :self];
}
-(void)getAllLineItems_result:(NSArray*)result{
    flatResult = [result mutableCopy];
    self.flxsDataGrid.dataProviderFLXS =result;
    [self groupBy:@"invoice.deal.customer.headquarterAddress.state.name"];



}
//function that takes a flat collection and groups it on basis of the provided group field.
-(void)groupBy:(NSString*)prop
{
    NSMutableDictionary* buckets = [[NSMutableDictionary alloc]init];
    NSObject* key;
    NSMutableArray* result= [[NSMutableArray alloc] init];
    //iterate through the flat list and create a hierarchy
    for (NSObject* item in flatResult){
        key = [FLXSExtendedUIUtils resolveExpression:item expression:prop valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ];  //the parent
        if(key){
        if(![buckets objectForKey:key]){
            [buckets setObject:[[NSMutableArray alloc] init] forKey:[key description]]; //the children
        }
        NSMutableArray* temp = [buckets objectForKey:[key description]];
        [temp addObject:item];
        }
    }
    for (key  in buckets){
        NSMutableDictionary * record = [[NSMutableDictionary alloc] init];
        [record setObject:key forKey:@"name"];
        [record setObject:[buckets objectForKey:key] forKey:@"children"];
        [result addObject:record];

    }
    self.flxsDataGrid.dataProviderFLXS =result; //this will refresh the grid...
}
-(NSArray *)getFiltered:(NSArray *)arrayIn{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (FLXSFlexDataGridColumn * cl in arrayIn){
        if([cl.dataFieldFLXS rangeOfString:@"."].location!=NSNotFound){
            [arr addObject:cl];
        }
    }
    return arr;
}
- (IBAction)btn_group_clickHanler:(id)sender {

}

- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [self setIPadToolBar:nil];
    [self setComboBox:nil];
    [super viewDidUnload];
}
@end
