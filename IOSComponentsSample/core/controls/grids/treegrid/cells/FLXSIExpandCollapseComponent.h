#import "FLXSVersion.h"
@class FLXSRowInfo;
@class FLXSFlexDataGridColumnLevel;

@protocol FLXSIFlexDataGridCell;

@protocol FLXSIExpandCollapseComponent

@property (nonatomic,assign) BOOL open;
@property (nonatomic,assign) BOOL hasChildren;
@property (nonatomic, readonly) UIImageView * expandCollapseImageView;

-(FLXSRowInfo*)rowInfo;
-(FLXSFlexDataGridColumnLevel*)level;
-(void)doClick;
-(void)refreshCell;
-(UIView<FLXSIFlexDataGridCell>*)cellFLXS;
@end

