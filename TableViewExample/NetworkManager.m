//
//  NetworkManager.m
//  TableViewExample
//
//  Created by Alexandra on 28/07/16.
//  Copyright © 2016 Alexandra. All rights reserved.
//

#import "NetworkManager.h"
@interface NetworkManager()
    @property (atomic, strong) NSMutableArray* articles;
@end


@implementation NetworkManager

+ (NetworkManager *)sharedInstance
{
    // 1
    static NetworkManager * _sharedInstance = nil;
    
    // 2
    static dispatch_once_t oncePredicate;
    
    // 3
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[NetworkManager alloc] init];
    });
    return _sharedInstance;
}

- (void)getImageForURL:(NSString *)url
                     withSuccess:(void (^)(UIImage * image))successBlock
                     withFailure:(URLSessionFailureBlock)failureBlock{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{ // 1
        
        NSURL *_url = [[NSURL alloc] initWithString: url];
        NSData *data = [NSData dataWithContentsOfURL:_url];
        UIImage* image = [[UIImage alloc] initWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{ // 2
            successBlock(image);
        });
    });
}
- (void)getArticlesWithSuccess:(void (^)(NSArray* articles))successBlock
        withFailure:(URLSessionFailureBlock)failureBlock{
    
    _articles = [[NSMutableArray alloc] initWithArray:@[]];;
    __block NSInteger success = 0;
    // 1
    dispatch_group_t downloadGroup = dispatch_group_create();
    
    for (NSInteger i = 0; i < 2; i++) {
        NSURL *url;
        switch (i) {
            case 1:
                url = [[NSURL alloc] initWithString:@"https://lenta.ru/rss"];
                break;
            case 0:
                url = [[NSURL alloc] initWithString:@"https://www.gazeta.ru/export/rss/lenta.xml"];
                break;
            default:
                break;
        }
        
        dispatch_group_enter(downloadGroup); // 2
        

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            Parser *parser = [[Parser alloc] init];
            NSXMLParser *xmlparser = [[NSXMLParser alloc] initWithContentsOfURL:url];
            
            
            [xmlparser setDelegate:parser];
            if([xmlparser parse]){
                success++;
                [parser cleanLineBreaks];
                [self.articles addObjectsFromArray:[parser articles]];
                
                //[parser debugPrint];
                //sleep(25);
                 }
            
            dispatch_group_leave(downloadGroup);
        });
    }
       dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{ // 4
           if(success){
               NSLog(@"No Errors");
               NSLog(@"SUCCESS = %ld", (long)success);
               [self sortByDate];
               successBlock(_articles);
           }
           else{
               NSLog(@"Error on start!!!");
               NSLog(@"SUCCESS = %ld", (long)success);
               failureBlock((NSError*)NSURLErrorDomain);
           }
       });
}

-(void)sortByDate{
    [_articles sortUsingComparator:^NSComparisonResult(Article *obj1, Article *obj2) {
        if (obj1.pubDate > obj2.pubDate)
            return (NSComparisonResult)NSOrderedAscending;
        if (obj1.pubDate < obj2.pubDate)
            return (NSComparisonResult)NSOrderedDescending;
        return (NSComparisonResult)NSOrderedSame;
    }];
}

@end

