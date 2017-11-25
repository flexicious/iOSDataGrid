#import "FLXSVersion.h"


@interface UIScrollView (UIScrollViewAdditions)
@property (nonatomic, assign) float horizontalScrollPosition;
@property (nonatomic, assign) float verticalScrollPosition;
@property (nonatomic, readonly) float maxHorizontalScrollPosition;
@property (nonatomic, readonly) float maxVerticalScrollPosition;

@end