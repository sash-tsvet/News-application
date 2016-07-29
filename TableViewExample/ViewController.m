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

@property ViewControllerDataSource *dataSource;
@property ViewControllerDelegate *delegate;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@property (nonatomic, copy) void (^successBlock)(NSArray* articles);
@property (nonatomic, copy) void (^errorBlock)(NSError* error);
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 500;
    
    
    
    
    _dataSource = [ViewControllerDataSource new];
    _delegate = [ViewControllerDelegate new];
    
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityView.backgroundColor = [UIColor whiteColor];
    [_activityView startAnimating];
    [self.view addSubview:_activityView];
    
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    
    
    //    [[NetworkManager sharedManager] getImageForArticlesWithSuccess:^(UIImage *image) {
    //        <#code#>
    //    } failure:^(NSError *error) {
    //        <#code#>
    //    }];
    //    

    
    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor whiteColor];
    self.refreshControl.tintColor = [UIColor grayColor];
    [self.refreshControl addTarget:self
                            action:@selector(getLatestValues)
                  forControlEvents:UIControlEventValueChanged];
    
    
    __weak typeof(self) weakSelf = self;
    _successBlock =^void( NSArray* articles) {
        weakSelf.dataSource.articles = articles;
        weakSelf.tableView.separatorStyle =  UITableViewCellSeparatorStyleSingleLine;
        weakSelf.tableView.scrollEnabled = YES;
        [weakSelf.activityView removeFromSuperview];
        [weakSelf.tableView reloadData];
        [weakSelf.refreshControl endRefreshing];
    };
    
    _errorBlock = ^(NSError *error){
        UILabel* _label = [[UILabel alloc] init];
        _label.text = @"ERROR - NO ARTICLES!\nCheck your internet connection!";
        _label.numberOfLines = 0;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.backgroundColor = [UIColor redColor];
        
        [weakSelf.view addSubview:_label];
        
        CGRect screenSize = [[UIScreen mainScreen] bounds];
        int width = screenSize.size.width;
        int height = 100;
        _label.frame = CGRectMake(0, screenSize.size.height/2 - height, width, height);
        
    };
    
    [self getLatestValues];

    [_delegate setStartNavigation:^ (int num){
        
        ViewControllerArticle *vc = [[ViewControllerArticle alloc] initWithArticle: weakSelf.dataSource.articles[num]];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    
    }];
    self.tableView.dataSource = _dataSource;
    self.tableView.delegate = _delegate;
    [self.tableView reloadData];
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    CGRect mainScreen = [[UIScreen mainScreen] bounds];
    CGPoint center = CGPointMake(mainScreen.size.width/2, mainScreen.size.height/2);
    _activityView.center = CGPointMake(center.x,
                                       center.y - self.view.frame.origin.y);
    
    [_activityView setNeedsLayout];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getLatestValues{
    NetworkManager* NM = [NetworkManager sharedInstance];
    [NM getArticlesWithSuccess:_successBlock withFailure:_errorBlock];
    
    
}
@end
