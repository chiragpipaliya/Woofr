//
//  ExploreVC.m
//  WOOFR
//
//  Created by dipen  narola on 20/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import "ExploreVC.h"
#import "EventDetailVC.h"
#import "ClubDetailVC.h"
#import "ExploreNightVC.h"
#import "SeeAllVC.h"
#import "TableAvailibilityVC.h"
#import "SearchVC.h"
#import "BookEventAvailibilityVC.h"

@interface ExploreVC ()
{
    UIButton *CityBTN;
    
    NSMutableArray *ARYclublist,*ARYeventlist,*ARYpromotionlist;
    
    NSString *uIDSTR;
    
    UIView *popover;
    
    UIImageView *allCIMG,*singaporimg,*thailandimg;
    

    int contrydetect;
    
    CGRect WfC,WfE,WfP;
    

}

@end

@implementation ExploreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSUserDefaults *login = [NSUserDefaults standardUserDefaults];
    [login setBool:YES forKey:@"WoofrLOGIN"];
    
    NSMutableDictionary *UserInfo=[[NSMutableDictionary alloc]init];
    
    NSUserDefaults *user=[[NSUserDefaults alloc]init];
    
    UserInfo=[user valueForKey:@"WoofrUSer"];

    [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%@",[UserInfo valueForKey:@"user_id"]] forKey:@"WoofruserID"];
    
    
    self.navigationController.navigationBar.translucent = YES;
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor]];
    
    _menubtn.tintColor = [UIColor whiteColor];
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
//    SWRevealViewController *revealController = [self revealViewController];
//    UITapGestureRecognizer *tap = [revealController tapGestureRecognizer];
//    tap.delegate = self;
//    
//    
//    [self.view addGestureRecognizer:tap];
    
    

    
    
    
    //self.title=@"Explore";
    
    CityBTN=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 120, 44)];
    [CityBTN setTitle:@"SINGAPORE" forState:UIControlStateNormal];
    [CityBTN setBackgroundImage:[UIImage imageNamed:@"ic_header_down_arrow.png"] forState:UIControlStateNormal];
    [CityBTN addTarget:self action:@selector(cityclick) forControlEvents:UIControlEventTouchUpInside];
    //[CityBTN sizeToFit];
    self.navigationItem.titleView = CityBTN;
    
    ExploreBTN.layer.borderWidth=1.0;
    ExploreBTN.layer.borderColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0].CGColor;
    
    
    bottomContainerView.layer.borderWidth=1.5;
    bottomContainerView.layer.borderColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0].CGColor;
    
    clubCNTview.layer.borderWidth=1.5;
    clubCNTview.layer.borderColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0].CGColor;
    
    eventCNTview.layer.borderWidth=1.5;
    eventCNTview.layer.borderColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0].CGColor;
    
    pramotionCNTview.layer.borderWidth=1.5;
    pramotionCNTview.layer.borderColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0].CGColor;
    
    ExploreSCR.contentSize=CGSizeMake(self.view.frame.size.width, ExploreVIEW.frame.origin.y+ExploreVIEW.frame.size.height);
    
    HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUD];
    [self.view bringSubviewToFront:HUD];
    [HUD setDelegate:self];
    [HUD setLabelText:@"Loading...."];
    
    uIDSTR= [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"WoofruserID"]];
    
    contrydetect=[[NSString stringWithFormat:@"%li",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"FilterCountryindexwfr"]] intValue];
    
    if(contrydetect==0)
    {
        [CityBTN setTitle:@"ALL" forState:UIControlStateNormal];
    }
    else if (contrydetect==1)
    {
        [CityBTN setTitle:@"SINGAPORE" forState:UIControlStateNormal];
    }
    else
    {
        [CityBTN setTitle:@"THAILAND" forState:UIControlStateNormal];
    }
    
    WfC=ClubWaterMark.frame;
    WfE=EventWaterMark.frame;
    WfP=PramotionWaterMark.frame;
    
    [self callAPIHOME];
    
}
-(void)cityclick
{
    [self LoadFilterView1];
    
    
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
-(void)callAPIHOME
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
    
    //admin.vasundharavision.com/woofr/api/?action=home&city=SINGAPORE
    
    
    NSMutableDictionary *sendData = [[NSMutableDictionary alloc]init];
    
    
    NSUserDefaults *fetchDefaultslogin = [NSUserDefaults standardUserDefaults];
    NSString *deviceTokan=[NSString stringWithFormat:@"%@",[fetchDefaultslogin valueForKey:@"deviceToken"]];
    
    
    [sendData setObject:@"home" forKey:@"action"];
    
    
    
    if([[NSString stringWithFormat:@"%li",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"FilterCountryindexwfr"]] intValue]==0)
    {
        [sendData setObject:@"all" forKey:@"city"];
    }
    else if([[NSString stringWithFormat:@"%li",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"FilterCountryindexwfr"]] intValue]==1)
    {
        [sendData setObject:@"SINGAPORE" forKey:@"city"];
    }
    else
    {
        [sendData setObject:@"THAILAND" forKey:@"city"];
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
    
    Homeconnection = [NSURLConnection connectionWithRequest:request delegate:self];
    if (Homeconnection)
    {
        HomeData = [[NSMutableData alloc]init];
    }
    
}

