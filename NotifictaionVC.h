//
//  NotifictaionVC.h
//  WOOFR
//
//  Created by dipen  narola on 20/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface NotifictaionVC : UIViewController <MBProgressHUDDelegate>
{
    NSURLConnection *Notificationconnection;
    NSMutableData *NotificationData;
    
    MBProgressHUD *HUD;
    
    IBOutlet UITableView *NotificationTBL;
    
    IBOutlet UILabel *NewNotifyLBL;
    
    IBOutlet UIImageView *waterMArk;
    
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;
@end
