//
//  ViewControllerDataSource.m
//  TableViewExample
//
//  Created by Alexandra on 25/07/16.
//  Copyright © 2016 Alexandra. All rights reserved.
//

#import "ViewControllerDataSource.h"
#import "Parser.h"
#import "Article.h"


@implementation ViewControllerDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _articles.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellIdentifier"];
    }
    if ([_articles[indexPath.row] isKindOfClass:[Article class]]) {
        Article *article = (Article *)_articles[indexPath.row];
        cell.textLabel.text = article.title;
        cell.detailTextLabel.text = article.pubDate;
        cell.textLabel.numberOfLines = 0;
//        UIImage *cellImage = [UIImage imageNamed:@"apple.png"];
//        cell.imageView.image = cellImage;
        
    }

    return cell;
}

-(void) startParsing {
    //NSURL *url = [[NSURL alloc] initWithString:@"http://sites.google.com/site/iphonesdktutorials/xml/Books.xml"];
    //
    //NSXMLParser *xmlparser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    NSXMLParser *xmlparser = [[NSXMLParser alloc] initWithData:[NSData dataWithContentsOfFile:@"/Users/alexandra/Downloads/lenta.xml"]];
    
    _articles = [[NSMutableArray alloc] initWithArray:@[]];
    Parser *parser = [[Parser alloc] initWithArticles: _articles];
    
    [xmlparser setDelegate:parser];
    
    BOOL success = [xmlparser parse];
    
    if(success){
        NSLog(@"No Errors");
        [parser cleanLineBreaks];
        [parser debugPrint];
    }
    else{
        NSLog(@"Error on start!!!");
    }
}
@end
