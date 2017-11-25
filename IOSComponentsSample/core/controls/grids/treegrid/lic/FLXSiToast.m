/*

iToast.m

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


#import "FLXSiToast.h"
#import "FLXSUIUtils.h"
#import <QuartzCore/QuartzCore.h>

#define CURRENT_TOAST_TAG 6984678

static const float kComponentPadding = 5;

static FLXSiToastSettings *sharedSettings = nil;

@interface FLXSiToast (private)

- (FLXSiToast *) settings;
- (CGRect)_toastFrameForImageSize:(CGSize)imageSize withLocation:(FLXSiToastImageLocation)location andTextSize:(CGSize)textSize;
- (CGRect)_frameForImage:(FLXSiToastType)type inToastFrame:(CGRect)toastFrame;

@end


@implementation FLXSiToast


- (id) initWithText:(NSString *) tex{
    if (self = [super init]) {
        text = [tex copy];
    }

    return self;
}

- (void) show{
    [self show:iToastTypeNone];
}

- (void) show:(FLXSiToastType) type {

    FLXSiToastSettings *theSettings = _settings;

    if (!theSettings) {
        theSettings = [FLXSiToastSettings getSharedSettings];
    }

    UIImage *image = [theSettings.images valueForKey:[NSString stringWithFormat:@"%i", type]];

    UIFont *font = [UIFont systemFontOfSize:16];
    CGSize textSize = [text sizeWithFont:font constrainedToSize:CGSizeMake(280, 60)];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width + kComponentPadding, textSize.height + kComponentPadding)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = font;
    label.text = text;
    label.numberOfLines = 0;
    label.shadowColor = [UIColor darkGrayColor];
    label.shadowOffset = CGSizeMake(1, 1);

    UIButton *v = [UIButton buttonWithType:UIButtonTypeCustom];
    if (image) {
        v.frame = [self _toastFrameForImageSize:image.size withLocation:[theSettings imageLocation] andTextSize:textSize];

        switch ([theSettings imageLocation]) {
            case iToastImageLocationLeft:
                [label setTextAlignment:NSTextAlignmentLeft];
                label.center = CGPointMake(image.size.width + kComponentPadding * 2
                        + (v.frame.size.width - image.size.width - kComponentPadding * 2) / 2,
                        v.frame.size.height / 2);
                break;
            case iToastImageLocationTop:
                [label setTextAlignment:NSTextAlignmentCenter];
                label.center = CGPointMake(v.frame.size.width / 2,
                        (image.size.height + kComponentPadding * 2
                                + (v.frame.size.height - image.size.height - kComponentPadding * 2) / 2));
                break;
            default:
                break;
        }

    } else {
        v.frame = CGRectMake(0, 0, textSize.width + kComponentPadding * 2, textSize.height + kComponentPadding * 2);
        label.center = CGPointMake(v.frame.size.width / 2, v.frame.size.height / 2);
    }
    CGRect lbfrm = label.frame;
    lbfrm.origin.x = ceil(lbfrm.origin.x);
    lbfrm.origin.y = ceil(lbfrm.origin.y);
    label.frame = lbfrm;
    [v addSubview:label];
    //[label release];

    if (image) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = [self _frameForImage:type inToastFrame:v.frame];
        [v addSubview:imageView];
      //  [imageView release];
    }

    v.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    v.layer.cornerRadius = 5;

    UIWindow *window = [FLXSUIUtils getTopLevelWindow];

    CGPoint point;

    // Set correct orientation/location regarding device orientation
    UIInterfaceOrientation orientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    switch (orientation) {
        case UIDeviceOrientationPortrait:
        {
            if (theSettings.gravity == iToastGravityTop) {
                point = CGPointMake(window.frame.size.width / 2, 45);
            } else if (theSettings.gravity == iToastGravityBottom) {
                point = CGPointMake(window.frame.size.width / 2, window.frame.size.height - 45);
            } else if (theSettings.gravity == iToastGravityCenter) {
                point = CGPointMake(window.frame.size.width/2, window.frame.size.height/2);
            } else {
                point = theSettings.position;
            }

            point = CGPointMake(point.x + offsetLeft, point.y + offsetTop);
            break;
        }
        case UIDeviceOrientationPortraitUpsideDown:
        {
            v.transform = CGAffineTransformMakeRotation(M_PI);

            float width = window.frame.size.width;
            float height = window.frame.size.height;

            if (theSettings.gravity == iToastGravityTop) {
                point = CGPointMake(width / 2, height - 45);
            } else if (theSettings.gravity == iToastGravityBottom) {
                point = CGPointMake(width / 2, 45);
            } else if (theSettings.gravity == iToastGravityCenter) {
                point = CGPointMake(width/2, height/2);
            } else {
                point = theSettings.position;
            }

            point = CGPointMake(point.x - offsetLeft, point.y - offsetTop);
            break;
        }
        case UIDeviceOrientationLandscapeLeft:
        {
            v.transform = CGAffineTransformMakeRotation(M_PI/2); //rotation in radians

            if (theSettings.gravity == iToastGravityTop) {
                point = CGPointMake(window.frame.size.width - 45, window.frame.size.height / 2);
            } else if (theSettings.gravity == iToastGravityBottom) {
                point = CGPointMake(45,window.frame.size.height / 2);
            } else if (theSettings.gravity == iToastGravityCenter) {
                point = CGPointMake(window.frame.size.width/2, window.frame.size.height/2);
            } else {
                point = theSettings.position;
            }

            point = CGPointMake(point.x - offsetTop, point.y - offsetLeft);
            break;
        }
        case UIDeviceOrientationLandscapeRight:
        {
            v.transform = CGAffineTransformMakeRotation(-M_PI/2);

            if (theSettings.gravity == iToastGravityTop) {
                point = CGPointMake(45, window.frame.size.height / 2);
            } else if (theSettings.gravity == iToastGravityBottom) {
                point = CGPointMake(window.frame.size.width - 45, window.frame.size.height/2);
            } else if (theSettings.gravity == iToastGravityCenter) {
                point = CGPointMake(window.frame.size.width/2, window.frame.size.height/2);
            } else {
                point = theSettings.position;
            }

            point = CGPointMake(point.x + offsetTop, point.y + offsetLeft);
            break;
        }
        default:
            break;
    }

    v.center = point;

    NSTimer *timer1 = [NSTimer timerWithTimeInterval:((float)theSettings.duration)/1000
                                              target:self selector:@selector(hideToast:)
                                            userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:timer1 forMode:NSDefaultRunLoopMode];

    v.tag = CURRENT_TOAST_TAG;

    UIView *currentToast = [window viewWithTag:CURRENT_TOAST_TAG];
    if (currentToast != nil) {
        [currentToast removeFromSuperview];
    }

    v.alpha = 0;
    [window addSubview:v];
    [window bringSubviewToFront:v];
    [UIView beginAnimations:nil context:nil];
    v.alpha = 1;
    [UIView commitAnimations];

    //view = [v retain];

    [v addTarget:self action:@selector(hideToast:) forControlEvents:UIControlEventTouchDown];
}

- (CGRect)_toastFrameForImageSize:(CGSize)imageSize withLocation:(FLXSiToastImageLocation)location andTextSize:(CGSize)textSize {
    CGRect theRect = CGRectZero;
    switch (location) {
        case iToastImageLocationLeft:
            theRect = CGRectMake(0, 0,
                    imageSize.width + textSize.width + kComponentPadding * 3,
                    MAX(textSize.height, imageSize.height) + kComponentPadding * 2);
            break;
        case iToastImageLocationTop:
            theRect = CGRectMake(0, 0,
                    MAX(textSize.width, imageSize.width) + kComponentPadding * 2,
                    imageSize.height + textSize.height + kComponentPadding * 3);

        default:
            break;
    }
    return theRect;
}

- (CGRect)_frameForImage:(FLXSiToastType)type inToastFrame:(CGRect)toastFrame {
    FLXSiToastSettings *theSettings = _settings;
    UIImage *image = [theSettings.images valueForKey:[NSString stringWithFormat:@"%i", type]];

    if (!image) return CGRectZero;

    CGRect imageFrame = CGRectZero;

    switch ([theSettings imageLocation]) {
        case iToastImageLocationLeft:
            imageFrame = CGRectMake(kComponentPadding, (toastFrame.size.height - image.size.height) / 2, image.size.width, image.size.height);
            break;
        case iToastImageLocationTop:
            imageFrame = CGRectMake((toastFrame.size.width - image.size.width) / 2, kComponentPadding, image.size.width, image.size.height);
            break;

        default:
            break;
    }

    return imageFrame;

}

- (void) hideToast:(NSTimer*)theTimer{
    [UIView beginAnimations:nil context:NULL];
    view.alpha = 0;
    [UIView commitAnimations];

    UIWindow *window = [FLXSUIUtils getTopLevelWindow];
    UIView *currentToast = [window viewWithTag:CURRENT_TOAST_TAG];
    if (currentToast != nil) {
        [currentToast removeFromSuperview];
    }


}

+ (FLXSiToast *) makeText:(NSString *) _text{
    FLXSiToast *toast = [[FLXSiToast alloc] initWithText:_text] ;

    return toast;
}


- (FLXSiToast *) setDuration:(NSInteger ) duration{
    [self theSettings].duration = duration;
    return self;
}

- (FLXSiToast *) setGravity:(FLXSiToastGravity) gravity
             offsetLeft:(NSInteger) left
              offsetTop:(NSInteger) top{
    [self theSettings].gravity = gravity;
    offsetLeft = left;
    offsetTop = top;
    return self;
}

- (FLXSiToast *) setGravity:(FLXSiToastGravity) gravity{
    [self theSettings].gravity = gravity;
    return self;
}

- (FLXSiToast *) setPostion:(CGPoint) _position{
    [self theSettings].position = CGPointMake(_position.x, _position.y);

    return self;
}

-(FLXSiToastSettings *) theSettings{
    if (!_settings) {
        _settings = [[FLXSiToastSettings getSharedSettings] copy];
    }

    return _settings;
}

@end


@implementation FLXSiToastSettings
@synthesize duration;
@synthesize gravity;
@synthesize position;
@synthesize images;
@synthesize imageLocation;

- (void) setImage:(UIImage *) img withLocation:(FLXSiToastImageLocation)location forType:(FLXSiToastType) type {
    if (type == iToastTypeNone) {
        // This should not be used, internal use only (to force no image)
        return;
    }

    if (!images) {
        images = [[NSMutableDictionary alloc] initWithCapacity:4];
    }

    if (img) {
        NSString *key = [NSString stringWithFormat:@"%i", type];
        [images setValue:img forKey:key];
    }

    [self setImageLocation:location];
}

- (void)setImage:(UIImage *)img forType:(FLXSiToastType)type {
    [self setImage:img withLocation:iToastImageLocationLeft forType:type];
}


+ (FLXSiToastSettings *) getSharedSettings{
    if (!sharedSettings) {
        sharedSettings = [FLXSiToastSettings new];
        sharedSettings.gravity = iToastGravityCenter;
        sharedSettings.duration = iToastDurationShort;
    }

    return sharedSettings;

}

- (id) copyWithZone:(NSZone *)zone{
    FLXSiToastSettings *copy = [FLXSiToastSettings new];
    copy.gravity = self.gravity;
    copy.duration = self.duration;
    copy.position = self.position;

    NSArray *keys = [self.images allKeys];

    for (NSString *key in keys){
        [copy setImage:[images valueForKey:key] forType:[key intValue]];
    }

    [copy setImageLocation:imageLocation];

    return copy;
}

@end