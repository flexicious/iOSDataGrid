#import "FLXSExtendedExportController.h"
#import "FLXSFlexDataGridColumnLevel.h"


@implementation FLXSExtendedExportController
static FLXSExtendedExportController *_instance;
@synthesize DEFAULT_TABLE_WIDTH;

+(FLXSExtendedExportController*)instance
{
     if(!_instance){
        _instance     = [[FLXSExtendedExportController alloc] init];
    }
    return _instance;
}

-(id)init
{
	self = [super init];
	if (self)
	{
		DEFAULT_TABLE_WIDTH = 1000;
        return self;
    }
    return self;
}


-(void)doExport
{
    FLXSExportOptions* exportOptions=self.exportOptions;
    FLXSFlexDataGrid* grid = self.grid;
	if([grid.filterPageSortMode isEqual: @"server"] &&
		(exportOptions.printExportOption==[FLXSPrintExportOptions PRINT_EXPORT_ALL_PAGES] ||
		exportOptions.printExportOption==[FLXSPrintExportOptions PRINT_EXPORT_SELECTED_PAGES])
		)
	{
		[self dispatchDataRequest];
		return;
	}
	[self runExport:[grid getDataForPrintExport:exportOptions] allOrSelectedPages:NO ];
}

- (void)runExport:(NSArray *)iCollectionView allOrSelectedPages:(BOOL)allOrSelectedPages {
    [self runNestedExport:iCollectionView level:self.grid.columnLevel];
}

- (void)runNestedExport:(NSArray *)iCollectionView level:(FLXSFlexDataGridColumnLevel *)level {
    FLXSFlexDataGrid* grid = self.grid;
	if(!level)level=grid.columnLevel;
    //id test = self.exportOptions.exporter;
    FLXSExportOptions* exportOptions=self.exportOptions;
	exportOptions.exporter.exportOptions=exportOptions;
	for(NSObject* obj in iCollectionView)
	{
		[exportOptions.exporter.allRecords addObject:obj];
	}
	if(!exportOptions.tableWidth)
		exportOptions.tableWidth=DEFAULT_TABLE_WIDTH;
	[exportOptions.exporter startDocument:grid];
	NSString* body=[exportOptions.exporter writeHeader:grid];
	for(NSObject*obj in iCollectionView)
	{
		body= [body stringByAppendingString:[self writeRecord:obj level:level]];
	}
	[self setExportLevel:level];
	body=[body stringByAppendingString:[exportOptions.exporter writeFooter:grid]];
	[exportOptions.exporter endDocument:grid];
    
    [[UIPasteboard generalPasteboard] setString:body];
	[exportOptions.exporter uploadForEcho:body :exportOptions];
	[self setExportLevel:nil];
}

-(int)getTotalRecords:(FLXSExporter*)exporter
{
	FLXSFlexDataGrid* grid = self.grid;
	int result= [self countLevels:exporter.allRecords level:grid.columnLevel];
	return result;
}

- (int)countLevels:(NSArray *)allRecords level:(FLXSFlexDataGridColumnLevel *)level {
	FLXSFlexDataGrid* grid = level.grid;
	int i=0;
	for(NSObject* obj in allRecords)
	{
		i++;
		if(level.nextLevel)
		{
			if(!level.nextLevel.reusePreviousLevelColumns)
				i++;
			NSArray* result= self.exportOptions.exportCollapsedRows||[level isItemOpen:obj]? [level getChildren:obj filter:YES page:NO sort:YES ] :[[NSArray alloc] init];
			if([grid getLength:result]>0)
			{
				i+= [self countLevels:result level:level.nextLevel];
			}
		}
	}
	return i;
}

- (NSString *)writeRecord:(NSObject *)obj level:(FLXSFlexDataGridColumnLevel *)level {
 	FLXSFlexDataGrid* grid = self.grid;
    FLXSExportOptions* exportOptions=self.exportOptions;
	NSString* body=@"";
	[self setExportLevel:level];
	body= [body stringByAppendingString:[exportOptions.exporter writeRecord:grid record:obj]];
    if(level.nextLevel)
	{
		[self setExportLevel:level.nextLevel];
		NSArray* result= exportOptions.exportCollapsedRows||[level isItemOpen:obj]? [level getChildren:obj filter:YES page:NO sort:YES ] :[[NSMutableArray alloc] init];
		if([grid getLength:result]>0)
		{
			if(!grid.currentExportLevel.reusePreviousLevelColumns)
                body= [body stringByAppendingString:[exportOptions.exporter writeHeader:grid]];
			for(NSObject* child in result)
			{
                body= [body stringByAppendingString:[exportOptions.exporter writeRecord:grid record:child]];
			}
			if(!grid.currentExportLevel.reusePreviousLevelColumns)
                body= [body stringByAppendingString:[exportOptions.exporter writeFooter:grid]];
		}
	}
	return body;
}

-(void)setExportLevel:(FLXSFlexDataGridColumnLevel*)level
{
    FLXSFlexDataGrid* grid = self.grid;
	self.exportOptions.exporter.nestDepth=level?level.nestDepth-1:0;
    self.exportOptions.exporter.reusePreviousLevelColumns=level?level.reusePreviousLevelColumns:NO;
	grid.currentExportLevel=level;
}

@end

