//
//  SettingsVC.h
//  WOOFR
//
//  Created by dipen  narola on 20/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsVC : UIViewController
{
    IBOutlet UIButton *AboutUSBTN;
    IBOutlet UIButton *TermsofUSeBTN;
    IBOutlet UIButton *PrivacyPolicyBTN;
    IBOutlet UISwitch *NotifySwitch;
    IBOutlet UISwitch *LocationSwitch;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;
- (IBAction)AboutUsBTNclick:(id)sender;
- (IBAction)TermsofUSeBTNclick:(id)sender;
- (IBAction)PrivacypolicyBTnClick:(id)sender;
- (IBAction)notificationswitch:(id)sender;
- (IBAction)LocationSwitchAction:(id)sender;
@end
