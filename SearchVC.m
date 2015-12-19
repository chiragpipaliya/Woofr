//
//  SearchVC.m
//  WOOFR
//
//  Created by Hemal Kachhadiya on 12/12/15.
//  Copyright (c) 2015 dipen. All rights reserved.
//

#import "SearchVC.h"

@interface SearchVC ()
{
    NSString *titleSTR;
    
    NSMutableArray *ClubSearchRARY,*EventSearchRARY;
}

@end

@implementation SearchVC

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
    
    
    HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUD];
    [self.view bringSubviewToFront:HUD];
    [HUD setDelegate:self];
    [HUD setLabelText:@"Loading...."];
    
    titleSTR=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"WoofrExploreNightTitle"]];
    
    self.title=titleSTR;
    
}

-(void)SearchAPIcall
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
    
    
    [sendData setObject:@"search" forKey:@"action"];
    [sendData setObject:titleSTR forKey:@"city"];
    [sendData setObject:[NSString stringWithFormat:@"%@",SearchBAR.text] forKey:@"keyword"];
    
    
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
    
    Searchconnection = [NSURLConnection connectionWithRequest:request delegate:self];
    if (Searchconnection)
    {
        SearchData = [[NSMutableData alloc]init];
    }
    
    
}
//********************************************
#pragma mark - Connection Delegate Methods
//********************************************

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection == Searchconnection)
    {
        [SearchData appendData:data];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (connection == Searchconnection)
    {
        [SearchData setLength:0];
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
    if (connection == Searchconnection)
    {
        NSMutableString *responceversionStr = [[NSMutableString alloc]initWithBytes:[SearchData mutableBytes] length:[SearchData length] encoding:NSUTF8StringEncoding];
        NSMutableDictionary *gat_dic = [[NSMutableDictionary alloc]init];
        [gat_dic setDictionary:[responceversionStr JSONValue]];
        
        [HUD hide:YES];
        
        NSLog(@"%@",gat_dic);
        
        
        if([[gat_dic valueForKey:@"status"] isEqualToString:@"1"])
        {
            
            ClubSearchRARY=[[NSMutableArray alloc]init];
            EventSearchRARY=[[NSMutableArray alloc]init];
            
            
            ClubSearchRARY=[gat_dic valueForKey:@"club_search"];
            EventSearchRARY=[gat_dic valueForKey:@"event_search"];
            
            if([NSString stringWithFormat:@"%@",ClubSearchRARY].length>5 || [NSString stringWithFormat:@"%@",EventSearchRARY].length>5)
            {
                [SearchSCRL.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                
                [self UPdateSCRL];
            }
            else
            {
                [SearchSCRL.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            }
        }
        
    }
}



- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [SearchBAR resignFirstResponder];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if(SearchBAR.text.length>0)
    {
        [SearchBAR resignFirstResponder];
        [self SearchAPIcall];
    }
    else
    {
        [SearchBAR resignFirstResponder];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






-(void)UPdateSCRL
{
    float SCRLHEight;
    
    SCRLHEight=0;
    
    if([NSString stringWithFormat:@"%@",ClubSearchRARY].length>5)
    {
        UILabel *CLubLBL=[[UILabel alloc]initWithFrame:CGRectMake(0, SCRLHEight, ViewWIdth, 30)];
        CLubLBL.text=[NSString stringWithFormat:@"  %@ CLUBS",titleSTR];
        CLubLBL.font=[UIFont boldSystemFontOfSize:16.0];
        CLubLBL.textColor=[UIColor whiteColor];
        CLubLBL.backgroundColor=[UIColor colorWithRed:167.0/255.0 green:149.0/255.0 blue:101.0/255.0 alpha:1.0];
        [SearchSCRL addSubview:CLubLBL];
        
        SCRLHEight=SCRLHEight+CLubLBL.frame.size.height;
        
        for(int i=0;i<ClubSearchRARY.count;i++)
        {
            SCRLHEight=SCRLHEight+8;
            
            float BPoint;
            BPoint=SCRLHEight-8;
            
            
            UILabel *CnameLBL=[[UILabel alloc]initWithFrame:CGRectMake(8, SCRLHEight, ViewWIdth-16, 5000)];
            CnameLBL.text=[NSString stringWithFormat:@"%@",[[ClubSearchRARY objectAtIndex:i]valueForKey:@"club_name"]];
            CnameLBL.font=[UIFont boldSystemFontOfSize:16.0];
            CnameLBL.textColor=[UIColor whiteColor];
            CnameLBL.numberOfLines=10;
            [CnameLBL sizeToFit];
            
            [SearchSCRL addSubview:CnameLBL];
            
            SCRLHEight=SCRLHEight+CnameLBL.frame.size.height+3;
            
            
            UILabel *CaddressLBL=[[UILabel alloc]initWithFrame:CGRectMake(8, SCRLHEight, ViewWIdth-16, 5000)];
            CaddressLBL.text=[NSString stringWithFormat:@"CLUBS . %@",[[ClubSearchRARY objectAtIndex:i]valueForKey:@"address"]];
            CaddressLBL.font=[UIFont systemFontOfSize:13.0];
            CaddressLBL.textColor=[UIColor whiteColor];
            CaddressLBL.numberOfLines=50;
            [CaddressLBL sizeToFit];
            
            [SearchSCRL addSubview:CaddressLBL];
            
            SCRLHEight=SCRLHEight+8+CaddressLBL.frame.size.height;
            
            UIButton *CLbBTN=[[UIButton alloc]initWithFrame:CGRectMake(0, BPoint, ViewWIdth, SCRLHEight-BPoint)];
            [CLbBTN addTarget:self action:@selector(CLbBTNclick:) forControlEvents:UIControlEventTouchUpInside];
            CLbBTN.tag=i+5000;
            [SearchSCRL addSubview:CLbBTN];
            
            
            UIImageView *lineimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, SCRLHEight, ViewWIdth, 1)];
            lineimage.backgroundColor=[UIColor colorWithRed:167.0/255.0 green:149.0/255.0 blue:101.0/255.0 alpha:1.0];
            [SearchSCRL addSubview:lineimage];
            
            SCRLHEight=SCRLHEight+1;
            
        }
        
    }
    
    
    
    if([NSString stringWithFormat:@"%@",EventSearchRARY].length>5)
    {
        UILabel *EventLBL=[[UILabel alloc]initWithFrame:CGRectMake(0, SCRLHEight, ViewWIdth, 30)];
        EventLBL.text=[NSString stringWithFormat:@"  %@ EVENTS",titleSTR];
        EventLBL.font=[UIFont boldSystemFontOfSize:16.0];
        EventLBL.textColor=[UIColor whiteColor];
        EventLBL.backgroundColor=[UIColor colorWithRed:167.0/255.0 green:149.0/255.0 blue:101.0/255.0 alpha:1.0];
        [SearchSCRL addSubview:EventLBL];
        
        SCRLHEight=SCRLHEight+EventLBL.frame.size.height;
        
        for(int i=0;i<EventSearchRARY.count;i++)
        {
            SCRLHEight=SCRLHEight+8;
            
            float Epoint;
            Epoint=SCRLHEight-8;
            
            UILabel *EnameLBL=[[UILabel alloc]initWithFrame:CGRectMake(8, SCRLHEight, ViewWIdth-16, 5000)];
            EnameLBL.text=[NSString stringWithFormat:@"%@",[[EventSearchRARY objectAtIndex:i]valueForKey:@"name"]];
            EnameLBL.font=[UIFont boldSystemFontOfSize:16.0];
            EnameLBL.textColor=[UIColor whiteColor];
            EnameLBL.numberOfLines=10;
            [EnameLBL sizeToFit];
            
            [SearchSCRL addSubview:EnameLBL];
            
            SCRLHEight=SCRLHEight+EnameLBL.frame.size.height+3;
            
            NSString *dateSTR=[NSString stringWithFormat:@"%@",[[EventSearchRARY objectAtIndex:i]valueForKey:@"date" ]];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            
            NSDate *fdate=[dateFormatter dateFromString:dateSTR];
            [dateFormatter setDateFormat:@"dd/MM/yy"];
            
            NSString *ffdatestr=[dateFormatter stringFromDate:fdate];
            
            UILabel *EaddressLBL=[[UILabel alloc]initWithFrame:CGRectMake(8, SCRLHEight, ViewWIdth-16, 5000)];
            EaddressLBL.text=[NSString stringWithFormat:@"%@ . %@",ffdatestr,[[EventSearchRARY objectAtIndex:i]valueForKey:@"club_name"]];
            EaddressLBL.font=[UIFont systemFontOfSize:13.0];
            EaddressLBL.textColor=[UIColor whiteColor];
            EaddressLBL.numberOfLines=50;
            [EaddressLBL sizeToFit];
            
            [SearchSCRL addSubview:EaddressLBL];
            
            SCRLHEight=SCRLHEight+8+EaddressLBL.frame.size.height;
            
            UIButton *EVNTBTN=[[UIButton alloc]initWithFrame:CGRectMake(0, Epoint, ViewWIdth, SCRLHEight-Epoint)];
            [EVNTBTN addTarget:self action:@selector(EVNTBTNclick:) forControlEvents:UIControlEventTouchUpInside];
            EVNTBTN.tag=i+50000;
            [SearchSCRL addSubview:EVNTBTN];
            
            UIImageView *lineimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, SCRLHEight, ViewWIdth, 1)];
            lineimage.backgroundColor=[UIColor colorWithRed:167.0/255.0 green:149.0/255.0 blue:101.0/255.0 alpha:1.0];
            [SearchSCRL addSubview:lineimage];
            
            SCRLHEight=SCRLHEight+1;
            
        }
        
    }
    
    SearchSCRL.contentSize=CGSizeMake(ViewWIdth, SCRLHEight);
    
}



-(void)CLbBTNclick:(id)sender
{
    UIButton *button1 = sender;
    NSInteger RbuttonTag = button1.tag;
    
    NSLog(@"%li",RbuttonTag-5000);
}
-(void)EVNTBTNclick:(id)sender
{
    UIButton *button1 = sender;
    NSInteger RbuttonTag = button1.tag;
    
    NSLog(@"%li",RbuttonTag-50000);
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
