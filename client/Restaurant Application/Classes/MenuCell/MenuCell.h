//
//  MenuCell.h
//  Restaurant Application
//
//  Created by Ömer Emre Aslan on 04/08/15.
//  Copyright © 2015 Ömer Emre Aslan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(int, MenuCellButtonType)
{
    MenuCellButtonTypeAdd,
    MenuCellButtonTypePlus,
    MenuCellButtonTypeMinus
};

@class MenuCell;


typedef void (^MenuCellSelectionBlock)(MenuCell*, MenuCellButtonType);

@interface MenuCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *foodName;
@property (weak, nonatomic) IBOutlet UILabel *foodQuantityPrice;
@property (weak, nonatomic) IBOutlet UILabel *foodQuantity;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;

@property (nonatomic,strong) NSIndexPath* indexPath;

@property (nonatomic,copy) MenuCellSelectionBlock selectionBlock;

@end
