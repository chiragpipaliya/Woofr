//
//  MyBookingVC.m
//  WOOFR
//
//  Created by dipen  narola on 20/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import "MyBookingVC.h"

@interface MyBookingVC ()
{
    int btndetect;
    
    float cellHeight;
    
    NSString *uIDSTR;
    
    NSMutableArray *BookingHistory,*upcomingARY,*completedARY;
    
    BOOL Patto1,Patto2;
    int long P1index,p2index;
    
    float cellHEight;
    
    CGRect TBLFRM;
    
    UIView *UserRewardview;
}

@end

@implementation MyBookingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = YES;
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor]];
    
    _menubtn.tintColor = [UIColor whiteColor];
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    self.title=@"MANAGE";
    
    UpcomingBTN.layer.borderColor=[UIColor colorWithRed:199.0/255.0 green:178.0/255.0 blue:114.0/255.0 alpha:1.0].CGColor;
    UpcomingBTN.layer.borderWidth=1.0;
    
    completedBTN.layer.borderColor=[UIColor colorWithRed:199.0/255.0 green:178.0/255.0 blue:114.0/255.0 alpha:1.0].CGColor;
    completedBTN.layer.borderWidth=1.0;
    
    
    BookingTBL.estimatedRowHeight = 100.0;
    BookingTBL.rowHeight = UITableViewAutomaticDimension;
    BookingTBL.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    btndetect=0;
    
    TBLFRM = BookingTBL.frame;
    
    HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUD];
    [self.view bringSubviewToFront:HUD];
    [HUD setDelegate:self];
    [HUD setLabelText:@"Loading...."];
    
    uIDSTR= [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"WoofruserID"]];
    
    Patto1=NO;
    Patto2=NO;

    [self UpcomingBTNclick:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)UpcomingBTNclick:(id)sender
{
    if(btndetect!=1)
    {
        UpcomingBTN.backgroundColor=[UIColor colorWithRed:199.0/255.0 green:178.0/255.0 blue:114.0/255.0 alpha:1.0];
        completedBTN.backgroundColor=[UIColor clearColor];
        
        btndetect=1;
        
        BookingTBL.frame=TBLFRM;
        
        [UserRewardview removeFromSuperview];
        
        [self CallBookingAPI];
    }
}

- (IBAction)CompletedBTNclick:(id)sender
{
    if(btndetect!=2)
    {
        completedBTN.backgroundColor=[UIColor colorWithRed:199.0/255.0 green:178.0/255.0 blue:114.0/255.0 alpha:1.0];
        UpcomingBTN.backgroundColor=[UIColor clearColor];
        
        btndetect=2;
        
        CGRect NEwTBLFRM=TBLFRM;
        NEwTBLFRM.origin.y=TBLFRM.origin.y+45;
        NEwTBLFRM.size.height=TBLFRM.size.height-45;
        BookingTBL.frame=NEwTBLFRM;
        
        
        [self CallBookingAPI];
    }
}


