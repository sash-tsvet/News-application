//
//  ViewControllerSettings.h
//  TableViewExample
//
//  Created by Alexandra on 01/08/16.
//  Copyright © 2016 Alexandra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerSettings : UITableViewController

- (instancetype)initWithSources: (NSArray*)sources;
@property (nonatomic, copy) void (^returnSettings)(NSArray* sources);

@end
