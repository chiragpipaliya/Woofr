//
//  SeeAllVC.h
//  WOOFR
//
//  Created by dipen  narola on 03/12/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface SeeAllVC : UIViewController <MBProgressHUDDelegate>
{
    IBOutlet UIImageView *backGIMGS;
    IBOutlet UIScrollView *SeeALLSCRL;
    
    MBProgressHUD *HUD;
    
    NSURLConnection *SeeAllconnection;
    NSMutableData *SeeAllData;
    
}

@end
