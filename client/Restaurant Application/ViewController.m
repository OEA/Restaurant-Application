//
//  ViewController.m
//  Restaurant Application
//
//  Created by Ömer Emre Aslan on 03/08/15.
//  Copyright © 2015 Ömer Emre Aslan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *foodTitle;
@end

@implementation ViewController

- (void)viewDidLoad {
    [self refreshUI];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshUI
{
    self.foodTitle.text = self.food.name;
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

@end
