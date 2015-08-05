//
//  ViewController.m
//  Restaurant Application
//
//  Created by Ömer Emre Aslan on 03/08/15.
//  Copyright © 2015 Ömer Emre Aslan. All rights reserved.
//

#import "ViewController.h"
#import "BasketCell.h"

@interface ViewController ()<UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBottomSpaceBasket;
@property (weak, nonatomic) IBOutlet UILabel *foodTitle;
@property (weak, nonatomic) IBOutlet UIView *cartView;
@property (weak, nonatomic) IBOutlet UILabel *basketLabel;
@property (strong, nonatomic) NSMutableArray *orders;
@property (weak, nonatomic) IBOutlet UITableView *basketTableVew;
@property (weak, nonatomic) IBOutlet UIButton *completeOrderButton;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@end

@implementation ViewController

- (void)viewDidLoad {
    [self refreshUI];
    [super viewDidLoad];
    _constraintBottomSpaceBasket.constant = 50 -self.view.frame.size.height;
    
    self.basketTableVew.dataSource = self;
    self.basketTableVew.delegate = self;
}
- (IBAction)clearOrders:(id)sender {
    [self.orders removeAllObjects];
    [self refreshUI];
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
        self.basketLabel.text = [NSString stringWithFormat:NSLocalizedString(@"You have %lu orders.", nil), (unsigned long)[self.orders count]];
        self.completeOrderButton.enabled = YES;
    } else {
        self.basketLabel.text = NSLocalizedString(@"Your basket is empty.", nil);
        self.completeOrderButton.enabled = NO;
    }
    self.totalPrice.text = [NSString stringWithFormat:NSLocalizedString(@"Total Price: %@ TL", nil),[self calculateTotalPrice]];
    [self.basketTableVew reloadData];
}

- (NSNumber *)calculateTotalPrice
{
    float totalPrice = 0;
    for (Order *order in self.orders) {
        totalPrice = totalPrice + [order.price floatValue];
    }
    return [NSNumber numberWithFloat:totalPrice];
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

- (void)selectedOrder:(Order *)order
{
    [self addOrder:order];
    [self refreshUI];
}

-(void)selectFood:(Food *)food
{
    self.food = food;
    self.foodTitle.text = food.name;
}

- (void)addOrder:(Order *)order
{
    [self.orders addObject:order];
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    BasketCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basketCell"];
    Order *order = [self.orders objectAtIndex:indexPath.row];
    cell.foodTitle.text = order.food;
    cell.foodPrice.text = [NSString stringWithFormat:@"%@ TL",order.price];
    cell.foodQuantity.text = [NSString stringWithFormat:@"%@",order.quantity];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.orders count];
}

- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSLog(@"test");
}

@end
