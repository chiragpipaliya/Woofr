//
//  ClubDetailVC.h
//  WOOFR
//
//  Created by dipen  narola on 28/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>

@interface ClubDetailVC : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>
{
    IBOutlet UIScrollView *ClubBackSCRL;
    IBOutlet UIScrollView *ClubIMGSCRL;
    
}

@end
