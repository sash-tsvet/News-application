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
#import "NetworkManager.h"
#import "MyCell.h"


@implementation ViewControllerDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _articles.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([_articles[indexPath.row] isKindOfClass:[Article class]]) {
        Article *article = (Article *)_articles[indexPath.row];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd MMM yyyy HH:mm"];
        
        NSString* datestr = [dateFormat stringFromDate:article.pubDate];

    
        static NSString *CellIdentifier = @"Cell";
    
        //поиск ячейки
        MyCell *mycell = (MyCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!mycell) {
            mycell = [[MyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
    
        mycell.title.text = article.title;
        mycell.date.text = datestr;
        
        
            if (!article.pictureUrl)
                article.pictureUrl = @"https://www.novelupdates.com/img/noimagefound.jpg";
            
            [[NetworkManager sharedInstance] getImageForURL:article.pictureUrl
                                                withSuccess:^(UIImage *image) {
                                                    article.pictureBig = image;
                                                    [mycell setPhoto:image];
                                                    [mycell setNeedsLayout];
                                                } withFailure:^(NSError *error) {
                                                    
                                                }];
        
        return mycell;
    }
    return nil;
}
@end
