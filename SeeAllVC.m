//
//  SeeAllVC.m
//  WOOFR
//
//  Created by dipen  narola on 03/12/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import "SeeAllVC.h"
#import "TableAvailibilityVC.h"
#import "ClubDetailVC.h"
#import "EventDetailVC.h"

@interface SeeAllVC ()
{
    NSString *detectSTR;
    NSMutableArray *clubLISTARY,*EventListARY,*pramotionARY;
    
    
    
    
}
@end

@implementation SeeAllVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUD];
    [self.view bringSubviewToFront:HUD];
    [HUD setDelegate:self];
    [HUD setLabelText:@"Loading...."];
    
    
    self.navigationController.navigationBar.translucent = YES;
    
    self.navigationController.navigationBar.backIndicatorImage=[[UIImage imageNamed:@"ic_header_back.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage=[[UIImage imageNamed:@"ic_header_back.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor]];
    
    // 1 club
    // 2 event
    // 3 Pramotion
    // 4 desco
    
    
    detectSTR=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"WooFrclubDetetct"]];
    
    if([detectSTR isEqualToString:@"1"])
    {
        self.title = @"Clubs";
    }
    else if ([detectSTR isEqualToString:@"2"])
    {
        self.title = @"Events";
    }
    else if ([detectSTR isEqualToString:@"3"])
    {
        self.title = @"Promotions";
    }
    else if ([detectSTR isEqualToString:@"4"])
    {
//        self.title = @"Descos";
        self.title = @"Discos";
    }
    
    
    
    [self callSeeAllAPI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)callSeeAllAPI
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
    
    
    
    
//    NSString *uIDSTR= [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"WoofruserID"]];
    
    
    
    
    //admin.vasundharavision.com/woofr/api/?action=event_list&is_featured=0
    //admin.vasundharavision.com/woofr/api/?action=club_list&is_featured=0
    //admin.vasundharavision.com/woofr/api/?action=disco_list&is_featured=0
    //admin.vasundharavision.com/woofr/api/?action=promotion_list&is_featured=0
    
    
    
    if([detectSTR isEqualToString:@"1"])
    {
        [sendData setObject:@"club_list" forKey:@"action"];
        [sendData setObject:@"1" forKey:@"is_featured"];
    }
    else if ([detectSTR isEqualToString:@"2"])
    {
        [sendData setObject:@"event_list" forKey:@"action"];
        [sendData setObject:@"1" forKey:@"is_featured"];
    }
    else if ([detectSTR isEqualToString:@"3"])
    {
        [sendData setObject:@"promotion_list" forKey:@"action"];
        [sendData setObject:@"1" forKey:@"is_featured"];
    }
    else if ([detectSTR isEqualToString:@"4"])
    {
        [sendData setObject:@"disco_list" forKey:@"action"];
        [sendData setObject:@"1" forKey:@"is_featured"];
    }
    
    NSString *CITYSTR=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"WoofrExploreNightTitle"]];
    [sendData setObject:CITYSTR forKey:@"city"];

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
    
    SeeAllconnection = [NSURLConnection connectionWithRequest:request delegate:self];
    if (SeeAllconnection)
    {
        SeeAllData = [[NSMutableData alloc]init];
    }
    
}
//********************************************
#pragma mark - Connection Delegate Methods
//********************************************

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection == SeeAllconnection)
    {
        [SeeAllData appendData:data];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (connection == SeeAllconnection)
    {
        [SeeAllData setLength:0];
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
    if (connection == SeeAllconnection)
    {
        NSMutableString *responceversionStr = [[NSMutableString alloc]initWithBytes:[SeeAllData mutableBytes] length:[SeeAllData length] encoding:NSUTF8StringEncoding];
        NSMutableDictionary *gat_dic = [[NSMutableDictionary alloc]init];
        [gat_dic setDictionary:[responceversionStr JSONValue]];
        
        [HUD hide:YES];
        
        NSLog(@"%@",gat_dic);
        
        // 1 club
        // 2 event
        // 3 Pramotion
        // 4 desco
        if ([NSString stringWithFormat:@"%@",[gat_dic valueForKey:@"status"]])
        {
            if([detectSTR isEqualToString:@"1"])
            {
                clubLISTARY=[[NSMutableArray alloc]init];
                clubLISTARY=[gat_dic valueForKey:@"club_list"];
                if([NSString stringWithFormat:@"%@",clubLISTARY].length>5)
                {
                    [self ClubScrlUpdate];
                }
            }
            else if([detectSTR isEqualToString:@"2"])
            {
                EventListARY=[[NSMutableArray alloc]init];
                EventListARY=[gat_dic valueForKey:@"event_list"];
                if([NSString stringWithFormat:@"%@",EventListARY].length>5)
                {
                    [self EventScrlUpdate];
                }
            }
            else if([detectSTR isEqualToString:@"3"])
            {
                pramotionARY=[[NSMutableArray alloc]init];
                pramotionARY=[gat_dic valueForKey:@"event_list"];
                if([NSString stringWithFormat:@"%@",pramotionARY].length>5)
                {
                    [self pramotionScrlUpdate];
                }
            }
            else if([detectSTR isEqualToString:@"4"])
            {
                
            }
        }
    }
}

-(void)ClubScrlUpdate
{
    float SCRLHeigt=0;
    
    float ImgWidth,Imageheight;
    ImgWidth=SeeALLSCRL.frame.size.width;
    Imageheight=ImgWidth*0.55;
    
    for(int i=0;i<clubLISTARY.count;i++)
    {
        UIImageView *IMAG=[[UIImageView alloc]initWithFrame:CGRectMake(0, SCRLHeigt, ImgWidth, Imageheight)];
        IMAG.layer.borderWidth=1.0;
        IMAG.layer.borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
        IMAG.userInteractionEnabled=YES;
        
        
        
        
        NSMutableArray *IMGEARY=[[NSMutableArray alloc]init];
        IMGEARY=[[clubLISTARY objectAtIndex:i]valueForKey:@"club_images"];
        
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
        
        
        UIButton *ClubdetailBTN=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, IMAG.frame.size.width, IMAG.frame.size.height)];
        [ClubdetailBTN addTarget:self action:@selector(ClubDetailBTNclick:) forControlEvents:UIControlEventTouchUpInside];
        ClubdetailBTN.tag=3000+i;
        
        
        UILabel *NameLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, IMAG.frame.size.width-120, 40)];
        NameLBL.font=[UIFont boldSystemFontOfSize:15.0];
        NameLBL.text=[NSString stringWithFormat:@"%@",[[clubLISTARY objectAtIndex:i]valueForKey:@"club_name" ]];
        NameLBL.numberOfLines=2;
        NameLBL.textColor=[UIColor whiteColor];
        [IMAG addSubview:NameLBL];
        
        [IMAG addSubview:ClubdetailBTN];
