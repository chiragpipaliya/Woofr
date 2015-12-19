//
//  ReferalcodeView.h
//  WOOFR
//
//  Created by dipen  narola on 18/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReferalcodeView : UIViewController
{
    IBOutlet UIImageView *RefrealCodebackimg;
    IBOutlet UITextField *RefrealTF;
    IBOutlet UIButton *APPLyBTN;
    IBOutlet UIButton *SkipBTN;
    
}
- (IBAction)skipBTNclick:(id)sender;
- (IBAction)ApplyBTNclick:(id)sender;
@end
