//
//  MenuTVC.h
//  Restaurant Application
//
//  Created by Ömer Emre Aslan on 03/08/15.
//  Copyright © 2015 Ömer Emre Aslan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Food.h"

@interface MenuTVC : UITableViewController
@property (strong, nonatomic) NSMutableArray *categories;
@property (nonatomic, assign) id<FoodSelectionDelegate> delegate;
@end
