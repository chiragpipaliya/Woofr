//
//  EventBookingVC.h
//  WOOFR
//
//  Created by Hemal Kachhadiya on 12/19/15.
//  Copyright (c) 2015 dipen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface EventBookingVC : UIViewController <MBProgressHUDDelegate>
{
    IBOutlet UIImageView *BillbackIMG;
    IBOutlet UIScrollView *BillCSCRL;
    
    IBOutlet UIScrollView *CLubIMGCSCRL;
    IBOutlet UIImageView *ProfilePicIMg;
    IBOutlet UILabel *UserNAmeLBL;
    IBOutlet UILabel *DateLBL;
    
    CGFloat animatedDistance;
    
    MBProgressHUD *HUD;
    
    
    NSURLConnection *Promoconnection;
    NSMutableData *PromoData;
}
@end
