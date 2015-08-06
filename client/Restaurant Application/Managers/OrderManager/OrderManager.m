//
//  OrderManager.m
//  Restaurant Application
//
//  Created by Ömer Emre Aslan on 06/08/15.
//  Copyright © 2015 Ömer Emre Aslan. All rights reserved.
//

#import "OrderManager.h"

@implementation OrderManager

+ (OrderManager *)sharedClient
{
    static OrderManager *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:SERVICE_URL]];
    });
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    return self;
}

- (void)addOrder:(NSString *)user
            food:(NSString *)food
           price:(NSNumber *)price
        quantity:(NSNumber *)quantity
         success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
         failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString *url = [SERVICE_URL stringByAppendingString:@"order/add"];
    NSDictionary *parameters = @{@"user": @"Masa2", @"food":food, @"quantity":quantity, @"price": price};
    [self POST:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, error);
    }];
}

- (void)getOrders:(NSString *)user
          success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
          failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString *url = [SERVICE_URL stringByAppendingString:[NSString stringWithFormat:@"order/get/%@",user]];
    [self GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, error);
    }];
}

- (void)payOrder:(NSString *)_id
         success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
         failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString *url = [SERVICE_URL stringByAppendingString:@"order/changestatus"];
    NSDictionary *parameters = @{@"_id": _id, @"status":@(0)};
    [self POST:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, error);
    }];
}
@end
