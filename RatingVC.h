//
//  RatingVC.h
//  WOOFR
//
//  Created by dipen  narola on 02/12/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RatingVC : UIViewController <MBProgressHUDDelegate>
{
    IBOutlet UIButton *Star1BTN;
    IBOutlet UIButton *Star2BTN;
    IBOutlet UIButton *Star3BTN;
    IBOutlet UIButton *Star4BTN;
    IBOutlet UIButton *Star5BTN;
    IBOutlet UIButton *DoneBTN;
    
    MBProgressHUD *HUD;
    
    
    NSURLConnection *Ratingconnection;
    NSMutableData *RatingData;
    
    
}
- (IBAction)Star1BTNclick:(id)sender;
- (IBAction)Star2BTNclick:(id)sender;
- (IBAction)Star3BTNclick:(id)sender;
- (IBAction)Star4BTNclick:(id)sender;
- (IBAction)Star5BTNclick:(id)sender;
- (IBAction)DoneBTNclick:(id)sender;
@end
