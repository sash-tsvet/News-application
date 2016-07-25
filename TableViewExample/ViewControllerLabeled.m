//
//  ViewControllerLabeled.m
//  TableViewExample
//
//  Created by Alexandra on 25/07/16.
//  Copyright © 2016 Alexandra. All rights reserved.
//

#import "ViewControllerLabeled.h"

@interface ViewControllerLabeled()

@property (nonatomic, strong) UILabel* label;
@property NSString* labeltext;
@end

@implementation ViewControllerLabeled
- (instancetype)init
{
    self = [super init];
    if (self) {
        _labeltext =  [NSString stringWithFormat:@"%d", 0];
    }
    return self;
}

- (instancetype)initWithNum: (int)num
{
    self = [super init];
    if (self) {
        _labeltext =  [NSString stringWithFormat:@"%d", num];
    }
    return self;
}

-(void)viewDidLoad{
    _label = [[UILabel alloc] init];
    _label.text = _labeltext;
    _label.textAlignment = NSTextAlignmentCenter;
    _label.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_label];
    
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    int width = screenSize.size.width;
    int height = 30;
    _label.frame = CGRectMake(0, screenSize.size.height/2 - height, width, height);
}
@end
