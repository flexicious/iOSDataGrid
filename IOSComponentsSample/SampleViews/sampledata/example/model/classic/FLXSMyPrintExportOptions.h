@class FLXSPrintExportOptions;

@interface FLXSMyPrintExportOptions : NSObject
{

}

@property (nonatomic, strong) NSString* printExportOption;
@property (nonatomic, assign) float pageFrom;
@property (nonatomic, assign) float pageTo;

-(id)initWithOptions:(FLXSPrintExportOptions*)options;

@end

