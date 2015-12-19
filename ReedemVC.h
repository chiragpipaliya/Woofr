//
//  ReedemVC.h
//  WOOFR
//
//  Created by dipen  narola on 20/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface ReedemVC : UIViewController <MBProgressHUDDelegate>
{
    NSURLConnection *ReedemListconnection;
    NSMutableData *ReedemListData;
    
    MBProgressHUD *HUD;
    
    IBOutlet UILabel *titleLBL;
    
    IBOutlet UIView *PointCView;
    IBOutlet UILabel *userpointLBL;
    IBOutlet UIImageView *DiIMG;
    
    IBOutlet UITableView *rewardTBL;

}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;
@end
