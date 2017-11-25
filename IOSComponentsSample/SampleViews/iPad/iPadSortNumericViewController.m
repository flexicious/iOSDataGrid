//
//  iPadSortNumericViewController.m
//  IOSComponentsSample
//
//  Created by Flexicious-110 on 7/17/13.
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadSortNumericViewController.h"
#import "FLXSFlexiciousMockGenerator.h"

@interface iPadSortNumericViewController (){
    NSArray* sortNumeric_ArrCol;
}

@end

@implementation iPadSortNumericViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.flxsDataGrid.delegate = self;
       
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSSortNumeric"];
    [self initializeTitleOfToolBar:@"SortNumeric"];
    
    self.flxsDataGrid.dataProviderFLXS = [[FLXSFlexiciousMockGenerator instance] getFlatOrgList];
    NSString *jsonFilePath;
    jsonFilePath = [[NSBundle mainBundle] pathForResource:@"FLXSSortNumericData" ofType:@"json"];
    NSData *jsonFileData = [NSData dataWithContentsOfFile:jsonFilePath];
    NSError * error;
    id dic= [NSJSONSerialization JSONObjectWithData:jsonFileData options:NSJSONReadingMutableContainers error:&error];
    self.flxsDataGrid.dataProviderFLXS = [dic isKindOfClass:[NSArray class] ]?dic: ((NSDictionary *)dic).allValues;
}



- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [super viewDidUnload];
}
@end
