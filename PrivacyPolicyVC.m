//
//  PrivacyPolicyVC.m
//  WOOFR
//
//  Created by dipen  narola on 21/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import "PrivacyPolicyVC.h"

@interface PrivacyPolicyVC ()

@end

@implementation PrivacyPolicyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = YES;
    
    self.navigationController.navigationBar.backIndicatorImage=[[UIImage imageNamed:@"ic_header_back.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage=[[UIImage imageNamed:@"ic_header_back.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    
    
    
    //    self.navigationItem.backBarButtonItem.image=[UIImage imageNamed:@"ic_header_back.png"];
    //    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"back-button-image"]];
    //    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back-button-image"]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor]];
    
    self.title=@"PRIVACY POLICY";

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

@end
