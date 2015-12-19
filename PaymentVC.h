//
//  PaymentVC.h
//  WOOFR
//
//  Created by dipen  narola on 10/12/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface PaymentVC : UIViewController <MBProgressHUDDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    
    IBOutlet UIScrollView *scrl;
    
    MBProgressHUD *HUD;
    IBOutlet UILabel *TotalLBL;
    IBOutlet UITextField *CardNAMETF;

    IBOutlet UIButton *ScanBTN;
    
    IBOutlet UIView *containerVIEW;
    IBOutlet UITextField *cardNumTF;
    IBOutlet UITextField *cardMnthTF;
    IBOutlet UITextField *cardYearTF;
    IBOutlet UITextField *CardCVCTF;
    
    CGFloat animatedDistance;
    
    
    UIToolbar *datepickerkeyboard;
    UIPickerView *datePicker;
    
    IBOutlet UIButton *MonthBTN;
    IBOutlet UILabel *MonthLBL;
    
    IBOutlet UILabel *YearLBL;
    IBOutlet UIButton *YearBTN;
    
    IBOutlet UIButton *paynowBTN;
    
    NSURLConnection *bookingconnection;
    NSMutableData *bookingData;

}
- (IBAction)ScanCardBTNclick:(id)sender;
- (IBAction)MonthBTnclick:(id)sender;
- (IBAction)YearBTNclick:(id)sender;
- (IBAction)paynwBTNclick:(id)sender;

@end
