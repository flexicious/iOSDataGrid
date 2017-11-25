//
//  iPadVariableHeaderRowHeightViewController.m
//  IOSComponentsSample
//
//  Created by Flexicious-110 on 7/17/13.
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadVariableHeaderRowHeightViewController.h"

@interface iPadVariableHeaderRowHeightViewController (){
 }

@end

@implementation iPadVariableHeaderRowHeightViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.flxsDataGrid.delegate = self;
    [self initializeTitleOfToolBar:@"VariableHeaderRowHeight"];
    
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSVariableHeaderRowHeight"];

    NSString *jsonFilePath;
    jsonFilePath = [[NSBundle mainBundle] pathForResource:@"FLXSVariableHeaderRowHeightData" ofType:@"json"];
    NSData *jsonFileData = [NSData dataWithContentsOfFile:jsonFilePath];
    NSError * error;
    id dic= [NSJSONSerialization JSONObjectWithData:jsonFileData options:NSJSONReadingMutableContainers error:&error];
    self.flxsDataGrid.dataProviderFLXS = [dic isKindOfClass:[NSArray class] ]?dic: ((NSDictionary *)dic).allValues;

}

-(void)variableHeaderRowHeight_handleDoubleClick :(NSNotification*)ns {
}

- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [super viewDidUnload];
}
@end
