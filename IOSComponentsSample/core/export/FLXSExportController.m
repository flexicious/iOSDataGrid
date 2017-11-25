#import "FLXSExportController.h"
#import "FLXSExportEvent.h"
#import "FLXSCsvExporter.h"
#import "FLXSExcelExporter.h"
#import "FLXSFlexDataGridColumn.h"
#import "FLXSLabelData.h"
#import "UIViewController+UIViewControllerAdditions.h"
#import "FLXSCloseEvent.h"
#import "FLXSPrintExportFilter.h"
#import "FLXSPrintExportDataRequestEvent.h"

@implementation FLXSExportController {

 }

@synthesize exportOptions = _exportOptions;
@synthesize grid = _grid;

+(FLXSExportController*)instance
{
	//return _instance;
    return nil;
}

-(id)init
{
	self = [super init];
	if (self)
	{
	}
	return self;
}


- (void)export:(FLXSFlexDataGrid *)grid exportOptions:(FLXSExportOptions *)exportOptions {
	if (!exportOptions)
		exportOptions=[[FLXSExportOptions alloc] init];
	[exportOptions.availableColumns removeAllObjects];
	[exportOptions.columnsToExport removeAllObjects];
	exportOptions.printExportParameters=grid.printExportParameters;
	exportOptions.grid=grid;
	if(exportOptions.grid)
	{
		FLXSExportEvent* expEvent = [[FLXSExportEvent alloc] initWithType:[FLXSExportEvent BEFORE_EXPORT]];
		expEvent.exportOptions=exportOptions;
		[exportOptions.grid dispatchEvent:expEvent];
	}
	return [self exportWithOptions:grid exportOptions:exportOptions];

}

- (void)exportWithOptions:(FLXSFlexDataGrid *)grid exportOptions:(FLXSExportOptions *)exportOptions {
	_exportOptions=exportOptions;
	_grid=grid;
	[exportOptions.availableColumns removeAllObjects];
	FLXSExporter* exporter;
	int expIndex;
	if(exportOptions.useExcelExporter)
	{
		for( exporter in exportOptions.exporters)
		{
			if([exporter isKindOfClass:[FLXSCsvExporter class]])
			{
				expIndex=(int)[exportOptions.exporters indexOfObject:exporter];
				[exportOptions.exporters replaceObjectAtIndex:expIndex withObject:[[FLXSExcelExporter alloc] init]];
                if([exportOptions.exporter isKindOfClass:[FLXSCsvExporter class]])
					exportOptions.exporter=exportOptions.exporters[expIndex];
				break;
			}
		}
	}
	if(grid.nativeExcelExporter !=nil)
	{
		for( exporter in exportOptions.exporters)
		{
            if([exporter isKindOfClass:[FLXSCsvExporter class]])
			{
                expIndex=(int)[exportOptions.exporters indexOfObject:exporter];
				[exportOptions.exporters replaceObjectAtIndex:expIndex withObject:grid.nativeExcelExporter];

                if([exporter isKindOfClass:[FLXSCsvExporter class]])
					exportOptions.exporter=exportOptions.exporters[expIndex];
				break;
			}
		}
	}
	int colIndex=0;
	NSString* colLabel;
	for(FLXSFlexDataGridColumn* col in [grid getExportableColumns:exportOptions])
	{
		colLabel= [FLXSExporter getColumnHeader:col colIndex:(colIndex++)];
        FLXSLabelData * lblData = [[FLXSLabelData alloc] init];
        lblData.name = col.uniqueIdentifier;
        lblData.label = colLabel;
        [exportOptions.availableColumns addObject:lblData];

	}
	if(exportOptions.hideHiddenColumns)
	{
		colIndex=0;
        for(FLXSFlexDataGridColumn* col in [grid getExportableColumns:exportOptions])
		{
			if(col.visible)
			{
				colLabel= [FLXSExporter getColumnHeader:col colIndex:(colIndex++)];
                FLXSLabelData * lblData = [[FLXSLabelData alloc] init];
                lblData.name = col.uniqueIdentifier;
                lblData.label = colLabel;
				[exportOptions.columnsToExport addObject:lblData];
			}
		}
	}
	if(exportOptions.showColumnPicker)
	{
		UIViewController* exportOptionsViewController=[exportOptions.exportOptionsRenderer generateInstance];
		exportOptions.exportOptionsView = exportOptionsViewController.view;
        if([exportOptionsViewController respondsToSelector:NSSelectorFromString(@"grid")])
            [exportOptionsViewController setValue:grid forKey:@"grid"];
        if([exportOptionsViewController respondsToSelector:NSSelectorFromString(@"exportOptions")])
            [exportOptionsViewController setValue:exportOptions forKey:@"exportOptions"];

        [exportOptionsViewController addEventListener:[FLXSCloseEvent CLOSE] target:self handler:@selector(onExportOptionsClose:)];
		UIView* popupParent=exportOptions.popupParent;
        UIWindow *window = [FLXSUIUtils getTopLevelWindow];
		if(!popupParent)popupParent=window;

		self.popoverController= (UIPopoverController*)[FLXSUIUtils addPopUpController:exportOptionsViewController parent:popupParent modal:exportOptions.modalWindows];


	}
	else
	{
		[self doExport];
	}
}

