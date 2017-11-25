//
//  iPadVariableRowHeightViewController.m
//  IOSComponentsSample
//
//  Created by Flexicious-110 on 7/17/13.
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadVariableRowHeightViewController.h"
#import "FLXSFlexiciousMockGenerator.h"
#import "SampleXMLReader.h"

@interface iPadVariableRowHeightViewController ()

@end

@implementation iPadVariableRowHeightViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.flxsDataGrid.delegate = self;
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSVariableRowHeight"];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"FLXSBookData" ofType:@"xml"];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    NSError *error;
    NSDictionary *dic=[SampleXMLReader dictionaryForXMLData:fileData error:&error];
    self.flxsDataGrid.dataProviderFLXS = [((NSDictionary *)[dic objectForKey:@"root"]) objectForKey:@"book"];
}

- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [super viewDidUnload];
}
@end
