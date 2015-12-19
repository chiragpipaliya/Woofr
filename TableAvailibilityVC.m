//
//  TableAvailibilityVC.m
//  WOOFR
//
//  Created by dipen  narola on 05/12/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import "TableAvailibilityVC.h"
#import "FoodDetailVC.h"

@interface TableAvailibilityVC ()
{
    NSMutableArray *dateARY,*timeARY,*tableARY;
    
    int long selecteddate,selecttime;
    
    NSString *clubIdSTR;
    
    NSMutableArray *VIPTBLARY,*NRMLTBLARY;
    
    NSMutableDictionary *gat_dic_value;
    
    NSMutableDictionary *TempDictTable;
    
    BOOL Is_select;
}

@end

@implementation TableAvailibilityVC

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
    
    
    self.title=@"BOOK NOW";
    
    clubIdSTR=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"bookCLUBIDWoofer"]];
    
    
    
    HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUD];
    [self.view bringSubviewToFront:HUD];
    [HUD setDelegate:self];
    [HUD setLabelText:@"Loading...."];
    
    
    dateARY=[[NSMutableArray alloc]init];
    
    for(int i=0;i<8;i++)
    {
        NSMutableDictionary *recordDict=[[NSMutableDictionary alloc]init];
        
        NSDate *tomorrow = [NSDate dateWithTimeInterval:(24*60*60*i) sinceDate:[NSDate date]];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSString *dateSTR = [dateFormatter stringFromDate:tomorrow];
        [recordDict setValue:dateSTR forKey:@"FullDate"];
        
        
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:tomorrow];
        
        NSInteger weekday = [components weekday];
        NSString *weekdayName = [dateFormatter weekdaySymbols][weekday - 1];
        [recordDict setValue:weekdayName forKey:@"WeekDay"];
        
        [dateFormatter setDateFormat:@"dd/MM"];
        
        NSString *halfDateSTR=[dateFormatter stringFromDate:tomorrow];
        [recordDict setValue:halfDateSTR forKey:@"halfDate"];
        
        [dateARY addObject:recordDict];
    }
    
    Is_select=NO;
    
    [self DateScrlLoad];
}
//********************************************
#pragma mark - Date Section Methods
//********************************************
-(void)DateScrlLoad
{
    float width;
    
    width=8;
    
    for (int i=0;i<dateARY.count;i++)
    {
        UILabel *dateLBL=[[UILabel alloc]initWithFrame:CGRectMake(width, 0, 500, 50)];
        dateLBL.text=[NSString stringWithFormat:@" %@ \n %@ ",[[dateARY objectAtIndex:i]valueForKey:@"WeekDay" ],[[dateARY objectAtIndex:i]valueForKey:@"halfDate" ]];
        dateLBL.numberOfLines=2;
        dateLBL.tag=500+i;
        dateLBL.userInteractionEnabled=YES;
        dateLBL.textAlignment=NSTextAlignmentCenter;
        dateLBL.textColor=[UIColor whiteColor];
        dateLBL.font=[UIFont systemFontOfSize:13.0];
        [dateLBL sizeToFit];
        CGRect frm=dateLBL.frame;
        frm.size.height=50;
        dateLBL.frame=frm;
        [DateCSCRL addSubview:dateLBL];
        
        UIButton *DateBTN=[[UIButton alloc]initWithFrame:CGRectMake(dateLBL.frame.origin.x, 0, dateLBL.frame.size.width, dateLBL.frame.size.height)];
        DateBTN.tag=510+i;
        [DateBTN addTarget:self action:@selector(DateBTNclick:) forControlEvents:UIControlEventTouchUpInside];
        [DateCSCRL addSubview:DateBTN];
        
        width=width+dateLBL.frame.size.width+8;
    }
    
    DateCSCRL.contentSize=CGSizeMake(width, 50);
}
-(void)DateBTNclick:(id)sender
{
    UIButton *button1 = sender;
    NSInteger RbuttonTag = button1.tag;
    
    selecteddate = RbuttonTag-510;
    
    NSLog(@"%li",RbuttonTag-510);
    
    for(int i=500;i<508;i++)
    {
        UILabel *temp=(UILabel *)[DateCSCRL viewWithTag:i];
        if(i==((RbuttonTag-510)+500))
        {
            temp.textColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        }
        else
        {
            temp.textColor=[UIColor whiteColor];
        }
        
    }
    
    [[NSUserDefaults standardUserDefaults]setValue:[dateARY objectAtIndex:selecteddate] forKey:@"WoofrBOOkingDate"];
    
    [self callTimeAPI];
    
}

