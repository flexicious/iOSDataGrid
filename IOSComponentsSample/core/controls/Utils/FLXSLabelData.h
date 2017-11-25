#import "FLXSVersion.h"

@interface FLXSLabelData : NSObject
@property (nonatomic, strong) NSString* name;

@property (nonatomic, strong) NSString* label;
@property (nonatomic, strong) NSString* data;
-(id)initWithLabel:(NSString *)label andData:(NSString *)data;
@end