//
//  AppDelegate.m
//  WOOFR
//
//  Created by dipen  narola on 16/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [[NSUserDefaults standardUserDefaults]setInteger:1 forKey:@"selectedsidebarINDEX"];
    
    [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"FilterCountryindexwfr"];
    
    NSUserDefaults *Location = [NSUserDefaults standardUserDefaults];
    BOOL LOcation = [Location boolForKey:@"LocationUpdatingPermisiion"];
    
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bg_navigation_transparent.png"]];
    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"bg_navigation_transparent.png"] forBarMetrics:UIBarMetricsDefault];
    
    if(LOcation == YES)
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
    }
    NSUserDefaults *fetchDefaultslogin = [NSUserDefaults standardUserDefaults];
   BOOL LOgin=[fetchDefaultslogin boolForKey:@"WoofrLOGIN"];
    BOOL Installed=[fetchDefaultslogin boolForKey:@"WoofrInstalled"];
    
    if (LOgin==NO)
    {
        
        if(Installed==NO)
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
            
            UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"Fnavigation"];
            
            self.window.rootViewController = viewController;
            [self.window makeKeyAndVisible];

        }
        else
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
            
            UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"Snavigation"];
            
            self.window.rootViewController = viewController;
            [self.window makeKeyAndVisible];

        }

    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
        
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
        
        self.window.rootViewController = viewController;
        [self.window makeKeyAndVisible];

    }
    
    
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
    {
        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        fontNames = [[NSArray alloc] initWithArray:
                     [UIFont fontNamesForFamilyName:
                      [familyNames objectAtIndex:indFamily]]];
        for (indFont=0; indFont<[fontNames count]; ++indFont)
        {
            NSLog(@"    Font name: %@", [fontNames objectAtIndex:indFont]);
        }
        
    }
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.dipen.WOOFR" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"WOOFR" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"WOOFR.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
#pragma mark - Push notification

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)theData
{
    NSString *str = [NSString stringWithFormat:@"%@",theData];
    self.deviceToken = [[[[str description]
                          stringByReplacingOccurrencesOfString:@"<"withString:@""]
                         stringByReplacingOccurrencesOfString:@">" withString:@""]
                        stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"device tokan %@",self.deviceToken);
    
    NSUserDefaults *fetchDefaultslogin = [NSUserDefaults standardUserDefaults];
    [fetchDefaultslogin setValue:self.deviceToken forKey:@"deviceToken"];
    
    
    [[NSUserDefaults standardUserDefaults]setValue:self.deviceToken forKey:@"deviceToken"];
    
    
    
    /*
     NSString *resetUrlStr = [NSString stringWithFormat:@"http://www.mimideast.com/admin/api/?action=device_reg&device_token=%@&device_type=iphone&lat=%@&long=%@",self.deviceToken,@"21.035",@"72.326"];
     resetUrlStr = [resetUrlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:resetUrlStr] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120];
     [NSURLConnection connectionWithRequest:request delegate:self];
     */
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
    NSString *badge = [apsInfo objectForKey:@"badge"];
    application.applicationIconBadgeNumber = [badge integerValue];
    NSLog(@"%@",apsInfo);
    if (application.applicationState == UIApplicationStateActive ) {
        
        
        //        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        //        localNotification.userInfo = userInfo;
        //        localNotification.soundName = UILocalNotificationDefaultSoundName;
        //        localNotification.alertBody = @"";
        //        localNotification.fireDate = [NSDate date];
        //        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        ////         [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
        
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"profile"];
        
        self.window.rootViewController = viewController;
        [self.window makeKeyAndVisible];
        
        
    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
        
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"profile"];
        
        self.window.rootViewController = viewController;
        [self.window makeKeyAndVisible];
    }
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alertView show];
    }
    
    // Request to reload table view data
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    
    // Set icon badge number to zero
    application.applicationIconBadgeNumber = 0;
}

/***************************************/
#pragma mark - Location update Method
/***************************************/

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
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    //    UIAlertView *errorAlert = [[UIAlertView alloc]
    //                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //[errorAlert show];
}

@end
