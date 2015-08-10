//
//  OrderManager.h
//  Restaurant Application
//
//  Created by Ömer Emre Aslan on 06/08/15.
//  Copyright © 2015 Ömer Emre Aslan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface OrderManager : AFHTTPSessionManager

+ (OrderManager *)sharedClient;

- (void)addOrder:(NSString *)user
            food:(NSString *)food
           price:(NSNumber *)price
        quantity:(NSNumber *)quantity
         success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
         failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)getOrders:(NSString *)user
          success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
          failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;


- (void)getAllOrders:(void(^)(NSURLSessionDataTask *task, id responseObject))success
          failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;


- (void)payOrder:(NSString *)_id
         success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
         failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