//        float Rating=[[NSString stringWithFormat:@"%@",[[clubLISTARY objectAtIndex:i]valueForKey:@"rating"]] floatValue];
//        float StarWidth=12;
//        int FullSTR=[[NSString stringWithFormat:@"%@",[[clubLISTARY objectAtIndex:i]valueForKey:@"rating"]] intValue];
//        for (int m=0; m<5; m++)
//        {
//            UIImageView *starIMg=[[UIImageView alloc]initWithFrame:CGRectMake(StarWidth, IMAG.frame.size.height-30, 20, 20)];
//            starIMg.userInteractionEnabled=YES;
//            
//            
//            if(Rating == 0)
//            {
//                
//                starIMg.image=[UIImage imageNamed:@"ic_rating_star_white.png"];
//            }
//            else if(Rating == 0.5)
//            {
//                if(m==0)
//                {
//                    //half image
//                    starIMg.image=[UIImage imageNamed:@"ic_rating_star_half.png"];
//                }
//                else
//                {
//                    starIMg.image=[UIImage imageNamed:@"ic_rating_star_white.png"];
//                }
//            }
//            else
//            {
//                if(Rating==FullSTR)
//                {
//                    if(m<=FullSTR-1)
//                    {
//                        starIMg.image=[UIImage imageNamed:@"ic_rating_star_gold.png"];
//                    }
//                    else
//                    {
//                        starIMg.image=[UIImage imageNamed:@"ic_rating_star_white.png"];
//                    }
//                }
//                else
//                {
//                    if(m<=FullSTR-1)
//                    {
//                        starIMg.image=[UIImage imageNamed:@"ic_rating_star_gold.png"];
//                    }
//                    else if (m==FullSTR)
//                    {
//                        starIMg.image=[UIImage imageNamed:@"ic_rating_star_half.png"];
//                    }
//                    else
//                    {
//                        starIMg.image=[UIImage imageNamed:@"ic_rating_star_white.png"];
//                    }
//                }
//                
//            }
//            
//            [IMAG addSubview:starIMg];
//            
//            StarWidth=StarWidth+20+5;
//        }
        
        //Do coding here for club and Raffles place & than Add detail Button
        
