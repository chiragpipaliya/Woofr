//
//  RewardDetailVC.h
//  WOOFR
//
//  Created by Hemal Kachhadiya on 12/18/15.
//  Copyright (c) 2015 dipen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface RewardDetailVC : UIViewController <MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    
    IBOutlet UIImageView *PHOTOimg;
    IBOutlet UIImageView *lineIMG;
    
    IBOutlet UIScrollView *RedemSCRL;
    
    NSURLConnection *Redemconnection;
    NSMutableData *RedemData;
    
}

@end
