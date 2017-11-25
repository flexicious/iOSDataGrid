//
//  iPadOnlyOneItemOpenViewController.m
//  IOSComponentsSample
//
//  Created by Flexicious-110 on 7/17/13.
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadOnlyOneItemOpenViewController.h"
#import "SampleXMLReader.h"

@interface iPadOnlyOneItemOpenViewController ()

@end

@implementation iPadOnlyOneItemOpenViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.flxsDataGrid.delegate = self;
    NSString *filePath;
    filePath = [[NSBundle mainBundle] pathForResource:@"FLXSOnlyOneItemOpen" ofType:@"xml"];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    [self.flxsDataGrid buildFromXML:fileData];

    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSOnlyOneItemOpen"];
    [self initializeTitleOfToolBar:@"OnlyOneItemOpen"];

    filePath = [[NSBundle mainBundle] pathForResource:@"FLXSXMLGroupedDataXmlData" ofType:@"xml"];
    fileData = [NSData dataWithContentsOfFile:filePath];
    NSError *error;
    NSDictionary *dic=[SampleXMLReader dictionaryForXMLData:fileData error:&error];
    dic=[dic.allValues objectAtIndex:0];
    self.flxsDataGrid.dataProviderFLXS = [dic.allValues objectAtIndex:0];

}
-(void)onlyOneItemOpen_itemOpeningHandler:(NSNotification*)ns{
    FLXSFlexDataGridEvent *evt = [ns.userInfo objectForKey:@"event"];
    [evt preventDefault];
    NSMutableArray * itemsToRemove= [[NSMutableArray alloc] init];
    NSArray* items= [self.flxsDataGrid getOpenObjects];
    for(int i=0;i<items.count;i++){
        NSObject * openItem= [items objectAtIndex:i];
        //need to ensure we do not close our own parent
        if([self onlyOneItemOpen_existsInParentHierarchy:openItem:evt.item]){
            continue;
        }else{
            [itemsToRemove addObject:openItem];
        }
    }
    //remove all open items except our ancestors
    for(int j=0;j<itemsToRemove.count;j++){
        NSObject * itemToRemove= [itemsToRemove objectAtIndex:j];
        [self.flxsDataGrid.openItems removeObjectAtIndex:[self.flxsDataGrid.openItems indexOfObject:itemToRemove]];
    }
    //add ourselves
    [self.flxsDataGrid.openItems addObject:evt.item];
    [self.flxsDataGrid rebuildBody:NO];
    
}
 -(BOOL)onlyOneItemOpen_existsInParentHierarchy:(NSObject *)openItem :(NSObject *)item{

    if(item==openItem){
        return YES;
    }
     NSObject *parent = [self.flxsDataGrid getParent:item level:self.flxsDataGrid.columnLevel];
    if(parent){
        return [self onlyOneItemOpen_existsInParentHierarchy : openItem :parent]; //since this is xml, we are using item.getParent(). We could also use grid.getParent(item) for non-lazy loaded grids.
    }
    return NO;
}


- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [super viewDidUnload];
}
@end
