//
//  AdminMenuTVC.m
//  Restaurant Application
//
//  Created by Ömer Emre Aslan on 07/08/15.
//  Copyright © 2015 Ömer Emre Aslan. All rights reserved.
//

#import "AdminMenuTVC.h"
#import "AdminMenuCell.h"

@interface AdminMenuTVC ()

@end

@implementation AdminMenuTVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AdminMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"adminMenuCell" forIndexPath:indexPath];
    cell.badgeView.layer.cornerRadius = cell.badgeView.frame.size.height /2;
    cell.badgeView.layer.masksToBounds = YES;
    cell.badgeView.layer.borderWidth = 0;
    // Configure the cell...
    
    return cell;
}

- (NSString *)tableView:(nonnull UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Genel Siparişler";
    } else if(section == 1) {
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
