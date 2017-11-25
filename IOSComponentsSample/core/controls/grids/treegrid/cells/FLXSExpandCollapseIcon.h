#import "FLXSVersion.h"
#import "FLXSIExpandCollapseComponent.h"

@protocol FLXSIFlexDataGridCell;
@class FLXSRowInfo;
@class FLXSFlexDataGridColumnLevel;
@interface FLXSExpandCollapseIcon : UIImageView<FLXSIExpandCollapseComponent>
{
}

@property (nonatomic, assign) BOOL hasChildren;
@property (nonatomic, assign) BOOL open;


-(UIView<FLXSIFlexDataGridCell>*)cellFLXS;
-(FLXSFlexDataGridColumnLevel*)level;
-(FLXSRowInfo*)rowInfo;
-(void)refreshCell;
-(void)doClick;
+(void)refreshCell:(UIView<FLXSIExpandCollapseComponent>*)iexp;
+(void)doClick:(UIView<FLXSIExpandCollapseComponent>*)iexp;
+(void)drawIcon:(UIView<FLXSIExpandCollapseComponent>*)iexp;
@end

