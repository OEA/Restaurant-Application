//
//  Order.h
//  Restaurant Application
//
//  Created by Ömer Emre Aslan on 04/08/15.
//  Copyright © 2015 Ömer Emre Aslan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Food.h"

@interface Order : NSObject
@property (strong, nonatomic) NSString *user;
@property (strong, nonatomic) NSString *food;
@property (strong, nonatomic) NSNumber *quantity;
@property (strong, nonatomic) NSNumber *price;
@end


@protocol OrderSelectionDelegate <NSObject>
@required
-(void)selectedOrder:(Order *)order;
-(void)selectFood:(Food *)food;
@end