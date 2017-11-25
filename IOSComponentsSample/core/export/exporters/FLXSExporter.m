#import "FLXSExporter.h"
#import "FLXSFlexDataGridColumn.h"
#import "FLXSFlexDataGridColumnLevel.h"
#import "FLXSFlexDataGridColumnGroup.h"
#import "FLXSExportEvent.h"

@implementation FLXSExporter {
@private 
    UIDocumentInteractionController *_documentInteractionController;
}


@synthesize nestIndent = _nestIndent;

@synthesize exportOptions = _exportOptions;
@synthesize allRecords = _allRecords;
@synthesize nestDepth = _nestDepth;
@synthesize reusePreviousLevelColumns = _reusePreviousLevelColumns;
@synthesize documentInteractionController = _documentInteractionController;

-(void)startDocument:(FLXSFlexDataGrid*)grid
{
}

-(void)endDocument:(FLXSFlexDataGrid*)grid
{
}

-(NSString*)writeHeader:(FLXSFlexDataGrid*)grid
{
	return @"";
}

- (NSString *)writeRecord:(FLXSFlexDataGrid *)grid record:(NSObject *)record {
	return @"";
}

-(NSString*)writeFooter:(FLXSFlexDataGrid*)grid
{
	return @"";
}

-(NSString*)contentType
{
	return @"";
}

-(NSString*)name
{
	return @"";
}

-(NSString*)extension
{
	return @"";
}

+ (NSString *)getColumnHeader:(FLXSFlexDataGridColumn *)col colIndex:(int)colIndex {
    return [self getColumnHeaderUltimate:col colIndex:colIndex];

}

+ (NSString *)getColumnHeaderUltimate:(FLXSFlexDataGridColumn *)col colIndex:(int)colIndex {

	FLXSFlexDataGrid* adg = col.level.grid;
	NSString* headerText =col.headerText?col.headerText:col.dataFieldFLXS ?col.dataFieldFLXS :([NSString stringWithFormat:@"%@%d",@"Column ",(colIndex+1)]);
	if(adg)
	{
		NSArray* cols=adg.groupedColumns;
		for(int i=0;i<[cols count];i++)
		{
			NSObject* grp=cols[i];
			if([grp isKindOfClass:[FLXSFlexDataGridColumnGroup class]])
			{
				if([[(FLXSFlexDataGridColumnGroup*)grp getAllColumns] containsObject:col])
				{
                    return [[((FLXSFlexDataGridColumnGroup*)grp).headerText stringByAppendingString:@" - "] stringByAppendingString:headerText];
				}
			}
		}
	}
	return headerText;

}

- (void)saveFile:(NSString *)body param1:(NSString *)param1 {
//	NSObject* fileReference = [fileRefFactory generateInstance];
//	if(!(@"save" in fileReference))
//	{
//		[FLXSUIUtils showError:(@"You are using enableLocalFilePersistence with a version of Flash Player lower than 10. Either use enableLocalFilePersistence=off, or upgrade your Flash Player version.")];
//	}
//	try
//	{
//		[fileReference save:body :param1];
//	}
//	[self catch:(e:Error)]
//	{
//		[FLXSUIUtils showError:(@"Unable to save file:" + e.message)];
//	}

// Write the UIImage to disk as PNG so that we can see the result
    NSString *path= [NSHomeDirectory() stringByAppendingPathComponent:[@"Documents/" stringByAppendingString:param1] ];
     NSError *error;
    self.exportOptions.exportFilePath = path;
    [body writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if(error!=nil){
        [FLXSUIUtils showError:error.localizedDescription errorTitle:@"Error occured"];
    }else{

    }


}
- (UIViewController *) documentInteractionControllerViewControllerForPreview: (UIDocumentInteractionController *) controller {
    UIWindow *window = [FLXSUIUtils getTopLevelWindow];
    UIViewController *rootViewController = window.rootViewController;
    return rootViewController;
}
-(void)uploadForEcho:(NSString*)body :(FLXSExportOptions*)exportOptions
{
	if(exportOptions.grid)
	{
		FLXSExportEvent* expEvent = [[FLXSExportEvent alloc] initWithType:[FLXSExportEvent AFTER_EXPORT]];
		expEvent.exportOptions=exportOptions;
		expEvent.textWritten = body;
		[exportOptions.grid dispatchEvent:expEvent];
		if(expEvent.textWritten!=body)
		{
			body=expEvent.textWritten;
		}
	}
	if(exportOptions.copyToClipboard)
	{
		[FLXSUIUtils pasteToClipBoard:body];
	}

    [self saveFile:body param1:[[exportOptions.exportFileName stringByAppendingString:@"."] stringByAppendingString:self.extension]];

}

-(BOOL)isIncludedInExport:(FLXSFlexDataGridColumn*)col
{
	return !self.exportOptions|| [self.exportOptions.columnsToExport count] ==0 ||
            [FLXSUIUtils doesArrayContainValue:self.exportOptions.columnsToExport valFld:(@"name") compareVal:col.uniqueIdentifier];
}

- (NSString *)getSpaces:(NSObject *)col spChar:(NSString *)spChar {
    if(!self.reusePreviousLevelColumns)
		return @"";
	if(![col respondsToSelector:NSSelectorFromString(@"enableHierarchicalNestIndent")])
		return @"";
	if(![col valueForKey:@"enableHierarchicalNestIndent"])
		return @"";
	NSString* result=@"";
	int i=0;
	while(i<(self.nestIndent*self.nestDepth))
	{
		result = [result stringByAppendingString:spChar];
		i++;
	}
	return result;
}

@end