//********************************************
#pragma mark - Connection Delegate Methods
//********************************************

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection == Timeconnection)
    {
        [TimeData appendData:data];
    }
    else if (connection == Tableconnection)
    {
        [TableData appendData:data];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (connection == Timeconnection)
    {
        [TimeData setLength:0];
    }
    else if (connection == Tableconnection)
    {
        [TableData setLength:0];
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
    if (connection == Timeconnection)
    {
        NSMutableString *responceversionStr = [[NSMutableString alloc]initWithBytes:[TimeData mutableBytes] length:[TimeData length] encoding:NSUTF8StringEncoding];
        NSMutableDictionary *gat_dic = [[NSMutableDictionary alloc]init];
        [gat_dic setDictionary:[responceversionStr JSONValue]];
        
        [HUD hide:YES];
        
        NSLog(@"%@",gat_dic);
        
        NSString *statusSTR=[NSString stringWithFormat:@"%@",[gat_dic valueForKey:@"status"]];
        
        if([statusSTR isEqualToString:@"1"])
        {
            timeARY=[[NSMutableArray alloc]init];
            timeARY=[gat_dic valueForKey:@"time_slot"];
            
            Is_select=NO;
            
            for (UIView *v in timeSCRL.subviews) {
                if (![v isKindOfClass:[UIScrollView class]]) {
                    [v removeFromSuperview];
                }
            }
            
            for(UIView *v in TimeCSCRL.subviews)
            {
                [v removeFromSuperview];
            }
            
            for (UIView *v in TableCSCRL.subviews)
            {
                [v removeFromSuperview];
            }
            
            if([NSString stringWithFormat:@"%@",timeARY].length>5)
            {
                [self LoadTimeSCRL];
            }
        }
    }
    else if (connection == Tableconnection)
    {
        NSMutableString *responceversionStr = [[NSMutableString alloc]initWithBytes:[TableData mutableBytes] length:[TableData length] encoding:NSUTF8StringEncoding];
        gat_dic_value = [[NSMutableDictionary alloc]init];
        [gat_dic_value setDictionary:[responceversionStr JSONValue]];
        
        [HUD hide:YES];
        
        NSLog(@"%@",gat_dic_value);
        
        NSString *statusSTR=[NSString stringWithFormat:@"%@",[gat_dic_value valueForKey:@"status"]];
        
        if([statusSTR isEqualToString:@"1"])
        {
            Is_select=NO;
            
            for (UIView *v in TableCSCRL.subviews)
            {
                [v removeFromSuperview];
            }
            
            tableARY=[[NSMutableArray alloc]init];
            tableARY=[gat_dic_value valueForKey:@"available_normal_packages"];
            
            NSMutableArray *tableARY1=[[NSMutableArray alloc]init];
            tableARY1=[gat_dic_value valueForKey:@"available_vip_packages"];
            
            if([NSString stringWithFormat:@"%@",tableARY].length>5 || [NSString stringWithFormat:@"%@",tableARY1].length>5)
            {
                [self LoadTBLTYPE];
            }
        }
    }

}
//********************************************
#pragma mark - Time Section Methods
//********************************************
-(void)callTimeAPI
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
    
    
    //admin.vasundharavision.com/woofr/api/?action=available_timslot_for_tables&club_id=1&date=2015-12-05
    
    NSString *dateSTR=[NSString stringWithFormat:@"%@",[[dateARY objectAtIndex:selecteddate]valueForKey:@"FullDate"]];
    
    NSMutableDictionary *sendData = [[NSMutableDictionary alloc]init];
    
    
    [sendData setObject:@"available_timslot_for_tables" forKey:@"action"];
    [sendData setObject:clubIdSTR forKey:@"club_id"];
    //[sendData setObject:@"1" forKey:@"club_id"];
    [sendData setObject:dateSTR forKey:@"date"];
    
    
    
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
    
    Timeconnection = [NSURLConnection connectionWithRequest:request delegate:self];
    if (Timeconnection)
    {
        TimeData = [[NSMutableData alloc]init];
    }
    
}

