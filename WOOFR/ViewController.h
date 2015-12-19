//
//  ViewController.h
//  WOOFR
//
//  Created by dipen  narola on 16/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    IBOutlet UIView *BorderVIew;
    IBOutlet UIScrollView *containerSCRL;
    IBOutlet UIImageView *BackImage;
    IBOutlet UIButton *AccessBTN;
    IBOutlet UIButton *notallowBTN;
    
}
- (IBAction)accessBTNclick:(id)sender;
- (IBAction)NotallowBTNclick:(id)sender;


@end

