//
//  Parser.h
//  TableViewExample
//
//  Created by Alexandra on 25/07/16.
//  Copyright © 2016 Alexandra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Parser : NSObject <NSXMLParserDelegate>
-(instancetype)initWithArticles: (NSMutableArray*)articles;
-(void)debugPrint;
-(void)cleanLineBreaks;
@end