-(void)CallBookingAPI
{
    [HUD show:YES];
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
    
    

   //admin.vasundharavision.com/woofr/api/?action=booking_history&user_id=1&is_clear=0
    
   
    
    if(btndetect==1)
    {
         [sendData setObject:@"booking_history" forKey:@"action"];
        [sendData setObject:@"0"forKey:@"is_clear"];
    }
    else
    {
        [sendData setObject:@"my_rewards" forKey:@"action"];

    }
    
    [sendData setObject:uIDSTR forKey:@"user_id"];
    
    
    
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
    
    Mybookingconnection = [NSURLConnection connectionWithRequest:request delegate:self];
    if (Mybookingconnection)
    {
        MybookingData = [[NSMutableData alloc]init];
    }

}
//********************************************
#pragma mark - Connection Delegate Methods
//********************************************

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection == Mybookingconnection)
    {
        [MybookingData appendData:data];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (connection == Mybookingconnection)
    {
        [MybookingData setLength:0];
    }
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"ERROR : %@",error.description);
    
    UIAlertView *connectionAlert = [[UIAlertView alloc]initWithTitle:nil message:@"Please Check your Internet Connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [connectionAlert show];
    
    [HUD hide:YES];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection == Mybookingconnection)
    {
        NSMutableString *responceversionStr = [[NSMutableString alloc]initWithBytes:[MybookingData mutableBytes] length:[MybookingData length] encoding:NSUTF8StringEncoding];
        NSMutableDictionary *gat_dic = [[NSMutableDictionary alloc]init];
        [gat_dic setDictionary:[responceversionStr JSONValue]];
        
       
        
        NSLog(@"%@",gat_dic);
        if([[NSString stringWithFormat:@"%@",[gat_dic valueForKey:@"status"]]isEqualToString:@"1"])
        {
            //[BookingHistory removeAllObjects];
            
            if(btndetect==1)
            {
                BookingHistory=[[NSMutableArray alloc]init];
                upcomingARY=[[NSMutableArray alloc]init];
                completedARY=[[NSMutableArray alloc]init];
                
                upcomingARY=[gat_dic valueForKey:@"upcomming"];
                
                Patto1=NO;
                Patto2=NO;
                
                if([NSString stringWithFormat:@"%@",upcomingARY].length>5)
                {
                    Patto1=YES;
                    P1index=0;
                    
                    for(int i=0;i<upcomingARY.count;i++)
                    {
                        [BookingHistory addObject:[upcomingARY objectAtIndex:i]];
                    }
                }
                else
                {
                    Patto1=NO;
                    P1index=200000;
                }
                
                completedARY=[gat_dic valueForKey:@"completed"];
                
                if([NSString stringWithFormat:@"%@",completedARY].length>5)
                {
                    if(Patto1==YES)
                    {
                        p2index=upcomingARY.count;
                        
                    }
                    else
                    {
                        p2index=0;
                        
                    }
                    Patto2=YES;
                    
                    for(int i=0;i<completedARY.count;i++)
                    {
                        [BookingHistory addObject:[completedARY objectAtIndex:i]];
                    }

                }
                else
                {
                    Patto2=NO;
                    p2index=200000;
                }
                
                if(Patto1 == YES || Patto2 ==YES)
                {
                    [BookingTBL reloadData];
                }
                
                if([NSString stringWithFormat:@"%@",completedARY].length<5 && [NSString stringWithFormat:@"%@",upcomingARY].length<5)
                {
                    BookingHistory=[[NSMutableArray alloc]init];
                    [BookingTBL reloadData];
                }
                
            }
            else
            {
                BookingHistory=[[NSMutableArray alloc]init];
                [BookingTBL reloadData];
                
                Patto1=NO;
                Patto2=NO;
                P1index=200000;
                p2index=200000;
                
                UserRewardview=[[UIView alloc] initWithFrame:CGRectMake(8, UpcomingBTN.frame.origin.y+5+UpcomingBTN.frame.size.height, ViewWIdth-16, 40)];
                
                
                BookingHistory=[gat_dic valueForKey:@"my_reward"];
                
                UILabel *userpointLBL=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, UserRewardview.frame.size.width, UserRewardview.frame.size.height)];
                userpointLBL.font=[UIFont fontWithName:@"ProximaNova-Bold" size:18.0];
                userpointLBL.textColor=[UIColor whiteColor];
                [UserRewardview addSubview:userpointLBL];
                
                CGRect pointfrm = userpointLBL.frame;
                userpointLBL.text=[NSString stringWithFormat:@"%@",[gat_dic valueForKey:@"user_reward_points"]];
                [userpointLBL sizeToFit];
                
                UIImageView *DiIMG=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
                DiIMG.image=[UIImage imageNamed:@"ic_side_menu_reward_normal@3x.png"];
                [UserRewardview addSubview:DiIMG];
                
                CGRect IMgfrm = DiIMG.frame;
                IMgfrm.origin.x = (ViewWIdth/2)-((DiIMG.frame.size.width+userpointLBL.frame.size.width+5)/2);
                DiIMG.frame=IMgfrm;
                DiIMG.hidden=NO;
                
                
                pointfrm.origin.x=DiIMG.frame.origin.x+DiIMG.frame.size.width+5;
                pointfrm.size.width=userpointLBL.frame.size.width;
                userpointLBL.frame=pointfrm;
                
                UserRewardview.layer.borderWidth=1.0;
                UserRewardview.layer.borderColor=[UIColor colorWithRed:199.0/255.0 green:178.0/255.0 blue:114.0/255.0 alpha:1.0].CGColor;
                
                [SCRLBView addSubview:UserRewardview];
                
                if([NSString stringWithFormat:@"%@",BookingHistory].length<5)
                {
                        BookingHistory=[[NSMutableArray alloc]init];
                }
                
                [BookingTBL reloadData];
                   
                
                //CodingBaki chhe
            }
            
            //            BookingHistory=[[NSMutableArray alloc]init];
