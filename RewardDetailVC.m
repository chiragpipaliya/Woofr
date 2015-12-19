//
//  RewardDetailVC.m
//  WOOFR
//
//  Created by Hemal Kachhadiya on 12/18/15.
//  Copyright (c) 2015 dipen. All rights reserved.
//

#import "RewardDetailVC.h"
#import "AsyncImageView.h"

@interface RewardDetailVC ()
{
    float ScrlviewHeight;
    
    NSMutableDictionary *ReDetailDict;
    
    UILabel *pointLBL;
    
    
}
@end

@implementation RewardDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = YES;
    
    self.navigationController.navigationBar.backIndicatorImage=[[UIImage imageNamed:@"ic_header_back.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage=[[UIImage imageNamed:@"ic_header_back.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    
    
    
    //    self.navigationItem.backBarButtonItem.image=[UIImage imageNamed:@"ic_header_back.png"];
    //    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"back-button-image"]];
    //    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back-button-image"]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor]];
    
    self.title=@"Rewards Details";
    
    
    HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUD];
    [self.view bringSubviewToFront:HUD];
    [HUD setDelegate:self];
    [HUD setLabelText:@"Loading...."];
    
    ReDetailDict=[[NSMutableDictionary alloc]init];
    ReDetailDict= [[NSUserDefaults standardUserDefaults]valueForKey:@"GiftWoofrDict"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    ScrlviewHeight=PHOTOimg.frame.size.height;
    
    
    NSURL *urllinksTR= [NSURL URLWithString:[[NSString stringWithFormat:@"%@",[ReDetailDict valueForKey:@"filename"]]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    AsyncImageView *beerImage = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, PHOTOimg.frame.size.width, PHOTOimg.frame.size.height)];
    [beerImage loadImageFromURL:urllinksTR imageName:@""];
    [PHOTOimg addSubview:beerImage];
    
    UILabel *NameLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, ViewWIdth-20, PHOTOimg.frame.size.height-20)];
    NameLBL.numberOfLines=10;
    NameLBL.text=[NSString stringWithFormat:@"%@",[ReDetailDict valueForKey:@"title"]];
    NameLBL.font=[UIFont fontWithName:@"ProximaNova-Bold" size:17.0];
    NameLBL.textColor=[UIColor whiteColor];
    [NameLBL sizeToFit];
    [PHOTOimg addSubview:NameLBL];
    
    // ScrlviewHeight++;
    
    
    lineIMG.frame=CGRectMake(0, ScrlviewHeight, ViewWIdth, 1);
    
    ScrlviewHeight=ScrlviewHeight+11;
    
    UIButton *ReedemBTN=[[UIButton alloc]initWithFrame:CGRectMake(16, ScrlviewHeight, ViewWIdth-32, 50)];
    [ReedemBTN setBackgroundImage:[UIImage imageNamed:@"btn_big_login_general.png"] forState:UIControlStateNormal];
    [ReedemBTN addTarget:self action:@selector(ReedemBTNclick) forControlEvents:UIControlEventTouchUpInside];
    [ReedemBTN setTitle:@"REDEEM" forState:UIControlStateNormal];
    [ReedemBTN setTintColor:[UIColor whiteColor]];
    ReedemBTN.titleLabel.font=[UIFont fontWithName:@"ProximaNova-Bold" size:18.0];
    [RedemSCRL addSubview:ReedemBTN];
    
    
    ScrlviewHeight=ScrlviewHeight+10+ReedemBTN.frame.size.height;
    
    UIImageView *line1IMG=[[UIImageView alloc]initWithFrame:CGRectMake(0, ScrlviewHeight, ViewWIdth, 1)];
    line1IMG.backgroundColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0];
    [RedemSCRL addSubview:line1IMG];
    
    ScrlviewHeight++;
    
    UIView *PointView=[[UIView alloc]initWithFrame:CGRectMake(0, ScrlviewHeight, ViewWIdth, 50)];
    PointView.backgroundColor=[UIColor clearColor];
    
    UIImageView *dImg=[[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 30, 30)];
    dImg.image=[UIImage imageNamed:@"ic_side_menu_reward_normal.png"];
    [PointView addSubview:dImg];
    
    
    pointLBL=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ViewWIdth, 50)];
    
    CGRect pointfrm = pointLBL.frame;
    pointLBL.text=[NSString stringWithFormat:@"%@",[ReDetailDict valueForKey:@"points"]];
    pointLBL.font=[UIFont fontWithName:@"ProximaNova-Bold" size:16.0];
    pointLBL.textColor=[UIColor whiteColor];
    [pointLBL sizeToFit];
    [PointView addSubview:pointLBL];
    
    
    
    CGRect IMgfrm = dImg.frame;
    IMgfrm.origin.x = (ViewWIdth/2)-((dImg.frame.size.width+pointLBL.frame.size.width+5)/2);
    dImg.frame=IMgfrm;
    
    
    
    pointfrm.origin.x=dImg.frame.origin.x+dImg.frame.size.width+5;
    pointfrm.size.width=pointLBL.frame.size.width;
    pointLBL.frame=pointfrm;
    
    
    [RedemSCRL addSubview:PointView];
    
    ScrlviewHeight=ScrlviewHeight+50;
    
    UIImageView *lineImage2=[[UIImageView alloc]initWithFrame:CGRectMake(0, ScrlviewHeight, ViewWIdth, 1)];
    lineImage2.backgroundColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0];
    [RedemSCRL addSubview:lineImage2];
    
    ScrlviewHeight++;
    
    UILabel *DescLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, ScrlviewHeight, ViewWIdth-20, 35)];
    
    DescLBL.text=@"Description:";
    DescLBL.font=[UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
    DescLBL.textColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0];
    [RedemSCRL addSubview:DescLBL];
    
    ScrlviewHeight = ScrlviewHeight+35;
    
    UILabel *DesicDLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, ScrlviewHeight, ViewWIdth-20, 50000)];
    DesicDLBL.text=[NSString stringWithFormat:@"%@",[ReDetailDict valueForKey:@"description"]];
    DesicDLBL.font=[UIFont fontWithName:@"ProximaNova-Regular" size:14.0];
    DesicDLBL.numberOfLines=500;
    DesicDLBL.textColor=[UIColor whiteColor];
    [DesicDLBL sizeToFit];
    [RedemSCRL addSubview:DesicDLBL];
    
    ScrlviewHeight = ScrlviewHeight+DesicDLBL.frame.size.height+15;
    
    UIImageView *lineImage3=[[UIImageView alloc]initWithFrame:CGRectMake(0, ScrlviewHeight, ViewWIdth, 1)];
    lineImage3.backgroundColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0];
    [RedemSCRL addSubview:lineImage3];
    
    ScrlviewHeight++;
    
    RedemSCRL.contentSize=CGSizeMake(ViewWIdth, ScrlviewHeight);
}

