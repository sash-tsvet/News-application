//
//  Parser.m
//  TableViewExample
//
//  Created by Alexandra on 25/07/16.
//  Copyright © 2016 Alexandra. All rights reserved.
//

#import "Parser.h"
#import "Article.h"

@interface Parser()

@property (nonatomic, strong) Article* article;
@property (nonatomic, strong) NSMutableString *curElem;
@property (nonatomic, strong) NSMutableArray* articles;

@end

@implementation Parser

-(instancetype)initWithArticles: (NSMutableArray*)articles {
    self = [super init];
    _articles = articles;
    return self;
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"channel"]) {
        //Initialize the array.
        if (!_articles) {
            NSLog(@"NO INPUT ARRAY!");
        }
        
    }
    else if([elementName isEqualToString:@"item"]) //{
    
        //Initialize the book.
        _article = [[Article alloc] init];
    if([elementName isEqualToString:@"enclosure"])
    {
        NSString *urlValue=[attributeDict valueForKey:@"url"];
        _article.pictureUrl=urlValue;
        urlValue = nil;
        //NSString *urlValue=[attributeDict valueForKey:@"type"];
        //NSString *urlValue=[attributeDict valueForKey:@"length"];
    }
    NSLog(@"Processing Element: %@", elementName);
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if(!_curElem)
        _curElem = [[NSMutableString alloc] initWithString:string];
    else
        [_curElem appendString:string];
    
    NSLog(@"Processing Value: %@", _curElem);
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if([elementName isEqualToString:@"channel"])
        return;
    
    if([elementName isEqualToString:@"item"]) {
        [_articles addObject:_article];
        
        _article = nil;
    }
    else
        [_article setValue:[_curElem copy] forKey:elementName];

    _curElem = nil;
}

-(void)debugPrint{
    NSLog(@"***************************************");
    NSLog(@"Collected data:");
    NSLog(@"***************************************");
    
    for (Article* article in _articles) {
        NSLog(@"Title: %@", article.title);
        NSLog(@"Link: %@", article.link);
        NSLog(@"Date: %@", article.pubDate);
        NSLog(@"Description: %@", article.shortVersion);
        NSLog(@"Picture: %@", article.pictureUrl);
        NSLog(@"***************************************\n");
    }
    
    NSLog(@"THE END");
}

-(void)cleanLineBreaks{
    for (Article* article in _articles) {
        //article.title = [article.title stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        article.title =[[[article.title componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@" "]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        article.pubDate = [[[article.pubDate componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@" "]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        article.pictureUrl = [[[article.pictureUrl componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@" "]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        article.link = [[[article.link componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@" "]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        article.shortVersion = [[[article.shortVersion componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@" "]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
    }
}
@end
