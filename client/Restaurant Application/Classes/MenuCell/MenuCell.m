//
//  MenuCell.m
//  Restaurant Application
//
//  Created by Ömer Emre Aslan on 04/08/15.
//  Copyright © 2015 Ömer Emre Aslan. All rights reserved.
//

#import "MenuCell.h"

@interface MenuCell()

@end

@implementation MenuCell

-(IBAction)buttonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(menuCellAddButtonTappedOnTableViewCell:)])
    {
        [self.delegate menuCellAddButtonTappedOnTableViewCell:self];
    }
}

-(IBAction)addButtonTapped:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(menuCellPlusButtonTappedOnTableViewCell:)])
    {
        [self.delegate menuCellPlusButtonTappedOnTableViewCell:self];
    }
}

-(IBAction)minusButtonTapped:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(menuCellMinusButtonTappedOnTableViewCell:)])
    {
        [self.delegate menuCellMinusButtonTappedOnTableViewCell:self];
    }
}

@end
