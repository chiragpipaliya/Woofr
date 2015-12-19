//
//  VoucherVC.m
//  WOOFR
//
//  Created by Hemal Kachhadiya on 12/12/15.
//  Copyright (c) 2015 dipen. All rights reserved.
//

#import "VoucherVC.h"

@interface VoucherVC ()
{
    
}
@end

@implementation VoucherVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    IMG1.layer.cornerRadius=IMG1.frame.size.height/2;
    IMG2.layer.cornerRadius=IMG2.frame.size.height/2;
    IMG3.layer.cornerRadius=IMG3.frame.size.height/2;
    IMG4.layer.cornerRadius=IMG4.frame.size.height/2;
    IMG5.layer.cornerRadius=IMG5.frame.size.height/2;
    IMG6.layer.cornerRadius=IMG6.frame.size.height/2;
    IMG7.layer.cornerRadius=IMG7.frame.size.height/2;
    
    
NSString *BookingID=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"WOOFRBOOKINGID"]];
    
    BookingIDLBL.text=BookingID;
    
    NSString *TBLType=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"WoofrTBLType"]];
    
    if([TBLType isEqualToString:@"1"])
    {
        bookingTypeLBL.text=@"VIP Table Packages";
    }
    else
    {
        bookingTypeLBL.text=@"Normal Table Packages";
    }

    float amounts;
    amounts=[[NSUserDefaults standardUserDefaults]floatForKey:@"PayableAMountRoof"];
    
    paymentLBL.text=[NSString stringWithFormat:@"%.02fSGD",amounts];
    
    self.title=@"Booking Done";
    
    [self.navigationItem setHidesBackButton:YES];
    
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

- (IBAction)ExploreEventClick:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    vc.view.backgroundColor = [UIColor clearColor];
    //  [vc setTransitioningDelegate:transitionController];
    vc.modalPresentationStyle= UIModalPresentationCustom;
    [self presentViewController:vc animated:YES completion:nil];
}
@end