//        UIButton *CBOOkNowBTN = [[UIButton alloc]initWithFrame:CGRectMake(NameLBL.frame.size.width+10, NameLBL.frame.origin.y+5, (IMAG.frame.size.width-(NameLBL.frame.size.width+10)-5), 35)];
//        [CBOOkNowBTN setBackgroundImage:[UIImage imageNamed:@"btn_small_login_general.png"] forState:UIControlStateNormal];
//        [CBOOkNowBTN setTitle:@"BOOK NOW" forState:UIControlStateNormal];
//        CBOOkNowBTN.tag=2000+i;
//        [CBOOkNowBTN addTarget:self action:@selector(CBookNowBTNclick:) forControlEvents:UIControlEventTouchUpInside];
//        [CBOOkNowBTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        CBOOkNowBTN.titleLabel.font=[UIFont systemFontOfSize:15.0];
        
        
        [NameLBL sizeToFit];
        
        
        NSString *TagSTR=[NSString stringWithFormat:@"%@",[[clubLISTARY objectAtIndex:i]valueForKey:@"tag"]];
        
        if(TagSTR.length>2)
        {
            NSArray *timeArray = [TagSTR componentsSeparatedByString:@","];
            
            UIScrollView *SCRL=[[UIScrollView alloc]initWithFrame:CGRectMake(10, IMAG.frame.size.height-35, IMAG.frame.size.width-20, 15)];
            
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
                tagFRM.size.height=15;
                tagLBL.frame=tagFRM;
                
                TagLBLWidth=TagLBLWidth+tagLBL.frame.size.width;
            }
            
            SCRL.contentSize=CGSizeMake(TagLBLWidth, 15);
            [IMAG addSubview:SCRL];
        }
        
//        [IMAG addSubview:CBOOkNowBTN];
        
        
        UILabel *AddRessLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, IMAG.frame.size.height-20, IMAG.frame.size.width-25, 15)];
        //  AddRessLBL.text=[NSString stringWithFormat:@"CLUBS.%@",[[ARYclublist objectAtIndex:i]valueForKey:@"address"]];
        AddRessLBL.text=[NSString stringWithFormat:@"%@",[[clubLISTARY objectAtIndex:i]valueForKey:@"address"]];
        //AddRessLBL.backgroundColor=[UIColor colorWithRed:33.0/255.0 green:31.0/255.0 blue:33.0/255.0 alpha:1.0];
        //                tagLBL.layer.borderColor=[UIColor colorWithRed:156.0/255.0 green:131.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
        //                tagLBL.layer.borderWidth=1.0;
        //        tagLBL.layer.borderColor=[UIColor whiteColor].CGColor;
        //        tagLBL.layer.borderWidth=0.5;
        AddRessLBL.textColor=[UIColor whiteColor];
        AddRessLBL.font=[UIFont systemFontOfSize:10.0];
        [IMAG addSubview:AddRessLBL];

        
        
        
        [SeeALLSCRL addSubview:IMAG];
        
        SCRLHeigt=SCRLHeigt+Imageheight+8;
    }
    
    SeeALLSCRL.contentSize=CGSizeMake(SeeALLSCRL.frame.size.width, SCRLHeigt);
}



