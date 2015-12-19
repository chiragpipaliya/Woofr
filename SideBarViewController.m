//
//  SideBarViewController.m
//  acino
//
//  Created by dipen  narola on 07/02/15.
//  Copyright (c) 2015 dipen. All rights reserved.
//

#import "SideBarViewController.h"
#import "SWRevealViewController.h"
#import "JSON.h"
#import <Social/Social.h>
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>

@interface SideBarViewController ()
{
    NSArray *menuItems;
    
    NSArray *user_info;
    
    int x;
    
}
@end

@implementation SideBarViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    //    NSString *imageupdate=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"imagechanged"]];
    //    if([imageupdate isEqualToString:@"1"])
    //    {
    //        [[NSUserDefaults standardUserDefaults]setValue:@"0" forKey:@"imagechanged"];
    //        [self.tableView reloadData];
    //    }
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_login_page.png"]];
    [tempImageView setFrame:self.tableView.frame];
    self.tableView.backgroundView=tempImageView;
    
    
    
    menuItems = @[@"Profile",@"Explore", @"MyBooking", @"Reedem",@"InviteFriend", @"Notification",@"Setting",@"Logout"];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    x=0;
    
    self.tableView.backgroundColor=[UIColor whiteColor];
    
    
    [self performSegueWithIdentifier:@"Explore" sender:nil];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [menuItems count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor=[UIColor clearColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    int long detect=[[NSUserDefaults standardUserDefaults]integerForKey:@"selectedsidebarINDEX"];
    
    
    if(indexPath.row==0)
    {
        NSMutableDictionary *UserInfo=[[NSMutableDictionary alloc]init];
        
        NSUserDefaults *user=[[NSUserDefaults alloc]init];
        
        UserInfo=[user valueForKey:@"WoofrUSer"];
        NSLog(@"%@",UserInfo);
        
        UIImageView *logo_img=[[UIImageView alloc]initWithFrame:CGRectMake(8, 30, 74, 74)];
        logo_img.layer.cornerRadius = 37.0;
        logo_img.clipsToBounds = YES;
        NSString *image_str=[NSString stringWithFormat:@"%@",[UserInfo valueForKey:@"user_image"]];
        NSURL *urllinksTR= [NSURL URLWithString:[[NSString stringWithFormat:@"%@",image_str]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        AsyncImageView *beerImage = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, logo_img.frame.size.width, logo_img.frame.size.height)];
        [beerImage loadImageFromURL:urllinksTR imageName:@""];
        beerImage.layer.cornerRadius=beerImage.frame.size.width/2;
        beerImage.clipsToBounds=YES;
        [logo_img addSubview:beerImage];

//        if(image_str.length>10)
//        {
//            
//            NSData *pngData = [[NSData alloc] initWithBase64EncodedString:image_str options:1];
//            UIImage *map = [UIImage imageWithData:pngData];
//            [logo_img setImage:map];
//        }
//        else
//        {
//            [logo_img setImage:[UIImage imageNamed:@"ic_default_pic.png"]];
//        }
        logo_img.backgroundColor=[UIColor lightGrayColor];
        
        [cell addSubview:logo_img];
        
        UILabel *namelbl=[[UILabel alloc]initWithFrame:CGRectMake(8+logo_img.frame.size.width+10, 30, 230-(8+logo_img.frame.size.width+15), 60)];
        namelbl.text=[NSString stringWithFormat:@"%@",[UserInfo valueForKey:@"user_name"]];
        namelbl.textColor=[UIColor whiteColor];
//        namelbl.font=[UIFont boldSystemFontOfSize:18.0];
        namelbl.font=[UIFont fontWithName:@"ProximaNova-Bold" size:15.0];
        namelbl.numberOfLines=2;
        namelbl.textAlignment=NSTextAlignmentCenter;
        [namelbl sizeToFit];
        
        [cell addSubview:namelbl];
        
        UILabel *locationLBL=[[UILabel alloc]initWithFrame:CGRectMake(8+logo_img.frame.size.width+10, namelbl.frame.size.height+namelbl.frame.origin.y+5, 230-(8+logo_img.frame.size.width+15), 60)];
        locationLBL.text=[NSString stringWithFormat:@"%@",[UserInfo valueForKey:@"user_name"]];
        locationLBL.textColor=[UIColor whiteColor];
//        locationLBL.font=[UIFont systemFontOfSize:15.0];
        locationLBL.font=[UIFont fontWithName:@"ProximaNova-Regular" size:13.0];
        locationLBL.numberOfLines=2;
        locationLBL.textAlignment=NSTextAlignmentCenter;
        [locationLBL sizeToFit];
        [cell addSubview:locationLBL];
        
        
        
        UIImageView *lineimg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 129, self.view.frame.size.width, 1)];
        lineimg.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        [cell addSubview:lineimg];
    }
    else if (indexPath.row==1)
    {
        UIImageView *ImageL=[[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 24, 24)];
        if(detect==indexPath.row)
        {
            ImageL.image=[UIImage imageNamed:@"ic_side_menu_explorer_selected.png"];
        }
        else
        {
            ImageL.image=[UIImage imageNamed:@"ic_side_menu_explorer_normal.png"];
        }
        
        ImageL.userInteractionEnabled=YES;
        [cell addSubview:ImageL];
        
        UILabel *lbl_home=[[UILabel alloc]initWithFrame:CGRectMake(60, 15, self.view.frame.size.width-80, 24)];
        lbl_home.text=@"EXPLORE";
        if(detect==indexPath.row)
        {
            lbl_home.textColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        }
        else
        {
            lbl_home.textColor=[UIColor whiteColor];
        }
//        lbl_home.font=[UIFont systemFontOfSize:16.0];
                lbl_home.font=[UIFont fontWithName:@"ProximaNova-Bold" size:15.0];
        lbl_home.textAlignment=NSTextAlignmentLeft;
        [cell addSubview:lbl_home];
        
        UIImageView *lineimg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 54, self.view.frame.size.width, 1)];
        lineimg.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        [cell addSubview:lineimg];
        
    }
    
    else if (indexPath.row==2)
    {
        
        UIImageView *BookimgIMG=[[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 24, 24)];
        if(detect==indexPath.row)
        {
            BookimgIMG.image=[UIImage imageNamed:@"ic_side_menu_my_booking_selected.png"];
        }
        else
        {
            BookimgIMG.image=[UIImage imageNamed:@"ic_side_menu_my_booking_normal.png"];
        }
        
        BookimgIMG.userInteractionEnabled=YES;
        [cell addSubview:BookimgIMG];
        
        UILabel *lbl_book=[[UILabel alloc]initWithFrame:CGRectMake(60, 15, self.view.frame.size.width-80, 24)];
        lbl_book.text=@"MANAGE";
        if(detect==indexPath.row)
        {
            lbl_book.textColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        }
        else
        {
            lbl_book.textColor=[UIColor whiteColor];
        }
//        lbl_book.font=[UIFont systemFontOfSize:16.0];
                lbl_book.font=[UIFont fontWithName:@"ProximaNova-Bold" size:15.0];
        lbl_book.textAlignment=NSTextAlignmentLeft;
        [cell addSubview:lbl_book];
        
        UIImageView *lineimg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 54, self.view.frame.size.width, 1)];
        lineimg.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        [cell addSubview:lineimg];
    }
    else if (indexPath.row==3)
    {
        
        UIImageView *reedemIMg=[[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 24, 24)];
        if(detect==indexPath.row)
        {
            reedemIMg.image=[UIImage imageNamed:@"ic_side_menu_reward_selected.png"];
        }
        else
        {
            reedemIMg.image=[UIImage imageNamed:@"ic_side_menu_reward_normal.png"];
        }
        
        reedemIMg.userInteractionEnabled=YES;
        [cell addSubview:reedemIMg];
        
        UILabel *lbl_reedem=[[UILabel alloc]initWithFrame:CGRectMake(60, 15, self.view.frame.size.width-80, 24)];
        lbl_reedem.text=@"REWARDS";
        if(detect==indexPath.row)
        {
            lbl_reedem.textColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        }
        else
        {
            lbl_reedem.textColor=[UIColor whiteColor];
        }
//        lbl_reedem.font=[UIFont systemFontOfSize:16.0];
                lbl_reedem.font=[UIFont fontWithName:@"ProximaNova-Bold" size:15.0];
        lbl_reedem.textAlignment=NSTextAlignmentLeft;
        [cell addSubview:lbl_reedem];
        
        UIImageView *lineimg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 54, self.view.frame.size.width, 1)];
        lineimg.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        [cell addSubview:lineimg];
    }
    
    else if (indexPath.row==4)
    {
        
        UIImageView *inviteIMg=[[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 24, 24)];
        if(detect==indexPath.row)
        {
            inviteIMg.image=[UIImage imageNamed:@"ic_side_menu_invite_selected.png"];
        }
        else
        {
            inviteIMg.image=[UIImage imageNamed:@"ic_side_menu_invite_normal.png"];
        }
        
        inviteIMg.userInteractionEnabled=YES;
        [cell addSubview:inviteIMg];
        
        UILabel *lbl_Invite=[[UILabel alloc]initWithFrame:CGRectMake(60, 15, self.view.frame.size.width-80, 24)];
        lbl_Invite.text=@"INVITE";
        lbl_Invite.font=[UIFont fontWithName:@"ProximaNova-Bold" size:15.0];
        if(detect==indexPath.row)
        {
            lbl_Invite.textColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        }
        else
        {
            lbl_Invite.textColor=[UIColor whiteColor];
        }
//        lbl_Invite.font=[UIFont systemFontOfSize:16.0];
        lbl_Invite.textAlignment=NSTextAlignmentLeft;
        [cell addSubview:lbl_Invite];
        
        UIImageView *lineimg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 54, self.view.frame.size.width, 1)];
        lineimg.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        [cell addSubview:lineimg];
    }
    else if (indexPath.row==5)
    {
        UIImageView *NotifIMG=[[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 24, 24)];
        if(detect==indexPath.row)
        {
            NotifIMG.image=[UIImage imageNamed:@"ic_side_menu_notification_selected.png"];
        }
        else
        {
            NotifIMG.image=[UIImage imageNamed:@"ic_side_menu_notification_normal.png"];
        }
        
        NotifIMG.userInteractionEnabled=YES;
        [cell addSubview:NotifIMG];
        
        UILabel *lbl_Notif=[[UILabel alloc]initWithFrame:CGRectMake(60, 15, 120, 24)];
        lbl_Notif.text=@"NOTIFICATIONS";
        if(detect==indexPath.row)
        {
            lbl_Notif.textColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        }
        else
        {
            lbl_Notif.textColor=[UIColor whiteColor];
        }
//        lbl_Notif.font=[UIFont systemFontOfSize:16.0];
        lbl_Notif.font=[UIFont fontWithName:@"ProximaNova-Bold" size:15.0];
        lbl_Notif.textAlignment=NSTextAlignmentLeft;
        [cell addSubview:lbl_Notif];
        
         NSInteger counter=[[NSUserDefaults standardUserDefaults]integerForKey:@"WoofrNotifycounter"];
        if(counter>0)
        {
            UILabel *counterLBL=[[UILabel alloc]initWithFrame:CGRectMake(lbl_Notif.frame.origin.x+lbl_Notif.frame.size.width+10, 15, self.view.frame.size.width-(lbl_Notif.frame.origin.x+lbl_Notif.frame.size.width+5+15), 24)];
            counterLBL.text=[NSString stringWithFormat:@"%li ",(long)counter];
            counterLBL.font=[UIFont systemFontOfSize:14.0];
            counterLBL.textColor=[UIColor whiteColor];
            [counterLBL sizeToFit];
            CGRect fdf=counterLBL.frame;
            fdf.size.height=lbl_Notif.frame.size.height;
            if(counterLBL.frame.size.width<lbl_Notif.frame.size.height)
            {
                fdf.size.width=lbl_Notif.frame.size.height;
            }
            counterLBL.frame=fdf;
            counterLBL.textAlignment=NSTextAlignmentCenter;
            
            UIImageView *rIMg=[[UIImageView alloc]initWithFrame:fdf];
            rIMg.layer.cornerRadius=fdf.size.height/2;
            rIMg.clipsToBounds=YES;
            rIMg.layer.borderWidth=1.0;
            rIMg.layer.borderColor=[UIColor whiteColor].CGColor;
            [cell addSubview:rIMg];
            [cell addSubview:counterLBL];
        }
        
        
        UIImageView *lineimg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 54, self.view.frame.size.width, 1)];
        lineimg.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        [cell addSubview:lineimg];
    }
    else if (indexPath.row==6)
    {
        
        UIImageView *SettingIMG=[[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 24, 24)];
        if(detect==indexPath.row)
        {
            SettingIMG.image=[UIImage imageNamed:@"ic_side_menu_explorer_settings_selected.png"];
        }
        else
        {
            SettingIMG.image=[UIImage imageNamed:@"ic_side_menu_explorer_settings_normal.png"];
        }
        
        SettingIMG.userInteractionEnabled=YES;
        [cell addSubview:SettingIMG];
        
        UILabel *lbl_Setting=[[UILabel alloc]initWithFrame:CGRectMake(60, 15, self.view.frame.size.width-80, 24)];
        lbl_Setting.text=@"SETTINGS";
        if(detect==indexPath.row)
        {
            lbl_Setting.textColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        }
        else
        {
            lbl_Setting.textColor=[UIColor whiteColor];
        }
//        lbl_Setting.font=[UIFont systemFontOfSize:16.0];
        lbl_Setting.font=[UIFont fontWithName:@"ProximaNova-Bold" size:15.0];
        lbl_Setting.textAlignment=NSTextAlignmentLeft;
        [cell addSubview:lbl_Setting];
        
        UIImageView *lineimg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 54, self.view.frame.size.width, 1)];
        lineimg.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        [cell addSubview:lineimg];
    }
    else if (indexPath.row==7)
    {
        UIImageView *logoutIMG=[[UIImageView alloc]init];
        UILabel *logoutlbl=[[UILabel alloc]init];
        
        if(self.view.frame.size.height>((55*6)+130) && (self.view.bounds.size.height-((55*6)+130)>55))
        {
            logoutIMG.frame=CGRectMake(20, (self.view.bounds.size.height-((55*6)+130))-40, 24, 24);
            logoutlbl.frame=CGRectMake(60, (self.view.bounds.size.height-((55*6)+130))-40, self.view.frame.size.width-80, 24);
        }
        else
        {
            logoutIMG.frame=CGRectMake(20, 15, 24, 24);
            logoutlbl.frame=CGRectMake(60, 15, self.view.frame.size.width-80, 24);
        }
        logoutlbl.text=@"LOGOUT";
        if(detect==indexPath.row)
        {
            logoutIMG.image=[UIImage imageNamed:@"ic_side_menu_logou.png"];
            logoutlbl.textColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        }
        else
        {
            logoutIMG.image=[UIImage imageNamed:@"ic_side_menu_logou.png"];
            logoutlbl.textColor=[UIColor whiteColor];
        }
        
        logoutIMG.userInteractionEnabled=YES;
        
//        logoutlbl.font=[UIFont systemFontOfSize:16.0];
        logoutlbl.font=[UIFont fontWithName:@"ProximaNova-Bold" size:15.0];
        logoutlbl.textAlignment=NSTextAlignmentLeft;
        [cell addSubview:logoutlbl];
        [cell addSubview:logoutIMG];
    }
    cell.backgroundColor=[UIColor clearColor];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        return 130;
    }
    else
    {
        
        if(indexPath.row==7)
        {
            if(self.view.frame.size.height>((55*6)+130) && (self.view.bounds.size.height-((55*6)+130)>55))
            {
                return self.view.bounds.size.height-((55*6)+130);
            }
            else
            {
                return 55;//self.view.bounds.size.height-((44*7)+250);
            }
        }
        else
        {
            return 55;
        }
    }
    
}
- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    
    if ([[segue identifier] isEqualToString:@"Sign Out"])
    {
        if(x==0)
        {
            UIAlertView *logout = [[UIAlertView alloc]initWithTitle:@"Are You sure?" message:@"Do you Want to Logout?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:nil];
            //locationAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
            logout.tag=512;
            [logout addButtonWithTitle:@"YES"];
            
            [logout show];
        }
        else
        {
            
            
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
            
            destViewController.title = [[menuItems objectAtIndex:indexPath.row] capitalizedString];
            
            NSUserDefaults *fetchDefaultslogin = [NSUserDefaults standardUserDefaults];
            [fetchDefaultslogin setBool:NO forKey:@"is_login"];
            
            if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] )
            {
                SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
                
                swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
                    
                    UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
                    [navController setViewControllers: @[dvc] animated: NO ];
                    [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
                };
                
            }
        }
        
    }
    else if ([[segue identifier] isEqualToString:@"Share"])
    {
        UIAlertView *share_alert = [[UIAlertView alloc]
                                    initWithTitle:@"Share Application With"
                                    message:nil
                                    delegate:self
                                    cancelButtonTitle:@"Cancel"
                                    otherButtonTitles:@"Twitter",@"Facebook",@"Email",@"Text Message",nil];
        share_alert.tag=45;
        [share_alert show];
    }
    else
    {
        
        if([[segue identifier] isEqualToString:@"Profile"])
        {
            [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"selectedsidebarINDEX"];
        }
        else if ([[segue identifier] isEqualToString:@"Explore"])
        {
            [[NSUserDefaults standardUserDefaults]setInteger:1 forKey:@"selectedsidebarINDEX"];
        }
        else if ([[segue identifier] isEqualToString:@"MyBooking"])
        {
            [[NSUserDefaults standardUserDefaults]setInteger:2 forKey:@"selectedsidebarINDEX"];
        }
        else if ([[segue identifier] isEqualToString:@"Reedem"])
        {
            [[NSUserDefaults standardUserDefaults]setInteger:3 forKey:@"selectedsidebarINDEX"];
        }
        else if ([[segue identifier] isEqualToString:@"InviteFriend"])
        {
            [[NSUserDefaults standardUserDefaults]setInteger:4 forKey:@"selectedsidebarINDEX"];
        }
        else if ([[segue identifier] isEqualToString:@"Notification"])
        {
            [[NSUserDefaults standardUserDefaults]setInteger:5 forKey:@"selectedsidebarINDEX"];
        }
        else if ([[segue identifier] isEqualToString:@"Setting"])
        {
            [[NSUserDefaults standardUserDefaults]setInteger:6 forKey:@"selectedsidebarINDEX"];
        }
        else if ([[segue identifier] isEqualToString:@"Logout"])
        {
            
        }
        
        // Set the title of navigation bar by using the menu items
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
        
        destViewController.title = [[menuItems objectAtIndex:indexPath.row] capitalizedString];
        
        //    home=[[HomeView alloc]init];
        //    [home.player1 play];
        
        // Set the photo if it navigates to the PhotoView
        
        if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] )
        {
            SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
            
            swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
                
                UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
                [navController setViewControllers: @[dvc] animated: NO ];
                [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
            };
            
        }
        
        else
        {
            if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] )
            {
                SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
                
                swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
                    
                    UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
                    [navController setViewControllers: @[dvc] animated: NO ];
                    [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
                };
                
            }
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==512)
    {
        if (buttonIndex == 1)
        {
            
            [self callLOgout];
            //        x=1;
            //        [self performSegueWithIdentifier:@"Sign Out" sender:nil];
        }
        else
        {
            x=0;
        }
    }
    
    if (alertView.tag == 45)
    {
        
        //        NSString *string = [alertView buttonTitleAtIndex:buttonIndex];
        
        NSInteger index = buttonIndex;
        if (index==1)
        {
            [self twittershare];
        }
        else if (index==2)
        {
            [self facebookshare];
        }
        else if(index ==3)
        {
            [self emailshare];
        }
        else if (index==4)
        {
            [self sendMessage];
        }
        
    }
    
}
-(void)twittershare
{
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        //    NSString *tweet_str=hederlbl.text;
        //    if(tweet_str.length>89)
        //    {
        //        tweet_str=[tweet_str substringToIndex:3];
        //        tweet_str=[tweet_str stringByAppendingString:@" Read more: http://www.elementmag.asia/magazine.php"];
        //    }
        //    else
        //    {
        //        tweet_str=[tweet_str stringByAppendingString:@" Read more: http://www.elementmag.asia/magazine.php"];
        //    }
        
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"Download amazing application Win Or Loss from app store : https://itunes.apple.com/us/app/win-or-loss/id985170419?ls=1&mt=8"];
        [tweetSheet addImage:[UIImage imageNamed:@"app_icon_image.png"]];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
    
    
}
-(void)facebookshare
{
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:@"Download amazing application Win Or Loss from app store : https://itunes.apple.com/us/app/win-or-loss/id985170419?ls=1&mt=8"];
        [controller addImage:[UIImage imageNamed:@"app_icon_image.png"]];//[UIImage imageNamed:@"socialsharing-facebook-image.jpg"]];
        [self presentViewController:controller animated:YES completion:Nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a post right now, make sure your device has an internet connection and you have at least one facebook account setup in setting"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
    
    
}
-(void)emailshare
{
    NSString * subject = @"Win Or Loss application Share";
    //email body
    // NSString * body = @"How did you find the Android-IOS-Tutorials Website ?";
    //recipient(s)
    // NSArray * recipients = [NSArray arrayWithObjects:@"info@vasundhravision.com", nil];
    MFMailComposeViewController * composer = [[MFMailComposeViewController alloc] init];
    
    if ([MFMailComposeViewController canSendMail]) {
        composer.mailComposeDelegate = self;
        [composer setSubject:subject];
        //[composer setMessageBody:@"here is link for Love Frame application" isHTML:NO];
        //[composer setMessageBody:body isHTML:YES]; //if you want to send an HTML message
        // [composer setToRecipients:recipients];
        
        [composer setMessageBody:@"Download amazing application Win Or Loss from app store : https://itunes.apple.com/us/app/win-or-loss/id985170419?ls=1&mt=8" isHTML:NO];
        
        //get the filepath from resources
        //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"logo" ofType:@"png"];
        
        //read the file using NSData
        // NSData * fileData = [NSData dataWithContentsOfFile:filePath];
        // Set the MIME type
        /*you can use :
         - @"application/msword" for MS Word
         - @"application/vnd.ms-powerpoint" for PowerPoint
         - @"text/html" for HTML file
         - @"application/pdf" for PDF document
         - @"image/jpeg" for JPEG/JPG images
         */
        //NSString *mimeType = @"image/png";
        
        //add attachement
        //[composer addAttachmentData:fileData mimeType:mimeType fileName:filePath];
        
        //present it on the screen
        [self presentViewController:composer animated:YES completion:NULL];
    }
    
    
    
    
    
}

