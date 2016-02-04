//
//  InviteFriendsVC.h
//  WOOFR
//
//  Created by dipen  narola on 20/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MessageUI/MessageUI.h>

@interface InviteFriendsVC : UIViewController <MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>

{
    IBOutlet UILabel *PromoLBL;
    
    IBOutlet UIButton *EmailBTN;
    IBOutlet UIButton *TExtBTN;
}
- (IBAction)EmailBTNclick:(id)sender;
- (IBAction)TextBTnclick:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;
@end