-(void)EventScrlUpdate
{
    float SCRLHeigt=0;
    
    float ImgWidth,Imageheight;
    ImgWidth=SeeALLSCRL.frame.size.width;
    Imageheight=ImgWidth*0.55;
    
    for(int i=0;i<EventListARY.count;i++)
    {
        UIImageView *IMAG=[[UIImageView alloc]initWithFrame:CGRectMake(0, SCRLHeigt, ImgWidth, Imageheight)];
        IMAG.layer.borderWidth=1.0;
        IMAG.layer.borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
        IMAG.userInteractionEnabled=YES;
        
        
        
        
        NSMutableArray *IMGEARY=[[NSMutableArray alloc]init];
        IMGEARY=[[EventListARY objectAtIndex:i]valueForKey:@"event_images"];
        
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
        
        
        UIImageView *blackTIMG=[[UIImageView alloc]initWithFrame:CGRectMake(0, IMAG.frame.size.height-60, IMAG.frame.size.width, 60)];
        blackTIMG.backgroundColor=[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.8];
        blackTIMG.userInteractionEnabled=YES;
        
        
        UILabel *NameLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, blackTIMG.frame.size.width-20, 20)];
        NameLBL.font=[UIFont boldSystemFontOfSize:16.0];
        NameLBL.text=[NSString stringWithFormat:@"%@",[[EventListARY objectAtIndex:i]valueForKey:@"name" ]];
        NameLBL.numberOfLines=2;
        NameLBL.textColor=[UIColor whiteColor];
        [blackTIMG addSubview:NameLBL];
        
        
        NSString *dateSTR=[NSString stringWithFormat:@"%@",[[EventListARY objectAtIndex:i]valueForKey:@"start_date" ]];
        
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        NSDate *yourDate = [dateFormatter dateFromString:dateSTR];
        dateFormatter.dateFormat = @"dd MMM yyyy";
        
        NSString *finalDateSTr=[dateFormatter stringFromDate:yourDate];
        
        
        //        UILabel *DateLBL=[[UILabel alloc]initWithFrame:CGRectMake(5, 15, blackTIMG.frame.size.width-(BookNowBTN.frame.size.width+10), 15)];
        UILabel *DateLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, 23, blackTIMG.frame.size.width-20, 20)];
        DateLBL.text=finalDateSTr;//[NSString stringWithFormat:@"%@",[[ARYeventlist objectAtIndex:i]valueForKey:@"date" ]];
        DateLBL.font=[UIFont systemFontOfSize:13.0];
        DateLBL.textColor=[UIColor whiteColor];
        [blackTIMG addSubview:DateLBL];

        
        UILabel *clubnameLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, 40, blackTIMG.frame.size.width-20, 20)];
        clubnameLBL.text=[NSString stringWithFormat:@"%@",[[EventListARY objectAtIndex:i]valueForKey:@"club_name" ]];
        clubnameLBL.font=[UIFont systemFontOfSize:13.0];
        //        clubnameLBL.textColor=[UIColor whiteColor];
        clubnameLBL.textColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        [blackTIMG addSubview:clubnameLBL];
        
        
//        float Rating=[[NSString stringWithFormat:@"%@",[[EventListARY objectAtIndex:i]valueForKey:@"rating"]] floatValue];
//        float StarWidth=12;
//        int FullSTR=[[NSString stringWithFormat:@"%@",[[EventListARY objectAtIndex:i]valueForKey:@"rating"]] intValue];
//        for (int m=0; m<5; m++)
//        {
//            UIImageView *starIMg=[[UIImageView alloc]initWithFrame:CGRectMake(StarWidth, IMAG.frame.size.height-30, 20, 20)];
//            starIMg.userInteractionEnabled=YES;
//            
//            
//            if(Rating == 0)
//            {
//                
//                starIMg.image=[UIImage imageNamed:@"ic_rating_star_white.png"];
//            }
//            else if(Rating == 0.5)
//            {
//                if(m==0)
//                {
//                    //half image
//                    starIMg.image=[UIImage imageNamed:@"ic_rating_star_half.png"];
//                }
//                else
//                {
//                    starIMg.image=[UIImage imageNamed:@"ic_rating_star_white.png"];
//                }
//            }
//            else
//            {
//                if(Rating==FullSTR)
//                {
//                    if(m<=FullSTR-1)
//                    {
//                        starIMg.image=[UIImage imageNamed:@"ic_rating_star_gold.png"];
//                    }
//                    else
//                    {
//                        starIMg.image=[UIImage imageNamed:@"ic_rating_star_white.png"];
//                    }
//                }
//                else
//                {
//                    if(m<=FullSTR-1)
//                    {
//                        starIMg.image=[UIImage imageNamed:@"ic_rating_star_gold.png"];
//                    }
//                    else if (m==FullSTR)
//                    {
//                        starIMg.image=[UIImage imageNamed:@"ic_rating_star_half.png"];
//                    }
//                    else
//                    {
//                        starIMg.image=[UIImage imageNamed:@"ic_rating_star_white.png"];
//                    }
//                }
//                
//            }
//            
//            [IMAG addSubview:starIMg];
//            
//            StarWidth=StarWidth+20+5;
//        }
        
        //Do coding here for club and Raffles place & than Add detail Button
        
