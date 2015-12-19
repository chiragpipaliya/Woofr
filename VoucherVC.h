//
//  VoucherVC.h
//  WOOFR
//
//  Created by Hemal Kachhadiya on 12/12/15.
//  Copyright (c) 2015 dipen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VoucherVC : UIViewController
{
    IBOutlet UIImageView *backImagvoucher;
    IBOutlet UIScrollView *VoucherSCRL;
    
    
    IBOutlet UIImageView *IMG1;
    IBOutlet UIImageView *IMG2;
    IBOutlet UIImageView *IMG3;
    IBOutlet UIImageView *IMG4;
    IBOutlet UIImageView *IMG5;
    IBOutlet UIImageView *IMG6;
    IBOutlet UIImageView *IMG7;
    
    
    IBOutlet UILabel *BookingIDLBL;
    IBOutlet UILabel *bookingTypeLBL;
    IBOutlet UILabel *paymentLBL;
    
    
    IBOutlet UIButton *exploreEvent;
    
}
- (IBAction)ExploreEventClick:(id)sender;

@end
