//
//  iPadRowSpanandColSpanViewController.m
//  IOSComponentsSample
//
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPadRowSpanandColSpanViewController.h"
#import "FLXSFlexiciousMockGenerator.h"

@interface iPadRowSpanandColSpanViewController (){
    NSMutableArray* questions;

}

@end

@implementation iPadRowSpanandColSpanViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    questions = [[NSMutableArray alloc] init];
     self.flxsDataGrid.delegate=self;
   
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSRowSpanColSpan"];
    [self initializeTitleOfToolBar:@"RowSpanColSpan"];

}

-(void)addQuestion:(NSString*)questionText{
    NSMutableDictionary* q = [[NSMutableDictionary alloc] init];
    //q.question=questionText; =
    [q setObject:questionText forKey:@"question"];
    //q.answers = new ArrayCollection(); =
    [q setObject:[[NSMutableArray alloc]init] forKey:@"answers"];
    //addAnswers(q);
    [self addAnswers:q];
    [questions addObject:q];
}
-(void) addAnswers:(NSMutableDictionary*)q
{
    
    NSMutableArray* answers = [q objectForKey:@"answers"];
    [answers addObject:[self createAnswer:@"Very Satisfied"]];
    [answers addObject:[self createAnswer:@"Moderately Satisfied"]];
    [answers addObject:[self createAnswer:@"No Opinion/NA"]];
    [answers addObject:[self createAnswer:@"Moderately Dissatisfied"]];
    [answers addObject:[self createAnswer:@"Very Satisfied"] ];
    float total= [FLXSUIUtils sum:answers fld:@"totalCount"];
    for(NSMutableDictionary* a in answers){
        [a setObject:[NSNumber numberWithFloat:100*[[a objectForKey:@"totalCount"] floatValue]/total] forKey:@"totalPercent"];
    }
    [q setObject:[NSNumber numberWithFloat:[FLXSUIUtils sum:answers fld:@"freshmanCount"]] forKey:@"freshmanCount"];
    [q setObject:[NSNumber numberWithFloat:[FLXSUIUtils sum:answers fld:@"sophomoreCount"]] forKey:@"sophomoreCount"];
    [q setObject:[NSNumber numberWithFloat:[FLXSUIUtils sum:answers fld:@"juniorCount"]] forKey:@"juniorCount"];
    [q setObject:[NSNumber numberWithFloat:[FLXSUIUtils sum:answers fld:@"seniorCount"]] forKey:@"seniorCount"];
   
    [q setObject:[NSNumber numberWithFloat:([[q objectForKey:@"freshmanCount"] floatValue]+[[q objectForKey:@"sophomoreCount"]floatValue]+[[q objectForKey:@"juniorCount"]floatValue]+[[q objectForKey:@"seniorCount"]floatValue])] forKey:@"totalCount"];
                                            
    [q setObject:[NSNumber numberWithFloat:(100*[[q objectForKey:@"freshmanCount"] floatValue]/[[q objectForKey:@"totalCount"]floatValue])] forKey:@"freshmanPercent"];
    [q setObject:[NSNumber numberWithFloat:(100*[[q objectForKey:@"sophomoreCount"]floatValue]/[[q objectForKey:@"totalCount"] floatValue])] forKey:@"sophomorePercent"];
    [q setObject:[NSNumber numberWithFloat:(100*[[q objectForKey:@"juniorCount"]floatValue]/[[q objectForKey:@"totalCount"]floatValue])] forKey:@"juniorPercent"]; 
    [q setObject:[NSNumber numberWithFloat:(100*[[q objectForKey:@"seniorCount"]floatValue]/[[q objectForKey:@"totalCount"] floatValue])] forKey:@"seniorPercent"]; 
    [q setObject:[NSNumber numberWithInt:100] forKey:@"totalPercent"];
}
-(NSObject*)createAnswer:(NSString*)answerOption
{
    NSMutableDictionary* a=[[NSMutableDictionary alloc]init];
    [a setObject:answerOption forKey:@"answerOption"];
    [a setObject:[NSNumber numberWithFloat:[FLXSFlexiciousMockGenerator getRandom:100 :400]] forKey:@"freshmanCount"];
    [a setObject:[NSNumber numberWithFloat:[FLXSFlexiciousMockGenerator getRandom:100 :400]] forKey:@"sophomoreCount"];
    [a setObject:[NSNumber numberWithFloat:[FLXSFlexiciousMockGenerator getRandom:100 :400]] forKey:@"juniorCount"];
    [a setObject:[NSNumber numberWithFloat:[FLXSFlexiciousMockGenerator getRandom:100 :400]] forKey:@"seniorCount"];
    
    [ a setObject:[NSNumber numberWithFloat:([[a objectForKey:@"freshmanCount" ] floatValue]+[[a objectForKey:@"sophomoreCount"]floatValue]+[[a objectForKey:@"juniorCount"] floatValue]+[[a objectForKey:@"seniorCount"] floatValue]) ] forKey:@"totalCount"] ;
    [a setObject:[NSNumber numberWithFloat:(100*[[a objectForKey:@"freshmanCount"]floatValue]/[[a objectForKey:@"totalCount"]floatValue])] forKey:@"freshmanPercent"];
    [a setObject:[NSNumber numberWithFloat:(100*[[a objectForKey:@"freshmanCount"]floatValue]/[[a objectForKey:@"totalCount"] floatValue])] forKey:@"sophomorePercent"]; 
    [a setObject:[NSNumber numberWithFloat:(100*[[a objectForKey:@"juniorCount"]floatValue]/[[a objectForKey:@"totalCount"] floatValue])] forKey:@"juniorPercent"]; 
    [a setObject:[NSNumber numberWithFloat:(100*[[a objectForKey:@"seniorCount"]floatValue]/[[a objectForKey:@"totalCount"] floatValue])] forKey:@"seniorPercent"]; 
    return a;
}

