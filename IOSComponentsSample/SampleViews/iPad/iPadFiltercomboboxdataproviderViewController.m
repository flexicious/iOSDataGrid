//
//  iPadFiltercomboboxdataproviderViewController.m
//  IOSComponentsSample
//
//  Created by Flexicious-110 on 7/17/13.
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadFiltercomboboxdataproviderViewController.h"


@interface iPadFiltercomboboxdataproviderViewController (){
    NSArray* filterComboboxDataprovider_ArrCol;
}

@end

@implementation iPadFiltercomboboxdataproviderViewController



- (void)viewDidLoad
{
     [super viewDidLoad];
    self.flxsDataGrid.delegate = self;
    NSString *filePath;
    filePath = [[NSBundle mainBundle] pathForResource:@"FLXSFilterComboBoxDataProvider" ofType:@"xml"];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    [self.flxsDataGrid buildFromXML:fileData];
    NSString *jsonFilePath;
    jsonFilePath = [[NSBundle mainBundle] pathForResource:@"FLXSFilterComboBoxDataProviderData" ofType:@"json"];
    NSData *jsonFileData = [NSData dataWithContentsOfFile:jsonFilePath];
    NSError * error;
    id dic= [NSJSONSerialization JSONObjectWithData:jsonFileData options:NSJSONReadingMutableContainers error:&error];
    filterComboboxDataprovider_ArrCol = [dic isKindOfClass:[NSArray class] ]?dic: ((NSDictionary *)dic).allValues;
    self.flxsDataGrid.dataProviderFLXS = filterComboboxDataprovider_ArrCol;
}

-(void)filterComboboxDataprovider_creationCompleteHandler:(NSNotification*)ns{
    [self filterComboboxDataprovider_loadFilters];
};
-(void)filterComboboxDataprovider_loadFilters{
    NSArray *filteredArray = [FLXSExtendedUIUtils filterArray:filterComboboxDataprovider_ArrCol filter:[self.flxsDataGrid createFilter] grid:self.flxsDataGrid level:self.flxsDataGrid.columnLevel hideIfNoChildren:NO ];
    FLXSFlexDataGridColumn * stateCol= [self.flxsDataGrid getColumnByDataField:@"state"];
    stateCol.filterComboBoxDataProvider = [stateCol getDistinctValues:filteredArray collection:nil addedCodes:nil level:nil ];
    [self.flxsDataGrid rebuildFilter];
};

-(void)filterComboboxDataprovider_filterPageSortChangeHandler:(NSNotification*)ns{
    [self filterComboboxDataprovider_loadFilters];
};



- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [super viewDidUnload];
}
@end
