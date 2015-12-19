//
//  SettingsVC.m
//  WOOFR
//
//  Created by dipen  narola on 20/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import "SettingsVC.h"
#import "AboutUSView.h"
#import "PrivacyPolicyVC.h"
#import "TermsofUseVC.h"

@interface SettingsVC ()

@end

@implementation SettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _menubtn.tintColor = [UIColor whiteColor];
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    self.title=@"SETTINGS";
    
    [NotifySwitch setOnTintColor:[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0]];
    [LocationSwitch setOnTintColor:[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)AboutUsBTNclick:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    AboutUSView *dealVC1 = (AboutUSView *)[storyboard instantiateViewControllerWithIdentifier:@"AboutUSView"];
    [self.navigationController pushViewController:dealVC1 animated:YES];
}

- (IBAction)TermsofUSeBTNclick:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    TermsofUseVC *dealVC1 = (TermsofUseVC *)[storyboard instantiateViewControllerWithIdentifier:@"TermsofUseVC"];
    [self.navigationController pushViewController:dealVC1 animated:YES];
}

- (IBAction)PrivacypolicyBTnClick:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    PrivacyPolicyVC *dealVC1 = (PrivacyPolicyVC *)[storyboard instantiateViewControllerWithIdentifier:@"PrivacyPolicyVC"];
    [self.navigationController pushViewController:dealVC1 animated:YES];
}

- (IBAction)notificationswitch:(id)sender
{
    
}

- (IBAction)LocationSwitchAction:(id)sender
{
    
}
@end
