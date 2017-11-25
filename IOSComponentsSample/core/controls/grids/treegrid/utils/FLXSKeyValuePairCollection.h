#import "FLXSVersion.h"

@interface FLXSKeyValuePairCollection : NSObject
{

}

@property (nonatomic, strong) NSMutableArray* keys;
@property (nonatomic, strong) NSMutableArray* values;

- (void)addItem:(NSObject *)key value:(NSObject *)value;
-(void)removeItem:(NSObject*)key;
-(NSObject*)getValue:(NSObject*)key;
-(BOOL)hasHey:(NSObject*)key;
-(void)clear;
@end

