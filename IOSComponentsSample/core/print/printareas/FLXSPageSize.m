//#import "FLXSPageSize.h"
//
//static NSString* PAGE_LAYOUT_POTRAIT = @"Portrait";
//static NSString* PAGE_LAYOUT_LANDSCAPE = @"Landscape";
//static FLXSPageSize* PAGE_SIZE_A3 ;
//static FLXSPageSize* PAGE_SIZE_A4 ;
//static FLXSPageSize* PAGE_SIZE_A5 ;
//static FLXSPageSize* PAGE_SIZE_LEGAL ;
//static FLXSPageSize* PAGE_SIZE_LETTER ;
//
//@implementation FLXSPageSize
//
//
//- (id)initWithName:(NSString *)name andWidth:(int)width andHeight:(int)height {
//	self = [super init];
//	if (self)
//	{
//        if(!PAGE_SIZE_A3)
//            PAGE_SIZE_A3 = [[FLXSPageSize alloc] initWithName:(@"A3") andWidth:842 andHeight:1191];
//        if(!PAGE_SIZE_A4)
//            PAGE_SIZE_A4 = [[FLXSPageSize alloc] initWithName:(@"A4") andWidth:595 andHeight:842];
//        if(!PAGE_SIZE_A5)
//            PAGE_SIZE_A5 = [[FLXSPageSize alloc] initWithName:(@"A5") andWidth:420 andHeight:595];
//        if(!PAGE_SIZE_LEGAL)
//            PAGE_SIZE_LEGAL = [[FLXSPageSize alloc] initWithName:(@"Legal") andWidth:612 andHeight:1008];
//        if(!PAGE_SIZE_LETTER)
//            PAGE_SIZE_LETTER = [[FLXSPageSize alloc] initWithName:(@"Letter") andWidth:612 andHeight:792];
//
//        _isLandscape = NO;
//
//		self.name = name;
//		self.width = width;
//		self.height = height;
//	}
//	return self;
//}
//
//+(FLXSPageSize*)getByName:(NSString*)name
//{
//	return [name isEqual:@"A3"]?[PAGE_SIZE_A3 clone]:[name isEqual:@"A4"]?[PAGE_SIZE_A4 clone]:[name isEqual:@"A5"]?[PAGE_SIZE_A5 clone]:[name isEqual:@"Letter"]?[PAGE_SIZE_LETTER clone]:[name isEqual:@"Legal"]?PAGE_SIZE_LEGAL:[PAGE_SIZE_A4 clone];
//}
//
//+ (FLXSPageSize *)getBySize:(int)width height:(int)height {
//    return (width==[PAGE_SIZE_A3 width] && height==[PAGE_SIZE_A3 height])?[PAGE_SIZE_A3 clone]:
//            (width==[PAGE_SIZE_A3 height]&& height==[PAGE_SIZE_A3 width] )?   [[PAGE_SIZE_A3 clone] rotate]
//           :(width==[PAGE_SIZE_A4 width] && height==[PAGE_SIZE_A4 height])?[PAGE_SIZE_A4 clone]:
//            (width==[PAGE_SIZE_A4 height]&& height==[PAGE_SIZE_A4 width] )?[[PAGE_SIZE_A4 clone] rotate]
//            :(width==[PAGE_SIZE_A5 width] && height==[PAGE_SIZE_A5 height])?[PAGE_SIZE_A5 clone]:
//            (width==[PAGE_SIZE_A5 height]&& height==[PAGE_SIZE_A5 width] )?[[PAGE_SIZE_A5 clone] rotate]
//            :(width==[PAGE_SIZE_LEGAL width] && height==[PAGE_SIZE_LEGAL height])?[PAGE_SIZE_LEGAL clone]
//            :(width==[PAGE_SIZE_LEGAL height]&& height==[PAGE_SIZE_LEGAL width] )?[[PAGE_SIZE_LEGAL clone] rotate]
//            :(width==[PAGE_SIZE_LETTER width] && height==[PAGE_SIZE_LETTER height])?[PAGE_SIZE_LETTER clone]
//            :(width==[PAGE_SIZE_LETTER height]&& height==[PAGE_SIZE_LETTER width] )?[[PAGE_SIZE_LETTER clone] rotate]
//            : [[FLXSPageSize alloc] initWithName:(@"Custom") andWidth:width andHeight:height];
//
//}
//
//-(FLXSPageSize*)clone
//{
//	return [[FLXSPageSize alloc] initWithName:self.name andWidth:self.width andHeight:self.height];
//}
//
//-(FLXSPageSize*)rotate
//{
//	self.isLandscape=!self.isLandscape;
//	return self;
//}
//
//-(NSString*)name
//{
//	return _name;
//}
//
//
//-(int)width
//{
//	return _isLandscape?_height:_width;
//}
//
//
//-(int)height
//{
//	return _isLandscape?_width:_height;
//}
//
//-(BOOL)isLandscape
//{
//	return _isLandscape;
//}
//
//
//+ (NSString*)PAGE_LAYOUT_POTRAIT
//{
//	return PAGE_LAYOUT_POTRAIT;
//}
//+ (NSString*)PAGE_LAYOUT_LANDSCAPE
//{
//	return PAGE_LAYOUT_LANDSCAPE;
//}
//+ (FLXSPageSize*)PAGE_SIZE_A3
//{
//	return PAGE_SIZE_A3;
//}
//+ (FLXSPageSize*)PAGE_SIZE_A4
//{
//	return PAGE_SIZE_A4;
//}
//+ (FLXSPageSize*)PAGE_SIZE_A5
//{
//	return PAGE_SIZE_A5;
//}
//+ (FLXSPageSize*)PAGE_SIZE_LEGAL
//{
//	return PAGE_SIZE_LEGAL;
//}
//+ (FLXSPageSize*)PAGE_SIZE_LETTER
//{
//	return PAGE_SIZE_LETTER;
//}
//@end
//
