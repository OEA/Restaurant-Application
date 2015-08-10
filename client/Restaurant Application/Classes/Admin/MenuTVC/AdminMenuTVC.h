//
//  AdminMenuTVC.h
//  Restaurant Application
//
//  Created by Ömer Emre Aslan on 07/08/15.
//  Copyright © 2015 Ömer Emre Aslan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminMenuTVC : UITableViewController
@property (strong, nonatomic) NSMutableArray *orders;
@property (strong, nonatomic) NSMutableArray *tables;
@property (strong, nonatomic) NSMutableArray *users;
@end
