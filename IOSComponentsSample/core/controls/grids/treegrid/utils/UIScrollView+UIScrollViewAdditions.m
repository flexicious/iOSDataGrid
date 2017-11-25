//
// Created by Flexicious-111 on 6/30/13.
// Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "UIScrollView+UIScrollViewAdditions.h"

@implementation UIScrollView (UIScrollViewAdditions)


///////////////////////////////////////////////////////////////////////////////////////////////////
- (float)horizontalScrollPosition {
    return MAX(0,self.contentOffset.x);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHorizontalScrollPosition:(float)horizontalScrollPosition {
    [self setContentOffset: CGPointMake(horizontalScrollPosition,self.contentOffset.y)];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (float)verticalScrollPosition {
    return MAX(0,self.contentOffset.y);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setVerticalScrollPosition:(float)vIn {
    [self setContentOffset: CGPointMake(self.contentOffset.x,vIn)];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (float)maxHorizontalScrollPosition {
    return self.contentSize.width - self.bounds.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (float)maxVerticalScrollPosition {
    return self.contentSize.height - self.bounds.size.height;
}


@end