//
//  AboutUSView.h
//  WOOFR
//
//  Created by dipen  narola on 20/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutUSView : UIViewController
{
    IBOutlet UITextView *AboutUSText;
    IBOutlet UIButton *WriteaReviewBTN;
    IBOutlet UIButton *rateUSBTN;
    
    IBOutlet UIButton *WebsiteBTN;
    IBOutlet UIButton *FBBTN;
    IBOutlet UIButton *TWtBTN;
    
    IBOutlet UIView *BOTTOMVIEW;
}
- (IBAction)writereviewBTN:(id)sender;
- (IBAction)rateUSBTNclick:(id)sender;
- (IBAction)WebsiteBTNclick:(id)sender;
- (IBAction)FBBtnclick:(id)sender;
- (IBAction)TWtBTNclick:(id)sender;

@end
