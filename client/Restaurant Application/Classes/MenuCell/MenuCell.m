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
    if (self.selectionBlock)
        self.selectionBlock(self,MenuCellButtonTypeAdd);
}

-(IBAction)addButtonTapped:(id)sender
{
    if (self.selectionBlock)
        self.selectionBlock(self,MenuCellButtonTypePlus);
}

-(IBAction)minusButtonTapped:(id)sender
{
    if (self.selectionBlock)
        self.selectionBlock(self,MenuCellButtonTypeMinus);
}

@end
