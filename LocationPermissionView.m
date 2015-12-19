//
//  LocationPermissionView.m
//  WOOFR
//
//  Created by dipen  narola on 17/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import "LocationPermissionView.h"



@interface LocationPermissionView ()

@end

@implementation LocationPermissionView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    BorderVIew1.layer.borderWidth=1.0;
    BorderVIew1.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

/*******************************/
#pragma mark - Access BTNclick
/*******************************/
- (IBAction)accessBTNclick1:(id)sender
{
    
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    if(IS_OS_8_OR_LATER){
        NSUInteger code = [CLLocationManager authorizationStatus];
        if (code == kCLAuthorizationStatusNotDetermined && ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
            // choose one request according to your business.
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                [locationManager requestAlwaysAuthorization];
            } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                [locationManager  requestWhenInUseAuthorization];
            } else {
                NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
            }
        }
    }
    [locationManager startUpdatingLocation];

    NSUserDefaults *Location = [NSUserDefaults standardUserDefaults];
    [Location setBool:YES forKey:@"LocationUpdatingPermisiion"];
    
    
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    //The navigation controller, not the view controller, is marked as the initial scene.
    
    UINavigationController *dealVC1 = (UINavigationController *)[storyBoard instantiateViewControllerWithIdentifier:@"Snavigation"];
    
    
    NSLog(@"-- Loading storyboard -- Nav controller: %@", dealVC1);
    
    //Remove the current navigation controller.
    [self.navigationController.view removeFromSuperview];
    UIWindow *window = [(AppDelegate *)[[UIApplication sharedApplication] delegate] window];
    window.rootViewController = dealVC1;

    
    
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    // NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        currentLongitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        currentLatitude= [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        [[NSUserDefaults standardUserDefaults] setValue:currentLatitude forKey:@"Latitude"];
        [[NSUserDefaults standardUserDefaults] setValue:currentLongitude forKey:@"Longitude"];
    }
    // NSLog(@"%@ %@",currentLatitude,currentLongitude);
   
    
   
    //[Location setBool:YES forKey:@"LocationUpdatingPermisiion"];
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    //    UIAlertView *errorAlert = [[UIAlertView alloc]
    //                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //[errorAlert show];
}

/*********************************/
#pragma mark - Notallow BTNclick
/*********************************/
- (IBAction)NotallowBTNclick1:(id)sender
{
        
    //Get the storyboard from the main bundle.
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    //The navigation controller, not the view controller, is marked as the initial scene.
   // UINavigationController *theInitialViewController = [storyBoard instantiateInitialViewController];
    
    UINavigationController *dealVC1 = (UINavigationController *)[storyBoard instantiateViewControllerWithIdentifier:@"Snavigation"];
    
    
    NSLog(@"-- Loading storyboard -- Nav controller: %@", dealVC1);
    
    //Remove the current navigation controller.
    [self.navigationController.view removeFromSuperview];
    UIWindow *window = [(AppDelegate *)[[UIApplication sharedApplication] delegate] window];
    window.rootViewController = dealVC1;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
