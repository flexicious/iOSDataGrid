//
//  iPadXmlGroupedDataViewController.m
//  IOSComponentsSample
//
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadXmlGroupedDataViewController.h"
#import "SampleUIUtils.h"
#import "SampleXMLReader.h"


@interface iPadXmlGroupedDataViewController ()

@end

@implementation iPadXmlGroupedDataViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.flxsDataGrid.delegate = self;
    NSString *filePath;
    NSData *fileData ;

    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSXmlGroupedData"];
    [self initializeTitleOfToolBar:@"Xml GroupedData"];
    
    filePath = [[NSBundle mainBundle] pathForResource:@"FLXSXMLGroupedDataXmlData" ofType:@"xml"];
    fileData = [NSData dataWithContentsOfFile:filePath];
    NSError *error;
    NSDictionary *dic=[SampleXMLReader dictionaryForXMLData:fileData error:&error];
    dic=[dic.allValues objectAtIndex:0];

    self.flxsDataGrid.dataProviderFLXS = [dic.allValues objectAtIndex:0];
}
-(void)hbox1_creationCompleteHandler:(NSNotification*)ns
{
    
}
-(NSString*)XMLGroupedData_getDataValue:(NSObject*)item :(FLXSFlexDataGridColumn*)col :(UIView<FLXSIFlexDataGridCell>*)cell{
    NSObject *val;
    int nestDepth=cell.level.nestDepth;
    
    if(nestDepth==3){
        val= [FLXSExtendedUIUtils resolveExpression:item expression:col.dataFieldFLXS valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ];
        return val?[SampleUIUtils formatCurrency:[[val description] floatValue]]:@"";
    }
    return [self getTotal:item :nestDepth + 1 :col.dataFieldFLXS :NO];
}
-(NSString*)XMLGroupedData_getFooter:(FLXSFlexDataGridFooterCell*)cell{
    NSObject* val=cell.rowInfo.data;
    return [self getTotal:val :cell.level.nestDepth :cell.columnFLXS.dataFieldFLXS :YES];
}
-(id)getTotal:(NSObject*)val :(int)nestDepth :(NSString*)dataField :(BOOL)usePrefix{
    NSMutableArray* arr=[[NSMutableArray alloc] init];
    NSString* lbl=@"";
    NSDictionary *regionGroup;
    NSDictionary *region;
    NSDictionary *rep;
    NSDictionary * valDic = [val isKindOfClass:[NSDictionary class]]?(NSDictionary *)val:nil;
    if([val isKindOfClass:[NSArray class]]){
        //the top level footers converts the root to a flat array.
        for ( regionGroup  in ((NSArray *)val)){
            for( region  in [regionGroup objectForKey:@"children"]){
                for ( rep  in [region  objectForKey:@"children"]){
                    //arr addObject {"value":rep[dataFieldFLXS]});
                    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
                    [dic setObject:[rep objectForKey:dataField] forKey:@"value"];
                    [arr addObject: dic];
                }
            }
        }
    }
    else if(nestDepth==1){
        for ( regionGroup  in [valDic objectForKey:@"children"]){
            for ( region  in [regionGroup objectForKey:@"Region"]){
                for ( rep  in [region objectForKey:@"Territory_Rep"]){
                    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
                    [dic setObject:[rep objectForKey:dataField] forKey:@"value"];
                    [arr addObject: dic];
                }
            }
        }
    }
    else if(nestDepth==2){
        for (NSDictionary * region1 in [valDic objectForKey:@"Region"]){
            for (NSDictionary * rep1 in [region1 objectForKey:@"Territory_Rep"]){
                NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
                [dic setObject:[rep1 objectForKey:dataField] forKey:@"value"];
                [arr addObject: dic];
            }
        }
        lbl=@"Region ";
    }
    else if(nestDepth==3){
        for (NSDictionary * rep2 in [val valueForKey:@"Territory_Rep"]){
         NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[rep2 objectForKey:dataField] forKey:@"value"];
        [arr addObject: dic];
    }
        lbl=@"State ";
    }
    return [(usePrefix?[lbl stringByAppendingString:@"Sum:"]:@"") stringByAppendingString:[SampleUIUtils formatCurrency:[FLXSUIUtils sum:arr fld:@"value"]]];
 }
- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [self setIPadToolBar:nil];
    [super viewDidUnload];
}
@end
