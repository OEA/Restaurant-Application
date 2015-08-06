//
//  Singleton.m
//  Restaurant Application
//
//  Created by Ömer Emre Aslan on 06/08/15.
//  Copyright © 2015 Ömer Emre Aslan. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

+ (instancetype)sharedInstance
{
    static Singleton *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedClient = [[super allocWithZone:nil] init];
    });
    return _sharedClient;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

-(id)copy
{
    return [self.class sharedInstance];
}

@end
