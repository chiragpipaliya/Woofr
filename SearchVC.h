//
//  SearchVC.h
//  WOOFR
//
//  Created by Hemal Kachhadiya on 12/12/15.
//  Copyright (c) 2015 dipen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface SearchVC : UIViewController <MBProgressHUDDelegate>
{
    IBOutlet UISearchBar *SearchBAR;
    IBOutlet UIScrollView *SearchSCRL;
    
    NSURLConnection *Searchconnection;
    NSMutableData *SearchData;
    
    MBProgressHUD *HUD;
    
    IBOutlet UIButton *closeBTN;
    IBOutlet UITextField *SearchTF;
}
- (IBAction)SearchcloseBTNclick:(id)sender;
@end
