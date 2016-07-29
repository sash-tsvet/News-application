//
//  MyCell.h
//  TableViewExample
//
//  Created by Alexandra on 29/07/16.
//  Copyright © 2016 Alexandra. All rights reserved.
//

#import <UIKit/UIKit.h>

static const NSInteger PICTURE_SIZE = 75;
static const int INDENTS = 10;

@interface MyCell : UITableViewCell

-(void)setPhoto:(UIImage*) photo;
@property (nonatomic, retain) UILabel *title;
@property (nonatomic, retain) UILabel *date;

@end
