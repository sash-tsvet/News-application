//
//  ViewControllerArticle.m
//  TableViewExample
//
//  Created by Alexandra on 26/07/16.
//  Copyright © 2016 Alexandra. All rights reserved.
//

#import "ViewControllerArticle.h"

@interface ViewControllerArticle ()
@property (nonatomic, strong) UILabel* labelTitle;
@property (nonatomic, strong) UILabel* labelDescription;
@property (nonatomic, strong) Article* article;
@end

@implementation ViewControllerArticle

- (instancetype)initWithArticle:(Article *)article
{
    self = [super init];
    if (self) {
        _article = article;
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];

    _labelTitle = [[UILabel alloc] init];
    _labelTitle.text = _article.title;
    _labelTitle.textAlignment = NSTextAlignmentCenter;
    _labelTitle.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:_labelTitle];
    
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    int screenWidth = screenSize.size.width;
    int screenHeight = screenSize.size.height;
//    
//    CGSize maximumLabelSize = CGSizeMake(screenWidth/2,9999);
//    
//    CGSize expectedLabelSize = [_article.shortVersion sizeWithFont:_labelTitle.font
//                                      constrainedToSize:maximumLabelSize
//                                          lineBreakMode:_labelTitle.lineBreakMode];
    
    _labelTitle.frame = CGRectMake(screenWidth/2, 0, screenWidth/2, screenHeight/2/*expectedLabelSize.height*/);
    _labelTitle.numberOfLines = 0;
    
    _labelDescription = [[UILabel alloc] init];
    _labelDescription.text = _article.shortVersion;
    _labelDescription.textAlignment = NSTextAlignmentCenter;
    _labelDescription.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:_labelDescription];
    _labelDescription.frame = CGRectMake(0, screenHeight/2, screenWidth, screenHeight/2/*expectedLabelSize.height*/);
    _labelDescription.numberOfLines = 0;
}
@end