//        UIButton *CBOOkNowBTN = [[UIButton alloc]initWithFrame:CGRectMake(NameLBL.frame.size.width+10, NameLBL.frame.origin.y+5, (IMAG.frame.size.width-(NameLBL.frame.size.width+10)-5), 35)];
//        [CBOOkNowBTN setBackgroundImage:[UIImage imageNamed:@"btn_small_login_general.png"] forState:UIControlStateNormal];
//        [CBOOkNowBTN setTitle:@"BOOK NOW" forState:UIControlStateNormal];
//        CBOOkNowBTN.tag=2000+i;
//        [CBOOkNowBTN addTarget:self action:@selector(CBookNowBTNclick:) forControlEvents:UIControlEventTouchUpInside];
//        [CBOOkNowBTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        CBOOkNowBTN.titleLabel.font=[UIFont systemFontOfSize:15.0];
        
        
 //       [NameLBL sizeToFit];
        
        
//        NSString *TagSTR=[NSString stringWithFormat:@"%@",[[EventListARY objectAtIndex:i]valueForKey:@"tag"]];
//        
//        if(TagSTR.length>2 && ![TagSTR isEqualToString:@"(null)"])
//        {
//            NSArray *timeArray = [TagSTR componentsSeparatedByString:@","];
//            
//            UIScrollView *SCRL=[[UIScrollView alloc]initWithFrame:CGRectMake(10, IMAG.frame.size.height-70, IMAG.frame.size.width-20, 30)];
//            
//            float TagLBLWidth=0;
//            
//            for(int i=0; i<timeArray.count;i++)
//            {
//                UILabel *tagLBL=[[UILabel alloc]initWithFrame:CGRectMake(TagLBLWidth, 0, 5000, 30)];
//                tagLBL.text=[NSString stringWithFormat:@"  %@  ",[timeArray objectAtIndex:i]];
//                tagLBL.backgroundColor=[UIColor colorWithRed:33.0/255.0 green:31.0/255.0 blue:33.0/255.0 alpha:1.0];
//                tagLBL.layer.borderColor=[UIColor colorWithRed:156.0/255.0 green:131.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
//                tagLBL.layer.borderWidth=1.0;
//                tagLBL.textColor=[UIColor whiteColor];
//                tagLBL.font=[UIFont systemFontOfSize:12.0];
//                
//                [tagLBL sizeToFit];
//                
//                [SCRL addSubview:tagLBL];
//                
//                CGRect tagFRM = tagLBL.frame;
//                tagFRM.size.height=30;
//                tagLBL.frame=tagFRM;
//                
//                TagLBLWidth=TagLBLWidth+tagLBL.frame.size.width+5;
//            }
//            
//            SCRL.contentSize=CGSizeMake(TagLBLWidth, 30);
//            [IMAG addSubview:SCRL];
//        }
        
 //       [IMAG addSubview:CBOOkNowBTN];
        
        
        UIButton *EventDetailBTN=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, IMAG.frame.size.width, IMAG.frame.size.height)];
        [EventDetailBTN addTarget:self action:@selector(EventDetailClick:) forControlEvents:UIControlEventTouchUpInside];
        EventDetailBTN.tag=i+4000;
        [IMAG addSubview:EventDetailBTN];
        [IMAG addSubview:blackTIMG];
        [SeeALLSCRL addSubview:IMAG];
        
        SCRLHeigt=SCRLHeigt+Imageheight+8;
    }
    
    SeeALLSCRL.contentSize=CGSizeMake(SeeALLSCRL.frame.size.width, SCRLHeigt);
}

