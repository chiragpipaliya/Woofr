//
//  SideBarViewController.h
//  acino
//
//  Created by dipen  narola on 07/02/15.
//  Copyright (c) 2015 dipen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MessageUI/MessageUI.h>


@interface SideBarViewController : UITableViewController <MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>
{
    NSURLConnection *registerUDIDConnectioncodelogout;
    NSMutableData *registerUDIDDatacodelogout;
    

}

@end
