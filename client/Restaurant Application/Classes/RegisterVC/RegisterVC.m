//
//  RegisterVC.m
//  Restaurant Application
//
//  Created by Ömer Emre Aslan on 07/08/15.
//  Copyright © 2015 Ömer Emre Aslan. All rights reserved.
//

#import "RegisterVC.h"

@interface RegisterVC ()
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UISwitch *isAdminSwitch;

@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)registerButtonTapped:(id)sender {
    if (self.isAdminSwitch.on) {
        [SSKeychain setPassword:@"YES" forService:@"isAdmin" account:@"tmob"];
    } else {
        [SSKeychain setPassword:@"NO" forService:@"isAdmin" account:@"tmob"];
    }
}

@end
