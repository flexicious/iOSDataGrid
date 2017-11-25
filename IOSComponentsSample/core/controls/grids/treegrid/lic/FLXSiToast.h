#import "FLXSVersion.h"
/*

iToast.h

MIT LICENSE

Copyright (c) 2011 Travis CI development team

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum FLXSiToastGravity {
    iToastGravityTop = 1000001,
    iToastGravityBottom,
    iToastGravityCenter
} FLXSiToastGravity;

typedef enum FLXSiToastDuration {
    iToastDurationLong = 10000,
    iToastDurationShort = 1000,
    iToastDurationNormal = 3000
} FLXSiToastDuration;

typedef enum FLXSiToastType {
    iToastTypeInfo = -100000,
    iToastTypeNotice,
    iToastTypeWarning,
    iToastTypeError,
    iToastTypeNone // For internal use only (to force no image)
} FLXSiToastType;

typedef enum {
    iToastImageLocationTop,
    iToastImageLocationLeft
} FLXSiToastImageLocation;


@class FLXSiToastSettings;

@interface FLXSiToast : NSObject {
    FLXSiToastSettings *_settings;
    NSInteger offsetLeft;
    NSInteger offsetTop;

    NSTimer *timer;

    UIView *view;
    NSString *text;
}

- (void) show;
- (void) show:(FLXSiToastType) type;
- (FLXSiToast *) setDuration:(NSInteger ) duration;
- (FLXSiToast *) setGravity:(FLXSiToastGravity) gravity
             offsetLeft:(NSInteger) left
              offsetTop:(NSInteger) top;
- (FLXSiToast *) setGravity:(FLXSiToastGravity) gravity;
+ (FLXSiToast *) makeText:(NSString *) text;

-(FLXSiToastSettings *) theSettings;

@end



@interface FLXSiToastSettings : NSObject<NSCopying>{
    NSInteger duration;
    FLXSiToastGravity gravity;
    CGPoint position;
    FLXSiToastType toastType;

    NSDictionary *images;

    BOOL positionIsSet;
}


@property(assign) NSInteger duration;
@property(assign) FLXSiToastGravity gravity;
@property(assign) CGPoint position;
@property(readonly) NSDictionary *images;
@property(assign) FLXSiToastImageLocation imageLocation;


- (void) setImage:(UIImage *)img forType:(FLXSiToastType) type;
- (void) setImage:(UIImage *)img withLocation:(FLXSiToastImageLocation)location forType:(FLXSiToastType)type;
+ (FLXSiToastSettings *) getSharedSettings;

@end