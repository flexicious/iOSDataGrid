
@interface FLXSClassicAddress : NSObject

@property (nonatomic, strong) NSString* street1;
@property (nonatomic, strong) NSString* street2;
@property (nonatomic, strong) NSString* city;
@property (nonatomic, strong) NSString* state;
@property (nonatomic, strong) NSString* country;
@property (nonatomic, assign) float apartmentNumber;
@property (nonatomic, strong) NSDate* validFrom;
@property (nonatomic, strong) NSDate* validTo;
@end