-(void)rowSpanColSpan_CreationComplete:(NSNotification*)ns
{
   [self addQuestion:@"Please rate your level of satisfaction with the sense of safety and security as experienced in your residential college/housing campus"];
  [self addQuestion:@"Please rate your level of satisfaction with the availability of public transportation to and from the University Campus"];
    [self addQuestion:@"Please rate your level of satisfaction with the quality of the Intramural sports and recreation programs"];
    [self  addQuestion:@"Please rate your level of satisfaction with your sense of acceptance, belonging, and community"];
    self.flxsDataGrid.dataProviderFLXS =questions;
    [self.flxsDataGrid validateNow];
    [self.flxsDataGrid expandAll];
}
-(NSNumber *)rowSpanColSpan_getRowSpan:(UIView<FLXSIFlexDataGridCell>*)cell{
    if(self.segmentControl.selectedSegmentIndex != 0) return [NSNumber numberWithInt:1];
    if(cell.level.nestDepth==1 //top level
       && [cell.level isItemOpen:cell.rowInfo.data]//item is open
       && cell.columnFLXS
       && [cell.columnFLXS.dataFieldFLXS isEqual:@"question"] //its the first column
       && cell.rowInfo.isDataRow //its the data row, not the header or the footer row
       && !cell.rowInfo.isFillRow//since the filler is also considered a data row
       ){
        NSDictionary* dic = (NSDictionary*)cell.rowInfo.data;
        NSArray* arr = (NSArray*)[dic objectForKey:@"answers"];
        return [NSNumber numberWithInt:(int)arr.count+1];
    }

    return [NSNumber numberWithInt:1];
}
-(NSNumber *)rowSpanColSpan_getColSpan:(UIView<FLXSIFlexDataGridCell>*)cell{
   if(self.segmentControl.selectedSegmentIndex != 1) return [NSNumber numberWithInt:1];
    if(cell.level.nestDepth==1 //top level
       && cell.columnFLXS
       && [cell.columnFLXS.dataFieldFLXS isEqual:@"question"] //its the first column
       && cell.rowInfo.isDataRow //its the data row, not the header or the footer row
       && !cell.rowInfo.isFillRow//since the filler is also considered a data row
       )
        return [NSNumber numberWithInt:(int)[[self.flxsDataGrid getColumns] count]];
    
    return [NSNumber numberWithInt:1];
}
-(NSObject*)rowSpanColSpan_getColor:(UIView<FLXSIFlexDataGridCell>*)cell{
    if(cell.level.nestDepth==1 //top level
       && cell.columnFLXS
       && [cell.columnFLXS.dataFieldFLXS isEqual:@"question"] //its the first column
       && cell.rowInfo.isDataRow //its the data row, not the header or the footer row
       )
        return [[FLXSStyleManager instance] getUIColorObjectFromHexString:0xF7F3F7];
    
    return nil;
}
- (IBAction)segment_ValueChanged:(id)sender {
     
    [self.flxsDataGrid rebuild];
}
- (IBAction)segment_Click:(id)sender {
    
    
}
- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [self setIPadToolBar:nil];
    [self setSegmentControl:nil];
    [super viewDidUnload];
}
@end
