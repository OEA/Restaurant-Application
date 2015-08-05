//
//  BasketCell.h
//  Restaurant Application
//
//  Created by Ömer Emre Aslan on 05/08/15.
//  Copyright © 2015 Ömer Emre Aslan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasketCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *foodQuantity;
@property (weak, nonatomic) IBOutlet UILabel *foodTitle;
@property (weak, nonatomic) IBOutlet UILabel *foodPrice;

@end
