#import "FLXSUserSettingsController.h"
#import "FLXSIPersistable.h"
#import "FLXSUserSettingsOptions.h"
#import "FLXSPreferencePersistenceEvent.h"
#import "FLXSFlexDataGrid.h"
#import "FLXSGridPreferencesInfo.h"
#import "FLXSFilterSort.h"
#import "FLXSFlexDataGridColumn.h"
#import "FLXSConstants.h"
#import "FLXSFlexDataGridColumnGroup.h"

static FLXSUserSettingsController* _instance = nil;

@implementation FLXSUserSettingsController
FLXSUserSettingsOptions * savedSettings;

+(FLXSUserSettingsController*)instance
{
    if(!_instance){
        _instance= [[FLXSUserSettingsController alloc] init] ;
    }
	return _instance;
}

-(id)init
{
	self = [super init];
	if (self)
	{

	}
	return self;
}
 
 
-(void)clearPreferences:(FLXSUserSettingsOptions*)userSettingsOptions
{
	FLXSFlexDataGrid* grid =(FLXSFlexDataGrid*) userSettingsOptions.persistable;
	if([grid.preferencePersistenceMode isEqual:@"client"])
	{
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:grid.preferencePersistenceKey];
        [[NSUserDefaults standardUserDefaults] synchronize];

    }
	//else
	{
		FLXSPreferencePersistenceEvent* preferencePersistenceEvent= [[FLXSPreferencePersistenceEvent alloc] initWithType:[FLXSPreferencePersistenceEvent CLEAR_PREFERENCES] andPreferenceKey:grid.preferencePersistenceKey andPreferenceXML:nil andBubbles:NO andCancelable:NO ];
		[grid dispatchEvent:preferencePersistenceEvent];
	}
	if(grid.enableMultiplePreferences)
	{
		grid.gridPreferencesInfo.savedPreferences= [[NSMutableArray alloc] init];
		//if we remove, remove from everywhere.
	}
}

-(void)loadPreferences:(FLXSUserSettingsOptions*)userSettingsOptions
{
	FLXSFlexDataGrid* grid = (FLXSFlexDataGrid*)userSettingsOptions.persistable;
	NSString* key=grid.preferencePersistenceKey;
	FLXSPreferencePersistenceEvent* preferencePersistenceEvent= [[FLXSPreferencePersistenceEvent alloc] initWithType:[FLXSPreferencePersistenceEvent PREFERENCES_LOADING] andPreferenceKey:key andPreferenceXML:nil andBubbles:NO andCancelable:NO ];
	[grid dispatchEvent:preferencePersistenceEvent];
    NSString* customData=@"";

    if([grid.preferencePersistenceMode isEqual:@"client"])
	{
        NSString* prefs = [[NSUserDefaults standardUserDefaults] objectForKey:key];

        FLXSGridPreferencesInfo* gpo;
		if(grid.enableMultiplePreferences && prefs!=nil)
		{
			gpo= [[[FLXSGridPreferencesInfo alloc] init] fromPreferenceString:userSettingsOptions string:prefs];
			[grid setGridPreferencesInfo:gpo ];
			for(FLXSPreferenceInfo* pi in gpo.savedPreferences)
			{
				if(pi.name==gpo.defaultPreferenceName)
				{
					prefs = pi.preferences;
					[grid setCurrentPreference:pi];
				}
			}
		}
		if(prefs!=nil)
		{
			if([prefs rangeOfString:userSettingsOptions.prefCustomDataDelimiter].location!=NSNotFound)
			{
				NSArray* prefParts=[prefs componentsSeparatedByString:userSettingsOptions.prefCustomDataDelimiter];
				prefs=prefParts[0];
				customData=prefParts[1];
			}
			if(!grid.enableMultiplePreferences || gpo.loadDefaultPreferenceOnCreationComplete)
				grid.preferences = prefs;
		}
	}
	//else
	{
		preferencePersistenceEvent= [[FLXSPreferencePersistenceEvent alloc] initWithType:[FLXSPreferencePersistenceEvent LOAD_PREFERENCES] andPreferenceKey:key andPreferenceXML:nil andBubbles:NO andCancelable:NO ];
		preferencePersistenceEvent.customData=customData;
		[grid dispatchEvent:preferencePersistenceEvent];
	}
}

