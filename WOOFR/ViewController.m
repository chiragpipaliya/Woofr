//
//  ViewController.m
//  WOOFR
//
//  Created by dipen  narola on 16/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import "ViewController.h"
#import "LocationPermissionView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setNeedsStatusBarAppearanceUpdate];
    
    BorderVIew.layer.borderWidth=1.0;
    BorderVIew.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    
    NSUserDefaults *login = [NSUserDefaults standardUserDefaults];
    [login setBool:YES forKey:@"WoofrInstalled"];
    
}
/*****************************************/
#pragma mark - Set Status Bar Style
/*****************************************/
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*******************************/
#pragma mark - Access BTNclick
/*******************************/
- (IBAction)accessBTNclick:(id)sender
{
 
    [self registerToReceivePushNotification];
}
#pragma mark - push notificaiton
-(void)registerToReceivePushNotification {
    // Register for push notifications
    UIApplication* application =[UIApplication sharedApplication];
    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    {
        // iOS 8 Notifications
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [application registerForRemoteNotifications];
    }
    else
    {
        // iOS < 8 Notifications
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
    }
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    LocationPermissionView *dealVC1 = (LocationPermissionView *)[storyboard instantiateViewControllerWithIdentifier:@"LocationPermissionView"];
    [self.navigationController pushViewController:dealVC1 animated:YES];

//    [application registerForRemoteNotificationTypes:
//     UIRemoteNotificationTypeBadge |
//     UIRemoteNotificationTypeAlert |
//     UIRemoteNotificationTypeSound];
}

/*********************************/
#pragma mark - Notallow BTNclick
/*********************************/
- (IBAction)NotallowBTNclick:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    LocationPermissionView *dealVC1 = (LocationPermissionView *)[storyboard instantiateViewControllerWithIdentifier:@"LocationPermissionView"];
    [self.navigationController pushViewController:dealVC1 animated:YES];
}
@end
