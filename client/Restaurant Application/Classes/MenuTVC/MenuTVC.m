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
                    
                    NSLog(@"Categories: %@", self.categories);
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
    NSMutableDictionary *dict = [self.categories objectAtIndex:indexPath.section];
    NSArray *foodArray = [dict objectForKey:@"foods"];
    NSDictionary *foodDict = [foodArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [foodDict objectForKey:@"name"];
    return cell;
}

@end
