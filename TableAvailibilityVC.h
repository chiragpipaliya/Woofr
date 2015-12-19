//
//  TableAvailibilityVC.h
//  WOOFR
//
//  Created by dipen  narola on 05/12/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface TableAvailibilityVC : UIViewController <MBProgressHUDDelegate>
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
    
    NSURLConnection *Tableconnection;
    NSMutableData *TableData;
    
}

@end
