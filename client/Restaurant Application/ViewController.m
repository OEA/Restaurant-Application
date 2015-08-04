//
//  ViewController.m
//  Restaurant Application
//
//  Created by Ömer Emre Aslan on 03/08/15.
//  Copyright © 2015 Ömer Emre Aslan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBottomSpaceBasket;
@property (weak, nonatomic) IBOutlet UILabel *foodTitle;
@property (weak, nonatomic) IBOutlet UIView *cartView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [self refreshUI];
    [super viewDidLoad];
    self.cartView.frame = CGRectMake(0, self.view.frame.size.height - 50, self.cartView.frame.size.width, self.view.frame.size.height );
    _constraintBottomSpaceBasket.constant = 50 -self.view.frame.size.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshUI
{
    self.foodTitle.text = self.food.name;
}

- (IBAction)viewTapped:(UITapGestureRecognizer *)sender {
    if (self.cartView.frame.origin.y == 0) {
        _constraintBottomSpaceBasket.constant = 50 -self.view.frame.size.height;
    } else {
        _constraintBottomSpaceBasket.constant = 0;
    }
    
    [UIView animateWithDuration:0.75 animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

-(void)setFood:(Food *)food
{
    //Make sure you're not setting up the same monster.
    if (_food != food) {
        _food = food;
        
        //Update the UI to reflect the new monster on the iPad.
        [self refreshUI];
    }
}

- (void)selectedFood:(Food *)newFood
{
    [self setFood:newFood];
}

@end
