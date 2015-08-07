//
//  AdminMenuCell.h
//  Restaurant Application
//
//  Created by Ömer Emre Aslan on 07/08/15.
//  Copyright © 2015 Ömer Emre Aslan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminMenuCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tableNameText;
@property (weak, nonatomic) IBOutlet UIView *badgeView;
@property (weak, nonatomic) IBOutlet UILabel *badgeCountText;

@end