-(void)LoadTimeSCRL
{
    UILabel *TimeLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 20)];
    TimeLBL.text=@"Arrival Time";
    TimeLBL.font=[UIFont systemFontOfSize:14.0];
    TimeLBL.textColor=[UIColor whiteColor];
    [timeSCRL addSubview:TimeLBL];
    
    
    float Twidth;
    
    Twidth=8;
    
    for (int i=0;i<timeARY.count;i++)
    {
        UILabel *timeLBL=[[UILabel alloc]initWithFrame:CGRectMake(Twidth, 0, 500, 40)];
        timeLBL.text=[NSString stringWithFormat:@" %@ ",[[timeARY objectAtIndex:i]valueForKey:@"time" ]];
        timeLBL.numberOfLines=2;
        timeLBL.tag=600+i;
        timeLBL.userInteractionEnabled=YES;
        timeLBL.textAlignment=NSTextAlignmentCenter;
        timeLBL.textColor=[UIColor whiteColor];
        timeLBL.font=[UIFont systemFontOfSize:13.0];
        [timeLBL sizeToFit];
        CGRect frm=timeLBL.frame;
        frm.size.height=40;
        timeLBL.frame=frm;
        timeLBL.layer.borderColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0].CGColor;
        timeLBL.layer.borderWidth=1.0;
        [TimeCSCRL addSubview:timeLBL];
        
        UIButton *DateBTN=[[UIButton alloc]initWithFrame:CGRectMake(timeLBL.frame.origin.x, 0, timeLBL.frame.size.width, timeLBL.frame.size.height)];
        DateBTN.tag=700+i;
        [DateBTN addTarget:self action:@selector(timeBTNclick:) forControlEvents:UIControlEventTouchUpInside];
        [TimeCSCRL addSubview:DateBTN];
        
        Twidth=Twidth+timeLBL.frame.size.width;
    }
    
    TimeCSCRL.contentSize=CGSizeMake(Twidth, 40);
    
}

-(void)timeBTNclick:(id)sender
{
    UIButton *button1 = sender;
    NSInteger RbuttonTag = button1.tag;
    
    selecttime = RbuttonTag-700;
    
    
    for(int i=600;i<(600+timeARY.count);i++)
    {
        UILabel *temp=(UILabel *)[TimeCSCRL viewWithTag:i];
        if(i==(selecttime+600))
        {
            temp.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        }
        else
        {
            temp.backgroundColor=[UIColor clearColor];
        }
        
    }
    
        [[NSUserDefaults standardUserDefaults]setValue:[timeARY objectAtIndex:selecttime] forKey:@"WoofrBOOkingTime"];
    
    [self callTableAPI];
    
}
//********************************************
#pragma mark - Table Section Methods
//********************************************
-(void)callTableAPI
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
    
    
    
    
    NSString *timeSTR=[NSString stringWithFormat:@"%@",[[timeARY objectAtIndex:selecttime]valueForKey:@"time"]];
    
    NSString *dateSTR=[NSString stringWithFormat:@"%@",[[dateARY objectAtIndex:selecteddate]valueForKey:@"FullDate"]];
    
    NSMutableDictionary *sendData = [[NSMutableDictionary alloc]init];
    
    //admin.vasundharavision.com/woofr/api/?action=available_tables_list&club_id=1&date=2015-12-05&time=10:00%20PM
    // 1 club
    // 2 event
    // 3 Pramotion
    // 4 desco
    
    NSString *typeSTR = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"WooFrclubDetetct"]];
    
    [sendData setObject:@"available_tables_list" forKey:@"action"];
    [sendData setObject:clubIdSTR forKey:@"club_id"];
    //[sendData setObject:@"1" forKey:@"club_id"];
    [sendData setObject:dateSTR forKey:@"date"];
    [sendData setObject:timeSTR forKey:@"time"];
    [sendData setObject:typeSTR forKey:@"is_type"];
    
    
    
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
    
    Tableconnection = [NSURLConnection connectionWithRequest:request delegate:self];
    if (Tableconnection)
    {
        TableData = [[NSMutableData alloc]init];
    }
    
}

