//
//  BookEventAvailibilityVC.h
//  WOOFR
//
//  Created by Hemal Kachhadiya on 12/18/15.
//  Copyright (c) 2015 dipen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BookEventAvailibilityVC : UIViewController <MBProgressHUDDelegate>
{
    IBOutlet UIImageView *ViewbackG;
    IBOutlet UIScrollView *ViewnackSCRL;
    IBOutlet UIScrollView *DateCSCRL;
    IBOutlet UIScrollView *timeSCRL;
    IBOutlet UIScrollView *TimeCSCRL;
    IBOutlet UIScrollView *TableCSCRL;

    MBProgressHUD *HUD;
    
    NSURLConnection *Timeconnection;
    NSMutableData *TimeData;
    
    NSURLConnection *availibilityconnection;
    NSMutableData *availibilityData;
    
    IBOutlet UIButton *continueBTN;

}
- (IBAction)continueBTNclick:(id)sender;
@end
