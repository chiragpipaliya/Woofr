//
//  ProfileVC.m
//  WOOFR
//
//  Created by dipen  narola on 20/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import "ProfileVC.h"
#import "EditProfileVC.h"

@interface ProfileVC ()

@end

@implementation ProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    //    [_sidebarButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    NSUserDefaults *fetchDefaultslogin = [NSUserDefaults standardUserDefaults];
    [fetchDefaultslogin setBool:YES forKey:@"WoofrLOGIN"];
    
    
    self.navigationController.navigationBar.translucent = YES;
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor]];
    
     _menubtn.tintColor = [UIColor whiteColor];
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    self.title=@"MY PROFILE";
    
    ProfileIMG.layer.cornerRadius=ProfileIMG.frame.size.height/2;
    ProfileIMG.clipsToBounds=YES;
    
    NSMutableDictionary *UserInfo=[[NSMutableDictionary alloc]init];
    
    NSUserDefaults *user=[[NSUserDefaults alloc]init];
    
    UserInfo=[user valueForKey:@"WoofrUSer"];
    
    EMailLBL.text=[NSString stringWithFormat:@"%@",[UserInfo valueForKey:@"user_email"]];
    MobileNo.text=[NSString stringWithFormat:@"%@-%@",[UserInfo valueForKey:@"country_code"],[UserInfo valueForKey:@"mobile_no"]];
    nameLBL.text=[NSString stringWithFormat:@"%@",[UserInfo valueForKey:@"user_name"]];
    AddressLBL.text=[NSString stringWithFormat:@"%@",[UserInfo valueForKey:@"user_name"]];
    
    NSURL *urllinksTR= [NSURL URLWithString:[[NSString stringWithFormat:@"%@",[UserInfo valueForKey:@"user_image"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    AsyncImageView *beerImage = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, ProfileIMG.frame.size.width, ProfileIMG.frame.size.height)];
    [beerImage loadImageFromURL:urllinksTR imageName:@""];
    [ProfileIMG addSubview:beerImage];

    
    
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

- (IBAction)EditBTNclick:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    EditProfileVC *dealVC1 = (EditProfileVC *)[storyboard instantiateViewControllerWithIdentifier:@"EditProfileVC"];
    [self.navigationController pushViewController:dealVC1 animated:YES];
}
@end