-(void)LoadTBLTYPE
{
    float ScrlHeight;
    ScrlHeight=8;
    
    VIPTBLARY=[[NSMutableArray alloc]init];
    VIPTBLARY=[gat_dic_value valueForKey:@"available_vip_packages"];
    
    if([NSString stringWithFormat:@"%@",VIPTBLARY].length>5)
    {
        UILabel *VIPLBL = [[UILabel alloc]initWithFrame:CGRectMake(10, ScrlHeight, ViewWIdth-20, 25)];
        VIPLBL.text=@"VIP TABLE PACKAGES";
        VIPLBL.font=[UIFont boldSystemFontOfSize:16.0];
        VIPLBL.textColor=[UIColor whiteColor];
        [TableCSCRL addSubview:VIPLBL];
        
        ScrlHeight=ScrlHeight+VIPLBL.frame.size.height;
        
        for(int i=0;i<VIPTBLARY.count;i++)
        {
            UIImageView *backimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, ScrlHeight, ViewWIdth, 57)];
            backimage.tag=900+i;
            backimage.userInteractionEnabled=YES;
            
            UILabel *PriceLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, 8, 100, 20)];
            PriceLBL.text=[NSString stringWithFormat:@"%@SGD",[[VIPTBLARY objectAtIndex:i]valueForKey:@"price"]];
            PriceLBL.font=[UIFont systemFontOfSize:15.0];
            PriceLBL.textColor=[UIColor whiteColor];
            PriceLBL.userInteractionEnabled=YES;
            [backimage addSubview:PriceLBL];
            
            UILabel *LeftTBL=[[UILabel alloc]initWithFrame:CGRectMake(PriceLBL.frame.size.width+15, 8, ViewWIdth-125, 20)];
            LeftTBL.text=[NSString stringWithFormat:@"%@ TABLE LEFT",[[VIPTBLARY objectAtIndex:i]valueForKey:@"total_tables_left"]];
            LeftTBL.font=[UIFont systemFontOfSize:15.0];
            LeftTBL.textAlignment=NSTextAlignmentRight;
            LeftTBL.textColor=[UIColor whiteColor];
            LeftTBL.userInteractionEnabled=YES;
            [backimage addSubview:LeftTBL];
            
            UILabel *TypeLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, 28, ViewWIdth-125, 18)];
            TypeLBL.text=[NSString stringWithFormat:@"%@",[[VIPTBLARY objectAtIndex:i]valueForKey:@"package_name"]];
            TypeLBL.font=[UIFont systemFontOfSize:12.0];
            TypeLBL.textAlignment=NSTextAlignmentLeft;
            TypeLBL.textColor=[UIColor whiteColor];
            TypeLBL.userInteractionEnabled=YES;
            [backimage addSubview:TypeLBL];
            
            
            UILabel *GoersLBL=[[UILabel alloc]initWithFrame:CGRectMake(ViewWIdth-115, 28, 100, 18)];
            GoersLBL.text=[NSString stringWithFormat:@"1 to %@ goers",[[VIPTBLARY objectAtIndex:i]valueForKey:@"total_seat"]];
            GoersLBL.font=[UIFont systemFontOfSize:12.0];
            GoersLBL.textAlignment=NSTextAlignmentRight;
            GoersLBL.textColor=[UIColor whiteColor];
            GoersLBL.userInteractionEnabled=YES;
            [backimage addSubview:GoersLBL];
            
            UIImageView *lineimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, backimage.frame.size.height-1, ViewWIdth, 1)];
            lineimage.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
            [backimage addSubview:lineimage];
            
            UIButton *selectedIMGBTN=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, backimage.frame.size.width, backimage.frame.size.height)];
            selectedIMGBTN.tag=1000+i;
            [selectedIMGBTN addTarget:self action:@selector(VIPtablebtnclick:) forControlEvents:UIControlEventTouchUpInside];
            [backimage addSubview:selectedIMGBTN];
            
            [TableCSCRL addSubview:backimage];
            
            
            ScrlHeight=ScrlHeight+backimage.frame.size.height;
        }
        
        ScrlHeight=ScrlHeight+10;
    }
    
    NRMLTBLARY=[[NSMutableArray alloc]init];
    NRMLTBLARY=[gat_dic_value valueForKey:@"available_normal_packages"];
    
    if([NSString stringWithFormat:@"%@",NRMLTBLARY].length>5)
    {
        ScrlHeight=ScrlHeight+8;
        UILabel *TBLLBL = [[UILabel alloc]initWithFrame:CGRectMake(10, ScrlHeight, ViewWIdth-20, 25)];
        TBLLBL.text=@"TABLE";
        TBLLBL.font=[UIFont boldSystemFontOfSize:16.0];
        TBLLBL.textColor=[UIColor whiteColor];
        [TableCSCRL addSubview:TBLLBL];
        
        ScrlHeight=ScrlHeight+TBLLBL.frame.size.height+5;
        
        UIImageView *lineimage23=[[UIImageView alloc]initWithFrame:CGRectMake(0, ScrlHeight-1, ViewWIdth, 1)];
        lineimage23.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        [TableCSCRL addSubview:lineimage23];
        
        for(int i=0;i<NRMLTBLARY.count;i++)
        {
            UIImageView *backimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, ScrlHeight, ViewWIdth, 57)];
            backimage.tag=950+i;
            backimage.userInteractionEnabled=YES;
            
            UILabel *PriceLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, 8, 100, 25)];
            PriceLBL.text=[NSString stringWithFormat:@"%@SGD",[[NRMLTBLARY objectAtIndex:i]valueForKey:@"price"]];
            PriceLBL.font=[UIFont systemFontOfSize:15.0];
            PriceLBL.textColor=[UIColor whiteColor];
            PriceLBL.userInteractionEnabled=YES;
            [backimage addSubview:PriceLBL];
            
            
            UILabel *LeftTBL=[[UILabel alloc]initWithFrame:CGRectMake(PriceLBL.frame.size.width+15, 8, ViewWIdth-125, 20)];
            LeftTBL.text=[NSString stringWithFormat:@"%@ TABLE LEFT",[[NRMLTBLARY objectAtIndex:i]valueForKey:@"total_tables_left"]];
            LeftTBL.font=[UIFont systemFontOfSize:15.0];
            LeftTBL.textAlignment=NSTextAlignmentRight;
            LeftTBL.textColor=[UIColor whiteColor];
            LeftTBL.userInteractionEnabled=YES;
            [backimage addSubview:LeftTBL];

            UILabel *TypeLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, 28, ViewWIdth-125, 18)];
            TypeLBL.text=[NSString stringWithFormat:@"%@",[[NRMLTBLARY objectAtIndex:i]valueForKey:@"package_name"]];
            TypeLBL.font=[UIFont systemFontOfSize:12.0];
            TypeLBL.textAlignment=NSTextAlignmentLeft;
            TypeLBL.textColor=[UIColor whiteColor];
            TypeLBL.userInteractionEnabled=YES;
            [backimage addSubview:TypeLBL];
            
            
            UILabel *GoersLBL=[[UILabel alloc]initWithFrame:CGRectMake(ViewWIdth-115, 28, 100, 18)];
            GoersLBL.text=[NSString stringWithFormat:@"1 to %@ goers",[[NRMLTBLARY objectAtIndex:i]valueForKey:@"total_seat"]];
            GoersLBL.font=[UIFont systemFontOfSize:12.0];
            GoersLBL.textAlignment=NSTextAlignmentRight;
            GoersLBL.textColor=[UIColor whiteColor];
            GoersLBL.userInteractionEnabled=YES;
            [backimage addSubview:GoersLBL];
            
            UIImageView *lineimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, backimage.frame.size.height-1, ViewWIdth, 1)];
            lineimage.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
            [backimage addSubview:lineimage];
            
            UIButton *selectedIMGBTN=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, backimage.frame.size.width, backimage.frame.size.height)];
            selectedIMGBTN.tag=1050+i;
            [selectedIMGBTN addTarget:self action:@selector(NRMLtablebtnclick:) forControlEvents:UIControlEventTouchUpInside];
            [backimage addSubview:selectedIMGBTN];

            
            [TableCSCRL addSubview:backimage];
            
            
            ScrlHeight=ScrlHeight+backimage.frame.size.height;
        }
    }
    
    
    if([NSString stringWithFormat:@"%@",VIPTBLARY].length>5 || [NSString stringWithFormat:@"%@",NRMLTBLARY].length>5)
    {
        ScrlHeight=ScrlHeight+10;
        
        UIButton *CBOOkNowbTN = [[UIButton alloc]initWithFrame:CGRectMake(10, ScrlHeight, ViewWIdth-20, 50)];
        [CBOOkNowbTN setBackgroundImage:[UIImage imageNamed:@"btn_small_login_general.png"] forState:UIControlStateNormal];
        [CBOOkNowbTN setTitle:@"BOOK NOW" forState:UIControlStateNormal];
        [CBOOkNowbTN addTarget:self action:@selector(CBOOkNowbTNclick) forControlEvents:UIControlEventTouchUpInside];
        [CBOOkNowbTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        CBOOkNowbTN.titleLabel.font=[UIFont systemFontOfSize:15.0];
        
        [TableCSCRL addSubview:CBOOkNowbTN];

        ScrlHeight=ScrlHeight+10+CBOOkNowbTN.frame.size.height;
    }

    TableCSCRL.contentSize=CGSizeMake(ViewWIdth, ScrlHeight);
    
}
-(void)CBOOkNowbTNclick
{
    if(Is_select==YES)
    {
        
        [[NSUserDefaults standardUserDefaults]setValue:TempDictTable forKey:@"WooferTBLfoodvalues"];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
        FoodDetailVC *dealVC1 = (FoodDetailVC *)[storyboard instantiateViewControllerWithIdentifier:@"FoodDetailVC"];
        [self.navigationController pushViewController:dealVC1 animated:YES];
    }
    else
    {
        UIAlertView *connectionAlert = [[UIAlertView alloc]initWithTitle:nil message:@"Please Select Table Type" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [connectionAlert show];
    }
}


- (void)VIPtablebtnclick:(id)sender
{
    UIButton *temp = (UIButton *)sender;
    NSLog(@"%ld",(long)temp.tag);
    
    int long clickindex = temp.tag-1000;
    
    
    NSLog(@"%ld",clickindex);
    
    if([NSString stringWithFormat:@"%@",VIPTBLARY].length>5)
    {
        for(int i=900;i<(900+VIPTBLARY.count);i++)
        {
            UIImageView *temp=(UIImageView *)[TableCSCRL viewWithTag:i];
            if(i==(clickindex+900))
            {
                temp.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
                TempDictTable=[[NSMutableDictionary alloc]init];
                TempDictTable=[VIPTBLARY objectAtIndex:clickindex];
                Is_select=YES;
            }
            else
            {
                temp.backgroundColor=[UIColor clearColor];
            }
            
        }

    }
    if([NSString stringWithFormat:@"%@",NRMLTBLARY].length>5)
    {
        for(int i=950;i<(950+VIPTBLARY.count);i++)
        {
            UIImageView *temp=(UIImageView *)[TableCSCRL viewWithTag:i];
            temp.backgroundColor=[UIColor clearColor];
        }
    }
    
    [[NSUserDefaults standardUserDefaults]setValue:@"1" forKey:@"WoofrTBLType"];
}
- (void)NRMLtablebtnclick:(id)sender
{
    UIButton *temp = (UIButton *)sender;
    NSLog(@"%ld",(long)temp.tag);
    
    int long clickindex = temp.tag-1050;
    
    NSLog(@"%ld",clickindex);
    
    if([NSString stringWithFormat:@"%@",NRMLTBLARY].length>5)
    {
        for(int i=950;i<(950+NRMLTBLARY.count);i++)
        {
            UIImageView *temp=(UIImageView *)[TableCSCRL viewWithTag:i];
            if(i==(clickindex+950))
            {
                temp.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
                TempDictTable=[[NSMutableDictionary alloc]init];
                TempDictTable=[NRMLTBLARY objectAtIndex:clickindex];
                Is_select=YES;
            }
            else
            {
                temp.backgroundColor=[UIColor clearColor];
            }
            
        }
        
    }
    
    if([NSString stringWithFormat:@"%@",VIPTBLARY].length>5)
    {
        for(int i=900;i<(900+VIPTBLARY.count);i++)
        {
            UIImageView *temp=(UIImageView *)[TableCSCRL viewWithTag:i];
            temp.backgroundColor=[UIColor clearColor];
        }
    }
    
    [[NSUserDefaults standardUserDefaults]setValue:@"2" forKey:@"WoofrTBLType"];
    
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
