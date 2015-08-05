//
//  MenuCell.h
//  Restaurant Application
//
//  Created by Ömer Emre Aslan on 04/08/15.
//  Copyright © 2015 Ömer Emre Aslan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuCell;

@protocol MenuCellDelegate <NSObject>

- (void) menuCellAddButtonTappedOnTableViewCell:(MenuCell *)cell;

@end


@interface MenuCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *foodName;
@property (weak, nonatomic) IBOutlet UILabel *foodQuantityPrice;
@property (weak, nonatomic) IBOutlet UILabel *foodQuantity;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (nonatomic,strong) NSIndexPath* indexPath;

@property (weak, nonatomic) id <MenuCellDelegate> delegate;

@end
