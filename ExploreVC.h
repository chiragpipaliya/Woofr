//
//  ExploreVC.h
//  WOOFR
//
//  Created by dipen  narola on 20/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExploreVC : UIViewController <MBProgressHUDDelegate,UIGestureRecognizerDelegate>
{
    IBOutlet UIScrollView *ExploreSCRview;
    IBOutlet UIImageView *ExplorebackImg;
    
    IBOutlet UIScrollView *ExploreSCR;
    IBOutlet UIView *bottomContainerView;
    
    IBOutlet UIButton *ExploreBTN;
    
    MBProgressHUD *HUD;
    
    NSURLConnection *Homeconnection;
    NSMutableData *HomeData;
    
    IBOutlet UIButton *BTNSMclub;
    IBOutlet UIButton *BTNSMevent;
    IBOutlet UIButton *BTNSMpramotion;
    
    IBOutlet UIView *clubCNTview;
    IBOutlet UIView *eventCNTview;
    IBOutlet UIView *pramotionCNTview;
    
    IBOutlet UIScrollView *clubSCR;
    IBOutlet UIScrollView *eventSCR;
    IBOutlet UIScrollView *pramotionSCR;
    
    IBOutlet UIView *ExploreVIEW;
    
    IBOutlet UIImageView *ClubWaterMark;
    IBOutlet UIImageView *EventWaterMark;
    IBOutlet UIImageView *PramotionWaterMark;
    
    IBOutlet UIPageControl *pagecontrol;
    
    BOOL pageControlBeingUsed;
    
}
- (IBAction)changepage:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *SearchBTN;
- (IBAction)SearchBTNclick:(id)sender;
- (IBAction)ExploreBTNclick:(id)sender;
- (IBAction)SMclubBTNclick:(id)sender;
- (IBAction)SMeventBTNclick:(id)sender;
- (IBAction)SMpramotionBTNclick:(id)sender;
@end