//**************************************************
#pragma mark - Mail composer Controll
//**************************************************
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled"); break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved"); break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent"); break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]); break;
        default:
            break;
    }
    
    // close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


-(void)callLOgout
{
    NSString *urlStr =FIND_URL;
    
    //    NSString *urlStr =@"http://www.elementmag.asia/ele-admin/api/?action=user_login&email=akypatel2010@gmail.com&password=1234656";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setHTTPShouldHandleCookies:NO];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setTimeoutInterval:300];
    [request setHTTPMethod:@"POST"];
    NSString *boundary = [NSString stringWithFormat:@"14737809831466499882746641449"];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    NSMutableDictionary *sendData = [[NSMutableDictionary alloc]init];
    
    NSUserDefaults *fetchDefaultslogin = [NSUserDefaults standardUserDefaults];
    
    NSString *userId1=[NSString stringWithFormat:@"%@",[fetchDefaultslogin valueForKey:@"LOGINUSERID"]];
    
    
    [sendData setObject:@"logout" forKey:@"action"];
    [sendData setObject:userId1 forKey:@"user_id"];
    
    NSLog(@"%@",sendData);
    
    for (id key in sendData)
    {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithString:[sendData valueForKey:key]] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setURL:[NSURL URLWithString:urlStr]];
    
    registerUDIDConnectioncodelogout = [NSURLConnection connectionWithRequest:request delegate:self];
    if (registerUDIDConnectioncodelogout)
    {
        registerUDIDDatacodelogout = [[NSMutableData alloc]init];
    }
    
}

