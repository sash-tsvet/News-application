//
//  Article.h
//  TableViewExample
//
//  Created by Alexandra on 25/07/16.
//  Copyright © 2016 Alexandra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Article : NSObject

@property  (nonatomic, strong) NSString *link;
@property  (nonatomic, strong) NSString *title;
@property  (nonatomic, strong) NSDate *pubDate;
@property  (nonatomic, strong) NSString *shortVersion;
@property  (nonatomic, strong) NSString *pictureUrl;
@property  (nonatomic, strong) UIImage *pictureBig;
@property  (nonatomic, strong) UIImage *pictureSmall;

@end
