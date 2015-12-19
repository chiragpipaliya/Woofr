//
//  EventDetailVC.h
//  WOOFR
//
//  Created by dipen  narola on 27/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventDetailVC : UIViewController
{
    IBOutlet UIScrollView *EventDetailSCR;
    IBOutlet UIImageView *eventPic;
    IBOutlet UIButton *BTNbuyTicket;
    
    IBOutlet UIButton *GIVERATINGSBTN;
    
    IBOutlet UILabel *LBLeventNAMe;
    
    IBOutlet UILabel *EventTimeLBL;
    IBOutlet UIImageView *EventTimePic;
    IBOutlet UIImageView *EventLocPic;
    IBOutlet UILabel *LocationLBL;
    
    IBOutlet UIImageView *lineIMg;
}
- (IBAction)BTNBuyticketclick:(id)sender;
- (IBAction)giveRatingBTnclick:(id)sender;

@end
