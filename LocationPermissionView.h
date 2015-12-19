//
//  LocationPermissionView.h
//  WOOFR
//
//  Created by dipen  narola on 17/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"

@interface LocationPermissionView : UIViewController <CLLocationManagerDelegate>
{
    IBOutlet UIView *BorderVIew1;
    IBOutlet UIScrollView *containerSCRL1;
    IBOutlet UIImageView *BackImage1;
    IBOutlet UIButton *AccessBTN1;
    IBOutlet UIButton *notallowBTN1;
    
    CLLocationManager *locationManager;
    CLLocation *startLocation;
    
    NSString *currentLatitude;
    NSString *currentLongitude;
    
    AppDelegate *appdelegate;
}

- (IBAction)accessBTNclick1:(id)sender;
- (IBAction)NotallowBTNclick1:(id)sender;

@end
