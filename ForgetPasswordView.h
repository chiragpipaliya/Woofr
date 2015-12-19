//
//  ForgetPasswordView.h
//  WOOFR
//
//  Created by dipen  narola on 18/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPasswordView : UIViewController
{
    IBOutlet UITextField *FemailTF;
    IBOutlet UIButton *LoginBTN;
    
    IBOutlet UIImageView *emailbackIMG;
}
- (IBAction)LoginBTnclick:(id)sender;
@end
