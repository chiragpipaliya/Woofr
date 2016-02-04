//
//  ForgetPasswordView.h
//  WOOFR
//
//  Created by dipen  narola on 18/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface ForgetPasswordView : UIViewController <MBProgressHUDDelegate>
{
    IBOutlet UITextField *FemailTF;
    IBOutlet UIButton *LoginBTN;
    
    IBOutlet UIImageView *emailbackIMG;
    
    IBOutlet UILabel *loginLBL;
    IBOutlet UIButton *sendEMailBTN;
    
        CGFloat animatedDistance;
    
    MBProgressHUD *HUD;
    
    NSURLConnection *FPasswordconnection;
    NSMutableData *FPasswordData;
}
- (IBAction)LoginBTnclick:(id)sender;
- (IBAction)sendEMailBTNclick:(id)sender;
@end
