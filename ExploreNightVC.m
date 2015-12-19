//
//  ExploreNightVC.m
//  WOOFR
//
//  Created by dipen  narola on 01/12/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import "ExploreNightVC.h"

@interface ExploreNightVC ()
{
    int BTNflag;
    
    NSString *cityNAMe,*APIkeySTR;
    
    NSMutableArray *RecordARY;
    
}
@end

@implementation ExploreNightVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor]];
    
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc]
                                     initWithImage:[UIImage imageNamed:@"ic_header_close.png"]
                                     style:UIBarButtonItemStylePlain
                                     target:self action:@selector(CloseView)];
    logoutButton.tintColor=[UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = logoutButton;
    
    cityNAMe = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"WoofrExploreNightTitle"]];
    self.title = cityNAMe;
    
    BTNflag=0;
    
    HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUD];
    [self.view bringSubviewToFront:HUD];
    [HUD setDelegate:self];
    [HUD setLabelText:@"Loading...."];
    
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    BTNCLub.layer.borderWidth=1.0;
    BTNCLub.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    
    UIView *topBorderC = [UIView new];
    topBorderC.backgroundColor = [UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0];
    topBorderC.frame = CGRectMake(0, 0, BTNDIscos.frame.size.width, 1.0);
    [BTNDIscos addSubview:topBorderC];
    
    UIView *leftBorderC = [UIView new];
    leftBorderC.backgroundColor = [UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0];
    leftBorderC.frame = CGRectMake(BTNDIscos.frame.size.width-1, 0, 1, BTNDIscos.frame.size.height);
    [BTNDIscos addSubview:leftBorderC];
    
    UIView *bottomBorderC = [UIView new];
    bottomBorderC.backgroundColor = [UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0];
    bottomBorderC.frame = CGRectMake(0, BTNDIscos.frame.size.height-1, BTNDIscos.frame.size.width, 1);
    [BTNDIscos addSubview:bottomBorderC];
    
    
    UIView *topBorderR = [UIView new];
    topBorderR.backgroundColor = [UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0];
    topBorderR.frame = CGRectMake(0, 0, BTNRating.frame.size.width, 1.0);
    [BTNRating addSubview:topBorderR];
    
    UIView *leftBorderR = [UIView new];
    leftBorderR.backgroundColor = [UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0];
    leftBorderR.frame = CGRectMake(BTNRating.frame.size.width-1, 0, 1, BTNRating.frame.size.height);
    [BTNRating addSubview:leftBorderR];
    
    UIView *bottomBorderR = [UIView new];
    bottomBorderR.backgroundColor = [UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0];
    bottomBorderR.frame = CGRectMake(0, BTNRating.frame.size.height-1, BTNRating.frame.size.width, 1);
    [BTNRating addSubview:bottomBorderR];
    
    
    [self ClubBTNclick:Nil];
}

-(void)CloseView
{
    [self dismissViewControllerAnimated:YES completion:Nil];
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

- (IBAction)ClubBTNclick:(id)sender
{
    if(BTNflag!=1)
    {
        BTNDIscos.backgroundColor=[UIColor clearColor];
        BTNRating.backgroundColor=[UIColor clearColor];
        BTNCLub.backgroundColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0];
        
        BTNflag=1;
        
        APIkeySTR=@"club_list";
        
        [self CAllAPi];
    }
}

- (IBAction)DiscosBTNclick:(id)sender
{
    if(BTNflag!=2)
    {
        BTNDIscos.backgroundColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0];
        BTNRating.backgroundColor=[UIColor clearColor];
        BTNCLub.backgroundColor=[UIColor clearColor];
        
        BTNflag=2;
        
        APIkeySTR=@"event_list";
        
        [self CAllAPi];
    }
}

