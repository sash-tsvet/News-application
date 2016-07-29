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
@property (nonatomic,strong)  UIImageView* imageView;
@property (nonatomic,strong)  UIImage* image;
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
    _labelTitle.backgroundColor = [UIColor whiteColor];
    _labelTitle.numberOfLines = 0;
    _labelTitle.adjustsFontSizeToFitWidth = YES;
   // _labelTitle.contentScaleFactor = 0.2;
    
    [self.view addSubview:_labelTitle];

    
    
    _labelDescription = [[UILabel alloc] init];
    _labelDescription.text = _article.shortVersion;
    _labelDescription.textAlignment = NSTextAlignmentCenter;
    _labelDescription.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_labelDescription];

    _labelDescription.numberOfLines = 0;
    if (!_article.pictureBig && _article.pictureUrl) {
        NSURL *url = [[NSURL alloc] initWithString: _article.pictureUrl];
        NSData *data = [NSData dataWithContentsOfURL:url];
        _image = [[UIImage alloc] initWithData:data];
        _article.pictureBig = _image;
    }
    else
        _image=_article.pictureBig;
        _imageView = [[UIImageView alloc] initWithImage: _image];
        [self.view addSubview:_imageView];

}


-(void)viewWillLayoutSubviews
{
    const int UPPER_INDENT = ([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationPortrait)? 10 : 10;
    const int INDENTS = 10;

    CGRect screenSize = self.view.bounds;
    int screenWidth = screenSize.size.width;
    int screenHeight = screenSize.size.height;
    
    int UPPER_HEIGHT = screenHeight/2;

    CGSize imgSize = _image.size;
    if (imgSize.width > screenWidth/2-INDENTS) {
        imgSize.height = imgSize.height * (screenWidth/2-INDENTS)/imgSize.width;
        imgSize.width = screenWidth/2-INDENTS;
    }
    if (imgSize.height > UPPER_HEIGHT-UPPER_INDENT-INDENTS) {
        imgSize.width = imgSize.width * (UPPER_HEIGHT-UPPER_INDENT-INDENTS)/imgSize.height;
        imgSize.height = UPPER_HEIGHT-UPPER_INDENT-INDENTS;
    }

    CGSize expectSize = [_labelTitle sizeThatFits:CGSizeMake(screenWidth/2 - 2*INDENTS, MAXFLOAT)];
    UPPER_HEIGHT = expectSize.height;
    UPPER_HEIGHT = (imgSize.height < UPPER_HEIGHT)? UPPER_HEIGHT: imgSize.height;
    UPPER_HEIGHT += UPPER_INDENT+INDENTS;
    
    const int DOWN_HEIGHT = screenHeight - UPPER_HEIGHT;
    _labelTitle.frame = CGRectMake(screenWidth/2+INDENTS, UPPER_INDENT, screenWidth/2-2*INDENTS, UPPER_HEIGHT-UPPER_INDENT-INDENTS);
    [_imageView setFrame:CGRectMake((screenWidth/2 - imgSize.width + INDENTS)/2, (UPPER_HEIGHT-UPPER_INDENT-INDENTS - imgSize.height)/2 + UPPER_INDENT, imgSize.width, imgSize.height)];
    _labelDescription.frame = CGRectMake(INDENTS, UPPER_HEIGHT, screenWidth-2*INDENTS, DOWN_HEIGHT-INDENTS);
    
}

@end
