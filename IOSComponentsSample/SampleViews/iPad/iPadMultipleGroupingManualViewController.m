//
//  iPadMutlipleGroupingManualViewController.m
//  IOSComponentsSample
//
//  Created by Flexicious-110 on 7/17/13.
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadMultipleGroupingManualViewController.h"


@interface iPadMultipleGroupingManualViewController (){
    NSArray*  multipleGrouping_Manual_dpFlat;

}

@end

@implementation iPadMultipleGroupingManualViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.flxsDataGrid.delegate = self;
   
    
    [self initializeTitleOfToolBar:@"MultipleGroupingManual"];
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSMultipleGroupingManual"];

}

-(void)multipleGrouping_Manual_CreationComplete:(NSNotification *)ns{
    NSString *jsonFilePath;
    jsonFilePath = [[NSBundle mainBundle] pathForResource:@"FLXSMultipleGroupingManualData" ofType:@"json"];
    NSData *jsonFileData = [NSData dataWithContentsOfFile:jsonFilePath];
    NSError * error;
    id dic= [NSJSONSerialization JSONObjectWithData:jsonFileData options:NSJSONReadingMutableContainers error:&error];
    multipleGrouping_Manual_dpFlat = [dic isKindOfClass:[NSArray class] ]?dic: ((NSDictionary *)dic).allValues;
    NSArray * regions = [self multipleGrouping_Manual_groupBy:multipleGrouping_Manual_dpFlat byProperty:@"Region" nullValue:@"(None)" filterFunction:nil additionalProperties:[[NSArray alloc] initWithObjects:@"RegionCode", nil] useOtherBucket:NO ];
    for(int i=0;i<regions.count;i++){
        NSMutableDictionary * region= [regions objectAtIndex:i];
        [region setObject:[self multipleGrouping_Manual_groupBy:[region objectForKey:@"children"] byProperty:@"Territory" nullValue:@"(None)" filterFunction:nil additionalProperties:[[NSArray alloc] initWithObjects:@"TerritoryCode", nil] useOtherBucket:NO ] forKey:@"children"];
    }
    self.flxsDataGrid.dataProviderFLXS = regions;
};

- (NSArray *)multipleGrouping_Manual_groupBy:(NSArray *)dp byProperty:(NSString *)prop nullValue:(NSString *)nullValue filterFunction:(NSString *)filterfunction additionalProperties:(NSArray *)additionalProperties useOtherBucket:(BOOL)useOtherBucket {

    if(!additionalProperties)additionalProperties= [[NSArray alloc] init];
    NSMutableDictionary * buckets = [[NSMutableDictionary alloc] init];
    NSString * key;
    NSMutableArray * result = [[NSMutableArray alloc] init];
    //iterate through the flat list and create a hierarchy
    if(useOtherBucket){
        [buckets setObject:[[NSMutableArray alloc] init]forKey:@"other"];
    }
    for(int i=0;i<dp.count;i++){
        NSObject * item= [dp objectAtIndex:i];
        key = [FLXSExtendedUIUtils resolveExpression:item expression:prop valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ];
        if(key==nil){
            key=@"null";
        }
        if(![buckets objectForKey:key]){
            //buckets[key] = [];//the children
            [buckets setObject:[[NSMutableArray alloc] init] forKey:key];
        }
        if(filterfunction==nil){
            [((NSMutableArray *)[buckets objectForKey:key]) addObject:item];
        }
        else if(useOtherBucket){
            [((NSMutableArray *)[buckets objectForKey:@"other"]) addObject:item];
        }
    }
    for (key  in buckets.allKeys){
        NSMutableDictionary * obj = [[NSMutableDictionary alloc] init];
        [obj setObject:[key isEqualToString:@"null"]?nullValue:key forKey:prop];
        [obj setObject:[buckets objectForKey:key] forKey:@"children"];
        NSArray * arr = [buckets objectForKey:key];
        if(arr.count>0){
            for(int j=0;j<additionalProperties.count;j++){
                NSString * addProp=additionalProperties[j];
                obj[addProp] = buckets[key][0][addProp];
                [obj setObject:[((NSDictionary *)[arr objectAtIndex:0]) objectForKey:addProp] forKey:additionalProperties];
            }
        }
        [result addObject:obj];
    }
    return result; //this will refresh the grid...

};


- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [super viewDidUnload];
}
@end
