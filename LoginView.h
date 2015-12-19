//
//  LoginView.h
//  WOOFR
//
//  Created by dipen  narola on 17/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIViewController <MBProgressHUDDelegate>
{
    IBOutlet UIImageView *usernameIMG;
    IBOutlet UIImageView *PasswordIMG;
    IBOutlet UIImageView *Backimg;
    IBOutlet UIScrollView *LoginContainSCRL;
    IBOutlet UITextField *userNameTF;
    IBOutlet UITextField *passwordTF;
    
    IBOutlet UIButton *registerBTN;
    IBOutlet UIButton *LoginBTN;
    IBOutlet UIButton *LoginwithFB;
    
    CGFloat animatedDistance;
    
    MBProgressHUD *HUD;
    
    NSURLConnection *LoginUserconnection;
    NSMutableData *LoginUserData;
    
    IBOutlet UIButton *forgetPasswordBTN;
    
}
- (IBAction)RegisterBTnclick:(id)sender;
- (IBAction)LoginBTnclick:(id)sender;
- (IBAction)LoginwithFBclick:(id)sender;
- (IBAction)ForgetPasswordBTNclick:(id)sender;

@end
