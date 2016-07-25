//
//  ViewControllerDelegate.h
//  TableViewExample
//
//  Created by Alexandra on 25/07/16.
//  Copyright © 2016 Alexandra. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ViewControllerDelegate : NSObject <UITableViewDelegate>

@property (nonatomic, copy) void (^startNavigation)(int);

@end
