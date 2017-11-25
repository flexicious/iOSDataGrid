//
//  iPhoneThemePickerViewController.m
//  IOSComponentsSample
//
//  Created by Flexicious-111 on 8/1/13.
//  Copyright (c) 2013 ___IOSComponents___. All rights reserved.
//

#import "iPhoneThemePickerViewController.h"

@interface iPhoneThemePickerViewController ()

@end

@implementation iPhoneThemePickerViewController
@synthesize arrayThemeValues, tableViewThemeValues;
@synthesize theDelegate = _theDelegate;

-(void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(closePopup)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.title = @"Pick A Theme";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return     arrayThemeValues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell    alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [self.arrayThemeValues objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryNone;

    if (selectedIndex == indexPath.row)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }

    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType == UITableViewCellAccessoryNone)
    {
        selectedIndex = indexPath.row;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    [_theDelegate applyTheme:(int)selectedIndex];
    [tableView  reloadData];
    [self closePopup];
}
- (void)viewDidUnload {
    [self setTableViewThemeValues:nil];
    [super viewDidUnload];
}


@end
