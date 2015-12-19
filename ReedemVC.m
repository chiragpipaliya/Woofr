//
//  ReedemVC.m
//  WOOFR
//
//  Created by dipen  narola on 20/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import "ReedemVC.h"
#import "AsyncImageView.h"
#import "RewardDetailVC.h"

@interface ReedemVC ()
{
        NSString *uIDSTR;
    
    NSMutableArray *ReedemLIstARY;
}
@end

@implementation ReedemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _menubtn.tintColor = [UIColor whiteColor];
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUD];
    [self.view bringSubviewToFront:HUD];
    [HUD setDelegate:self];
    [HUD setLabelText:@"Loading...."];
    
    self.title=@"REWARDS";
    
    DiIMG.hidden=YES;
    
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:@"For evry dollar spent, you will earn 1 WOOFR gem"];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:173.0/255.0 green:153.0/255.0 blue:91.0/255.0 alpha:1.0] range:NSMakeRange(36,12)];
    titleLBL.attributedText=string;
    
    uIDSTR= [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"WoofruserID"]];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self caLLREEDEMapi];
}
-(void)caLLREEDEMapi
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
    
    [sendData setObject:@"reward_list" forKey:@"action"];
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
    
    ReedemListconnection = [NSURLConnection connectionWithRequest:request delegate:self];
    if (ReedemListconnection)
    {
        ReedemListData = [[NSMutableData alloc]init];
    }

}
//********************************************
#pragma mark - Connection Delegate Methods
//********************************************

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection == ReedemListconnection)
    {
        [ReedemListData appendData:data];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (connection == ReedemListconnection)
    {
        [ReedemListData setLength:0];
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
    if (connection == ReedemListconnection)
    {
        NSMutableString *responceversionStr = [[NSMutableString alloc]initWithBytes:[ReedemListData mutableBytes] length:[ReedemListData length] encoding:NSUTF8StringEncoding];
        NSMutableDictionary *gat_dic = [[NSMutableDictionary alloc]init];
        [gat_dic setDictionary:[responceversionStr JSONValue]];
        
        
        
        NSLog(@"%@",gat_dic);
        if([[NSString stringWithFormat:@"%@",[gat_dic valueForKey:@"status"]]isEqualToString:@"1"])
        {
            //[BookingHistory removeAllObjects];
            ReedemLIstARY=[[NSMutableArray alloc]init];
            ReedemLIstARY=[gat_dic valueForKey:@"reward_list"];
            
            CGRect pointfrm = userpointLBL.frame;
            userpointLBL.text=[NSString stringWithFormat:@"%@",[gat_dic valueForKey:@"user_reward_points"]];
            [userpointLBL sizeToFit];
            
            CGRect IMgfrm = DiIMG.frame;
            IMgfrm.origin.x = (ViewWIdth/2)-((DiIMG.frame.size.width+userpointLBL.frame.size.width+5)/2);
            DiIMG.frame=IMgfrm;
            DiIMG.hidden=NO;
            
            
            pointfrm.origin.x=DiIMG.frame.origin.x+DiIMG.frame.size.width+5;
            pointfrm.size.width=userpointLBL.frame.size.width;
            userpointLBL.frame=pointfrm;
            
            [rewardTBL reloadData];
            
        }
        
//            if([NSString stringWithFormat:@"%@",BookingHistory].length>5)
//            {
//                
//                [BookingTBL reloadData];
//            }
//            else
//            {
//                BookingHistory=[[NSMutableArray alloc]init];
//                [BookingTBL reloadData];
//                
//            }
//        }
//        else
//        {
//            [BookingHistory removeAllObjects];
//            BookingHistory=[[NSMutableArray alloc]init];
//            [BookingTBL reloadData];
//        }
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
    
    return [ReedemLIstARY count];    //count number of row from counting array hear cataGorry is An Array
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID =@"cellID";
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
//    UIImageView *backIMg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 15, self.view.frame.size.width, 100)];
//    backIMg.backgroundColor=[UIColor clearColor];
//    backIMg.userInteractionEnabled=YES;
//    
    NSURL *urllinksTR= [NSURL URLWithString:[[NSString stringWithFormat:@"%@",[[ReedemLIstARY objectAtIndex:indexPath.row]valueForKey:@"filename" ]]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

    AsyncImageView *beerImage = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0,ViewWIdth, ViewWIdth/2)];
    [beerImage loadImageFromURL:urllinksTR imageName:@""];
    [cell addSubview:beerImage];
    
    
    
    
    
    UIImageView *diamondIMG=[[UIImageView alloc]initWithFrame:CGRectMake(10, (ViewWIdth/2)-30, 20, 20)];
    diamondIMG.image=[UIImage imageNamed:@"ic_side_menu_reward_selected.png"];
    [cell addSubview:diamondIMG];
    
    
    UILabel *ReedmPoint = [[UILabel alloc]initWithFrame:CGRectMake(35, (ViewWIdth/2)-30, ViewWIdth-45, 20)];
    ReedmPoint.text=[NSString stringWithFormat:@"%@",[[ReedemLIstARY objectAtIndex:indexPath.row]valueForKey:@"points" ]];
    ReedmPoint.textColor=[UIColor whiteColor];
    ReedmPoint.font=[UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
    [cell addSubview:ReedmPoint];
    
    
    UILabel *ReedemNameLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, ViewWIdth-20, (ViewWIdth/2)-45)];
    ReedemNameLBL.numberOfLines=10;
    ReedemNameLBL.text=[NSString stringWithFormat:@"%@",[[ReedemLIstARY objectAtIndex:indexPath.row]valueForKey:@"title" ]];
    ReedemNameLBL.textColor=[UIColor whiteColor];
    ReedemNameLBL.font=[UIFont fontWithName:@"ProximaNova-Bold" size:16.0];
    [ReedemNameLBL sizeToFit];
    [cell addSubview:ReedemNameLBL];

    CGRect frm= ReedemNameLBL.frame;
    frm.origin.y=(ViewWIdth/2)-35-ReedemNameLBL.frame.size.height;
    ReedemNameLBL.frame=frm;
    
    
//    [backIMg addSubview:beerImage];
//    
//    NSString *DateSTR=[NSString stringWithFormat:@"%@",[[NotificationARY objectAtIndex:indexPath.row]valueForKey:@"booking_date" ]];
//    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
//    [formatter1 setDateFormat:@"dd MMM yyyy"];
//    
//    NSDate *dates=[formatter dateFromString:DateSTR];
//    
//    NSString *fDateSTR=[formatter1 stringFromDate:dates];
//    
//    
//    
//    
//    UILabel *NotificationLBL=[[UILabel alloc]initWithFrame:CGRectMake(66, 0, self.view.frame.size.width-76, 5000)];
//    NotificationLBL.textColor=[UIColor whiteColor];
//    NotificationLBL.font=[UIFont systemFontOfSize:14.0];
//    
//    
//    NSString *msgSTR=[NSString stringWithFormat:@"You have a booked a new request for %@ on %@ as a VIP booking at the rate of %@ USD",[[NotificationARY objectAtIndex:indexPath.row]valueForKey:@"name"],fDateSTR,[[NotificationARY objectAtIndex:indexPath.row]valueForKey:@"price"]];
//    NSString *clubNAmeSTR=[NSString stringWithFormat:@"%@",[[NotificationARY objectAtIndex:indexPath.row]valueForKey:@"name"]];
//    NSRange rangeValue1 = [msgSTR rangeOfString:clubNAmeSTR options:NSCaseInsensitiveSearch];
//    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:msgSTR];
//    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:146.0/255.0 green:126.0/255.0 blue:96.0/255.0 alpha:1.0] range:rangeValue1];
//    [string addAttribute:NSFontAttributeName
//                   value:[UIFont boldSystemFontOfSize:16.0]
//                   range:rangeValue1];
//    
//    NotificationLBL.attributedText=string;
//    NotificationLBL.numberOfLines=500;
//    [NotificationLBL sizeToFit];
//    [backIMg addSubview:NotificationLBL];
//    
//    if(NotificationLBL.frame.size.height<50)
//    {
//        CGRect frm = backIMg.frame;
//        frm.size.height = 50;
//        backIMg.frame=frm;
//    }
//    else
//    {
//        CGRect frm = backIMg.frame;
//        frm.size.height = NotificationLBL.frame.size.height;
//        backIMg.frame=frm;
//    }
//    
//    
//    cellHEight=backIMg.frame.size.height+30;
//    
//    UIImageView *lineimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, cellHEight-1, self.view.frame.size.width, 1)];
//    lineimage.backgroundColor=[UIColor colorWithRed:146.0/255.0 green:126.0/255.0 blue:96.0/255.0 alpha:1.0];
//    [cell addSubview:lineimage];
//    
//    [cell addSubview:backIMg];
    
    UIImageView *LineIMG=[[UIImageView alloc]initWithFrame:CGRectMake(0, (ViewWIdth/2)-1, ViewWIdth, 1)];
    LineIMG.backgroundColor=[UIColor colorWithRed:199.0/255.0 green:178.0/255.0 blue:114.0/255.0 alpha:1.0];
    [cell addSubview:LineIMG];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ViewWIdth/2;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *temp=[[NSMutableDictionary alloc]init];
    temp=[ReedemLIstARY objectAtIndex:indexPath.row];
    [temp setValue:userpointLBL.text forKey:@"UserPOint"];
    
    [[NSUserDefaults standardUserDefaults]setValue:temp forKey:@"GiftWoofrDict"];
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    RewardDetailVC *dealVC1 = (RewardDetailVC *)[storyboard instantiateViewControllerWithIdentifier:@"RewardDetailVC"];
    [self.navigationController pushViewController:dealVC1 animated:YES];
    
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

@end
