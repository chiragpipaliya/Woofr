//
//  NotifictaionVC.m
//  WOOFR
//
//  Created by dipen  narola on 20/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import "NotifictaionVC.h"

@interface NotifictaionVC ()
{
    NSString *uIDSTR;
    NSMutableArray *NotificationARY;
    
    float cellHEight;
}
@end

@implementation NotifictaionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUD];
    [self.view bringSubviewToFront:HUD];
    [HUD setDelegate:self];
    [HUD setLabelText:@"Loading...."];

    
    _menubtn.tintColor = [UIColor whiteColor];
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    

    self.title=@"NOTIFICATIONS";
    
     uIDSTR= [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"WoofruserID"]];
    
    NotificationTBL.estimatedRowHeight = 100.0;
    NotificationTBL.rowHeight = UITableViewAutomaticDimension;
    NotificationTBL.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self notificationAPIcall];
}

-(void)notificationAPIcall
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
    [sendData setObject:@"notification_list" forKey:@"action"];
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
    
    Notificationconnection = [NSURLConnection connectionWithRequest:request delegate:self];
    if (Notificationconnection)
    {
        NotificationData = [[NSMutableData alloc]init];
    }

}

//********************************************
#pragma mark - Connection Delegate Methods
//********************************************

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection == Notificationconnection)
    {
        [NotificationData appendData:data];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (connection == Notificationconnection)
    {
        [NotificationData setLength:0];
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
    if (connection == Notificationconnection)
    {
        NSMutableString *responceversionStr = [[NSMutableString alloc]initWithBytes:[NotificationData mutableBytes] length:[NotificationData length] encoding:NSUTF8StringEncoding];
        
        NSMutableDictionary *gat_dic = [[NSMutableDictionary alloc]init];
        [gat_dic setDictionary:[responceversionStr JSONValue]];
        
        [HUD hide:YES];
        NSLog(@"%@",gat_dic);
        
        if([[NSString stringWithFormat:@"%@",[gat_dic valueForKey:@"status"]]isEqualToString:@"1"])
        
        {
            NotificationARY=[[NSMutableArray alloc]init];
            NotificationARY=[gat_dic valueForKey:@"notification"];
            
            NSString *unreadSTR=[NSString stringWithFormat:@"%@",[gat_dic valueForKey:@"unread_counter"]];
            if([unreadSTR isEqualToString:@"0"])
            {
                NewNotifyLBL.text=@"No New NOTIFICATIONS";
            }
            else
            {
                NewNotifyLBL.text=[NSString stringWithFormat:@"%@ New NOTIFICATIONS",unreadSTR];
            }
            if([NSString stringWithFormat:@"%@",NotificationARY].length>5)
            {
                waterMArk.hidden=YES;
                [NotificationTBL reloadData];
            }
            else
            {
                NotificationARY=[[NSMutableArray alloc]init];
                waterMArk.hidden=NO;
                [NotificationTBL reloadData];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    return [NotificationARY count];    //count number of row from counting array hear cataGorry is An Array
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID =@"cellID";
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    UIImageView *backIMg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 15, self.view.frame.size.width, 100)];
    backIMg.backgroundColor=[UIColor clearColor];
    backIMg.userInteractionEnabled=YES;
    
    NSURL *urllinksTR= [NSURL URLWithString:[[NSString stringWithFormat:@"%@",[[NotificationARY objectAtIndex:indexPath.row]valueForKey:@"image" ]]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    AsyncImageView *beerImage = [[AsyncImageView alloc]initWithFrame:CGRectMake(8, 0,50, 50)];
    beerImage.layer.cornerRadius=25.0;
    beerImage.clipsToBounds=YES;
    [beerImage loadImageFromURL:urllinksTR imageName:@""];
    [backIMg addSubview:beerImage];
    
    NSString *DateSTR=[NSString stringWithFormat:@"%@",[[NotificationARY objectAtIndex:indexPath.row]valueForKey:@"booking_date" ]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"dd MMM yyyy"];
    
    NSDate *dates=[formatter dateFromString:DateSTR];
    
    NSString *fDateSTR=[formatter1 stringFromDate:dates];
    
    
    

    UILabel *NotificationLBL=[[UILabel alloc]initWithFrame:CGRectMake(66, 0, self.view.frame.size.width-76, 5000)];
    NotificationLBL.textColor=[UIColor whiteColor];
    NotificationLBL.font=[UIFont systemFontOfSize:14.0];
    
    
    NSString *msgSTR=[NSString stringWithFormat:@"You have a booked a new request for %@ on %@ as a VIP booking at the rate of %@",[[NotificationARY objectAtIndex:indexPath.row]valueForKey:@"name"],fDateSTR,[[NotificationARY objectAtIndex:indexPath.row]valueForKey:@"price"]];
    NSString *clubNAmeSTR=[NSString stringWithFormat:@"%@",[[NotificationARY objectAtIndex:indexPath.row]valueForKey:@"name"]];
    NSRange rangeValue1 = [msgSTR rangeOfString:clubNAmeSTR options:NSCaseInsensitiveSearch];
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:msgSTR];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:146.0/255.0 green:126.0/255.0 blue:96.0/255.0 alpha:1.0] range:rangeValue1];
    [string addAttribute:NSFontAttributeName
                      value:[UIFont boldSystemFontOfSize:16.0]
                      range:rangeValue1];
    
    NotificationLBL.attributedText=string;
    NotificationLBL.numberOfLines=500;
    [NotificationLBL sizeToFit];
    [backIMg addSubview:NotificationLBL];
    
    if(NotificationLBL.frame.size.height<50)
    {
        CGRect frm = backIMg.frame;
        frm.size.height = 50;
        backIMg.frame=frm;
    }
    else
    {
        CGRect frm = backIMg.frame;
        frm.size.height = NotificationLBL.frame.size.height;
        backIMg.frame=frm;
    }
    
    
    cellHEight=backIMg.frame.size.height+30;
    
    UIImageView *lineimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, cellHEight-1, self.view.frame.size.width, 1)];
    lineimage.backgroundColor=[UIColor colorWithRed:146.0/255.0 green:126.0/255.0 blue:96.0/255.0 alpha:1.0];
    [cell addSubview:lineimage];
    
    [cell addSubview:backIMg];
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHEight;
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
