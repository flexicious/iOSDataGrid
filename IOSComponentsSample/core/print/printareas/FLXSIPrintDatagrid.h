#import "FLXSVersion.h"
@protocol FLXSIPrintDatagrid
-(NSArray*)printListItems;
-(void)horizontalScrollPolicy:(NSString*)val;
-(NSString*)horizontalScrollPolicy;
-(int)rowCount;
-(float)rowHeight;
-(float)headerHeight;
-(void)setResizableColumns:(BOOL)val;
-(BOOL)variableRowHeight;
-(void)invalidateSize;
-(void)invalidateList;
-(void)validateNow;
-(void)gotoRow:(int)rowIndex;
-(NSArray*)getColumns;
-(void)setColumns:(NSArray*)val;
-(NSObject*)getDataProvider;
-(void)setDataProviderFLXS:(NSObject*)val;
@end

