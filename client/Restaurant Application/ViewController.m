//
//  ViewController.m
//  Restaurant Application
//
//  Created by Ömer Emre Aslan on 03/08/15.
//  Copyright © 2015 Ömer Emre Aslan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBottomSpaceBasket;
@property (weak, nonatomic) IBOutlet UILabel *foodTitle;
@property (weak, nonatomic) IBOutlet UIView *cartView;
@property (weak, nonatomic) IBOutlet UILabel *basketLabel;
@property (strong, nonatomic) NSMutableArray *orders;
@property (weak, nonatomic) IBOutlet UITableView *basketTableVew;
@end

@implementation ViewController

- (void)viewDidLoad {
    [self refreshUI];
    [super viewDidLoad];
    _constraintBottomSpaceBasket.constant = 50 -self.view.frame.size.height;
    
    self.basketTableVew.dataSource = self;
    self.basketTableVew.delegate = self;
}

- (NSMutableArray *)orders
{
    if(!_orders) {
        _orders = [NSMutableArray new];
    }
    return _orders;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshUI
{
    
    self.foodTitle.text = self.food.name;
    if ([self.orders count] > 0) {
        self.basketLabel.text = [NSString stringWithFormat:@"%lu adet sipariş mevcut.", (unsigned long)[self.orders count]];
    } else {
        //doNothin'
    }
    
    [self.basketTableVew reloadData];
}

- (IBAction)viewTapped:(UITapGestureRecognizer *)sender {
    
    UITableView *view = (UITableView *)sender.view;
    if (![sender isKindOfClass:[UITableView class]]) {
       [self refreshConstraints];
    }
    
    
}

- (void)refreshConstraints
{
    if (self.cartView.frame.origin.y == 0) {
        
        _constraintBottomSpaceBasket.constant = 50 -self.view.frame.size.height;
    } else {
        _constraintBottomSpaceBasket.constant = 0;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

-(void)setFood:(Food *)food
{
    //Make sure you're not setting up the same monster.
    if (_food != food) {
        _food = food;
        
        //Update the UI to reflect the new monster on the iPad.
    }
}

- (void)selectedFood:(Food *)newFood
{
    [self setFood:newFood];
    [self addOrder:newFood];
    [self refreshUI];
}

- (void)addOrder:(Food *)food
{
    Order *order = [Order new];
    order.food = food.name;
    order.user = @"test";
    order.price = food.price;
    order.quantity = @(1);
    [self.orders addObject:order];
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basketCell"];
    Order *order = [self.orders objectAtIndex:indexPath.row];
    cell.textLabel.text = order.food;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ TL",order.price];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.orders count];
}

@end
