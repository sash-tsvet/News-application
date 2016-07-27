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
#import "ViewControllerArticle.h"

@interface ViewController () 

@property UITableView *tableView;
@property ViewControllerDataSource *dataSource;
@property ViewControllerDelegate *delegate;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 500;
    [self.view addSubview:self.tableView];
    
    _dataSource = [ViewControllerDataSource new];
    _delegate = [ViewControllerDelegate new];
    
    [_dataSource startParsing];
    
    __weak typeof(self) weakSelf = self;
    [_delegate setStartNavigation:^ (int num){
        
        ViewControllerArticle *vc = [[ViewControllerArticle alloc] initWithArticle: weakSelf.dataSource.articles[num]];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    
    }];
    
    _tableView.dataSource = _dataSource;
    _tableView.delegate = _delegate;
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
