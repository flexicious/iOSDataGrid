#import "iPadiTunesViewController.h"
#import "FLXSFlexiciousMockGenerator.h"
#import "SampleUIUtils.h"

@interface iPadiTunesViewController ()

@end


@implementation iPadiTunesViewController {
    UISearchBar *mySearchBar;
}
- (void)viewDidLoad {

    [super viewDidLoad];

    [self setUpUI];
    [self setUpGrid];
    [self setUpInitialData];

    [self initializeTitleOfToolBar : @"iTunes Search"];
    self.flxsDataGrid.delegate = self;
}

- (void)setUpInitialData {
    NSURL *url = [NSURL URLWithString:@"http://204.196.140.120:89/getjson.php"];
    NSData *jsonFileData = [NSData dataWithContentsOfURL:url];
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:jsonFileData options:0 error:&error];
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *results = object;
        _flxsDataGrid.dataProviderFLXS = [results valueForKey:@"results"];
    }else if([object isKindOfClass:[NSArray class]]){
        _flxsDataGrid.dataProviderFLXS = object;
    }
}

- (void)setUpGrid {
    _flxsDataGrid.delegate = self;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"FLXSItunesJsonUrl" ofType:@"xml"];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    [_flxsDataGrid buildFromXML:fileData];
}

- (void)setUpUI { 
}
@end
