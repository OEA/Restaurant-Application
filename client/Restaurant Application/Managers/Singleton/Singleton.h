//
//  Singleton.h
//  Restaurant Application
//
//  Created by Ömer Emre Aslan on 06/08/15.
//  Copyright © 2015 Ömer Emre Aslan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuTVC.h"
#import "ViewController.h"

@interface Singleton : NSObject

@property (nonatomic,strong) MenuTVC *leftVC;
@property (nonatomic,strong) ViewController *rightVC;

+(instancetype)sharedInstance;

@end
