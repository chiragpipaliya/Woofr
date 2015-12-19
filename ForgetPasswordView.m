//
//  ForgetPasswordView.m
//  WOOFR
//
//  Created by dipen  narola on 18/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import "ForgetPasswordView.h"

@interface ForgetPasswordView ()

@end

@implementation ForgetPasswordView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    emailbackIMG.layer.borderWidth=1.0;
    emailbackIMG.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    
    [FemailTF setValue:[UIColor whiteColor]
            forKeyPath:@"_placeholderLabel.textColor"];
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

- (IBAction)LoginBTnclick:(id)sender
{
    [FemailTF resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}
@end
