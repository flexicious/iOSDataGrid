#import "FLXSVersion.h"
@class FLXSFlexDataGridHeaderContainer;

@interface FLXSInsertionLocationInfo : NSObject
{
}

@property (nonatomic, assign) float contentX;
@property (nonatomic, assign) float headerX;
@property (nonatomic, assign) float contentY;
@property (nonatomic, assign) float leftLockedContentX;
@property (nonatomic, assign) float rightLockedContentX;
@property (nonatomic, assign) float leftLockedHeaderX;
@property (nonatomic, assign) float leftLockedHeaderY;
@property (nonatomic, assign) float rightLockedHeaderX;
@property (nonatomic, assign) float rightLockedHeaderY;
@property (nonatomic, assign) float leftLockedFooterX;
@property (nonatomic, assign) float leftLockedFooterY;
@property (nonatomic, assign) float rightLockedFooterX;
@property (nonatomic, assign) float rightLockedFooterY;

-(void)nextChromeRow:(FLXSFlexDataGridHeaderContainer*)row;
-(void)reset;


@end

