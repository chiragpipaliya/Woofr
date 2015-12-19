//
//  ExploreNightVC.h
//  WOOFR
//
//  Created by dipen  narola on 01/12/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExploreNightVC : UIViewController <MBProgressHUDDelegate>
{
    IBOutlet UIButton *BTNCLub;
    IBOutlet UIButton *BTNDIscos;
    IBOutlet UIButton *BTNRating;
    
    IBOutlet UIScrollView *containSCRL;
    
    MBProgressHUD *HUD;
    
    NSURLConnection *ExploreNightconnection;
    NSMutableData *ExploreNightData;
    
    
}
- (IBAction)ClubBTNclick:(id)sender;
- (IBAction)DiscosBTNclick:(id)sender;
- (IBAction)RatingBTNclick:(id)sender;
@end
