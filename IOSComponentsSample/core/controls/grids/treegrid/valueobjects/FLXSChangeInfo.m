#import "FLXSChangeInfo.h"

static const NSString* CHANGE_TYPE_INSERT = @"insert";
static const NSString* CHANGE_TYPE_UPDATE = @"update";
static const NSString* CHANGE_TYPE_DELETE = @"delete";

@implementation FLXSChangeInfo

@synthesize changedItem;
@synthesize changedProperty;
@synthesize previousValue;
@synthesize changedValue;
@synthesize origValue;
@synthesize changeType;
@synthesize changeLevelNestDepth;

- (id)initWithChangedItem:(NSObject *)changedItemIn changeLevelNestDepth:(int)changeLevelNestDepthIn changedProperty:(NSString *)changedPropertyIn previousValue:(NSObject *)previousValueIn changedValue:(NSObject *)newValueIn changeType:(NSString *)changeTypeIn {
	self = [super init];
	if (self)
	{
		self.changeLevelNestDepth = changeLevelNestDepthIn;
		self.changedItem=changedItemIn;
		self.changedProperty=changedPropertyIn;
		self.previousValue=previousValueIn;
		self.changedValue=newValueIn;
		self.changeType=changeTypeIn;
		self.origValue=previousValueIn;
	}
	return self;
}

-(NSString*)description {
    return	[[[NSArray alloc] initWithObjects:
            @" NestDepth:", [NSNumber numberWithInt:changeLevelNestDepth],
                    @" previousValue:",previousValue,
                    @" newValue:",@":" ,  changedValue,
                    @" changeType:",@":" ,  changeType,
                    @" changedProperty:",@":" , changedProperty ,nil] componentsJoinedByString:@""];
}
+ (NSString*)CHANGE_TYPE_INSERT
{
	return [CHANGE_TYPE_INSERT description];
}
+ (NSString*)CHANGE_TYPE_UPDATE
{
	return [CHANGE_TYPE_UPDATE description];
}
+ (NSString*)CHANGE_TYPE_DELETE
{
	return [CHANGE_TYPE_DELETE description];
}
@end

