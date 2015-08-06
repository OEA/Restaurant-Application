//
//  CategoryManager.m
//  Restaurant Application
//
//  Created by Ömer Emre Aslan on 03/08/15.
//  Copyright © 2015 Ömer Emre Aslan. All rights reserved.
//

#import "CategoryManager.h"

@implementation CategoryManager


+ (CategoryManager *)sharedClient {
    static CategoryManager *_sharedClient = nil;
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
- (void)getCategories:(BOOL)ascending
              success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
              failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;
{
    NSString *path = @"category/list";
    [self GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, error);
    }];
    
    
}

- (void)getFoods:(NSString *)category
         success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
         failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString *path = [NSString stringWithFormat:@"food/category/%@",category];
    [self GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, error);
    }];
}


@end