-(void)pramotionScrlUpdate
{
    float SCRLHeigt=0;
    
    float ImgWidth,Imageheight;
    ImgWidth=SeeALLSCRL.frame.size.width;
    Imageheight=ImgWidth*0.55;
    
    for(int i=0;i<pramotionARY.count;i++)
    {
        UIImageView *IMAG=[[UIImageView alloc]initWithFrame:CGRectMake(0, SCRLHeigt, ImgWidth, Imageheight)];
        IMAG.layer.borderWidth=1.0;
        IMAG.layer.borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
        IMAG.userInteractionEnabled=YES;
        
        
        
        
        NSMutableArray *IMGEARY=[[NSMutableArray alloc]init];
        IMGEARY=[[pramotionARY objectAtIndex:i]valueForKey:@"event_images"];
        
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
        
        
        UIImageView *blackTIMG=[[UIImageView alloc]initWithFrame:CGRectMake(0, IMAG.frame.size.height-60, IMAG.frame.size.width, 60)];
        blackTIMG.backgroundColor=[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.8];
        blackTIMG.userInteractionEnabled=YES;
        
        
        UILabel *NameLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, blackTIMG.frame.size.width-20, 20)];
        NameLBL.font=[UIFont boldSystemFontOfSize:16.0];
        NameLBL.text=[NSString stringWithFormat:@"%@",[[pramotionARY objectAtIndex:i]valueForKey:@"name" ]];
       
        NameLBL.textColor=[UIColor whiteColor];
        [blackTIMG addSubview:NameLBL];
        
        
        NSString *dateSTR=[NSString stringWithFormat:@"%@",[[pramotionARY objectAtIndex:i]valueForKey:@"start_date" ]];
        
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        NSDate *yourDate = [dateFormatter dateFromString:dateSTR];
        dateFormatter.dateFormat = @"dd MMM yyyy";
        
        NSString *finalDateSTr=[dateFormatter stringFromDate:yourDate];
        
        
        //        UILabel *DateLBL=[[UILabel alloc]initWithFrame:CGRectMake(5, 15, blackTIMG.frame.size.width-(BookNowBTN.frame.size.width+10), 15)];
        UILabel *DateLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, 23, blackTIMG.frame.size.width-20, 20)];
        DateLBL.text=finalDateSTr;//[NSString stringWithFormat:@"%@",[[ARYeventlist objectAtIndex:i]valueForKey:@"date" ]];
        DateLBL.font=[UIFont systemFontOfSize:13.0];
        DateLBL.textColor=[UIColor whiteColor];
        [blackTIMG addSubview:DateLBL];
        
        
        UILabel *clubnameLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, 40, blackTIMG.frame.size.width-20, 20)];
        clubnameLBL.text=[NSString stringWithFormat:@"%@",[[pramotionARY objectAtIndex:i]valueForKey:@"club_name" ]];
        clubnameLBL.font=[UIFont systemFontOfSize:13.0];
        //        clubnameLBL.textColor=[UIColor whiteColor];
        clubnameLBL.textColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        [blackTIMG addSubview:clubnameLBL];
        
