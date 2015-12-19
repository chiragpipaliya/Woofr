//
//  EditProfileVC.h
//  WOOFR
//
//  Created by dipen  narola on 21/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProfileVC : UIViewController
{
    IBOutlet UIImageView *ProfileIMG;
    IBOutlet UIButton *ProfileIMGBTN;
    IBOutlet UITextField *NameTF;
    IBOutlet UITextField *PrePAssTF;
    IBOutlet UITextField *PassNewTF;
    IBOutlet UITextField *ReEnterPassTF;
    IBOutlet UITextField *SelectCountryCodeTF;
    IBOutlet UITextField *MobileTF;
    IBOutlet UIButton *SaveBTN;
    IBOutlet UIImageView *NamebackIMG;
    IBOutlet UIImageView *PreBackimge;
    IBOutlet UIImageView *Newpassbackimg;
    IBOutlet UIImageView *Confpassbackimg;
    IBOutlet UIImageView *countrycodebackImg;
    IBOutlet UIImageView *MobilebackImg;
    
    IBOutlet UIScrollView *EditPSCR;
    
    CGFloat animatedDistance;
}
- (IBAction)ProfileImgbtnclick:(id)sender;
- (IBAction)SaveBTNclick:(id)sender;

@end