//            BookingHistory=[gat_dic valueForKey:@"booking_history"];
//            
//            if([NSString stringWithFormat:@"%@",BookingHistory].length>5)
//            {
//                waterMARKIMG.hidden=YES;
//                [BookingTBL reloadData];
//            }
//            else
//            {
//                waterMARKIMG.hidden=NO;
//                BookingHistory=[[NSMutableArray alloc]init];
//                [BookingTBL reloadData];
//                
//            }
        }
        else
        {
            Patto1=NO;
            Patto2=NO;
            
            [BookingHistory removeAllObjects];
            waterMARKIMG.hidden=NO;
            BookingHistory=[[NSMutableArray alloc]init];
            [BookingTBL reloadData];
        }
         [HUD hide:YES];
    }
}
//********************************
#pragma mark - Table View Methods
//********************************

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [BookingHistory count];    //count number of row from counting array hear cataGorry is An Array
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID =@"cellID";
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    UIImageView *backIMg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 70)];
    backIMg.backgroundColor=[UIColor clearColor];
    backIMg.userInteractionEnabled=YES;
    
    float HEIGHt;
    
    if(btndetect==1)
    {
        if(Patto1==YES && indexPath.row == P1index)
        {
            UILabel *TitleLBL=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ViewWIdth, 35)];
            TitleLBL.text=@"   Upcoming Bookings";
            TitleLBL.textColor=[UIColor whiteColor];
            TitleLBL.font=[UIFont fontWithName:@"ProximaNova-Bold" size:16.0];
            TitleLBL.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
            [cell addSubview:TitleLBL];
            
            HEIGHt=40;
        }
        else if(Patto2==YES && indexPath.row == p2index)
        {
            
            UILabel *TitleLBL=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ViewWIdth, 35)];
            TitleLBL.text=@"   Completed Bookings";
            TitleLBL.textColor=[UIColor whiteColor];
            TitleLBL.font=[UIFont fontWithName:@"ProximaNova-Bold" size:16.0];
            TitleLBL.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
            [cell addSubview:TitleLBL];
            
            HEIGHt=40;
        }
        else
        {
            HEIGHt=5;
        }
        
        UIImageView *clubIMG=[[UIImageView alloc]initWithFrame:CGRectMake(8, HEIGHt, 72, 72)];
        clubIMG.layer.borderColor=[UIColor colorWithRed:199.0/255.0 green:178.0/255.0 blue:114.0/255.0 alpha:1.0].CGColor;
        clubIMG.layer.borderWidth=1.0;
        
        NSURL *urllinksTR= [NSURL URLWithString:[[NSString stringWithFormat:@"%@",[[BookingHistory objectAtIndex:indexPath.row] valueForKey:@"club_image"]]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        AsyncImageView *beerImage = [[AsyncImageView alloc]initWithFrame:CGRectMake(1, 1, 70, 70)];
        [beerImage loadImageFromURL:urllinksTR imageName:@""];
        [clubIMG addSubview:beerImage];
        
        [backIMg addSubview:clubIMG];
        
        UILabel *LBL=[[UILabel alloc]initWithFrame:CGRectMake(87, HEIGHt, ViewWIdth-(97+85), 5000)];
        LBL.text=[NSString stringWithFormat:@"%@",[[BookingHistory objectAtIndex:indexPath.row]valueForKey:@"club_name"]];
        LBL.numberOfLines=50;
        LBL.font=[UIFont systemFontOfSize:18.0];
        LBL.textColor=[UIColor whiteColor];
        [LBL sizeToFit];
        [backIMg addSubview:LBL];
        
        UILabel *prLBL=[[UILabel alloc]initWithFrame:CGRectMake(ViewWIdth-90, HEIGHt, 85, 5000)];
        prLBL.text=[NSString stringWithFormat:@"%@ SGD",[[BookingHistory objectAtIndex:indexPath.row]valueForKey:@"price"]];
        prLBL.numberOfLines=50;
        prLBL.font=[UIFont systemFontOfSize:16.0];
        prLBL.textColor=[UIColor whiteColor];
        [prLBL sizeToFit];
        [backIMg addSubview:prLBL];
        
        HEIGHt=HEIGHt+LBL.frame.size.height+8;
        
        UILabel *TBLtype=[[UILabel alloc]initWithFrame:CGRectMake(87, HEIGHt, ViewWIdth-97, 50)];
        TBLtype.text=[NSString stringWithFormat:@"%@ %@",[[BookingHistory objectAtIndex:indexPath.row]valueForKey:@"table_type"],[[BookingHistory objectAtIndex:indexPath.row]valueForKey:@"package_name"]];
        TBLtype.numberOfLines=4;
        TBLtype.font=[UIFont systemFontOfSize:14.0];
        TBLtype.textColor=[UIColor whiteColor];
        [TBLtype sizeToFit];
        [backIMg addSubview:TBLtype];
        
        HEIGHt=HEIGHt+TBLtype.frame.size.height+8;
        
        UIImageView *clockIMG=[[UIImageView alloc]initWithFrame:CGRectMake(87, HEIGHt, 20, 20)];
        clockIMG.image=[UIImage imageNamed:@"ic_home_opening_time.png"];
        clockIMG.userInteractionEnabled=YES;
        [backIMg addSubview:clockIMG];
        
        NSString *TimeSTR=[NSString stringWithFormat:@"%@",[[BookingHistory objectAtIndex:indexPath.row]valueForKey:@"time"]];
        NSString *dateSTR=[NSString stringWithFormat:@"%@",[[BookingHistory objectAtIndex:indexPath.row]valueForKey:@"date"]];
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        NSDate *yourDate = [dateFormatter dateFromString:dateSTR];
        dateFormatter.dateFormat = @"dd MMM yyyy";
        
        NSString *fDate=[dateFormatter stringFromDate:yourDate];
        
        UILabel *TimeDateLBL=[[UILabel alloc]initWithFrame:CGRectMake(115, HEIGHt, ViewWIdth-125, 20)];
        TimeDateLBL.text=[NSString stringWithFormat:@"%@, %@",TimeSTR,fDate];
        TimeDateLBL.font=[UIFont systemFontOfSize:14.0];
        TimeDateLBL.textColor=[UIColor whiteColor];
        [backIMg addSubview:TimeDateLBL];
        
        HEIGHt=HEIGHt+TimeDateLBL.frame.size.height;
        
        if(HEIGHt>82)
        {
//            if(Patto1==YES && indexPath.row == P1index)
//            {
//                CGRect frm=backIMg.frame;
//                frm.size.height=HEIGHt+5+20;
//                backIMg.frame=frm;
//            }
//            else if (Patto2==YES && indexPath.row == p2index)
//            {
//                CGRect frm=backIMg.frame;
//                frm.size.height=HEIGHt+5+20;
//                backIMg.frame=frm;
//            }
//            else
//            {
                CGRect frm=backIMg.frame;
                frm.size.height=HEIGHt+5;
                backIMg.frame=frm;
//            }
        }
        else
        {
            CGRect frm=backIMg.frame;
            frm.size.height=87;
            backIMg.frame=frm;
        }
        
        cellHEight=backIMg.frame.size.height+20;
        
        [cell addSubview:backIMg];
        
        
        UIImageView *lineIMG=[[UIImageView alloc]initWithFrame:CGRectMake(0, cellHEight-1, ViewWIdth, 1)];
        lineIMG.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        [cell addSubview:lineIMG];

    }
    else
    {
        HEIGHt=5;
        
        
        UIImageView *RewardIMG=[[UIImageView alloc]initWithFrame:CGRectMake(8, HEIGHt, 72, 72)];
        RewardIMG.layer.borderColor=[UIColor whiteColor].CGColor;//[UIColor colorWithRed:199.0/255.0 green:178.0/255.0 blue:114.0/255.0 alpha:1.0].CGColor;
        RewardIMG.layer.borderWidth=1.0;
        
        NSURL *urllinksTR= [NSURL URLWithString:[[NSString stringWithFormat:@"%@",[[BookingHistory objectAtIndex:indexPath.row] valueForKey:@"filename"]]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        AsyncImageView *RewardBImage = [[AsyncImageView alloc]initWithFrame:CGRectMake(1, 1, 70, 70)];
        [RewardBImage loadImageFromURL:urllinksTR imageName:@""];
        [RewardIMG addSubview:RewardBImage];
        
        [backIMg addSubview:RewardIMG];
        
        
        
        UILabel *RweardNLBL=[[UILabel alloc]initWithFrame:CGRectMake(87, HEIGHt, ViewWIdth-(97+85), 5000)];
        RweardNLBL.text=[NSString stringWithFormat:@"%@",[[BookingHistory objectAtIndex:indexPath.row]valueForKey:@"title"]];
        RweardNLBL.numberOfLines=50;
        RweardNLBL.font=[UIFont fontWithName:@"ProximaNova-Bold" size:18.0];
        RweardNLBL.textColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        [RweardNLBL sizeToFit];
        [backIMg addSubview:RweardNLBL];
        
        HEIGHt = HEIGHt+RweardNLBL.frame.size.height+10;
        
        
        UIImageView *clockIMG=[[UIImageView alloc]initWithFrame:CGRectMake(87, HEIGHt, 20, 20)];
        clockIMG.image=[UIImage imageNamed:@"ic_home_opening_time.png"];
        clockIMG.userInteractionEnabled=YES;
        [backIMg addSubview:clockIMG];
        
        UILabel *TimeDateLBL=[[UILabel alloc]initWithFrame:CGRectMake(115, HEIGHt, ViewWIdth-125, 20)];
        TimeDateLBL.text=[NSString stringWithFormat:@"%@ Days Left",[[BookingHistory objectAtIndex:indexPath.row]valueForKey:@"diff_days"]];
        TimeDateLBL.font=[UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
        TimeDateLBL.textColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        [backIMg addSubview:TimeDateLBL];
        
        HEIGHt=HEIGHt+TimeDateLBL.frame.size.height;

        
        if(HEIGHt>82)
        {
            //            if(Patto1==YES && indexPath.row == P1index)
            //            {
            //                CGRect frm=backIMg.frame;
            //                frm.size.height=HEIGHt+5+20;
            //                backIMg.frame=frm;
            //            }
            //            else if (Patto2==YES && indexPath.row == p2index)
            //            {
            //                CGRect frm=backIMg.frame;
            //                frm.size.height=HEIGHt+5+20;
            //                backIMg.frame=frm;
            //            }
            //            else
            //            {
            CGRect frm=backIMg.frame;
            frm.size.height=HEIGHt+5;
            backIMg.frame=frm;
            //            }
        }
        else
        {
            CGRect frm=backIMg.frame;
            frm.size.height=87;
            backIMg.frame=frm;
        }
        
        cellHEight=backIMg.frame.size.height+20;
        
        [cell addSubview:backIMg];
        
        
        UIImageView *lineIMG=[[UIImageView alloc]initWithFrame:CGRectMake(0, cellHEight-1, ViewWIdth, 1)];
        lineIMG.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        [cell addSubview:lineIMG];
    }
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHEight;
}

@end