-(void)ReedemBTNclick
{
    [HUD show:YES];
    NSString *urlStr =FIND_URL;
    
    
    
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
    
     NSString *uIDSTR= [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"WoofruserID"]];
    
    [sendData setObject:@"reddem_points" forKey:@"action"];
    [sendData setObject:uIDSTR forKey:@"user_id"];
    [sendData setObject:[NSString stringWithFormat:@"%@",[ReDetailDict valueForKey:@"reward_id"]] forKey:@"reward_id"];
    [sendData setObject:[NSString stringWithFormat:@"%@",[ReDetailDict valueForKey:@"points"]] forKey:@"redeem_points"];
    
    
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
    
    Redemconnection = [NSURLConnection connectionWithRequest:request delegate:self];
    if (Redemconnection)
    {
        RedemData = [[NSMutableData alloc]init];
    }
    
}
//********************************************
#pragma mark - Connection Delegate Methods
//********************************************

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection == Redemconnection)
    {
        [RedemData appendData:data];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (connection == Redemconnection)
    {
        [RedemData setLength:0];
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
    if (connection == Redemconnection)
    {
        NSMutableString *responceversionStr = [[NSMutableString alloc]initWithBytes:[RedemData mutableBytes] length:[RedemData length] encoding:NSUTF8StringEncoding];
        NSMutableDictionary *gat_dic = [[NSMutableDictionary alloc]init];
        [gat_dic setDictionary:[responceversionStr JSONValue]];
        
        [HUD hide:YES];
        
        UIAlertView *connectionAlert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"%@",[gat_dic valueForKey:@"message"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [connectionAlert show];
    }
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
