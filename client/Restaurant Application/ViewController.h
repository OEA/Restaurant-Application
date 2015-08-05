//
//  ViewController.h
//  Restaurant Application
//
//  Created by Ömer Emre Aslan on 03/08/15.
//  Copyright © 2015 Ömer Emre Aslan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Food.h"
#import "Order.h"

@interface ViewController : UIViewController <OrderSelectionDelegate>
@property (strong ,nonatomic) Food *food;
@end