//        float Rating=[[NSString stringWithFormat:@"%@",[[pramotionARY objectAtIndex:i]valueForKey:@"rating"]] floatValue];
//        float StarWidth=12;
//        int FullSTR=[[NSString stringWithFormat:@"%@",[[pramotionARY objectAtIndex:i]valueForKey:@"rating"]] intValue];
//        for (int m=0; m<5; m++)
//        {
//            UIImageView *starIMg=[[UIImageView alloc]initWithFrame:CGRectMake(StarWidth, IMAG.frame.size.height-30, 20, 20)];
//            starIMg.userInteractionEnabled=YES;
//            
//            
//            if(Rating == 0)
//            {
//                
//                starIMg.image=[UIImage imageNamed:@"ic_rating_star_white.png"];
//            }
//            else if(Rating == 0.5)
//            {
//                if(m==0)
//                {
//                    //half image
//                    starIMg.image=[UIImage imageNamed:@"ic_rating_star_half.png"];
//                }
//                else
//                {
//                    starIMg.image=[UIImage imageNamed:@"ic_rating_star_white.png"];
//                }
//            }
//            else
//            {
//                if(Rating==FullSTR)
//                {
//                    if(m<=FullSTR-1)
//                    {
//                        starIMg.image=[UIImage imageNamed:@"ic_rating_star_gold.png"];
//                    }
//                    else
//                    {
//                        starIMg.image=[UIImage imageNamed:@"ic_rating_star_white.png"];
//                    }
//                }
//                else
//                {
//                    if(m<=FullSTR-1)
//                    {
//                        starIMg.image=[UIImage imageNamed:@"ic_rating_star_gold.png"];
//                    }
//                    else if (m==FullSTR)
//                    {
//                        starIMg.image=[UIImage imageNamed:@"ic_rating_star_half.png"];
//                    }
//                    else
//                    {
//                        starIMg.image=[UIImage imageNamed:@"ic_rating_star_white.png"];
//                    }
//                }
//                
//            }
//            
//            [IMAG addSubview:starIMg];
//            
//            StarWidth=StarWidth+20+5;
//        }
//        
//        //Do coding here for club and Raffles place & than Add detail Button
//        
//        UIButton *CBOOkNowBTN = [[UIButton alloc]initWithFrame:CGRectMake(NameLBL.frame.size.width+10, NameLBL.frame.origin.y+5, (IMAG.frame.size.width-(NameLBL.frame.size.width+10)-5), 35)];
//        [CBOOkNowBTN setBackgroundImage:[UIImage imageNamed:@"btn_small_login_general.png"] forState:UIControlStateNormal];
//        [CBOOkNowBTN setTitle:@"BOOK NOW" forState:UIControlStateNormal];
//        CBOOkNowBTN.tag=2000+i;
//        [CBOOkNowBTN addTarget:self action:@selector(CBookNowBTNclick:) forControlEvents:UIControlEventTouchUpInside];
//        [CBOOkNowBTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        CBOOkNowBTN.titleLabel.font=[UIFont systemFontOfSize:15.0];
//        
//        
//        [NameLBL sizeToFit];
        
        
//        NSString *TagSTR=[NSString stringWithFormat:@"%@",[[pramotionARY objectAtIndex:i]valueForKey:@"tag"]];
//        
//        if(TagSTR.length>2 && ![TagSTR isEqualToString:@"(null)"])
//        {
//            NSArray *timeArray = [TagSTR componentsSeparatedByString:@","];
//            
//            UIScrollView *SCRL=[[UIScrollView alloc]initWithFrame:CGRectMake(10, IMAG.frame.size.height-70, IMAG.frame.size.width-20, 30)];
//            
//            float TagLBLWidth=0;
//            
//            for(int i=0; i<timeArray.count;i++)
//            {
//                UILabel *tagLBL=[[UILabel alloc]initWithFrame:CGRectMake(TagLBLWidth, 0, 5000, 30)];
//                tagLBL.text=[NSString stringWithFormat:@"  %@  ",[timeArray objectAtIndex:i]];
//                tagLBL.backgroundColor=[UIColor colorWithRed:33.0/255.0 green:31.0/255.0 blue:33.0/255.0 alpha:1.0];
//                tagLBL.layer.borderColor=[UIColor colorWithRed:156.0/255.0 green:131.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
//                tagLBL.layer.borderWidth=1.0;
//                tagLBL.textColor=[UIColor whiteColor];
//                tagLBL.font=[UIFont systemFontOfSize:12.0];
//                
//                [tagLBL sizeToFit];
//                
//                [SCRL addSubview:tagLBL];
//                
//                CGRect tagFRM = tagLBL.frame;
//                tagFRM.size.height=30;
//                tagLBL.frame=tagFRM;
//                
//                TagLBLWidth=TagLBLWidth+tagLBL.frame.size.width+5;
//            }
//            
//            SCRL.contentSize=CGSizeMake(TagLBLWidth, 30);
//            [IMAG addSubview:SCRL];
//        }
//        
//        [IMAG addSubview:CBOOkNowBTN];
        
        
        UIButton *EventDetailBTN=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, IMAG.frame.size.width, IMAG.frame.size.height)];
        [EventDetailBTN addTarget:self action:@selector(PramotionDetailClick:) forControlEvents:UIControlEventTouchUpInside];
        EventDetailBTN.tag=i+86000;
        [IMAG addSubview:EventDetailBTN];
        [IMAG addSubview:blackTIMG];
        [SeeALLSCRL addSubview:IMAG];
        
        SCRLHeigt=SCRLHeigt+Imageheight+8;
    }
    
    SeeALLSCRL.contentSize=CGSizeMake(SeeALLSCRL.frame.size.width, SCRLHeigt);
}


