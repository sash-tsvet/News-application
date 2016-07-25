//
//  ViewController.m
//  TableViewExample
//
//  Created by Alexandra on 25/07/16.
//  Copyright © 2016 Alexandra. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerDataSource.h"
#import "ViewControllerDelegate.h"
#import "ViewControllerLabeled.h"

@interface ViewController () 

@property UITableView *tableView;
@property ViewControllerDataSource *dataSource;
@property ViewControllerDelegate *delegate;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.tableView];
    
    _dataSource = [ViewControllerDataSource new];
    _delegate = [ViewControllerDelegate new];
    
    
    __weak typeof(self) weakSelf = self;
    [_delegate setStartNavigation:^ (int num){
        
        ViewControllerLabeled *vc = [[ViewControllerLabeled alloc] initWithNum: num];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    
    }];
    
    _tableView.dataSource = _dataSource;
    _tableView.delegate = _delegate;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
