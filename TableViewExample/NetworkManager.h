//
//  NetworkManager.h
//  TableViewExample
//
//  Created by Alexandra on 28/07/16.
//  Copyright © 2016 Alexandra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Parser.h"
#import "Article.h"

typedef void (^URLSessionFailureBlock)(NSError *error);
@interface NetworkManager : NSObject

+ (NetworkManager *)sharedInstance;
- (void)getImageForURL:(NSString *)url
                         withSuccess:(void (^)(UIImage * image))successBlock
                             withFailure:(URLSessionFailureBlock)failureBlock;
- (void)getArticlesWithSuccess:(void (^)(NSArray* articles))successBlock
                         withFailure:(URLSessionFailureBlock)failureBlock;


@end
