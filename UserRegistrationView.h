//
//  UserRegistrationView.h
//  WOOFR
//
//  Created by dipen  narola on 17/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface UserRegistrationView : UIViewController <MBProgressHUDDelegate,UIImagePickerControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate>
{
    IBOutlet UITextField *NameTF;
    IBOutlet UITextField *EmailTF;
    IBOutlet UITextField *PasswordTF;
    IBOutlet UITextField *ConfirmPasswordTF;
    IBOutlet UITextField *selectcountryTF;
    IBOutlet UITextField *MobileNumberTF;
    
    IBOutlet UIImageView *NAmeIMG;
    IBOutlet UIImageView *EmailIMG;
    IBOutlet UIImageView *PasswordIMG;
    IBOutlet UIImageView *ConfirmPasswordIMG;
    IBOutlet UIImageView *selectcountryIMG;
    IBOutlet UIImageView *MobileNumberIMG;
    
    IBOutlet UIButton *RegisterBTN;
    //User Profile Photo
   
    IBOutlet UIButton *photoBTN;
    IBOutlet UIImageView *PhotoIMG;
    
    IBOutlet UILabel *LoginLBL;
    
    IBOutlet UIScrollView *RegisSCR;
    
    IBOutlet UIButton *LoginBtn;
    
    CGFloat animatedDistance;
    
    MBProgressHUD *HUD;
    
    NSURLConnection *registerUDIDConnectionRegister;
    NSMutableData *registerUDIDDataRegister;
    
}
- (IBAction)RegisterBTNclick:(id)sender;
- (IBAction)PhotoBTNclick:(id)sender;
- (IBAction)LoginBtnclick:(id)sender;

@end
