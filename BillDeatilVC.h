//
//  BillDeatilVC.h
//  WOOFR
//
//  Created by dipen  narola on 08/12/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BillDeatilVC : UIViewController <UITextFieldDelegate,MBProgressHUDDelegate>
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
