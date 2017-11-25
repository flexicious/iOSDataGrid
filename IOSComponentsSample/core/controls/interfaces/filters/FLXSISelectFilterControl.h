#import "FLXSIFilterControl.h"
#import "FLXSVersion.h"
/**
* Implemented by the ComboBox,MultiSelectComboBox,RadioButtonList,DateComboBox
* to enable to participate in the Filtering Infrastructure.
*/
@protocol FLXSISelectFilterControl <FLXSIFilterControl>
@property (nonatomic,strong) NSArray * dataProviderFLXS;
@property (nonatomic,strong) NSString * dataFieldFLXS;
@property (nonatomic,strong) NSString * labelField;
@property (nonatomic,strong) NSString * addAllItemText;
@property (nonatomic, assign) BOOL addAllItem;
@property (nonatomic,assign) float dropDownWidth;
@end

