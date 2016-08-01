//
//  MyCell.m
//  TableViewExample
//
//  Created by Alexandra on 29/07/16.
//  Copyright © 2016 Alexandra. All rights reserved.
//

#import "MyCell.h"


@interface MyCell()
@property (nonatomic, retain) UIImageView *picture;
@property (nonatomic, retain) UIActivityIndicatorView* actindicator;
@end

@implementation MyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _actindicator = [[UIActivityIndicatorView alloc]init];
        _title = [[UILabel alloc]init];
        _date = [[UILabel alloc]init];
        [_actindicator setHidesWhenStopped:NO];
        [_actindicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        [_actindicator startAnimating];
        _title.numberOfLines = 0;
        [[self contentView] addSubview:_actindicator];
        [[self contentView] addSubview:_title];
        [[self contentView] addSubview:_date];
    }
    return self;
}
-(void)clean{
    _title.text = nil;
    _date.text = nil;
    _picture = nil;
}

-(void)layoutSubviews
{
    [super layoutSubviews];

    CGRect pictureFrame = CGRectMake(INDENTS, INDENTS, PICTURE_SIZE, PICTURE_SIZE);
    _actindicator.frame = pictureFrame;
    _picture.frame = pictureFrame;
    
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    int screenWidth = screenSize.size.width;
    _title.frame =CGRectMake(PICTURE_SIZE+2*INDENTS, INDENTS, screenWidth-(PICTURE_SIZE+3*INDENTS), PICTURE_SIZE*4/5);
    _date.frame =CGRectMake(PICTURE_SIZE+2*INDENTS, PICTURE_SIZE*4/5+INDENTS, screenWidth-(PICTURE_SIZE+3*INDENTS), PICTURE_SIZE/5);
    
    
    /////////////////////////////
//    const int UPPER_INDENT = ([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationPortrait)? 10 : 10;
//    const int INDENTS = 10;
    

    
//    int UPPER_HEIGHT = screenHeight/2;
//    
//    CGSize imgSize = _image.size;
//    if (imgSize.width > screenWidth/2-INDENTS) {
//        imgSize.height = imgSize.height * (screenWidth/2-INDENTS)/imgSize.width;
//        imgSize.width = screenWidth/2-INDENTS;
//    }
//    if (imgSize.height > UPPER_HEIGHT-UPPER_INDENT-INDENTS) {
//        imgSize.width = imgSize.width * (UPPER_HEIGHT-UPPER_INDENT-INDENTS)/imgSize.height;
//        imgSize.height = UPPER_HEIGHT-UPPER_INDENT-INDENTS;
//    }
//    
//    CGSize expectSize = [_labelTitle sizeThatFits:CGSizeMake(screenWidth/2 - 2*INDENTS, MAXFLOAT)];
//    UPPER_HEIGHT = expectSize.height;
//    UPPER_HEIGHT = (imgSize.height < UPPER_HEIGHT)? UPPER_HEIGHT: imgSize.height;
//    UPPER_HEIGHT += UPPER_INDENT+INDENTS;
//    
//    const int DOWN_HEIGHT = screenHeight - UPPER_HEIGHT;
//    _labelTitle.frame = CGRectMake(screenWidth/2+INDENTS, UPPER_INDENT, screenWidth/2-2*INDENTS, UPPER_HEIGHT-UPPER_INDENT-INDENTS);
//    [_imageView setFrame:CGRectMake((screenWidth/2 - imgSize.width + INDENTS)/2, (UPPER_HEIGHT-UPPER_INDENT-INDENTS - imgSize.height)/2 + UPPER_INDENT, imgSize.width, imgSize.height)];
//    _labelDescription.frame = CGRectMake(INDENTS, UPPER_HEIGHT, screenWidth-2*INDENTS, DOWN_HEIGHT-INDENTS);
    
}

-(void)setPhoto:(UIImage *)photo{
    CGRect rect = CGRectMake(0,0,PICTURE_SIZE,PICTURE_SIZE);
    UIGraphicsBeginImageContext( rect.size );
    [photo drawInRect:rect];
    UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImagePNGRepresentation(picture1);
    _picture = [[UIImageView alloc] init];
    _picture.image = [UIImage imageWithData:imageData];
    
    [_actindicator setHidesWhenStopped:YES];
    [_actindicator stopAnimating];
        [[self contentView] addSubview:_picture];
}

@end