//********************************************
#pragma mark - Connection Delegate Methods
//********************************************

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection == Homeconnection)
    {
        [HomeData appendData:data];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (connection == Homeconnection)
    {
        [HomeData setLength:0];
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
    if (connection == Homeconnection)
    {
        NSMutableString *responceversionStr = [[NSMutableString alloc]initWithBytes:[HomeData mutableBytes] length:[HomeData length] encoding:NSUTF8StringEncoding];
        NSMutableDictionary *gat_dic = [[NSMutableDictionary alloc]init];
        [gat_dic setDictionary:[responceversionStr JSONValue]];
        
        [HUD hide:YES];
        
        NSLog(@"%@",gat_dic);
        
        NSString *statusSTR=[NSString stringWithFormat:@"%@",[gat_dic valueForKey:@"status"]];
        
        if([statusSTR isEqualToString:@"1"])
        {
            
            if(contrydetect==0)
            {
                [CityBTN setTitle:@"ALL" forState:UIControlStateNormal];
            }
            else if (contrydetect==1)
            {
                [CityBTN setTitle:@"SINGAPORE" forState:UIControlStateNormal];
            }
            else
            {
                [CityBTN setTitle:@"THAILAND" forState:UIControlStateNormal];
            }

            CityBTN.userInteractionEnabled=YES;
            ARYclublist=[[NSMutableArray alloc]init];
            ARYeventlist=[[NSMutableArray alloc]init];
            ARYpromotionlist=[[NSMutableArray alloc]init];
            ARYclublist=[gat_dic valueForKey:@"featuerd_club_list"];
            ARYeventlist=[gat_dic valueForKey:@"featuerd_event_list"];
            ARYpromotionlist=[gat_dic valueForKey:@"featuerd_promotion_list"];
            
            int ntfc=[[NSString stringWithFormat:@"%@",[gat_dic valueForKey:@"unread_counter"]] intValue];
            [[NSUserDefaults standardUserDefaults]setInteger:ntfc forKey:@"WoofrNotifycounter"];
            
            if([NSString stringWithFormat:@"%@",ARYclublist].length>5)
            {
                [clubSCR.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                [self ReloadCLubSCRL];
            }
            else
            {
                [clubSCR.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                
                UIImageView *waterIMG=[[UIImageView alloc]init];
                waterIMG.frame=WfC;
                waterIMG.image=[UIImage imageNamed:@"ic_watermark.png"];
                clubSCR.contentSize=CGSizeMake(0, 0);
                [clubSCR addSubview:waterIMG];
                
            }
            if([NSString stringWithFormat:@"%@",ARYeventlist].length>5)
            {
                [eventSCR.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                [self ReloadEventSCRL];
            }
            else
            {
                [eventSCR.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                
                UIImageView *waterIMG=[[UIImageView alloc]init];
                waterIMG.frame=WfE;
                waterIMG.image=[UIImage imageNamed:@"ic_watermark.png"];
                eventSCR.contentSize=CGSizeMake(0, 0);
                [eventSCR addSubview:waterIMG];
            }
            if([NSString stringWithFormat:@"%@",ARYpromotionlist].length>5)
            {
                [pramotionSCR.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                [self ReloadPramotionSCRL];
            }
            else
            {
                [pramotionSCR.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                
                UIImageView *waterIMG=[[UIImageView alloc]init];
                waterIMG.frame=WfP;
                waterIMG.image=[UIImage imageNamed:@"ic_watermark.png"];
                pramotionSCR.contentSize=CGSizeMake(0, 0);
                [pramotionSCR addSubview:waterIMG];
            }
            
            
        }
        else
        {
            [clubSCR.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [eventSCR.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [pramotionSCR.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            
            UIImageView *waterIMG1=[[UIImageView alloc]init];
            waterIMG1.frame=WfC;
            waterIMG1.image=[UIImage imageNamed:@"ic_watermark.png"];
            [clubSCR addSubview:waterIMG1];
            UIImageView *waterIMG2=[[UIImageView alloc]init];
            waterIMG2.frame=WfE;
            waterIMG2.image=[UIImage imageNamed:@"ic_watermark.png"];
            [eventSCR addSubview:waterIMG2];
            UIImageView *waterIMG3=[[UIImageView alloc]init];
            waterIMG3.frame=WfP;
            waterIMG3.image=[UIImage imageNamed:@"ic_watermark.png"];
            [pramotionSCR addSubview:waterIMG3];
            
            UIAlertView *connectionAlert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"%@",[gat_dic valueForKey:@"message"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [connectionAlert show];
        }
    }
}

-(void)ReloadCLubSCRL
{
    for(int i=0;i<ARYclublist.count;i++)
    {
        UIImageView *ClubIMG=[[UIImageView alloc]initWithFrame:CGRectMake(clubSCR.frame.size.width*i, 0, clubSCR.frame.size.width, clubSCR.frame.size.height)];
        ClubIMG.userInteractionEnabled=YES;
        ClubIMG.backgroundColor=[UIColor clearColor];
        
        NSURL *urllinksTR= [NSURL URLWithString:[[NSString stringWithFormat:@"%@",[[[[ARYclublist objectAtIndex:i] valueForKey:@"club_images"] objectAtIndex:0] valueForKey:@"filename"]]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        
        
        AsyncImageView *beerImage = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, ClubIMG.frame.size.width, ClubIMG.frame.size.height)];
        [beerImage loadImageFromURL:urllinksTR imageName:@""];
        [ClubIMG addSubview:beerImage];
        
        
        UIImageView *blackTIMG=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ClubIMG.frame.size.width, ClubIMG.frame.size.height)];
        blackTIMG.backgroundColor=[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.0];
        blackTIMG.userInteractionEnabled=YES;
        
        
        UIButton *ClubdetailBTN=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, blackTIMG.frame.size.width, blackTIMG.frame.size.height)];
        [ClubdetailBTN addTarget:self action:@selector(ClubDetailBTNclick:) forControlEvents:UIControlEventTouchUpInside];
        ClubdetailBTN.tag=3000+i;
        
        
        
        UILabel *NameLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, blackTIMG.frame.size.width-85, 40)];
        NameLBL.font=[UIFont boldSystemFontOfSize:15.0];
        NameLBL.text=[NSString stringWithFormat:@"%@",[[ARYclublist objectAtIndex:i]valueForKey:@"club_name" ]];
        NameLBL.numberOfLines=2;
        NameLBL.textColor=[UIColor whiteColor];
        [blackTIMG addSubview:NameLBL];
        
//        UIButton *CBOOkNowBTN = [[UIButton alloc]initWithFrame:CGRectMake(NameLBL.frame.size.width-50, blackTIMG.frame.size.height-30, 60, 20)];
//        //[CBOOkNowBTN setBackgroundImage:[UIImage imageNamed:@"btn_small_login_general.png"] forState:UIControlStateNormal];
//        [CBOOkNowBTN setTitle:@"BOOK NOW" forState:UIControlStateNormal];
//        CBOOkNowBTN.tag=2000+i;
//        [CBOOkNowBTN addTarget:self action:@selector(CBookNowBTNclick:) forControlEvents:UIControlEventTouchUpInside];
//        [CBOOkNowBTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [CBOOkNowBTN setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.5]];
//        
//        CBOOkNowBTN.titleLabel.font=[UIFont systemFontOfSize:9.0];
//        CBOOkNowBTN.layer.borderColor=[UIColor whiteColor].CGColor;
//        CBOOkNowBTN.layer.borderWidth=0.5;
        
        
        
        
        [NameLBL sizeToFit];
        
        
        NSString *TagSTR=[NSString stringWithFormat:@"%@",[[ARYclublist objectAtIndex:i]valueForKey:@"tag"]];
        
        if(TagSTR.length>2)
        {
            NSArray *timeArray = [TagSTR componentsSeparatedByString:@","];
            
            UIScrollView *SCRL=[[UIScrollView alloc]initWithFrame:CGRectMake(10, blackTIMG.frame.size.height-35, blackTIMG.frame.size.width-20, 15)];
            
            float TagLBLWidth=0;
            
            for(int i=0; i<timeArray.count;i++)
            {
                UILabel *tagLBL=[[UILabel alloc]initWithFrame:CGRectMake(TagLBLWidth, 0, 5000, 15)];
                tagLBL.text=[NSString stringWithFormat:@"  %@  ",[timeArray objectAtIndex:i]];
                tagLBL.backgroundColor=[UIColor colorWithRed:33.0/255.0 green:31.0/255.0 blue:33.0/255.0 alpha:1.0];
//                tagLBL.layer.borderColor=[UIColor colorWithRed:156.0/255.0 green:131.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
//                tagLBL.layer.borderWidth=1.0;
                tagLBL.layer.borderColor=[UIColor whiteColor].CGColor;
                tagLBL.layer.borderWidth=0.5;
                tagLBL.textColor=[UIColor whiteColor];
                tagLBL.font=[UIFont systemFontOfSize:9.0];
                
            
                [tagLBL sizeToFit];
                
                [SCRL addSubview:tagLBL];
                
                CGRect tagFRM = tagLBL.frame;
                tagFRM.size.height=15;
                tagLBL.frame=tagFRM;
                
                TagLBLWidth=TagLBLWidth+tagLBL.frame.size.width;
            }
            
            SCRL.contentSize=CGSizeMake(TagLBLWidth, 15);
            [blackTIMG addSubview:SCRL];
        }

        /*
        float Rating=[[NSString stringWithFormat:@"%@",[[ARYclublist objectAtIndex:i]valueForKey:@"rating"]] floatValue];
        float StarWidth=12;
        int FullSTR=[[NSString stringWithFormat:@"%@",[[ARYclublist objectAtIndex:i]valueForKey:@"rating"]] intValue];
        for (int m=0; m<5; m++)
        {
            UIImageView *starIMg=[[UIImageView alloc]initWithFrame:CGRectMake(StarWidth, blackTIMG.frame.size.height-30, 20, 20)];
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
            
            [blackTIMG addSubview:starIMg];
            
            StarWidth=StarWidth+20+5;
        }
         */
        
      //  UILabel *AddRessLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, blackTIMG.frame.size.height-20, blackTIMG.frame.size.width-25-(CBOOkNowBTN.frame.size.width), 15)];
         UILabel *AddRessLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, blackTIMG.frame.size.height-20, blackTIMG.frame.size.width-25, 15)];
      //  AddRessLBL.text=[NSString stringWithFormat:@"CLUBS.%@",[[ARYclublist objectAtIndex:i]valueForKey:@"address"]];
        AddRessLBL.text=[NSString stringWithFormat:@"%@",[[ARYclublist objectAtIndex:i]valueForKey:@"address"]];
        //AddRessLBL.backgroundColor=[UIColor colorWithRed:33.0/255.0 green:31.0/255.0 blue:33.0/255.0 alpha:1.0];
        //                tagLBL.layer.borderColor=[UIColor colorWithRed:156.0/255.0 green:131.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
        //                tagLBL.layer.borderWidth=1.0;
//        tagLBL.layer.borderColor=[UIColor whiteColor].CGColor;
//        tagLBL.layer.borderWidth=0.5;
        AddRessLBL.textColor=[UIColor whiteColor];
        AddRessLBL.font=[UIFont systemFontOfSize:10.0];
        [blackTIMG addSubview:AddRessLBL];
        
        [blackTIMG addSubview:ClubdetailBTN];
        //[blackTIMG addSubview:CBOOkNowBTN];
        [ClubIMG addSubview:blackTIMG];
        [clubSCR addSubview:ClubIMG];
    }
    
    clubSCR.contentSize=CGSizeMake(clubSCR.frame.size.width*ARYclublist.count, clubSCR.frame.size.height);
    
    pagecontrol.currentPage = 0;
    pagecontrol.numberOfPages = ARYclublist.count;
}
//********************************************
#pragma mark - Page Control Methods
//********************************************
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    UIScrollView *temp= (UIScrollView *)sender;
    if(temp == clubSCR)
    {
    if (!pageControlBeingUsed) {
        // Switch the indicator when more than 50% of the previous/next page is visible
        CGFloat pageWidth = clubSCR.frame.size.width;
        int page = floor((clubSCR.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        pagecontrol.currentPage = page;
//        NSString *page_str=[NSString stringWithFormat:@"%i",page];
//        NSLog(@"%@",page_str);
//        [[NSUserDefaults standardUserDefaults]setValue:page_str forKey:@"page"];
    }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    UIScrollView *temp= scrollView;
    
    if(temp == clubSCR)
    {
        pageControlBeingUsed = NO;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    UIScrollView *temp= scrollView;
    
    if(temp == clubSCR)
    {
        pageControlBeingUsed = NO;
    }
}
- (IBAction)changepage:(id)sender
{
    // Update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = clubSCR.frame.size.width * pagecontrol.currentPage;
    frame.origin.y = 0;
    frame.size = clubSCR.frame.size;
    [clubSCR scrollRectToVisible:frame animated:YES];
    
    // Keep track of when scrolls happen in response to the page control
    // value changing. If we don't do this, a noticeable "flashing" occurs
    // as the the scroll delegate will temporarily switch back the page
    // number.
    pageControlBeingUsed = YES;
}

-(void)ReloadEventSCRL
{
    
    float Imagewidth;
    Imagewidth=5.0;
    for(int i=0;i<ARYeventlist.count;i++)
    {
        UIImageView *EventIMG=[[UIImageView alloc]initWithFrame:CGRectMake(Imagewidth, 5, eventSCR.frame.size.height*0.67, eventSCR.frame.size.height-10)];
        EventIMG.userInteractionEnabled=YES;
        EventIMG.backgroundColor=[UIColor clearColor];
        
        NSURL *urllinksTR;
        NSMutableArray *aryTempImageList = [[ARYeventlist objectAtIndex:i] valueForKey:@"event_images"];
        if(aryTempImageList.count == 0){
            urllinksTR= [[NSBundle mainBundle] URLForResource:@"ic_login_logo@3x" withExtension:@".png"];
        }else{
            urllinksTR= [NSURL URLWithString:[[NSString stringWithFormat:@"%@",[[[[ARYeventlist objectAtIndex:i] valueForKey:@"event_images"] objectAtIndex:0] valueForKey:@"filename"]]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }
        
        
        
        AsyncImageView *beerImage = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, EventIMG.frame.size.width, EventIMG.frame.size.height)];
        [beerImage loadImageFromURL:urllinksTR imageName:@""];
        [EventIMG addSubview:beerImage];
        
        
        UIImageView *blackTIMG=[[UIImageView alloc]initWithFrame:CGRectMake(0, EventIMG.frame.size.height-40, EventIMG.frame.size.width, 40)];
        blackTIMG.backgroundColor=[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.8];
        blackTIMG.userInteractionEnabled=YES;
        
        
        
//        UIButton *BookNowBTN=[[UIButton alloc]initWithFrame:CGRectMake(blackTIMG.frame.size.width-50, 12, 45, 16)];
//        //[BookNowBTN setBackgroundImage:[UIImage imageNamed:@"btn_small_login_general.png"] forState:UIControlStateNormal];
//        [BookNowBTN setTitle:@"BOOK NOW" forState:UIControlStateNormal];
//        BookNowBTN.tag=1000+i;
//        [BookNowBTN addTarget:self action:@selector(EBookNowBTNclick:) forControlEvents:UIControlEventTouchUpInside];
//        [BookNowBTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        BookNowBTN.titleLabel.font=[UIFont systemFontOfSize:7.0];
//        [BookNowBTN setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.5]];
//    
//        BookNowBTN.layer.borderColor=[UIColor whiteColor].CGColor;
//        BookNowBTN.layer.borderWidth=0.5;
        
        
//        UILabel *NAmeLBL=[[UILabel alloc]initWithFrame:CGRectMake(5,0, blackTIMG.frame.size.width-(BookNowBTN.frame.size.width+10), 15)];
        UILabel *NAmeLBL=[[UILabel alloc]initWithFrame:CGRectMake(5,0, blackTIMG.frame.size.width-10, 15)];
        NAmeLBL.text=[NSString stringWithFormat:@"%@",[[ARYeventlist objectAtIndex:i]valueForKey:@"name"]];
        NAmeLBL.font=[UIFont systemFontOfSize:13.0];
        NAmeLBL.textColor=[UIColor whiteColor];
        [blackTIMG addSubview:NAmeLBL];
        
        
        NSString *dateSTR=[NSString stringWithFormat:@"%@",[[ARYeventlist objectAtIndex:i]valueForKey:@"start_date" ]];
        
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        NSDate *yourDate = [dateFormatter dateFromString:dateSTR];
        dateFormatter.dateFormat = @"dd MMM yyyy";
        
        NSString *finalDateSTr=[dateFormatter stringFromDate:yourDate];
        
        
//        UILabel *DateLBL=[[UILabel alloc]initWithFrame:CGRectMake(5, 15, blackTIMG.frame.size.width-(BookNowBTN.frame.size.width+10), 15)];
        UILabel *DateLBL=[[UILabel alloc]initWithFrame:CGRectMake(5, 15, blackTIMG.frame.size.width-10, 15)];
        DateLBL.text=finalDateSTr;//[NSString stringWithFormat:@"%@",[[ARYeventlist objectAtIndex:i]valueForKey:@"date" ]];
        DateLBL.font=[UIFont systemFontOfSize:11.0];
        DateLBL.textColor=[UIColor whiteColor];
        [blackTIMG addSubview:DateLBL];
        
//        UILabel *clubnameLBL=[[UILabel alloc]initWithFrame:CGRectMake(5, 28, blackTIMG.frame.size.width-(BookNowBTN.frame.size.width+10), 15)];
        UILabel *clubnameLBL=[[UILabel alloc]initWithFrame:CGRectMake(5, 28, blackTIMG.frame.size.width-10, 15)];
        clubnameLBL.text=[NSString stringWithFormat:@"%@",[[ARYeventlist objectAtIndex:i]valueForKey:@"club_name" ]];
        clubnameLBL.font=[UIFont systemFontOfSize:10.0];
//        clubnameLBL.textColor=[UIColor whiteColor];
        clubnameLBL.textColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        [blackTIMG addSubview:clubnameLBL];
        
        UIButton *EventDetailBTN=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, EventIMG.frame.size.width, EventIMG.frame.size.height)];
        [EventDetailBTN addTarget:self action:@selector(EventDetailClick:) forControlEvents:UIControlEventTouchUpInside];
        EventDetailBTN.tag=i+4000;
        [EventIMG addSubview:EventDetailBTN];
        
        
        
//        [blackTIMG addSubview:BookNowBTN];
        [EventIMG addSubview:blackTIMG];
        [eventSCR addSubview:EventIMG];
        Imagewidth=Imagewidth+EventIMG.frame.size.width+5;
        
        
    }
    
    eventSCR.contentSize=CGSizeMake(Imagewidth, eventSCR.frame.size.height);
    
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
    tempDetailDict=[ARYeventlist objectAtIndex:(RbuttonTag-4000)];
    
    [[NSUserDefaults standardUserDefaults]setValue:tempDetailDict forKey:@"WoofrEventDetail"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    EventDetailVC *dealVC1 = (EventDetailVC *)[storyboard instantiateViewControllerWithIdentifier:@"EventDetailVC"];
    [self.navigationController pushViewController:dealVC1 animated:YES];
    
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
    tempDetailDict=[ARYclublist objectAtIndex:(RbuttonTag-3000)];
    
    [[NSUserDefaults standardUserDefaults]setValue:tempDetailDict forKey:@"WoofrclubDetail"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    ClubDetailVC *dealVC1 = (ClubDetailVC *)[storyboard instantiateViewControllerWithIdentifier:@"ClubDetailVC"];
    [self.navigationController pushViewController:dealVC1 animated:YES];
}

-(void)CBookNowBTNclick:(id)sender
{
    UIButton *button1 = sender;
    NSInteger RbuttonTag = button1.tag;
    
    NSLog(@"%li",RbuttonTag-2000);
    
    // 1 club
    // 2 event
    // 3 Pramotion
    // 4 desco
    
    [[NSUserDefaults standardUserDefaults]setValue:@"1" forKey:@"WooFrclubDetetct"];
    
    NSString *clubID=[NSString stringWithFormat:@"%@",[[ARYclublist objectAtIndex:RbuttonTag-2000]valueForKey:@"club_id" ]];
    
    NSMutableDictionary *tempDetailDict=[[NSMutableDictionary alloc]init];
    tempDetailDict=[ARYclublist objectAtIndex:(RbuttonTag-2000)];
    
    [[NSUserDefaults standardUserDefaults]setValue:tempDetailDict forKey:@"WoofrclubDetail"];
    
    
    [[NSUserDefaults standardUserDefaults]setValue:clubID forKey:@"bookCLUBIDWoofer"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    TableAvailibilityVC *dealVC1 = (TableAvailibilityVC *)[storyboard instantiateViewControllerWithIdentifier:@"TableAvailibilityVC"];
    [self.navigationController pushViewController:dealVC1 animated:YES];
}
- (void)EBookNowBTNclick:(id)sender
{
    UIButton *button1 = sender;
    NSInteger RbuttonTag = button1.tag;
    
    NSLog(@"%li",RbuttonTag-1000);

    
    // 1 club
    // 2 event
    // 3 Pramotion
    // 4 desco
    
    [[NSUserDefaults standardUserDefaults]setValue:@"2" forKey:@"WooFrclubDetetct"];
    
    [[NSUserDefaults standardUserDefaults]setValue:[ARYeventlist objectAtIndex:(RbuttonTag-1000)] forKey:@"EventWoofrBookDetail"];
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    BookEventAvailibilityVC *dealVC1 = (BookEventAvailibilityVC *)[storyboard instantiateViewControllerWithIdentifier:@"BookEventAvailibilityVC"];
    [self.navigationController pushViewController:dealVC1 animated:YES];

    
}

-(void)ReloadPramotionSCRL
{
//    for(int i=0;i<ARYpromotionlist.count;i++)
//    {
//        
//        UIImageView *PramotionIMG=[[UIImageView alloc]initWithFrame:CGRectMake(pramotionSCR.frame.size.width*i, 0, pramotionSCR.frame.size.width, pramotionSCR.frame.size.height)];
//        PramotionIMG.userInteractionEnabled=YES;
//        PramotionIMG.backgroundColor=[UIColor clearColor];
//        
//        NSURL *urllinksTR= [NSURL URLWithString:[[NSString stringWithFormat:@"%@",[[[[ARYpromotionlist objectAtIndex:i] valueForKey:@"event_images"] objectAtIndex:0] valueForKey:@"filename"]]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//        
//        NSLog(@"%@",urllinksTR);
//        
//        AsyncImageView *beerImage = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, PramotionIMG.frame.size.width, PramotionIMG.frame.size.height)];
//        [beerImage loadImageFromURL:urllinksTR imageName:@""];
//        [PramotionIMG addSubview:beerImage];
//        [pramotionSCR addSubview:PramotionIMG];
//    }
//    
//    pramotionSCR.contentSize=CGSizeMake(pramotionSCR.frame.size.width*ARYpromotionlist.count, pramotionSCR.frame.size.height);
    
    
    
    
    
    float Imagewidth;
    Imagewidth=5.0;
    for(int i=0;i<ARYpromotionlist.count;i++)
    {
        UIImageView *EventIMG=[[UIImageView alloc]initWithFrame:CGRectMake(Imagewidth, 5, pramotionSCR.frame.size.height*0.72, pramotionSCR.frame.size.height-10)];
        EventIMG.userInteractionEnabled=YES;
        EventIMG.backgroundColor=[UIColor clearColor];
        
        NSURL *urllinksTR= [NSURL URLWithString:[[NSString stringWithFormat:@"%@",[[[[ARYpromotionlist objectAtIndex:i] valueForKey:@"event_images"] objectAtIndex:0] valueForKey:@"filename"]]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        
        
        AsyncImageView *beerImage = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, EventIMG.frame.size.width, EventIMG.frame.size.height)];
        [beerImage loadImageFromURL:urllinksTR imageName:@""];
        [EventIMG addSubview:beerImage];
        
        
        UIImageView *blackTIMG=[[UIImageView alloc]initWithFrame:CGRectMake(0, EventIMG.frame.size.height-40, EventIMG.frame.size.width, 40)];
        blackTIMG.backgroundColor=[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.8];
        blackTIMG.userInteractionEnabled=YES;
        
        
        
//        UIButton *BookNowBTN=[[UIButton alloc]initWithFrame:CGRectMake(blackTIMG.frame.size.width-50, 12, 45, 16)];
//        //[BookNowBTN setBackgroundImage:[UIImage imageNamed:@"btn_small_login_general.png"] forState:UIControlStateNormal];
//        [BookNowBTN setTitle:@"BOOK NOW" forState:UIControlStateNormal];
//        BookNowBTN.tag=33000+i;
//        [BookNowBTN addTarget:self action:@selector(PBookNowBTNclick:) forControlEvents:UIControlEventTouchUpInside];
//        [BookNowBTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        BookNowBTN.titleLabel.font=[UIFont systemFontOfSize:7.0];
//        [BookNowBTN setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.5]];
//        
//        BookNowBTN.layer.borderColor=[UIColor whiteColor].CGColor;
//        BookNowBTN.layer.borderWidth=0.5;
        
        
//        UILabel *NAmeLBL=[[UILabel alloc]initWithFrame:CGRectMake(5,0, blackTIMG.frame.size.width-(BookNowBTN.frame.size.width+10), 15)];
               UILabel *NAmeLBL=[[UILabel alloc]initWithFrame:CGRectMake(5,0, blackTIMG.frame.size.width-10, 15)];
        NAmeLBL.text=[NSString stringWithFormat:@"%@",[[ARYpromotionlist objectAtIndex:i]valueForKey:@"name"]];
        NAmeLBL.font=[UIFont systemFontOfSize:13.0];
        NAmeLBL.textColor=[UIColor whiteColor];
        [blackTIMG addSubview:NAmeLBL];
        
        
        NSString *dateSTR=[NSString stringWithFormat:@"%@",[[ARYpromotionlist objectAtIndex:i]valueForKey:@"start_date" ]];
        
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        NSDate *yourDate = [dateFormatter dateFromString:dateSTR];
        dateFormatter.dateFormat = @"dd MMM yyyy";
        
        NSString *finalDateSTr=[dateFormatter stringFromDate:yourDate];
        
 //       UILabel *DateLBL=[[UILabel alloc]initWithFrame:CGRectMake(5, 15, blackTIMG.frame.size.width-(BookNowBTN.frame.size.width+10), 15)];
        UILabel *DateLBL=[[UILabel alloc]initWithFrame:CGRectMake(5, 15, blackTIMG.frame.size.width-10, 15)];
        DateLBL.text=finalDateSTr;//[NSString stringWithFormat:@"%@",[[ARYeventlist objectAtIndex:i]valueForKey:@"date" ]];
        DateLBL.font=[UIFont systemFontOfSize:11.0];
        DateLBL.textColor=[UIColor whiteColor];
        [blackTIMG addSubview:DateLBL];
        
//        UILabel *clubnameLBL=[[UILabel alloc]initWithFrame:CGRectMake(5, 28, blackTIMG.frame.size.width-(BookNowBTN.frame.size.width+10), 15)];
        UILabel *clubnameLBL=[[UILabel alloc]initWithFrame:CGRectMake(5, 28, blackTIMG.frame.size.width-10, 15)];
        clubnameLBL.text=[NSString stringWithFormat:@"%@",[[ARYpromotionlist objectAtIndex:i]valueForKey:@"club_name" ]];
        clubnameLBL.font=[UIFont systemFontOfSize:10.0];
 //       clubnameLBL.textColor=[UIColor whiteColor];
        clubnameLBL.textColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        [blackTIMG addSubview:clubnameLBL];
        
        UIButton *EventDetailBTN=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, EventIMG.frame.size.width, EventIMG.frame.size.height)];
        [EventDetailBTN addTarget:self action:@selector(PramotionDetailClick:) forControlEvents:UIControlEventTouchUpInside];
        EventDetailBTN.tag=i+86000;
        [EventIMG addSubview:EventDetailBTN];
        
        
        
//        [blackTIMG addSubview:BookNowBTN];
        [EventIMG addSubview:blackTIMG];
        [pramotionSCR addSubview:EventIMG];
        Imagewidth=Imagewidth+EventIMG.frame.size.width+5;
        
        
    }
    
    pramotionSCR.contentSize=CGSizeMake(Imagewidth, pramotionSCR.frame.size.height);
}
- (void)PBookNowBTNclick:(id)sender
{
    UIButton *button1 = sender;
    NSInteger RbuttonTag = button1.tag;
    
    NSLog(@"%li",RbuttonTag-33000);
    
    
    // 1 club
    // 2 event
    // 3 Pramotion
    // 4 desco
    
    [[NSUserDefaults standardUserDefaults]setValue:@"3" forKey:@"WooFrclubDetetct"];
    
    [[NSUserDefaults standardUserDefaults]setValue:[ARYpromotionlist objectAtIndex:(RbuttonTag-33000)] forKey:@"EventWoofrBookDetail"];
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    BookEventAvailibilityVC *dealVC1 = (BookEventAvailibilityVC *)[storyboard instantiateViewControllerWithIdentifier:@"BookEventAvailibilityVC"];
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
    tempDetailDict=[ARYpromotionlist objectAtIndex:(RbuttonTag-86000)];
    
    [[NSUserDefaults standardUserDefaults]setValue:tempDetailDict forKey:@"WoofrEventDetail"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    EventDetailVC *dealVC1 = (EventDetailVC *)[storyboard instantiateViewControllerWithIdentifier:@"EventDetailVC"];
    [self.navigationController pushViewController:dealVC1 animated:YES];
}

- (IBAction)SearchBTNclick:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setValue:[NSString  stringWithFormat:@"%@",CityBTN.titleLabel.text] forKey:@"WoofrExploreNightTitle"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    SearchVC *dealVC1 = (SearchVC *)[storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
    [self.navigationController pushViewController:dealVC1 animated:YES];

}

- (IBAction)ExploreBTNclick:(id)sender
{
    
    [[NSUserDefaults standardUserDefaults]setValue:[NSString  stringWithFormat:@"%@",CityBTN.titleLabel.text] forKey:@"WoofrExploreNightTitle"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ExploreNightVC"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navigationController animated:YES completion:nil];

}

- (IBAction)SMclubBTNclick:(id)sender
{
    // 1 club
    // 2 event
    // 3 Pramotion
    // 4 desco
    
    [[NSUserDefaults standardUserDefaults]setValue:@"1" forKey:@"WooFrclubDetetct"];
    
     [[NSUserDefaults standardUserDefaults]setValue:[NSString  stringWithFormat:@"%@",CityBTN.titleLabel.text] forKey:@"WoofrExploreNightTitle"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    SeeAllVC *dealVC1 = (SeeAllVC *)[storyboard instantiateViewControllerWithIdentifier:@"SeeAllVC"];
    [self.navigationController pushViewController:dealVC1 animated:YES];
}

- (IBAction)SMeventBTNclick:(id)sender
{
    // 1 club
    // 2 event
    // 3 Pramotion
    // 4 desco
    
    [[NSUserDefaults standardUserDefaults]setValue:@"2" forKey:@"WooFrclubDetetct"];
    
     [[NSUserDefaults standardUserDefaults]setValue:[NSString  stringWithFormat:@"%@",CityBTN.titleLabel.text] forKey:@"WoofrExploreNightTitle"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    SeeAllVC *dealVC1 = (SeeAllVC *)[storyboard instantiateViewControllerWithIdentifier:@"SeeAllVC"];
    [self.navigationController pushViewController:dealVC1 animated:YES];
}

- (IBAction)SMpramotionBTNclick:(id)sender
{
    // 1 club
    // 2 event
    // 3 Pramotion
    // 4 desco
    
    [[NSUserDefaults standardUserDefaults]setValue:@"3" forKey:@"WooFrclubDetetct"];
    
     [[NSUserDefaults standardUserDefaults]setValue:[NSString  stringWithFormat:@"%@",CityBTN.titleLabel.text] forKey:@"WoofrExploreNightTitle"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    SeeAllVC *dealVC1 = (SeeAllVC *)[storyboard instantiateViewControllerWithIdentifier:@"SeeAllVC"];
    [self.navigationController pushViewController:dealVC1 animated:YES];
}

/*
-(void)LoadFilterView
{

    int long cdetect;
    
    cdetect=[[NSUserDefaults standardUserDefaults]integerForKey:@"FilterCountryindexwfr"];
    
    CityBTN.userInteractionEnabled=NO;
    
    popover=[[UIView alloc]initWithFrame:self.view.frame];
    //popover.backgroundColor=[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.50];
    [self.view addSubview:popover];
    
    UIImageView *Bimgv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, popover.frame.size.width, popover.frame.size.height)];
    UIImage *Bimg=[UIImage imageNamed:@"bg_black_main.png"];
    Bimgv.image=[self blurImage:Bimg withBottomInset:Bimgv.frame.size.height blurRadius:0];
    [popover addSubview:Bimgv];
    
    
    UIView *ContVIew=[[UIView alloc]initWithFrame:CGRectMake(20, (((popover.frame.size.height)/2)-92.75), ViewWIdth-40, 185.5)];
    ContVIew.userInteractionEnabled=YES;
    
    //UIImageView
    
    float Vheight=0;
    
    UILabel *TITLELBL=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ContVIew.frame.size.width-60, 50)];
    TITLELBL.text=@"Select Your Country";
    TITLELBL.font=[UIFont boldSystemFontOfSize:16.0];
    TITLELBL.textAlignment=NSTextAlignmentCenter;
    TITLELBL.textColor=[UIColor whiteColor];
    TITLELBL.userInteractionEnabled=YES;
    TITLELBL.backgroundColor=[UIColor colorWithRed:147.0/255.0 green:129.0/255.0 blue:99.0/255.0 alpha:1.0];
    [ContVIew addSubview:TITLELBL];
    
    UIButton *DOneBTN=[[UIButton alloc]initWithFrame:CGRectMake(ContVIew.frame.size.width-60, 0, 60, 50)];
    [DOneBTN setTitle:@"Done" forState:UIControlStateNormal];
    DOneBTN.titleLabel.textColor=[UIColor whiteColor];
    [DOneBTN setBackgroundColor:[UIColor colorWithRed:147.0/255.0 green:129.0/255.0 blue:99.0/255.0 alpha:1.0]];
    [DOneBTN addTarget:self action:@selector(DoneBTNclick) forControlEvents:UIControlEventTouchUpInside];
    [ContVIew addSubview:DOneBTN];
    
    Vheight=Vheight+TITLELBL.frame.size.height;
    
    UILabel *AllLBL=[[UILabel alloc]initWithFrame:CGRectMake(0, Vheight, ContVIew.frame.size.width, 45)];
    AllLBL.text=@"  All Countries";
    AllLBL.userInteractionEnabled=YES;
    AllLBL.font=[UIFont systemFontOfSize:16.0];
    AllLBL.textColor=[UIColor whiteColor];
    AllLBL.layer.borderWidth=1.0;
    AllLBL.layer.borderColor=[UIColor colorWithRed:147.0/255.0 green:129.0/255.0 blue:99.0/255.0 alpha:1.0].CGColor;
    [ContVIew addSubview:AllLBL];
    
    
    allCIMG=[[UIImageView alloc]initWithFrame:CGRectMake(AllLBL.frame.size.width-35, Vheight+15, 25, 15)];
    if(cdetect==0)
    {
        allCIMG.image=[UIImage imageNamed:@"ic_alert_right.png"];
    }
    allCIMG.userInteractionEnabled=YES;
    [ContVIew addSubview:allCIMG];
    
    UIButton *ALLBTN=[[UIButton alloc]initWithFrame:CGRectMake(0, Vheight, ContVIew.frame.size.width, 45)];
    [ALLBTN addTarget:self action:@selector(ALLBTNclick) forControlEvents:UIControlEventTouchUpInside];
    [ContVIew addSubview:ALLBTN];
    
    Vheight=Vheight+AllLBL.frame.size.height;
    
    UILabel *SingaporeLBL=[[UILabel alloc]initWithFrame:CGRectMake(0, Vheight, ContVIew.frame.size.width, 45)];
    SingaporeLBL.text=@"  Singapore, SG";
    SingaporeLBL.userInteractionEnabled=YES;
    SingaporeLBL.font=[UIFont systemFontOfSize:16.0];
    SingaporeLBL.textColor=[UIColor whiteColor];
    SingaporeLBL.layer.borderWidth=1.0;
    SingaporeLBL.layer.borderColor=[UIColor colorWithRed:147.0/255.0 green:129.0/255.0 blue:99.0/255.0 alpha:1.0].CGColor;
    [ContVIew addSubview:SingaporeLBL];
    
    
    singaporimg=[[UIImageView alloc]initWithFrame:CGRectMake(AllLBL.frame.size.width-35, Vheight+15, 25, 15)];
    if(cdetect==1)
    {
        singaporimg.image=[UIImage imageNamed:@"ic_alert_right.png"];
    }
    singaporimg.userInteractionEnabled=YES;
    [ContVIew addSubview:singaporimg];
    
    UIButton *singaBTN=[[UIButton alloc]initWithFrame:CGRectMake(0, Vheight, ContVIew.frame.size.width, 45)];
    [singaBTN addTarget:self action:@selector(singaBTNclick) forControlEvents:UIControlEventTouchUpInside];
    [ContVIew addSubview:singaBTN];
    
    
    Vheight=Vheight+SingaporeLBL.frame.size.height;
    
    UILabel *thaiLBL=[[UILabel alloc]initWithFrame:CGRectMake(0, Vheight, ContVIew.frame.size.width, 45)];
    thaiLBL.text=@"  Thailand, TH";
    thaiLBL.userInteractionEnabled=YES;
    thaiLBL.font=[UIFont systemFontOfSize:16.0];
    thaiLBL.textColor=[UIColor whiteColor];
    thaiLBL.layer.borderWidth=1.0;
    thaiLBL.layer.borderColor=[UIColor colorWithRed:147.0/255.0 green:129.0/255.0 blue:99.0/255.0 alpha:1.0].CGColor;
    [ContVIew addSubview:thaiLBL];
    
    
    thailandimg=[[UIImageView alloc]initWithFrame:CGRectMake(AllLBL.frame.size.width-35, Vheight+15, 25, 15)];
    if(cdetect==2)
    {
        thailandimg.image=[UIImage imageNamed:@"ic_alert_right.png"];
    }
    thailandimg.userInteractionEnabled=YES;
    [ContVIew addSubview:thailandimg];
    
    UIButton *thaiBTN=[[UIButton alloc]initWithFrame:CGRectMake(0, Vheight, ContVIew.frame.size.width, 45)];
    [thaiBTN addTarget:self action:@selector(thaiBTNclick) forControlEvents:UIControlEventTouchUpInside];
    [ContVIew addSubview:thaiBTN];

    
    
    Vheight=Vheight+thaiLBL.frame.size.height;
    
    UIImageView *lineimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, Vheight, ContVIew.frame.size.width, 0.5)];
    lineimage.backgroundColor=[UIColor colorWithRed:147.0/255.0 green:129.0/255.0 blue:99.0/255.0 alpha:1.0];
    [ContVIew addSubview:lineimage];
    
    ContVIew.layer.cornerRadius=8.0;
    ContVIew.clipsToBounds=YES;
    ContVIew.layer.borderWidth=1.0;
    ContVIew.layer.borderColor=[UIColor colorWithRed:147.0/255.0 green:129.0/255.0 blue:99.0/255.0 alpha:1.0].CGColor;
    [popover addSubview:ContVIew];
    
    
    
    
//    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
//        self.view.backgroundColor = [UIColor clearColor];
//        
//        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//        blurEffectView.frame = self.view.bounds;
//        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        
//        [self.view addSubview:blurEffectView];
//    }
//    else {
//        self.view.backgroundColor = [UIColor blackColor];
//    }
    
}
*/
-(void)LoadFilterView1
{
    
    int long cdetect;
    
    cdetect=[[NSUserDefaults standardUserDefaults]integerForKey:@"FilterCountryindexwfr"];
    
    CityBTN.userInteractionEnabled=NO;
    
    popover=[[UIView alloc]initWithFrame:self.view.frame];
    //popover.backgroundColor=[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.50];
    [self.view addSubview:popover];
    
    UIImageView *Bimgv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, popover.frame.size.width, popover.frame.size.height)];
    UIImage *Bimg=[UIImage imageNamed:@"bg_black_main.png"];
    Bimgv.image=Bimg;//[self blurImage:Bimg withBottomInset:Bimgv.frame.size.height blurRadius:0];
    [popover addSubview:Bimgv];
    
    
    UIView *ContVIew=[[UIView alloc]initWithFrame:CGRectMake(20, (((popover.frame.size.height)/2)-100), ViewWIdth-40, 200)];
    ContVIew.userInteractionEnabled=YES;
    
    UIImageView *backGGimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ContVIew.frame.size.width, ContVIew.frame.size.height)];
    backGGimage.image=[UIImage  imageNamed:@"Popupback.png"];
    [ContVIew addSubview:backGGimage];
    
    //UIImageView
    
    float Vheight=0;
    
    UILabel *TITLELBL=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, ContVIew.frame.size.width, 40)];
    TITLELBL.text=[NSString stringWithFormat:@"%@",CityBTN.titleLabel.text];
    TITLELBL.font=[UIFont fontWithName:@"ProximaNova-Bold" size:18.0];
    TITLELBL.textAlignment=NSTextAlignmentCenter;
    TITLELBL.textColor=[UIColor whiteColor];
    TITLELBL.userInteractionEnabled=YES;
    //TITLELBL.backgroundColor=[UIColor colorWithRed:147.0/255.0 green:129.0/255.0 blue:99.0/255.0 alpha:1.0];
    [ContVIew addSubview:TITLELBL];
    
    UILabel *seleLBL=[[UILabel alloc]initWithFrame:CGRectMake(0, 55, ContVIew.frame.size.width, 21)];
    seleLBL.text=@"Select your country";
    seleLBL.font=[UIFont fontWithName:@"ProximaNova-Semibold" size:16.0];
    seleLBL.textAlignment=NSTextAlignmentCenter;
    seleLBL.textColor=[UIColor whiteColor];
    seleLBL.userInteractionEnabled=YES;
    //TITLELBL.backgroundColor=[UIColor colorWithRed:147.0/255.0 green:129.0/255.0 blue:99.0/255.0 alpha:1.0];
    [ContVIew addSubview:seleLBL];
    
    UIButton *DOneBTN=[[UIButton alloc]initWithFrame:CGRectMake(ContVIew.frame.size.width-60, 0, 60, 50)];
    [DOneBTN setTitle:@"Done" forState:UIControlStateNormal];
    DOneBTN.titleLabel.textColor=[UIColor whiteColor];
    //[DOneBTN setBackgroundColor:[UIColor colorWithRed:147.0/255.0 green:129.0/255.0 blue:99.0/255.0 alpha:1.0]];
    [DOneBTN addTarget:self action:@selector(DoneBTNclick) forControlEvents:UIControlEventTouchUpInside];
    [ContVIew addSubview:DOneBTN];
    
    UIImageView *closeIMG=[[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 20, 20)];
    closeIMG.image=[UIImage imageNamed:@"ic_header_close.png"];
    closeIMG.userInteractionEnabled=YES;
    [ContVIew addSubview:closeIMG];
    
    UIButton *closepop=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    [closepop addTarget:self action:@selector(closepopBTNclick) forControlEvents:UIControlEventTouchUpInside];
    [ContVIew addSubview:closepop];
    
    Vheight=Vheight+110;
    
//    UILabel *AllLBL=[[UILabel alloc]initWithFrame:CGRectMake(0, Vheight, ContVIew.frame.size.width, 45)];
//    AllLBL.text=@"  All Countries";
//    AllLBL.userInteractionEnabled=YES;
//    AllLBL.font=[UIFont systemFontOfSize:16.0];
//    AllLBL.textColor=[UIColor whiteColor];
//    AllLBL.layer.borderWidth=1.0;
//    AllLBL.layer.borderColor=[UIColor colorWithRed:147.0/255.0 green:129.0/255.0 blue:99.0/255.0 alpha:1.0].CGColor;
//    [ContVIew addSubview:AllLBL];
//    
//    
//    allCIMG=[[UIImageView alloc]initWithFrame:CGRectMake(AllLBL.frame.size.width-35, Vheight+15, 25, 15)];
//    if(cdetect==0)
//    {
//        allCIMG.image=[UIImage imageNamed:@"ic_alert_right.png"];
//    }
//    allCIMG.userInteractionEnabled=YES;
//    [ContVIew addSubview:allCIMG];
//    
//    UIButton *ALLBTN=[[UIButton alloc]initWithFrame:CGRectMake(0, Vheight, ContVIew.frame.size.width, 45)];
//    [ALLBTN addTarget:self action:@selector(ALLBTNclick) forControlEvents:UIControlEventTouchUpInside];
//    [ContVIew addSubview:ALLBTN];
    
   // Vheight=Vheight+AllLBL.frame.size.height;
    
    UILabel *SingaporeLBL=[[UILabel alloc]initWithFrame:CGRectMake(0, Vheight, ContVIew.frame.size.width, 45)];
    SingaporeLBL.text=@"  Singapore, SG";
    SingaporeLBL.userInteractionEnabled=YES;
    SingaporeLBL.font=[UIFont systemFontOfSize:16.0];
    SingaporeLBL.textColor=[UIColor whiteColor];
//    SingaporeLBL.layer.borderWidth=1.0;
//    SingaporeLBL.layer.borderColor=[UIColor colorWithRed:147.0/255.0 green:129.0/255.0 blue:99.0/255.0 alpha:1.0].CGColor;
    UIImageView *l1img=[[UIImageView alloc]initWithFrame:CGRectMake(0, Vheight+44, ContVIew.frame.size.width, 1)];
    l1img.backgroundColor=[UIColor colorWithRed:147.0/255.0 green:129.0/255.0 blue:99.0/255.0 alpha:1.0];
    [ContVIew addSubview:SingaporeLBL];
    [ContVIew addSubview:l1img];

    
    
    singaporimg=[[UIImageView alloc]initWithFrame:CGRectMake(SingaporeLBL.frame.size.width-35, Vheight+15, 25, 15)];
    if(cdetect==1)
    {
        singaporimg.image=[UIImage imageNamed:@"ic_alert_right.png"];
    }
    singaporimg.userInteractionEnabled=YES;
    [ContVIew addSubview:singaporimg];
    
    UIButton *singaBTN=[[UIButton alloc]initWithFrame:CGRectMake(0, Vheight, ContVIew.frame.size.width, 45)];
    [singaBTN addTarget:self action:@selector(singaBTNclick) forControlEvents:UIControlEventTouchUpInside];
    [ContVIew addSubview:singaBTN];
    
    
    Vheight=Vheight+SingaporeLBL.frame.size.height;
    
    UILabel *thaiLBL=[[UILabel alloc]initWithFrame:CGRectMake(0, Vheight, ContVIew.frame.size.width, 45)];
    thaiLBL.text=@"  Thailand, TH";
    thaiLBL.userInteractionEnabled=YES;
    thaiLBL.font=[UIFont systemFontOfSize:16.0];
    thaiLBL.textColor=[UIColor whiteColor];
//    thaiLBL.layer.borderWidth=1.0;
//    thaiLBL.layer.borderColor=[UIColor colorWithRed:147.0/255.0 green:129.0/255.0 blue:99.0/255.0 alpha:1.0].CGColor;
    UIImageView *l2img=[[UIImageView alloc]initWithFrame:CGRectMake(0, Vheight+44, ContVIew.frame.size.width, 1)];
    l2img.backgroundColor=[UIColor colorWithRed:147.0/255.0 green:129.0/255.0 blue:99.0/255.0 alpha:1.0];
    [ContVIew addSubview:thaiLBL];
    [ContVIew addSubview:l2img];
    
    
    
    thailandimg=[[UIImageView alloc]initWithFrame:CGRectMake(SingaporeLBL.frame.size.width-35, Vheight+15, 25, 15)];
    if(cdetect==2)
    {
        thailandimg.image=[UIImage imageNamed:@"ic_alert_right.png"];
    }
    thailandimg.userInteractionEnabled=YES;
    [ContVIew addSubview:thailandimg];
    
    UIButton *thaiBTN=[[UIButton alloc]initWithFrame:CGRectMake(0, Vheight, ContVIew.frame.size.width, 45)];
    [thaiBTN addTarget:self action:@selector(thaiBTNclick) forControlEvents:UIControlEventTouchUpInside];
    [ContVIew addSubview:thaiBTN];
    
    
    
    Vheight=Vheight+thaiLBL.frame.size.height;
    
//    UIImageView *lineimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, Vheight, ContVIew.frame.size.width, 0.5)];
//    lineimage.backgroundColor=[UIColor colorWithRed:147.0/255.0 green:129.0/255.0 blue:99.0/255.0 alpha:1.0];
//    [ContVIew addSubview:lineimage];
    
//    ContVIew.layer.cornerRadius=8.0;
//    ContVIew.clipsToBounds=YES;
//    ContVIew.layer.borderWidth=1.0;
//    ContVIew.layer.borderColor=[UIColor colorWithRed:147.0/255.0 green:129.0/255.0 blue:99.0/255.0 alpha:1.0].CGColor;
    [popover addSubview:ContVIew];
    
    
    
    
    //    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
    //        self.view.backgroundColor = [UIColor clearColor];
    //
    //        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    //        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    //        blurEffectView.frame = self.view.bounds;
    //        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //
    //        [self.view addSubview:blurEffectView];
    //    }
    //    else {
    //        self.view.backgroundColor = [UIColor blackColor];
    //    }
    
}
-(void)closepopBTNclick
{
    CityBTN.userInteractionEnabled=YES;
    [popover removeFromSuperview];
}
-(void)DoneBTNclick
{
    [[NSUserDefaults standardUserDefaults]setInteger:contrydetect forKey:@"FilterCountryindexwfr"];
    
    [popover removeFromSuperview];

    [self callAPIHOME];
}
-(void)ALLBTNclick
{
    allCIMG.image=[UIImage imageNamed:@"ic_alert_right.png"];
    singaporimg.image=[UIImage imageNamed:@""];
    thailandimg.image=[UIImage imageNamed:@""];
    
    contrydetect=0;
}
-(void)singaBTNclick
{
    allCIMG.image=[UIImage imageNamed:@""];
    singaporimg.image=[UIImage imageNamed:@"ic_alert_right.png"];
    thailandimg.image=[UIImage imageNamed:@""];
    
    contrydetect=1;
}
-(void)thaiBTNclick
{
    allCIMG.image=[UIImage imageNamed:@""];
    singaporimg.image=[UIImage imageNamed:@""];
    thailandimg.image=[UIImage imageNamed:@"ic_alert_right.png"];
    
    contrydetect=2;
}
- (UIImage*)blurImage:(UIImage*)image withBottomInset:(CGFloat)inset blurRadius:(CGFloat)radius{
    
   // image =  [UIImage imageWithCGImage: CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, image.size.height - inset, image.size.width,inset))];
    
    CIImage *ciImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    //[filter setValue:@(radius) forKey:kCIInputRadiusKey];
    
    CIImage *outputCIImage = filter.outputImage;
    CIContext *context = [CIContext contextWithOptions:nil];
    
    return [UIImage imageWithCGImage: [context createCGImage:outputCIImage fromRect:ciImage.extent]];
    
}
@end