- (void)persistPreferences:(FLXSUserSettingsOptions *)userSettingsOptions name:(NSString *)name isDefault:(BOOL)isDefault {
	FLXSFlexDataGrid* grid = (FLXSFlexDataGrid*)userSettingsOptions.persistable;
	NSString* prefs=[self getPreferencesString:userSettingsOptions];
	FLXSPreferencePersistenceEvent* preferencePersistenceEvent= [[FLXSPreferencePersistenceEvent alloc] initWithType:[FLXSPreferencePersistenceEvent PERSIST_PREFERENCES] andPreferenceKey:grid.preferencePersistenceKey andPreferenceXML:prefs andBubbles:NO andCancelable:NO ];
	preferencePersistenceEvent.preferenceName = name;
	preferencePersistenceEvent.isDefault = isDefault;
	if(grid.enableMultiplePreferences)
	{
		FLXSPreferenceInfo* preferenceInfo=nil;
		for(FLXSPreferenceInfo* po in grid.gridPreferencesInfo.savedPreferences)
		{
			if([po.name isEqualToString:name])
			{
				preferenceInfo=po;
				break;
			}
		}
		if(!preferenceInfo)
		{
			preferenceInfo=[[FLXSPreferenceInfo alloc] init];
			preferenceInfo.name = name;
			[grid.gridPreferencesInfo.savedPreferences addObject:preferenceInfo];
		}
		preferenceInfo.preferences = prefs;
		if(isDefault)
		{
			grid.gridPreferencesInfo.defaultPreferenceName=name;
		}
		preferencePersistenceEvent.preferenceXml=[grid.gridPreferencesInfo toPreferenceString:userSettingsOptions];
		[grid dispatchEvent:preferencePersistenceEvent];
		grid.preferencesSet=YES;
		if(preferencePersistenceEvent.customData)
		{
//			prefs= [[prefs stringByAppendingString:userSettingsOptions.prefCustomDataDelimiter] stringByAppendingString: preferencePersistenceEvent.customData];
		}
		if([grid.preferencePersistenceMode isEqual:@"client"])
		{
            [[NSUserDefaults standardUserDefaults] setObject:[grid.gridPreferencesInfo toPreferenceString:userSettingsOptions]
                                                       forKey:grid.preferencePersistenceKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
		[grid setCurrentPreference:preferenceInfo ];
	}
	else
	{
		[grid dispatchEvent:preferencePersistenceEvent];
		grid.preferencesSet=YES;
		if(preferencePersistenceEvent.customData)
		{
            prefs= [[prefs stringByAppendingString:userSettingsOptions.prefCustomDataDelimiter] stringByAppendingString: preferencePersistenceEvent.customData];
		}
		if([grid.preferencePersistenceMode isEqual:@"client"])
		{
            [[NSUserDefaults standardUserDefaults] setObject:prefs
                                                      forKey:grid.preferencePersistenceKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
		}
	}
}

-(NSString*)getPreferencesString:(FLXSUserSettingsOptions*)userSettingsOptions
{
	FLXSFlexDataGrid* grid = (FLXSFlexDataGrid*)userSettingsOptions.persistable;
	if(grid.useCompactPreferences)
	{
		return [self getCompactPreferencesString:userSettingsOptions];
	}

    return nil;
}

- (NSMutableArray *)parsePreferences:(FLXSUserSettingsOptions *)userSettingsOptions value:(NSString *)val {
	if(!val || val.length==0)return [[NSMutableArray alloc] init];
	FLXSFlexDataGrid* grid = (FLXSFlexDataGrid*)userSettingsOptions.persistable;
	@try
	{
		if(grid.useCompactPreferences)
		{
			return [self parseCompactPreferencesString:userSettingsOptions value:val];
		}

	}
	@catch (NSException* e) {
 		if(userSettingsOptions.silentFailure)return [[NSMutableArray alloc] init];
		if(userSettingsOptions.allowClearOnCorruption)
		{
            UIAlertView *alert = [[UIAlertView alloc]
                    initWithTitle: @"Error Occured"
                          message: userSettingsOptions.showErrorMessageWhenCorrupt
                         delegate: self
                cancelButtonTitle:  @"Cancel"
                otherButtonTitles: @"OK", nil];
            savedSettings=userSettingsOptions;
            [alert show];
		}
		else
		{
            @throw e;
		}
	}
	return [[NSMutableArray alloc] init];
}
// Called when an alertview button is touched
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    FLXSFlexDataGrid* grid = (FLXSFlexDataGrid*)savedSettings.persistable;
    savedSettings = nil;
    switch (buttonIndex) {
        case 0:
        {
        }
            break;

        case 1:
        {
            [grid clearPreferences];
        }
            break;
    }
}

- (NSMutableArray *)parseCompactPreferencesString:(FLXSUserSettingsOptions *)userSettingsOptions value:(NSString *)val {
	NSMutableArray* result=[[NSMutableArray alloc] init];
	NSMutableArray* prefs =(NSMutableArray*) [val componentsSeparatedByString:userSettingsOptions.prefDelimiter];
	NSArray* colInfos= [[prefs objectAtIndex:0] componentsSeparatedByString:userSettingsOptions.prefColDelimiter];
	NSString* noVal=@"o";
	NSMutableArray* colOrders= [[NSMutableArray alloc] init];
	NSMutableArray* colVisibilities= [[NSMutableArray alloc] init];
	NSMutableArray* colWidths= [[NSMutableArray alloc] init];
	NSMutableArray* colFilters= [[NSMutableArray alloc] init];
	NSMutableArray* colSorts= [[NSMutableArray alloc] init];
	NSMutableArray* colLockModes= [[NSMutableArray alloc] init];
	FLXSFlexDataGrid* grid = (FLXSFlexDataGrid*)userSettingsOptions.persistable;
	for(NSString* colInfoData in colInfos)
	{
        if(colInfoData.length==0)continue;
		NSArray* colInfo=[colInfoData componentsSeparatedByString:userSettingsOptions.prefColPrefDelimiter];
		NSString* colHeaderText= [colInfo objectAtIndex:0];
		[colOrders addObject:colHeaderText];
		if(![colInfo[1] isEqual:noVal])
		{
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
            [dic setObject:colHeaderText forKey:@"key"];
            [dic setObject:[NSNumber numberWithBool:[((NSString *)[colInfo objectAtIndex:1]) isEqual:@"y"]] forKey:@"property"];
            [colVisibilities addObject:dic];
		}
		if(![colInfo[2] isEqual:noVal])
		{      NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:colHeaderText forKey:@"key"];
            [dic setObject:[colInfo objectAtIndex:2] forKey:@"property"];
            [colWidths addObject:dic];
		}
		if(![colInfo[3] isEqual:noVal] )
		{
			if(colInfo[3]!=nil) {
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setObject:colHeaderText forKey:@"key"];
                [dic setObject:[FLXSUIUtils fromPersistenceString:[colInfo objectAtIndex:3]] forKey:@"property"];
                [colFilters addObject:dic];
            }
		}
		if(![colInfo[4] isEqual:noVal])
		{
			FLXSFilterSort* fs = [[FLXSFilterSort alloc] init];
			for(FLXSFlexDataGridColumn* col in grid.columns)
			{
				if(col.persistenceKey == colHeaderText)
				{
					fs.sortColumn=col.sortFieldName;
					fs.isAscending = [[colInfo objectAtIndex:4] isEqual:@"y"];
					[colSorts addObject:fs];
					break;
				}
			}
		}
		if(userSettingsOptions.persistLockModes && [colInfo count] >5 )
		{
            NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
            [dictionary setObject:colHeaderText forKey:@"key"];
            [dictionary setObject:[colInfo objectAtIndex:5] forKey:@"property"];
            [colLockModes addObject:dictionary];
		}
	}
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[FLXSConstants PERSIST_COLUMN_ORDER] forKey:@"key"];
    [dic setObject:colOrders forKey:@"data"];
    [result addObject:dic];
	if(colVisibilities.count>0) {
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        [dictionary setObject:[FLXSConstants PERSIST_COLUMN_VISIBILITY] forKey:@"key"];
        [dictionary setObject:colVisibilities forKey:@"data"];
        [result addObject:dictionary];
    }
	if(colWidths.count>0){
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        [dictionary setObject:[FLXSConstants PERSIST_COLUMN_WIDTH] forKey:@"key"];
        [dictionary setObject:colWidths forKey:@"data"];
        [result addObject:dictionary];
    }
	if(colSorts.count>0) {
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        [dictionary setObject:[FLXSConstants PERSIST_SORT] forKey:@"key"];
        [dictionary setObject:colSorts forKey:@"data"];
        [result addObject:dictionary];
    }
	if(colFilters.count>0){
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        [dictionary setObject:[FLXSConstants PERSIST_FILTER] forKey:@"key"];
        [dictionary setObject:colFilters forKey:@"data"];
        [result addObject:dictionary];
    }
	if(userSettingsOptions.persistLockModes && colLockModes.count>0){
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        [dictionary setObject:[FLXSConstants PERSIST_COLUMN_LOCKMODES] forKey:@"key"];
        [dictionary setObject:colLockModes forKey:@"data"];
        [result addObject:dictionary];
    }
	if(prefs[1]!=noVal)
	{   NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        [dictionary setObject:[FLXSConstants PERSIST_VERTICAL_SCROLL] forKey:@"key"];
        [dictionary setObject:[NSNumber numberWithFloat:[[prefs objectAtIndex:1] floatValue]] forKey:@"data"];
        [result addObject:dictionary];
		//[result addObject:({key:[FLXSConstants PERSIST_VERTICAL_SCROLL]) :(data:((float)(prefs[1[] toString]))})];
	}
	if(prefs[2]!=noVal)
	{     NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        [dictionary setObject:[FLXSConstants PERSIST_HORIZONTAL_SCROLL] forKey:@"key"];
        [dictionary setObject:[NSNumber numberWithFloat:[[prefs objectAtIndex:2] floatValue]] forKey:@"data"];
        [result addObject:dictionary];
		//[result addObject:({key:[FLXSConstants PERSIST_HORIZONTAL_SCROLL]) :(data:((float)(prefs[2[] toString]))})];
	}
	if(prefs[3]!=noVal)
	{      NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        [dictionary setObject:[FLXSConstants PERSIST_FOOTER_FILTER_VISIBILITY] forKey:@"key"];
        NSNumber *num1=[NSNumber numberWithBool:[[[[prefs objectAtIndex:3] description] substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"y"]];
        NSNumber *num2=[NSNumber numberWithBool:[[[[prefs objectAtIndex:3] description] substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"y"]];
        [dictionary setObject:[[NSMutableArray  alloc] initWithObjects:num1, num2, nil] forKey:@"data"];

        [result addObject:dictionary];
		//[result addObject:({key:[FLXSConstants PERSIST_FOOTER_FILTER_VISIBILITY])
		// :(data:[[NSMutableArray alloc] initWithType:([prefs[3[] toString[] [charAt:0] isEqual:@"y]",prefs[3[] toString[] [charAt:1] isEqual:@"y"]])]})];
	}
	if(prefs[4]!=noVal)
	{     NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        [dictionary setObject:[FLXSConstants PERSIST_PAGE_SIZE] forKey:@"key"];
        [dictionary setObject:[NSNumber numberWithFloat:[[prefs objectAtIndex:4] floatValue]] forKey:@"data"];
        [result addObject:dictionary];
		//[result addObject:({key:[FLXSConstants PERSIST_PAGE_SIZE]) :(data:((float)(prefs[4[] toString]))})];
	}
	if(prefs[5]!=noVal)
	{    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        [dictionary setObject:[FLXSConstants PERSIST_PRINT_SETTINGS] forKey:@"key"];
        [dictionary setObject:[NSNumber numberWithFloat:[[prefs objectAtIndex:5] floatValue]] forKey:@"data"];
        [result addObject:dictionary];
		//[result addObject:({key:[FLXSConstants PERSIST_PRINT_SETTINGS]) :(data:(prefs[5[] toString])})];
	}
	return result;
}

-(NSString*)getCompactPreferencesString:(FLXSUserSettingsOptions*)userSettingsOptions
{
	FLXSFlexDataGrid* grid = (FLXSFlexDataGrid *)userSettingsOptions.persistable;
	NSArray* preferenceKeys = [grid.preferencesToPersist componentsSeparatedByString:(@",")];
	NSArray* cols = [grid getColumns];
	NSString* colSettings=@"";
	float colIndex=0;
	NSString* delim=userSettingsOptions.prefColPrefDelimiter;
	NSMutableArray* sorts = [grid createFilter].sorts;
	for(FLXSFlexDataGridColumn* col in cols)
	{
		//NSString* colIdentifier=[col hasOwnProperty:(@"uniqueIdentifier")]?col.uniqueIdentifier:col.headerText;
		NSString* colIdentifier=col.persistenceKey;
		NSObject* filterValue=nil;
		if([col respondsToSelector:@selector(searchField)] && col.searchField)
			 filterValue=[grid getFilterValue:col.searchField];
		FLXSFilterSort* sort=nil;
		for(FLXSFilterSort* srt in sorts)
		{
			if(srt.sortColumn==col.sortFieldName)
			{
				sort=srt;
				break;
			}
		}
		colSettings = [[colSettings stringByAppendingString:colIdentifier] stringByAppendingString: delim];
		colSettings = [[colSettings stringByAppendingString:([preferenceKeys indexOfObject:[FLXSConstants PERSIST_COLUMN_VISIBILITY]] ? col.visible ? @"y" : @"n" : @"o")] stringByAppendingString:delim];
		colSettings =[[colSettings stringByAppendingString:([preferenceKeys indexOfObject:[FLXSConstants PERSIST_COLUMN_WIDTH]]?[NSString stringWithFormat:@"%d",(int)col.width]:@"o") ]  stringByAppendingString:delim];
		colSettings= [[colSettings  stringByAppendingString:(([preferenceKeys indexOfObject:[FLXSConstants PERSIST_FILTER]]&&(filterValue!=nil)&&![filterValue isEqual:@""])?[FLXSUIUtils toPersistenceString:filterValue]:@"o") ] stringByAppendingString: delim];
		colSettings = [[colSettings stringByAppendingString:(([preferenceKeys indexOfObject:[FLXSConstants PERSIST_SORT]]&&sort)?(sort.isAscending?@"y":@"n"):@"o")]  stringByAppendingString: delim];
		if(userSettingsOptions.persistLockModes)
			colSettings = [[colSettings stringByAppendingString:([preferenceKeys indexOfObject:[FLXSConstants PERSIST_COLUMN_WIDTH]]?(col.columnLockMode):@"o") ] stringByAppendingString: delim];
		colSettings = [colSettings stringByAppendingString:userSettingsOptions.prefColDelimiter];
		colIndex++;
	}
	colSettings = [colSettings stringByAppendingString: userSettingsOptions.prefDelimiter];
	colSettings = [[colSettings stringByAppendingString:([preferenceKeys indexOfObject:[FLXSConstants PERSIST_VERTICAL_SCROLL]]?[NSString stringWithFormat:@"%f",grid.verticalScrollPosition]:@"o") ] stringByAppendingString: userSettingsOptions.prefDelimiter];
	colSettings = [[colSettings stringByAppendingString:([preferenceKeys indexOfObject:[FLXSConstants PERSIST_HORIZONTAL_SCROLL]]?[NSString stringWithFormat:@"%f",grid.horizontalScrollPosition]:@"o")]  stringByAppendingString: userSettingsOptions.prefDelimiter];
	colSettings = [[colSettings stringByAppendingString:([preferenceKeys indexOfObject:[FLXSConstants PERSIST_FOOTER_FILTER_VISIBILITY]]?([grid.footerVisible?@"y":@"n" stringByAppendingString:(grid.filterVisible?@"y":@"n")]):@"o")] stringByAppendingString: userSettingsOptions.prefDelimiter];
	colSettings = [[colSettings stringByAppendingString:([preferenceKeys indexOfObject:[FLXSConstants PERSIST_PAGE_SIZE]]?[NSString stringWithFormat:@"%d",grid.pageSize]:@"o")] stringByAppendingString: userSettingsOptions.prefDelimiter];
	colSettings = [[colSettings stringByAppendingString:
            ([preferenceKeys indexOfObject:[FLXSConstants PERSIST_PRINT_SETTINGS]]?
                    grid.lastPrintOptionsString?
                            grid.lastPrintOptionsString:grid.persistedPrintOptionsString:@"o")]
            stringByAppendingString: userSettingsOptions.prefDelimiter];
	return colSettings;
}


-(NSMutableArray*)getColumnOrder:(FLXSUserSettingsOptions*)userSettingsOptions
{
	FLXSFlexDataGrid* grid = (FLXSFlexDataGrid*)userSettingsOptions.persistable;
	NSMutableArray* cols=[[NSMutableArray alloc] init];
	for(FLXSFlexDataGridColumn* column in grid.columns)
	{
		[cols addObject:column.persistenceKey];
	}
	return cols;
}

- (NSMutableArray *)getPropertyValues:(FLXSUserSettingsOptions *)userSettingsOptions property:(NSString *)property {
	FLXSFlexDataGrid* grid=(FLXSFlexDataGrid*)userSettingsOptions.persistable;
	NSMutableArray* prefs=[[NSMutableArray alloc] init];
	for(FLXSFlexDataGridColumn* column in grid.columns)
	{
		if([column respondsToSelector:@selector(property)]){
            NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
            [dic setObject:column.persistenceKey forKey:@"key"];
            [dic setObject:[column valueForKey:property] forKey:property];
        }
	}
	return prefs;
}

-(NSMutableArray*)getColumnVisibility:(FLXSUserSettingsOptions*)userSettingsOptions
{
	return [self getPropertyValues:userSettingsOptions property:(@"visible")];
}

-(NSMutableArray*)getColumnWidths:(FLXSUserSettingsOptions*)userSettingsOptions
{
	return [self getPropertyValues:userSettingsOptions property:(@"width")];
}

- (void)applyPreferences:(FLXSUserSettingsOptions *)userSettingsOptions nsMutableArray:(NSMutableArray *)array {
	@try
	{
		FLXSFlexDataGrid* grid=(FLXSFlexDataGrid*)userSettingsOptions.persistable;
		for(NSDictionary* item in array)
		{
            NSString* key = [item objectForKey:@"key"];
            NSMutableArray* data =(NSMutableArray*)[item objectForKey:@"data"];
			if(key==[FLXSConstants PERSIST_COLUMN_ORDER])
			{
				[self setColumnOrder:userSettingsOptions value:data];
			}
			else if(key ==[FLXSConstants PERSIST_COLUMN_LOCKMODES])
			{
				[self setPropertyValues:userSettingsOptions value:data property:@""];
			}
			else if(key==[FLXSConstants PERSIST_COLUMN_VISIBILITY])
			{
				[self setColumnVisibility:userSettingsOptions value:data];
			}
			else if(key==[FLXSConstants PERSIST_COLUMN_WIDTH])
			{
				[self setColumnWidths:userSettingsOptions value:data];
			}
			else if(key==[FLXSConstants PERSIST_SORT])
			{
				[grid processSort:data];
			}
			else if(key==[FLXSConstants PERSIST_FILTER])
			{
				[grid clearFilter];
				[grid validateNow];
				for(FLXSFlexDataGridColumn* column in grid.columns)
				{
					for(NSMutableDictionary* pref in data)
					{
						if(column && pref && ([column.persistenceKey isEqualToString:[pref valueForKey:@"key"]]))
						{
							if([pref objectForKey:@"property"]!=nil){
								[grid setFilterValue:[column searchField] value:([[pref objectForKey:@"property"] respondsToSelector:@selector(item)] ? [[pref objectForKey:@"property"] valueForKey:@"item"] : [pref objectForKey:@"property"]) triggerEvent:NO ];
                            }
						}
					}
				}
				[grid validateNow];
			}
			else if(key==[FLXSConstants PERSIST_VERTICAL_SCROLL])
			{
				grid.verticalScrollPosition=[[item objectForKey:@"data"] floatValue];
			}
			else if(key==[FLXSConstants PERSIST_HORIZONTAL_SCROLL])
			{
				grid.horizontalScrollPosition=[[item objectForKey:@"data"] floatValue];
			}
			else if(key==[FLXSConstants PERSIST_FOOTER_FILTER_VISIBILITY])
			{
				grid.footerVisible = [[[item objectForKey:@"data"] objectAtIndex:0] boolValue];
				grid.filterVisible = [[[item objectForKey:@"data"] objectAtIndex:1] boolValue];
			}
			else if(key==[FLXSConstants PERSIST_PAGE_SIZE])
			{
				grid.pageSize=[[item objectForKey:@"data"] intValue];
			}
			else if(key==[FLXSConstants PERSIST_PRINT_SETTINGS])
			{
				grid.persistedPrintOptionsString = [item objectForKey:@"data"]?[[item objectForKey:@"data"] stringValue]:@"";
			}
		}
	}
	@catch (NSException* e) {
 		if(userSettingsOptions.silentFailure)return ;
		if(userSettingsOptions.allowClearOnCorruption)
		{
            UIAlertView *alert = [[UIAlertView alloc]
                    initWithTitle: @"Error Occured"
                          message: userSettingsOptions.showErrorMessageWhenCorrupt
                         delegate: self
                cancelButtonTitle:  @"Cancel"
                otherButtonTitles: @"OK", nil];
            savedSettings=userSettingsOptions;
            [alert show];
        }
        else
        {
            @throw e;
        }


	}
}

- (void)setColumnOrder:(FLXSUserSettingsOptions *)userSettingsOptions value:(NSMutableArray *)val {
	FLXSFlexDataGrid* grid=(FLXSFlexDataGrid*)userSettingsOptions.persistable ;
	//create a new array collection of the size of the existing columns
	NSMutableArray* persistedCols;//=[[NSMutableArray alloc] initWithArray:([[NSArray alloc] init])];
	if(grid.hasGroupedColumns)
	{
		//if has column groups
	//	{
            persistedCols=[[NSMutableArray alloc] initWithCapacity:grid.columns.count];
            for(int i = 0; i<grid.columns.count; i++) [persistedCols addObject: [NSNull null]];
			//for of current columns
			for(FLXSFlexDataGridColumn* col in grid.groupedColumns)
			{
				NSUInteger colIndex= 0;
				if([col respondsToSelector:NSSelectorFromString(@"children")])
				{
					//if it is a column group
					//get the index of its first persisted column.
					//add the column group at that index
					FLXSFlexDataGridColumn* firstCol = (FLXSFlexDataGridColumn  *)[self getFirstColumn:col];
					if(firstCol)
					{
						colIndex= [val indexOfObject:firstCol.uniqueIdentifier];
					}
					//if self is a @"column only" columnGroup, re arrange its columns.
					[self rearrangeColumns:col value:val userSettingsOptions:userSettingsOptions];
				}
				else
				{
					//get its index in the preferences string, and add it to the array collection at its persisted index
					colIndex= [val indexOfObject:col.uniqueIdentifier];
				}
				//if it does not exist in the preferences string, add it to the array collection at its current index
				if(colIndex==NSNotFound)
				{
					colIndex=[grid.columns indexOfObject:col];
				}
				if(colIndex==NSNotFound)
				{
					colIndex=[grid.groupedColumns indexOfObject:col];
				}
				while((colIndex<persistedCols.count) && (persistedCols[colIndex]!=[NSNull null]))
				{
					colIndex++;
				}
				if([persistedCols objectAtIndex:colIndex]!= [NSNull null])
				{
					[persistedCols addObject:col];
				}
				else
                    [persistedCols setObject:col atIndexedSubscript:colIndex];
			}
			grid.groupedColumns=[self removeUndefined:persistedCols];
		}
		else
		{
			NSMutableArray* persistedColsArray= [[NSMutableArray alloc] initWithCapacity:grid.columns.count];
            for(int i = 0; i<grid.columns.count; i++) [persistedColsArray addObject: [NSNull null]];

            for(FLXSFlexDataGridColumn* col in grid.columns)
			{
				//get its index in the preferences string, and add it to the array collection at its persisted index
			NSUInteger	colIndex = [val indexOfObject:col.uniqueIdentifier];
				//if it does not exist in the preferences string, add it to the array collection at its current index
				if(colIndex==NSNotFound)
				{
					colIndex=[grid.columns indexOfObject:col];
				}
				while(colIndex<persistedColsArray.count&&([persistedColsArray objectAtIndex:colIndex]!= [NSNull null]))
				{
					colIndex++;
				}
				if([persistedColsArray objectAtIndex:colIndex]!= [NSNull null])
				{
					[persistedColsArray addObject:col];
				}
				else
                    [persistedColsArray setObject:col atIndexedSubscript:colIndex];
				//NSString* val2 = [FLXSUIUtils extractPropertyValues:persistedCols :(@"headerText")][.source join:(@"|")];
			}
			[grid setColumns:[self removeUndefined:persistedColsArray]];
			//NSString* val1 = [FLXSUIUtils extractPropertyValues:([[NSMutableArray alloc] init:grid.columns]) :(@"headerText")][.source join:(@"|")];
		}
		//set the new grouped columns
	}

- (void)rearrangeColumns:(NSObject *)col value:(NSMutableArray *)val userSettingsOptions:(FLXSUserSettingsOptions *)userSettingsOptions {
		//if self is a @"column only" columnGroup, re arrange its columns on basis of preferences.
        FLXSFlexDataGridColumnGroup * grp = [col isKindOfClass:[FLXSFlexDataGridColumnGroup class]]?(FLXSFlexDataGridColumnGroup *)col:nil;
        BOOL isColumnOnly = grp?grp.isColumnOnly:NO;
		if(isColumnOnly)
		{
			NSArray* columns=grp.columns;
			NSMutableArray* resultCols= [[NSMutableArray alloc] init];
			for(NSString* uq in val)
			{
				for(FLXSFlexDataGridColumn* childCol in columns)
				{
					if([childCol.uniqueIdentifier isEqualToString:uq] )
					{
						[resultCols addObject:childCol];
					}
				}
			}
			for(NSObject* childCol1 in columns)
			{
				if([resultCols indexOfObject:childCol1]==NSNotFound)
				{
					[resultCols addObject:childCol1];
				}
			}
            grp.columns = resultCols;
		}
		else if(grp)
		{
			NSArray* cgs=grp.columnGroups;
			for(NSObject* childGrp in cgs)
			{
				if([childGrp respondsToSelector:@selector(children)])
				{
                    [self rearrangeColumns:childGrp value:val userSettingsOptions:userSettingsOptions];
				}
			}
		}
	}

	-(BOOL)getIsColumnOnly:(FLXSFlexDataGridColumnGroup*)col
	{
		for(NSObject* child in col.children)
		{
			if([child respondsToSelector:@selector(children)])
			{
				return NO;
			}
		}
		return YES;
	}

	-(NSMutableArray*)removeUndefined:(NSMutableArray*)source
	{
		NSMutableArray* result= [[NSMutableArray alloc] init];
		for(NSObject* item in source)
		{
			if(item != [NSNull null] && item != nil)
				[result addObject:item];
		}
		return result;
	}

	-(NSObject*)getFirstColumn:(FLXSFlexDataGridColumnGroup*)col
	{
		for(NSObject* child in col.children)
		{
			if(![child respondsToSelector:@selector(children)])
			{
				//self means self is a column
				return child;
			}
			else
			{
				//self means self is a column group
				NSObject* result = [self getFirstColumn:child];
				if(result)
					return result;
			}
		}
		return nil;
	}

- (void)setPropertyValues:(FLXSUserSettingsOptions *)userSettingsOptions value:(NSMutableArray *)val property:(NSString *)property {
		FLXSFlexDataGrid* grid=(FLXSFlexDataGrid*)userSettingsOptions.persistable;
		for(FLXSFlexDataGridColumn* column in grid.columns)
		{
			for(NSMutableDictionary* pref in val)
			{
				if([column.persistenceKey isEqualToString: [pref objectForKey:@"key"]])
				{
					if(userSettingsOptions.userWidthsOverrideFitToContent &&[property isEqual:@"width"] && [column respondsToSelector:@selector(columnWidthMode)]
						&& [column.columnWidthMode isEqual:@"fitToContent"])
					{
						column.columnWidthMode=@"fixed";
					}
					[column setValue:[pref objectForKey:@"property"] forKey:property]  ;
				}
			}
		}
	}

- (void)setColumnVisibility:(FLXSUserSettingsOptions *)userSettingsOptions value:(NSMutableArray *)val {
		[self setPropertyValues:userSettingsOptions value:val property:(@"visible")];
	}

- (void)setColumnWidths:(FLXSUserSettingsOptions *)userSettingsOptions value:(NSMutableArray *)val {
		FLXSFlexDataGrid* grid=(FLXSFlexDataGrid*)userSettingsOptions.persistable;
		NSString* policy = grid.horizontalScrollPolicy;
		grid.horizontalScrollPolicy=@"on";
		[self setPropertyValues:userSettingsOptions value:val property:(@"width")];
		grid.horizontalScrollPolicy=policy;
	}

	+ (FLXSUserSettingsController*)_instance
	{
		return _instance;
	}
	@end

