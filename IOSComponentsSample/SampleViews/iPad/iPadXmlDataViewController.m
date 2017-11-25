//
//  iPadXmlDataViewController.m
//  IOSComponentsSample
//
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadXmlDataViewController.h"
#import "SampleXMLReader.h"

@interface iPadXmlDataViewController ()

@end

@implementation iPadXmlDataViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.flxsDataGrid.delegate = self;
    NSString *filePath;
    NSData *fileData;
    
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSXmlData"];
    [self initializeTitleOfToolBar:@"Xml Data"];

    filePath = [[NSBundle mainBundle] pathForResource:@"FLXSBookData" ofType:@"xml"];
    fileData = [NSData dataWithContentsOfFile:filePath];
    NSError *error;
    NSDictionary *dic=[SampleXMLReader dictionaryForXMLData:fileData error:&error];
    self.flxsDataGrid.dataProviderFLXS = [((NSDictionary *)[dic objectForKey:@"root"]) objectForKey:@"book"];
}

//because XML is sending strings, we need to convert to date object for filter comparision.
-(NSDate*)XMLData_convertDate:(NSObject*)item :(FLXSFlexDataGridColumn*)col{

    NSString *dt = [FLXSExtendedUIUtils resolveExpression:item expression:col.dataFieldFLXS valueToApply:nil returnUndefinedIfPropertyNotFound:NO applyNullValues:NO ];
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
    formatter.dateFormat=@"YYYY-MM-DD";
    return [formatter dateFromString:[dt description]];
}
- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [self setIPadToolBar:nil];
    [super viewDidUnload];
}
@end
