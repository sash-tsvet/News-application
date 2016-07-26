//
//  Article.m
//  TableViewExample
//
//  Created by Alexandra on 25/07/16.
//  Copyright © 2016 Alexandra. All rights reserved.
//

#import "Article.h"

@interface Article()


@end

@implementation Article
-(void)setValue:(id)value forKey:(NSString *)key{
    if ([key  isEqualToString: @"description"]) _shortVersion = value;
    else if ([key isEqualToString: @"title"]) _title = value;
    else if ([key isEqualToString: @"link"]) _link = value;
    else if ([key isEqualToString: @"pubDate"]) _pubDate = value;
    else if ([key isEqualToString: @"enclosure url"]) _picture = value;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    return;
}
@end
