//
//  ProfileVC.h
//  WOOFR
//
//  Created by dipen  narola on 20/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileVC : UIViewController
{
    IBOutlet UIImageView *ProfileIMG;
    IBOutlet UIBarButtonItem *EditBTN;
    
    IBOutlet UILabel *EMailLBL;
    IBOutlet UILabel *MobileNo;
    
    IBOutlet UILabel *nameLBL;
    IBOutlet UILabel *AddressLBL;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;
- (IBAction)EditBTNclick:(id)sender;
@end
