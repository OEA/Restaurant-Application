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
#import "Food.h"

@interface MenuTVC()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@property (strong, nonatomic) NSMutableArray *categories;
@property (strong, nonatomic) NSMutableArray *mCategories;
@end
@implementation MenuTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!_categories)
        _categories = [NSMutableArray new];
    if (!_mCategories)
        _mCategories = [NSMutableArray new];
    [self.loading startAnimating];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CategoryManager *manager = [CategoryManager sharedClient];
    [manager getCategories:YES success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSMutableDictionary *dict = [responseObject mutableCopy];
        
        self.categories = [[dict objectForKey:@"categories"] mutableCopy];
        
        
        for (NSDictionary *categoryDict in self.categories) {
            [manager getFoods:[categoryDict objectForKey:@"name"] success:^(NSURLSessionDataTask *task, id responseObject) {
                CategoryM *category = [CategoryM new];
                category.name = [categoryDict objectForKey:@"name"];
                category.foods = [NSMutableArray new];
                
                NSMutableArray *foodArray = [responseObject objectForKey:@"foods"];
                
                for (NSDictionary *foodDict in foodArray) {
                    Food *food = [Food new];
                    food.name = [foodDict objectForKey:@"name"];
                    [category.foods addObject:food];
                    
                }
                
                [self.mCategories addObject:category];
                
                [self.loading stopAnimating];
                [self.tableView reloadData];
                
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
    if (_mCategories) {
        CategoryM *category = [self.mCategories objectAtIndex:section];
        return [category.foods count];
    } else {
        return 0;
    }
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
    NSMutableDictionary *dict = [self.categories objectAtIndex:indexPath.row];
    cell.textLabel.text = [dict objectForKey:@"name"];
    return cell;
}

@end
