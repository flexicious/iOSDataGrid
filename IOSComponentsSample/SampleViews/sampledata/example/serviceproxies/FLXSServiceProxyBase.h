
@interface FLXSServiceProxyBase : NSObject
{
}
@property (nonatomic, strong) NSMutableArray * messageQueue;
-(void)callServiceMethod:(NSObject*)token :(SEL)resultFunction :(NSObject *)target;

@end

