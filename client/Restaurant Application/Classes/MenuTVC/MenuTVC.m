//
//  MenuTVC.m
//  Restaurant Application
//
//  Created by Ömer Emre Aslan on 03/08/15.
//  Copyright © 2015 Ömer Emre Aslan. All rights reserved.
//

#import "MenuTVC.h"
#import "CategoryManager.h"
#import "CategoryM.h"
#import "MenuCell.h"

@interface MenuTVC()<MenuCellDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@end
@implementation MenuTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!_categories)
        _categories = [NSMutableArray new];
    [self.loading startAnimating];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CategoryManager *manager = [CategoryManager sharedClient];
    [manager getCategories:YES success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSMutableDictionary *dict = [responseObject mutableCopy];
        
        self.categories = [[dict objectForKey:@"categories"] mutableCopy];
        
        
        
        __block int count = 0;
        
        for (NSDictionary *catDict in self.categories) {
            [manager getFoods:[catDict objectForKey:@"name"] success:^(NSURLSessionDataTask *task, id responseObject) {
                
                
                NSDictionary *foodDict = responseObject;
                NSArray *foodArray = [foodDict objectForKey:@"foods"];
                count++;
                NSMutableDictionary *testDict = [[self.categories objectAtIndex:count-1] mutableCopy];
                
                [testDict setValue:foodArray forKey:@"foods"];
                
                [self.categories setObject:testDict atIndexedSubscript:[self.categories indexOfObject:catDict]];
                
               
                if(count == [self.categories count]) {
                   
                    [self.loading stopAnimating];
                    [self.tableView reloadData];
                }
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"Error: %@",error);
            }];
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@",error);
    }];

}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *catDict = [self.categories objectAtIndex:section];
    return [[catDict objectForKey:@"foods"] count];
}

- (NSString *)tableView:(nonnull UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSMutableDictionary *dict = [self.categories objectAtIndex:section];
    return [dict objectForKey:@"name"];
}

- (NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView
{
    return [self.categories count];
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
    NSMutableDictionary *dict = [self.categories objectAtIndex:indexPath.section];
    
    cell.indexPath = indexPath;
    cell.delegate = self;
    
    NSArray *foodArray = [dict objectForKey:@"foods"];
    NSDictionary *foodDict = [foodArray objectAtIndex:indexPath.row];
    cell.foodName.text = [foodDict objectForKey:@"name"];
    cell.foodQuantityPrice.text = [NSString stringWithFormat:@"%@ TL",[foodDict objectForKey:@"price"]];
    return cell;
}

-(void)menuCellAddButtonTappedOnTableViewCell:(MenuCell *)cell
{
    NSMutableDictionary *dict = [self.categories objectAtIndex:cell.indexPath.section];
    NSArray *foodArray = [dict objectForKey:@"foods"];
    NSDictionary *foodDict = [foodArray objectAtIndex:cell.indexPath.row];
    Food *food = [Food new];
    food.name = [foodDict objectForKey:@"name"];
    food.category = [foodDict objectForKey:@"category"];
    food.image = [foodDict objectForKey:@"image"];
    food.price = [foodDict objectForKey:@"price"];
    if (_delegate) {
        [_delegate selectedFood:food];
    }
}

- (void)menuCellPlusButtonTappedOnTableViewCell:(MenuCell *)cell
{
    if ([cell.foodQuantity.text isEqualToString:@"1.5"]) {
        [self changeTextWithAnimation:cell changedText:@"2" changedButton:cell.plusButton status:NO];
    } else {
        [self changeTextWithAnimation:cell changedText:@"1.5" changedButton:cell.minusButton status:YES];
    }
}

- (void)menuCellMinusButtonTappedOnTableViewCell:(MenuCell *)cell
{
    if ([cell.foodQuantity.text isEqualToString:@"1.5"]) {
        [self changeTextWithAnimation:cell changedText:@"1" changedButton:cell.minusButton status:NO];
    } else {
        [self changeTextWithAnimation:cell changedText:@"1.5" changedButton:cell.plusButton status:YES];
    }
    
}

- (void)changeTextWithAnimation:(MenuCell *)cell
                    changedText:(NSString *)changedText
                  changedButton:(UIButton *)changedButton
                         status:(BOOL)status
{
    [UIView animateWithDuration:0.25 animations:^{
        cell.foodQuantity.alpha = 0;
    } completion:^(BOOL finished) {
        cell.foodQuantity.text = changedText;
        [UIView animateWithDuration:0.25 animations:^{
            cell.foodQuantity.alpha = 1;
        }];
        if (changedButton) {
            changedButton.enabled = status;
        }
        
    }];
}

@end