-(void)CBookNowBTNclick:(id)sender
{
    UIButton *button1 = sender;
    NSInteger RbuttonTag = button1.tag;
    
    NSLog(@"%li",RbuttonTag-2000);
    
    
    
    if([detectSTR isEqualToString:@"1"])
    {
        
        // 1 club
        // 2 event
        // 3 Pramotion
        // 4 desco
        
        [[NSUserDefaults standardUserDefaults]setValue:@"1" forKey:@"WooFrclubDetetct"];
        
        NSString *clubID=[NSString stringWithFormat:@"%@",[[clubLISTARY objectAtIndex:RbuttonTag-2000]valueForKey:@"club_id" ]];
        
        NSMutableDictionary *tempDetailDict=[[NSMutableDictionary alloc]init];
        tempDetailDict=[clubLISTARY objectAtIndex:(RbuttonTag-2000)];
        
        [[NSUserDefaults standardUserDefaults]setValue:tempDetailDict forKey:@"WoofrclubDetail"];
        
        
        [[NSUserDefaults standardUserDefaults]setValue:clubID forKey:@"bookCLUBIDWoofer"];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
        TableAvailibilityVC *dealVC1 = (TableAvailibilityVC *)[storyboard instantiateViewControllerWithIdentifier:@"TableAvailibilityVC"];
        [self.navigationController pushViewController:dealVC1 animated:YES];
    }
}

-(void)ClubDetailBTNclick:(id)sender
{
    UIButton *button1 = sender;
    NSInteger RbuttonTag = button1.tag;
    
    NSLog(@"%li",RbuttonTag-3000);
    
    // 1 club
    // 2 event
    // 3 Pramotion
    // 4 desco
    
    [[NSUserDefaults standardUserDefaults]setValue:@"1" forKey:@"WooFrclubDetetct"];
    
    NSMutableDictionary *tempDetailDict=[[NSMutableDictionary alloc]init];
    tempDetailDict=[clubLISTARY objectAtIndex:(RbuttonTag-3000)];
    
    [[NSUserDefaults standardUserDefaults]setValue:tempDetailDict forKey:@"WoofrclubDetail"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    ClubDetailVC *dealVC1 = (ClubDetailVC *)[storyboard instantiateViewControllerWithIdentifier:@"ClubDetailVC"];
    [self.navigationController pushViewController:dealVC1 animated:YES];
}
-(void)EventDetailClick:(id)sender
{
    UIButton *button1 = sender;
    NSInteger RbuttonTag = button1.tag;
    
    NSLog(@"%li",RbuttonTag-4000);
    
    // 1 club
    // 2 event
    // 3 Pramotion
    // 4 desco
    
    [[NSUserDefaults standardUserDefaults]setValue:@"2" forKey:@"WooFrclubDetetct"];
    
    NSMutableDictionary *tempDetailDict=[[NSMutableDictionary alloc]init];
    tempDetailDict=[EventListARY objectAtIndex:(RbuttonTag-4000)];
    
    [[NSUserDefaults standardUserDefaults]setValue:tempDetailDict forKey:@"WoofrEventDetail"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    EventDetailVC *dealVC1 = (EventDetailVC *)[storyboard instantiateViewControllerWithIdentifier:@"EventDetailVC"];
    [self.navigationController pushViewController:dealVC1 animated:YES];
    
}
-(void)PramotionDetailClick:(id)sender
{
    UIButton *button1 = sender;
    NSInteger RbuttonTag = button1.tag;
    
    NSLog(@"%li",RbuttonTag-86000);
    
    // 1 club
    // 2 event
    // 3 Pramotion
    // 4 desco
    
    [[NSUserDefaults standardUserDefaults]setValue:@"3" forKey:@"WooFrclubDetetct"];
    
    NSMutableDictionary *tempDetailDict=[[NSMutableDictionary alloc]init];
    tempDetailDict=[pramotionARY objectAtIndex:(RbuttonTag-86000)];
    
    [[NSUserDefaults standardUserDefaults]setValue:tempDetailDict forKey:@"WoofrEventDetail"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    EventDetailVC *dealVC1 = (EventDetailVC *)[storyboard instantiateViewControllerWithIdentifier:@"EventDetailVC"];
    [self.navigationController pushViewController:dealVC1 animated:YES];
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
