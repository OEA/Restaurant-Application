//
//  ViewController.m
//  Restaurant Application
//
//  Created by Ömer Emre Aslan on 03/08/15.
//  Copyright © 2015 Ömer Emre Aslan. All rights reserved.
//

#import "ViewController.h"
#import "BasketCell.h"
#import "OrderManager.h"

@interface ViewController ()<UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBottomSpaceBasket;
@property (weak, nonatomic) IBOutlet UILabel *foodTitle;
@property (weak, nonatomic) IBOutlet UIView *cartView;
@property (weak, nonatomic) IBOutlet UILabel *basketLabel;
@property (strong, nonatomic) NSMutableArray *orders;
@property (strong, nonatomic) NSMutableArray *completedOrders;
@property (weak, nonatomic) IBOutlet UITableView *basketTableView;
@property (weak, nonatomic) IBOutlet UIButton *completeOrderButton;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UITableView *completedOrderTableView;
@property (weak, nonatomic) IBOutlet UILabel *orderStatus;
@end

@implementation ViewController

- (void)viewDidLoad {
    [self refreshUI];
    [super viewDidLoad];
    _constraintBottomSpaceBasket.constant = 50 -self.view.frame.size.height;
    
    self.basketTableView.dataSource = self;
    self.basketTableView.delegate = self;
    self.completedOrderTableView.delegate = self;
    self.completedOrderTableView.dataSource = self;
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

- (NSMutableArray *)completedOrders
{
    if (!_completedOrders) {
        _completedOrders = [NSMutableArray new];
    }
    return _completedOrders;
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
    [self.basketTableView reloadData];
    [self.completedOrderTableView reloadData];
}

- (NSNumber *)calculateTotalPrice
{
    float totalPrice = 0;
    for (Order *order in self.orders) {
        totalPrice = totalPrice + [order.price floatValue];
    }
    for (Order *order in self.completedOrders) {
        totalPrice = totalPrice + [order.price floatValue];
    }
    return [NSNumber numberWithFloat:totalPrice];
}

- (IBAction)viewTapped:(UITapGestureRecognizer *)sender {
    
    if (![sender isKindOfClass:[UITableView class]]) {
       [self refreshConstraints];
    }
    
    
}
- (IBAction)completeOrders:(id)sender {
    OrderManager *orderManager = [OrderManager new];
    for (Order *order in self.orders) {
        [self.completedOrders addObject:order];
        
        [orderManager addOrder:@"test" food:order.food price:order.price quantity:order.quantity success:^(NSURLSessionDataTask *task, id responseObject) {
            //return responseObject
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            //return error
        }];
        
    }
    [self.orders removeAllObjects];
    self.orderStatus.text = NSLocalizedString(@"Your orders are being prepared.", nil);
    
    
    [self refreshUI];
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
    Order *order;
    if (tableView == self.basketTableView) {
        order = [self.orders objectAtIndex:indexPath.row];
    } else {
        order = [self.completedOrders objectAtIndex:indexPath.row];
    }
    
    
    cell.foodTitle.text = order.food;
    cell.foodPrice.text = [NSString stringWithFormat:@"%@ TL",order.price];
    cell.foodQuantity.text = [NSString stringWithFormat:@"%@",order.quantity];
    
    return cell;
}

- (IBAction)payTotalPrice:(id)sender {
    
    
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Payment"
                                          message:@"If you want to pay, please tap Pay button"
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel action");
                                   }];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"Pay", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   
                                   OrderManager *orderManager = [OrderManager new];
                                   [orderManager getOrders:@"Masa2" success:^(NSURLSessionDataTask *task, id responseObject) {
                                       NSArray *dictArray = [responseObject objectForKey:@"orders"];
                                       
                                       for (NSDictionary *dict in dictArray) {
                                           [orderManager payOrder:[dict objectForKey:@"_id"] success:^(NSURLSessionDataTask *task, id responseObject) {
                                               NSLog(@"%@ id odendi",[dict objectForKey:@"_id"]);
                                           } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                               
                                           }];
                                       }
                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       
                                   }];
                                   
                                   [self.completedOrders removeAllObjects];
                                   
                                   [self refreshUI];
                                   
                                   self.orderStatus.text = NSLocalizedString(@"Has not ordered yet.", nil);
                                   
                               }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.basketTableView) {
        return [self.orders count];
    } else {
        return [self.completedOrders count];
    }
}

- (NSString *)tableView:(nonnull UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(tableView == self.basketTableView) {
        return @"Siparişler";
    } else {
        return @"Önceki Siparişler";
    }
}

- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSLog(@"test");
}

@end
