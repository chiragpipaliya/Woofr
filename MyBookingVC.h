//
//  MyBookingVC.h
//  WOOFR
//
//  Created by dipen  narola on 20/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface MyBookingVC : UIViewController <MBProgressHUDDelegate>
{
    IBOutlet UIButton *UpcomingBTN;
    IBOutlet UIButton *completedBTN;
    
    NSURLConnection *Mybookingconnection;
    NSMutableData *MybookingData;
    
    MBProgressHUD *HUD;
    
    IBOutlet UITableView *BookingTBL;
    
    IBOutlet UIImageView *waterMARKIMG;
}
- (IBAction)UpcomingBTNclick:(id)sender;
- (IBAction)CompletedBTNclick:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;
@end