//********************************************
#pragma mark - Connection Delegate Methods
//********************************************

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection == registerUDIDConnectioncodelogout)
    {
        [registerUDIDDatacodelogout appendData:data];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (connection == registerUDIDConnectioncodelogout)
    {
        [registerUDIDDatacodelogout setLength:0];
    }
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"ERROR : %@",error.description);
    
    UIAlertView *connectionAlert = [[UIAlertView alloc]initWithTitle:nil message:@"Please Check your Internet Connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [connectionAlert show];
    
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection == registerUDIDConnectioncodelogout)
    {
        NSMutableString *responceversionStr = [[NSMutableString alloc]initWithBytes:[registerUDIDDatacodelogout mutableBytes] length:[registerUDIDDatacodelogout length] encoding:NSUTF8StringEncoding];
        NSMutableDictionary *gate_responce_dic = [[NSMutableDictionary alloc]init];
        [gate_responce_dic setDictionary:[responceversionStr JSONValue]];
        
        NSLog(@"%@",gate_responce_dic);
        NSString *statusstr=[NSString stringWithFormat:@"%@",[gate_responce_dic valueForKey:@"Status"]];
        if([statusstr isEqualToString:@"1"])
        {
            x=1;
            
            [self performSegueWithIdentifier:@"Sign Out" sender:nil];
        }
        
    }
}
//************************************************
#pragma mark - Send Message
//************************************************
-(void)sendMessage
{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        NSString *share_str=[NSString stringWithFormat:@"Download amazing application Win Or Loss from app store : https://itunes.apple.com/us/app/win-or-loss/id985170419?ls=1&mt=8"];
        
        controller.body = share_str;
        //controller.recipients = [NSArray arrayWithObjects:@"1(234)567-8910", nil];
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    }
    
    
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultCancelled:
            NSLog(@"Cancelled");
            break;
        case MessageComposeResultFailed:
            
            break;
        case MessageComposeResultSent:
            
            break;
        default:
            break;
    }
    
    [self dismissModalViewControllerAnimated:YES];
}





/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
