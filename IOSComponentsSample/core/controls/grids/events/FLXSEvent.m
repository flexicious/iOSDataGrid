//
// Created by FLEXICIOUS-MAC on 6/11/13.
// Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//#import "FLXSFlexDataGrid.h"
// To change the template use AppCode | Preferences | File Templates.
//


#import "FLXSEvent.h"
#import "FLXSIFlexDataGridCell.h"
#import "FLXSRowInfo.h"
#import "FLXSFlexDataGridColumn.h"


@implementation FLXSEvent
    static NSString * EVENT_KEY_UP = @"FLXS_EVENT_KEY_UP";
    static NSString * EVENT_DELAYED_CHANGE = @"FLXS_EVENT_DELAYED_CHANGE";
    static NSString * EVENT_CHANGE = @"FLXS_EVENT_CHANGE";
    static NSString * RESIZE = @"FLXS_RESIZE";
    + (NSString *)DICTIONARY_KEY
    {
        return @"event";
    }
    + (NSString *)RESIZE
    {
        return RESIZE;
    }
    + (NSString *)EVENT_KEY_UP
    {
        return EVENT_KEY_UP;
    }
    + (NSString *)EVENT_DELAYED_CHANGE
    {
        return EVENT_DELAYED_CHANGE;
    }
    + (NSString *)EVENT_CHANGE
    {
        return EVENT_CHANGE;
    }


    @synthesize target;
    @synthesize isDefaultPrevented;
    @synthesize type;

    -(id)initWithType:(NSString*)typeIn
        andCancelable:(BOOL)cancelableIn
           andBubbles:(BOOL)bubblesIn{
        self = [super init];
        if (self)
        {
            self.bubbles = bubblesIn;
            self.cancelable=cancelableIn;
            self.type = typeIn;
        }
        return self;
    }

    -(id)initWithType:(NSString*)typeIn {
        self = [super init];
        if (self)
        {
            self.type = typeIn;
        }
        return self;
    }
    -(void)preventDefault {
        self.isDefaultPrevented=true;
    }

@end