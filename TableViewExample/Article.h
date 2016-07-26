//
//  Article.h
//  TableViewExample
//
//  Created by Alexandra on 25/07/16.
//  Copyright © 2016 Alexandra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject

@property  (nonatomic, strong) NSString *link;
@property  (nonatomic, strong) NSString *title;
@property  (nonatomic, strong) NSString *pubDate;
@property  (nonatomic, strong) NSString *shortVersion;
@property  (nonatomic, strong) NSString *picture;

@end
