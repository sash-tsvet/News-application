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
    else if ([key isEqualToString: @"pubDate"]) {
        // Convert string to date object
        value = [[[value componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@" "]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
       // [dateFormat setLocale:[NSLocale systemLocale]];
        [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        [dateFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];

        [dateFormat setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss Z"];
        
        _pubDate = [dateFormat dateFromString:value];
    }
    //else if ([key isEqualToString: @"enclosure"]) _picture = value;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    return;
}
@end