- (IBAction)RatingBTNclick:(id)sender
{
    if(BTNflag!=3)
    {
        BTNDIscos.backgroundColor=[UIColor clearColor];
        BTNRating.backgroundColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0];
        BTNCLub.backgroundColor=[UIColor clearColor];
        
        BTNflag=3;
        
        APIkeySTR=@"rating_wise_list";
        
        [self CAllAPi];
    }
}
-(void)CAllAPi
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
    
    
    
    //admin.vasundharavision.com/woofr/api/?action=rating_wise_list
    //admin.vasundharavision.com/woofr/api/?action=disco_list&is_featured=0
    //admin.vasundharavision.com/woofr/api/?action=club_list&is_featured=0
    
    [sendData setObject:APIkeySTR forKey:@"action"];
    if(BTNflag == 1 || BTNflag == 2)
    {
        [sendData setObject:APIkeySTR forKey:@"is_featured"];
//        [sendData setObject:APIkeySTR forKey:@"is_featured"];
    }
    NSString *string =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"WoofrExploreNightTitle"]];
    [sendData setObject:string forKey:@"city"];
    
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
    
    ExploreNightconnection = [NSURLConnection connectionWithRequest:request delegate:self];
    if (ExploreNightconnection)
    {
        ExploreNightData = [[NSMutableData alloc]init];
    }
    
}
//********************************************
#pragma mark - Connection Delegate Methods
//********************************************

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection == ExploreNightconnection)
    {
        [ExploreNightData appendData:data];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (connection == ExploreNightconnection)
    {
        [ExploreNightData setLength:0];
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
    if (connection == ExploreNightconnection)
    {
        NSMutableString *responceversionStr = [[NSMutableString alloc]initWithBytes:[ExploreNightData mutableBytes] length:[ExploreNightData length] encoding:NSUTF8StringEncoding];
        NSMutableDictionary *gat_dic = [[NSMutableDictionary alloc]init];
        [gat_dic setDictionary:[responceversionStr JSONValue]];
        
        [HUD hide:YES];
        
        NSLog(@"%@",gat_dic);
        
        NSString *statusSTR=[NSString stringWithFormat:@"%@",[gat_dic valueForKey:@"status"]];
        
        if([statusSTR isEqualToString:@"1"])
        {
            RecordARY=[[NSMutableArray alloc]init];
            
            if(BTNflag==1)
            {
                RecordARY=[gat_dic valueForKey:@"club_list"];
            }
            else if (BTNflag==2)
            {
                RecordARY=[gat_dic valueForKey:@"event_list"];
            }
            else
            {
                RecordARY=[gat_dic valueForKey:@"club_disco_list"];
            }
            [containSCRL.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [containSCRL setContentOffset:CGPointMake(0, 0) animated:NO];
            
            if([NSString stringWithFormat:@"%@",RecordARY].length>10)
            {
                [self UpdateSCRL];
            }
        }
    }
}
-(void)UpdateSCRL
{
    float SCRLHeigt=0;
    
    float ImgWidth,Imageheight;
    ImgWidth=containSCRL.frame.size.width;
    Imageheight=ImgWidth*0.55;
    
    for(int i=0;i<RecordARY.count;i++)
    {
        UIImageView *IMAG=[[UIImageView alloc]initWithFrame:CGRectMake(0, SCRLHeigt, ImgWidth, Imageheight)];
        IMAG.layer.borderWidth=1.0;
        IMAG.layer.borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
        IMAG.userInteractionEnabled=YES;
        
        
        
        
        NSMutableArray *IMGEARY=[[NSMutableArray alloc]init];
        if(BTNflag==1)
        {
            IMGEARY=[[RecordARY objectAtIndex:i]valueForKey:@"club_images"];
        }
        else
        {
            IMGEARY=[[RecordARY objectAtIndex:i]valueForKey:@"event_images"];
        }
        
        if([NSString stringWithFormat:@"%@",IMGEARY].length>5)
        {
            UIScrollView *IMGSCRL=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, IMAG.frame.size.width, IMAG.frame.size.height)];
            IMGSCRL.pagingEnabled=YES;
            
            for(int k=0;k<IMGEARY.count;k++)
            {
                
                NSURL *urllinksTR= [NSURL URLWithString:[[NSString stringWithFormat:@"%@",[[IMGEARY objectAtIndex:k] valueForKey:@"filename"]]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                
                AsyncImageView *beerImage = [[AsyncImageView alloc]initWithFrame:CGRectMake(IMGSCRL.frame.size.width*k, 0, IMGSCRL.frame.size.width, IMGSCRL.frame.size.height)];
                [beerImage loadImageFromURL:urllinksTR imageName:@""];
                [IMGSCRL addSubview:beerImage];
                
            }
            
            IMGSCRL.contentSize=CGSizeMake((IMGSCRL.frame.size.width)*(IMGEARY.count), IMGSCRL.frame.size.height);
            
            [IMAG addSubview:IMGSCRL];
        }
        
        
        UILabel *NameLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, IMAG.frame.size.width-(IMAG.frame.size.height-40-36)-20, 40)];
        NameLBL.font=[UIFont boldSystemFontOfSize:15.0];
        if(BTNflag==1)
        {
            NameLBL.text=[NSString stringWithFormat:@"%@",[[RecordARY objectAtIndex:i]valueForKey:@"club_name" ]];
        }
        else
        {
            NameLBL.text=[NSString stringWithFormat:@"%@",[[RecordARY objectAtIndex:i]valueForKey:@"name" ]];
        }
        NameLBL.numberOfLines=2;
        NameLBL.textColor=[UIColor whiteColor];
        [IMAG addSubview:NameLBL];
        
        
        float Rating=[[NSString stringWithFormat:@"%@",[[RecordARY objectAtIndex:i]valueForKey:@"rating"]] floatValue];
        float StarWidth=12;
        int FullSTR=[[NSString stringWithFormat:@"%@",[[RecordARY objectAtIndex:i]valueForKey:@"rating"]] intValue];
        for (int m=0; m<5; m++)
        {
            UIImageView *starIMg=[[UIImageView alloc]initWithFrame:CGRectMake(StarWidth, IMAG.frame.size.height-30, 20, 20)];
            starIMg.userInteractionEnabled=YES;
            
            
            if(Rating == 0)
            {
                
                starIMg.image=[UIImage imageNamed:@"ic_rating_star_white.png"];
            }
            else if(Rating == 0.5)
            {
                if(m==0)
                {
                    //half image
                    starIMg.image=[UIImage imageNamed:@"ic_rating_star_half.png"];
                }
                else
                {
                  starIMg.image=[UIImage imageNamed:@"ic_rating_star_white.png"];
                }
            }
            else
            {
                if(Rating==FullSTR)
                {
                    if(m<=FullSTR-1)
                    {
                        starIMg.image=[UIImage imageNamed:@"ic_rating_star_gold.png"];
                    }
                    else
                    {
                        starIMg.image=[UIImage imageNamed:@"ic_rating_star_white.png"];
                    }
                }
                else
                {
                    if(m<=FullSTR-1)
                    {
                        starIMg.image=[UIImage imageNamed:@"ic_rating_star_gold.png"];
                    }
                    else if (m==FullSTR)
                    {
                        starIMg.image=[UIImage imageNamed:@"ic_rating_star_half.png"];
                    }
                    else
                    {
                        starIMg.image=[UIImage imageNamed:@"ic_rating_star_white.png"];
                    }
                }
                
            }
            
            [IMAG addSubview:starIMg];
            
            StarWidth=StarWidth+20+5;
        }
        
        //Do coding here for club and Raffles place & than Add detail Button
        
                UIButton *CBOOkNowBTN = [[UIButton alloc]initWithFrame:CGRectMake(NameLBL.frame.size.width+10, NameLBL.frame.origin.y+5, (IMAG.frame.size.width-(NameLBL.frame.size.width+10)-5), 30)];
                [CBOOkNowBTN setBackgroundImage:[UIImage imageNamed:@"btn_small_login_general.png"] forState:UIControlStateNormal];
                [CBOOkNowBTN setTitle:@"BOOK NOW" forState:UIControlStateNormal];
                CBOOkNowBTN.tag=2000+i;
                [CBOOkNowBTN addTarget:self action:@selector(CBookNowBTNclick:) forControlEvents:UIControlEventTouchUpInside];
                [CBOOkNowBTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                CBOOkNowBTN.titleLabel.font=[UIFont systemFontOfSize:15.0];
        
        
        [NameLBL sizeToFit];
        
        if(BTNflag==1)
        {
        NSString *TagSTR=[NSString stringWithFormat:@"%@",[[RecordARY objectAtIndex:i]valueForKey:@"tag"]];
        
        if(TagSTR.length>2)
        {
            NSArray *timeArray = [TagSTR componentsSeparatedByString:@","];
            
            UIScrollView *SCRL=[[UIScrollView alloc]initWithFrame:CGRectMake(10, IMAG.frame.size.height-70, IMAG.frame.size.width-20, 30)];
            
            float TagLBLWidth=0;
            
            for(int i=0; i<timeArray.count;i++)
            {
                UILabel *tagLBL=[[UILabel alloc]initWithFrame:CGRectMake(TagLBLWidth, 0, 5000, 30)];
                tagLBL.text=[NSString stringWithFormat:@"  %@  ",[timeArray objectAtIndex:i]];
                tagLBL.backgroundColor=[UIColor colorWithRed:33.0/255.0 green:31.0/255.0 blue:33.0/255.0 alpha:1.0];
                tagLBL.layer.borderColor=[UIColor colorWithRed:156.0/255.0 green:131.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
                tagLBL.layer.borderWidth=1.0;
                tagLBL.textColor=[UIColor whiteColor];
                tagLBL.font=[UIFont systemFontOfSize:12.0];
                
                [tagLBL sizeToFit];
                
                [SCRL addSubview:tagLBL];
                
                CGRect tagFRM = tagLBL.frame;
                tagFRM.size.height=30;
                tagLBL.frame=tagFRM;
                
                TagLBLWidth=TagLBLWidth+tagLBL.frame.size.width+5;
            }
            
            SCRL.contentSize=CGSizeMake(TagLBLWidth, 30);
            [IMAG addSubview:SCRL];
        }
        }
        [IMAG addSubview:CBOOkNowBTN];
        [containSCRL addSubview:IMAG];
        
        SCRLHeigt=SCRLHeigt+Imageheight+8;
    }
    
    containSCRL.contentSize=CGSizeMake(containSCRL.frame.size.width, SCRLHeigt);
}

-(void)CBookNowBTNclick:(id)sender
{
    
}
@end
