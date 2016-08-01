//
//  ViewControllerSettings.m
//  TableViewExample
//
//  Created by Alexandra on 01/08/16.
//  Copyright © 2016 Alexandra. All rights reserved.
//

#import "ViewControllerSettings.h"
#import "Source.h"

@interface ViewControllerSettings ()

@property NSMutableArray* sources;

@end

@implementation ViewControllerSettings

- (instancetype)initWithSources: (NSArray*) sources
{
    self = [super init];
    if (self) {
        _sources = [[NSMutableArray alloc] initWithArray:sources];
    }
    return self;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    UISwitch *aSwitch = [[UISwitch alloc] init];
    static const NSInteger SW_WIDTH = 60;
    static const NSInteger INDENT = 5;

    aSwitch.frame = CGRectMake(self.view.bounds.size.width- SW_WIDTH, INDENT, SW_WIDTH, 0);
    Source *source = nil;
    if ([_sources[indexPath.row] isKindOfClass:[Source class]]) {
        source = _sources[indexPath.row];
    }
    aSwitch.on = source.isOn;
    [aSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    [cell.contentView addSubview:aSwitch];
    cell.textLabel.text = source.name;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _sources.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
        return @"Источники:";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40; //play around with this value
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(performBackNavigation:)];
    self.navigationItem.leftBarButtonItem = newBackButton;
    //[self.navigationItem.backBarButtonItem setAction:@selector(performBackNavigation:)];
}

-(void)switchChanged:(id)sender{
    if ([sender isKindOfClass:[UISwitch class]]){
        
        UISwitch* aSwitch = (UISwitch*)sender;
        UITableViewCell* cellCV= (UITableViewCell*)[aSwitch superview];
        UITableViewCell* cell= (UITableViewCell*)[cellCV superview];
        UITableView* tableWV = (UITableView *)[cell superview];
        UITableView* table = (UITableView *)[tableWV superview];
        NSIndexPath* pathOfTheCell = [table indexPathForCell:cell];
        NSInteger rowOfTheCell = [pathOfTheCell row];
        
        Source* source = _sources[rowOfTheCell];
        source.isOn = aSwitch.on;
        [_sources replaceObjectAtIndex:rowOfTheCell withObject: source];
        
    }
}

- (void)performBackNavigation:(id)sender
{
    // Do operations
    
    _returnSettings(_sources);
    
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
