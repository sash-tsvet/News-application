////
////  NetworkManager.m
////  TableViewExample
////
////  Created by Alexandra on 28/07/16.
////  Copyright © 2016 Alexandra. All rights reserved.
////
//
//#import "NetworkManager_.h"
//
//@implementation NetworkManager
//
//+ (NetworkManager *)sharedManager {
//    static NetworkManager *sharedManager = nil;
//
//    static dispatch_once_t onceToken;
//    
//    dispatch_once(&onceToken, ^{
//        sharedManager = [NetworkManager new];
//    });
//    return sharedManager;
//}
//
//-(void)getImageForArticlesWithSuccess:(void (^)(UIImage *))successBlock failure:(URLSessionFailureBlock)failureBlock {
//    
//    
////    [myOSertvice getImageForArticlesWithSuccess:^(Responce responce) {
////        
////        
////        
////        [myMapper mappingResponceAtict:(Responce *)responcewWithComplition:^(NSArray *array) {
////            
////            successBlock(array);
////            
////            
////            
////        } failure:^(NSError *error) {
////            failureBlock (error);
////        }];
////
////        
////        
////        
////    } failure:^(NSError *error) {
////        
////    }];
////
//
//}
//
//@end
