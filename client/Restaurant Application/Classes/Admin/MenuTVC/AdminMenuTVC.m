//
//  AdminMenuTVC.m
//  Restaurant Application
//
//  Created by Ömer Emre Aslan on 07/08/15.
//  Copyright © 2015 Ömer Emre Aslan. All rights reserved.
//

#import "AdminMenuTVC.h"
#import "AdminMenuCell.h"
#import "OrderManager.h"

@interface AdminMenuTVC ()

@end

@implementation AdminMenuTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initArrays];
    [self loadOrders];
}

- (void)initArrays
{
    if (!_orders)
        _orders = [NSMutableArray new];
    if (!_tables)
        _tables = [NSMutableArray new];
    if (!_users)
        _users = [NSMutableArray new];
}

- (void)loadOrders
{
    OrderManager *orderManager = [OrderManager new];
    [orderManager getAllOrders:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dict = responseObject;
        self.orders = [dict objectForKey:@"orders"];
        [self processOrders];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)processOrders
{
    for (NSDictionary *dict in self.orders) {
        NSString *user = [dict objectForKey:@"user"];
        if ([user containsString:@"Masa"] && ![self hasAddedUser:user :_tables]) {
            [_tables addObject:dict];
        } else if(![user containsString:@"Masa"] &&![self hasAddedUser:user :_users]) {
            [_users addObject:dict];
        }
    }
    [self.tableView reloadData];
}

- (BOOL)hasAddedUser:(NSString *)name :(NSMutableArray *)array
{
    for (NSDictionary *dict in array) {
        if ([name isEqualToString:[dict objectForKey:@"user"]]) {
            return YES;
        }
    }
    return NO;
}

- (NSInteger)countOfTablesOrder :(NSString *)name
{
    NSInteger count = 0;
    for (NSDictionary *dict in _orders) {
        if ([name isEqualToString:[dict objectForKey:@"user"]]) {
            count++;
        }
    }
    return count;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0){
        return [_tables count];
    } else {
        return [_users count];
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AdminMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"adminMenuCell" forIndexPath:indexPath];
    cell.badgeView.layer.cornerRadius = cell.badgeView.frame.size.height /2;
    cell.badgeView.layer.masksToBounds = YES;
    cell.badgeView.layer.borderWidth = 0;
    // Configure the cell...
    
    if (indexPath.section == 0) {
        NSDictionary *userDict = [_tables objectAtIndex:indexPath.row];
        cell.tableNameText.text = [userDict objectForKey:@"user"];
        cell.badgeCountText.text = [NSString stringWithFormat:@"%ld",(long)[self countOfTablesOrder:[userDict objectForKey:@"user"]]];
    } else {
        NSDictionary *userDict = [_users objectAtIndex:indexPath.row];
        cell.tableNameText.text = [userDict objectForKey:@"user"];
        cell.badgeCountText.text = [NSString stringWithFormat:@"%ld",(long)[self countOfTablesOrder:[userDict objectForKey:@"user"]]];
    }
    
    return cell;
}

- (NSString *)tableView:(nonnull UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0) {
        return @"Masa Siparişleri";
    } else {
        return @"Kullanıcı Siparişleri";
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
