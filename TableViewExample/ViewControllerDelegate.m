//
//  ViewControllerDelegate.m
//  TableViewExample
//
//  Created by Alexandra on 25/07/16.
//  Copyright © 2016 Alexandra. All rights reserved.
//

#import "ViewControllerDelegate.h"
#include "MyCell.h"

@implementation ViewControllerDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.startNavigation) {
        self.startNavigation((int)indexPath.row);
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return PICTURE_SIZE+2*INDENTS;
}

@end
