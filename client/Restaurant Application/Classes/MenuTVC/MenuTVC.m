//
//  MenuTVC.m
//  Restaurant Application
//
//  Created by Ömer Emre Aslan on 03/08/15.
//  Copyright © 2015 Ömer Emre Aslan. All rights reserved.
//

#import "MenuTVC.h"
#import "CategoryManager.h"

@interface MenuTVC()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@property (strong, nonatomic) NSMutableArray *categories;
@end
@implementation MenuTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.loading startAnimating];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CategoryManager *manager = [CategoryManager sharedClient];
    [manager getCategories:YES success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dict = responseObject;
        self.categories = [dict objectForKey:@"categories"];
        NSLog(@"%@",self.categories);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@",error);
    }];

}

-(void)setCategories:(NSMutableArray *)categories
{
    if ( _categories != categories)
    {
        _categories = categories;
        [self.loading stopAnimating];
        [self.tableView reloadData];
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
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

- (NSString *)tableView:(nonnull UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (!_categories)
        return nil;
    else
        return @"Menu Baslik";
}
@end