-(void)onExportOptionsClose:(NSNotification*)ns
{
    FLXSCloseEvent *event= (FLXSCloseEvent *)[ns.userInfo objectForKey:@"event"];
    [((UIViewController *)event.target) removeEventListenerOfType:[FLXSCloseEvent CLOSE] fromTarget:self usingHandler:@selector(onExportOptionsClose:)];
	NSObject* exportOptionsView=event.target;
	if (event.detail == [FLXSCloseEvent OK])
	{
        if([exportOptionsView respondsToSelector:NSSelectorFromString(@"exportOptions")])
            _exportOptions= [exportOptionsView valueForKey:@"exportOptions"];
		[self doExport];
	}
    self.popoverController = nil;
}

-(void)doExport
{
 //this is classis stuff we dont need.
}

-(void)dispatchDataRequest
{
	FLXSExportOptions* exportOptions=self.exportOptions;
	if(exportOptions.saveFileMessage)
		exportOptions.useSaveFileMessage=YES;
	FLXSFlexDataGrid* grid=_grid;
	FLXSPrintExportFilter* printExportFilter=[[FLXSPrintExportFilter alloc] init];
	[printExportFilter copyFrom:([grid createFilter])];
    printExportFilter.printExportOptions=exportOptions;
	[grid addEventListenerOfType:[FLXSPrintExportDataRequestEvent PRINT_EXPORT_DATA_RECD] usingTarget:self withHandler:@selector(onPrintRequestDataRecieved:)];
	FLXSPrintExportDataRequestEvent* printExportDataRequestEvent= [[FLXSPrintExportDataRequestEvent alloc] initWithType:[FLXSPrintExportDataRequestEvent PRINT_EXPORT_DATA_REQUEST] :printExportFilter :NO :NO];
	[grid dispatchEvent:printExportDataRequestEvent];
	return;
}

- (void)runExport:(NSArray *)iCollectionView allOrSelectedPages:(BOOL)allOrSelectedPages {

}


-(void)onPrintRequestDataRecieved:(FLXSEvent*)event
{
	[self.grid removeEventListenerOfType:[FLXSPrintExportDataRequestEvent PRINT_EXPORT_DATA_RECD]
                              fromTarget:self
                            usingHandler:@selector(onPrintRequestDataRecieved:)];
	[self runExport:[self.grid printExportData] allOrSelectedPages:YES ];
}


-(int)getTotalRecords:(FLXSExporter*)exporter
{
	return (int)exporter.allRecords.count;
}

@end

