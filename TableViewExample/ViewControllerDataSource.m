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
    cell.textLabel.text = nil;
    cell.detailTextLabel.text = nil;
    cell.imageView.image = nil;
    if ([_articles[indexPath.row] isKindOfClass:[Article class]]) {
        Article *article = (Article *)_articles[indexPath.row];
        cell.textLabel.text = article.title;
        cell.detailTextLabel.text = article.pubDate;
        cell.textLabel.numberOfLines = 0;
        
//        cell.imageView = [[UIActivityIndicatorView alloc]
//                          initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        if (!article.pictureSmall){
        
            if (!article.pictureUrl)
                article.pictureUrl = @"http://www.novelupdates.com/img/noimagefound.jpg";
            
            
//          cell.imageView = UIActivityIndicator;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{ // 1
                
                NSURL *url = [[NSURL alloc] initWithString: article.pictureUrl];
                NSData *data = [NSData dataWithContentsOfURL:url];
                UIImage* image = [[UIImage alloc] initWithData:data];
                article.pictureBig = image;
                CGRect rect = CGRectMake(0,0,50,50);
                UIGraphicsBeginImageContext( rect.size );
                [image drawInRect:rect];
                UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                
                NSData *imageData = UIImagePNGRepresentation(picture1);
                UIImage *cellImage=[UIImage imageWithData:imageData];
                article.pictureSmall = cellImage;
                cell.imageView.image = cellImage;
                
            dispatch_async(dispatch_get_main_queue(), ^{ // 2
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                });
            });
            

        
        }
        else
            cell.imageView.image = article.pictureSmall;
        
    }

    return cell;
}

-(void) startParsing {
    //NSURL *url = [[NSURL alloc] initWithString:@"http://sites.google.com/site/iphonesdktutorials/xml/Books.xml"];
    //
    //NSXMLParser *xmlparser = [[NSXMLParser alloc] initWithContentsOfURL:url];
//    NSXMLParser *xmlparser = [[NSXMLParser alloc] initWithData:[NSData dataWithContentsOfFile:@"/Users/alexandra/Downloads/lenta.xml"]];
    NSXMLParser *xmlparser = [[NSXMLParser alloc] initWithData:[NSData dataWithContentsOfFile:@"/Users/alexandra/Downloads/rss.txt"]];
    
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
