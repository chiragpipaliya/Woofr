//
//  BookEventAvailibilityVC.m
//  WOOFR
//
//  Created by Hemal Kachhadiya on 12/18/15.
//  Copyright (c) 2015 dipen. All rights reserved.
//

#import "BookEventAvailibilityVC.h"

@interface BookEventAvailibilityVC ()
{
    NSString *EventIDSTR;
    NSMutableArray *dateARY,*timeARY,*tableARY,*TicketsARY;
    
    BOOL Is_select;
    
    NSMutableDictionary *EventDetailDict,*selectedDictPACK;
    
    int long selecteddate,selecttime,SelectedPack;
}

@end

@implementation BookEventAvailibilityVC

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
    
    
    
    
    HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUD];
    [self.view bringSubviewToFront:HUD];
    [HUD setDelegate:self];
    [HUD setLabelText:@"Loading...."];
    
    
    dateARY=[[NSMutableArray alloc]init];
    
    EventDetailDict=[[NSMutableDictionary alloc]init];
    
    EventDetailDict = [[NSUserDefaults standardUserDefaults]valueForKey:@"EventWoofrBookDetail"];
    
    
    NSString *start = [NSString stringWithFormat:@"%@",[EventDetailDict valueForKey:@"start_date"]];
    NSString *end = [NSString stringWithFormat:@"%@",[EventDetailDict valueForKey:@"end_date"]];
    
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy-MM-dd"];
    NSDate *startDate = [f dateFromString:start];
    NSDate *endDate = [f dateFromString:end];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:NSCalendarWrapComponents];
    NSLog(@" Detail %@",EventDetailDict);
    NSLog(@" Days %@",components);
    
    EventIDSTR=[NSString stringWithFormat:@"%@",[EventDetailDict valueForKey:@"event_id"]];
    
    NSArray* foo = [[NSString stringWithFormat:@"%@",components] componentsSeparatedByString: @"Day"];
    NSString* firstBit = [foo objectAtIndex: 1];
    
    NSString *numberString;
    
    NSScanner *scanner = [NSScanner scannerWithString:firstBit];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    // Throw away characters before the first number.
    [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
    
    // Collect numbers.
    [scanner scanCharactersFromSet:numbers intoString:&numberString];
    
    // Result.
    int long number = [numberString integerValue];
    
    for(int i=0;i<=number;i++)
    {
        NSMutableDictionary *recordDict=[[NSMutableDictionary alloc]init];
        
        NSDate *tomorrow = [NSDate dateWithTimeInterval:(24*60*60*i) sinceDate:startDate];
        
        NSString *TomorrowSTR=[f stringFromDate:tomorrow];
        NSString *TodaySTR=[f stringFromDate:[NSDate date]];
        
        NSTimeInterval secondsBetween = [tomorrow timeIntervalSinceDate:[NSDate date]];
        
        if(secondsBetween>0 || [TomorrowSTR isEqualToString:TodaySTR])
        {
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
    }
    
    NSLog(@"%@",dateARY);
    
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
        DateBTN.tag=5100+i;
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
    
    selecteddate = RbuttonTag-5100;
    
    NSLog(@"%li",RbuttonTag-5100);
    
    for(int i=0;i<=dateARY.count;i++)
    {
        UILabel *temp=(UILabel *)[DateCSCRL viewWithTag:(i+500)];
        if(i==((RbuttonTag-5100)))
        {
            temp.textColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        }
        else
        {
            temp.textColor=[UIColor whiteColor];
        }
        
    }
    
    [[NSUserDefaults standardUserDefaults]setValue:[dateARY objectAtIndex:selecteddate] forKey:@"WoofrEBOOkingDate"];
    
    [self callTimeAPI];
    
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
    
    
    
    //admin.vasundharavision.com/woofr/api/?action=available_timeslot_for_event&event_id=1&date=2015-12-15
    
    
    
    NSString *dateSTR=[NSString stringWithFormat:@"%@",[[dateARY objectAtIndex:selecteddate]valueForKey:@"FullDate"]];
    
    NSMutableDictionary *sendData = [[NSMutableDictionary alloc]init];
    
    
    [sendData setObject:@"available_timeslot_for_event" forKey:@"action"];
    //    [sendData setObject:clubIdSTR forKey:@"club_id"];
    [sendData setObject:EventIDSTR forKey:@"event_id"];
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
//********************************************
#pragma mark - Connection Delegate Methods
//********************************************

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection == Timeconnection)
    {
        [TimeData appendData:data];
    }
    else if (connection == availibilityconnection)
    {
        [availibilityData appendData:data];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (connection == Timeconnection)
    {
        [TimeData setLength:0];
    }
    else if (connection == availibilityconnection)
    {
        [availibilityData setLength:0];
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
            TicketsARY=[[NSMutableArray alloc]init];
            TicketsARY=[gat_dic valueForKey:@"tickets"];
            
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
                // NSLog(@"%@",timeARY);
            }
            
        }
    }
    
    if (connection == availibilityconnection)
    {
        NSMutableString *responceversionStr = [[NSMutableString alloc]initWithBytes:[availibilityData mutableBytes] length:[availibilityData length] encoding:NSUTF8StringEncoding];
        NSMutableDictionary *Av_gat_dic = [[NSMutableDictionary alloc]init];
        [Av_gat_dic setDictionary:[responceversionStr JSONValue]];
        
        [HUD hide:YES];
        
        NSLog(@"%@",Av_gat_dic);
        
        if([[NSString stringWithFormat:@"%@",[Av_gat_dic valueForKey:@"status"]]isEqualToString:@"1"])
        {
            
            for(int i=0;i<TicketsARY.count;i++)
            {
                UIImageView *temp=(UIImageView *)[TableCSCRL viewWithTag:(i+900)];
                if(i==SelectedPack)
                {
                    temp.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
                    selectedDictPACK=[[NSMutableDictionary alloc]init];
                    selectedDictPACK=[TicketsARY objectAtIndex:SelectedPack];
                    Is_select=YES;
                }
                else
                {
                    temp.backgroundColor=[UIColor clearColor];
                }
                
            }
        }
        else
        {
            Is_select=NO;
            
            for (UIView *v in TableCSCRL.subviews)
            {
                [v removeFromSuperview];
            }
            
            if([NSString stringWithFormat:@"%@",TicketsARY].length>5 )
            {
                [self LoadTBLTYPE];
            }
            
            UIAlertView *Messgalert  = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"%@",[Av_gat_dic valueForKey:@"message"] ] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [Messgalert show];
            
        }
    }
    
}
-(void)LoadTBLTYPE
{
    float ScrlHeight;
    ScrlHeight=8;
    
    NSLog(@"%@",TicketsARY);
    
    
    if([NSString stringWithFormat:@"%@",TicketsARY].length>5)
    {
        UILabel *VIPLBL = [[UILabel alloc]initWithFrame:CGRectMake(10, ScrlHeight, ViewWIdth-20, 25)];
        VIPLBL.text=@"TICKETS";
        VIPLBL.font=[UIFont boldSystemFontOfSize:16.0];
        VIPLBL.textColor=[UIColor whiteColor];
        [TableCSCRL addSubview:VIPLBL];
        
        ScrlHeight=ScrlHeight+VIPLBL.frame.size.height;
        
        for(int i=0;i<TicketsARY.count;i++)
        {
            UIImageView *backimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, ScrlHeight, ViewWIdth, 57)];
            backimage.tag=900+i;
            backimage.userInteractionEnabled=YES;
            
            UILabel *PriceLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, 18, 80, 20)];
            PriceLBL.text=[NSString stringWithFormat:@"%@SGD",[[TicketsARY objectAtIndex:i]valueForKey:@"price"]];
            PriceLBL.font=[UIFont systemFontOfSize:15.0];
            PriceLBL.textColor=[UIColor whiteColor];
            PriceLBL.userInteractionEnabled=YES;
            [backimage addSubview:PriceLBL];
            
            UILabel *LeftTBL=[[UILabel alloc]initWithFrame:CGRectMake(PriceLBL.frame.size.width+15, 8, ViewWIdth-105, 20)];
            LeftTBL.text=[NSString stringWithFormat:@"%@",[[TicketsARY objectAtIndex:i]valueForKey:@"title"]];
            LeftTBL.font=[UIFont systemFontOfSize:15.0];
            LeftTBL.textAlignment=NSTextAlignmentRight;
            LeftTBL.textColor=[UIColor whiteColor];
            LeftTBL.userInteractionEnabled=YES;
            [backimage addSubview:LeftTBL];
            
            //            UILabel *TypeLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, 28, ViewWIdth-125, 18)];
            //            TypeLBL.text=[NSString stringWithFormat:@"%@",[[VIPTBLARY objectAtIndex:i]valueForKey:@"package_name"]];
            //            TypeLBL.font=[UIFont systemFontOfSize:12.0];
            //            TypeLBL.textAlignment=NSTextAlignmentLeft;
            //            TypeLBL.textColor=[UIColor whiteColor];
            //            TypeLBL.userInteractionEnabled=YES;
            //            [backimage addSubview:TypeLBL];
            
            
            UILabel *GoersLBL=[[UILabel alloc]initWithFrame:CGRectMake(ViewWIdth-105, 28, 100, 18)];
            GoersLBL.text=[NSString stringWithFormat:@"%@ guests",[[TicketsARY objectAtIndex:i]valueForKey:@"tickets"]];
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
    
}
- (void)VIPtablebtnclick:(id)sender
{
    UIButton *temp = (UIButton *)sender;
    NSLog(@"%ld",(long)temp.tag);
    
    int long clickindex = temp.tag-1000;
    
    SelectedPack=clickindex;
    
    [self CallAvailibilitypackAPI];
    
    //    NSLog(@"%ld",clickindex);
    //
    //    if([NSString stringWithFormat:@"%@",VIPTBLARY].length>5)
    //    {
    //        for(int i=900;i<(900+VIPTBLARY.count);i++)
    //        {
    //            UIImageView *temp=(UIImageView *)[TableCSCRL viewWithTag:i];
    //            if(i==(clickindex+900))
    //            {
    //                temp.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
    //                TempDictTable=[[NSMutableDictionary alloc]init];
    //                TempDictTable=[VIPTBLARY objectAtIndex:clickindex];
    //                Is_select=YES;
    //            }
    //            else
    //            {
    //                temp.backgroundColor=[UIColor clearColor];
    //            }
    //
    //        }
    //
    //    }
    
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
    
    Is_select=NO;
    
    for (UIView *v in TableCSCRL.subviews)
    {
        [v removeFromSuperview];
    }
    
    if([NSString stringWithFormat:@"%@",TicketsARY].length>5 )
    {
        [self LoadTBLTYPE];
    }
    
    
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
    
    [[NSUserDefaults standardUserDefaults]setValue:[timeARY objectAtIndex:selecttime] forKey:@"WoofrBOOkingETime"];
    
    Is_select=NO;
    
    for (UIView *v in TableCSCRL.subviews)
    {
        [v removeFromSuperview];
    }
    
    if([NSString stringWithFormat:@"%@",TicketsARY].length>5 )
    {
        [self LoadTBLTYPE];
    }
    
    
    
}

-(void)CallAvailibilitypackAPI
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
    
    
    
    
    
    
    NSString *dateSTR=[NSString stringWithFormat:@"%@",[[dateARY objectAtIndex:selecteddate]valueForKey:@"FullDate"]];
    
    NSMutableDictionary *sendData = [[NSMutableDictionary alloc]init];
    
    
    // 1 club
    // 2 event
    // 3 Pramotion
    // 4 desco
    
    //admin.vasundharavision.com/woofr/api/?action=check_available_tickets&event_id=1&ticket_id=2&date=2015-12-16
    
    
    [sendData setObject:@"check_available_tickets" forKey:@"action"];
    [sendData setObject:EventIDSTR forKey:@"event_id"];
    [sendData setObject:[NSString stringWithFormat:@"%@",[[TicketsARY objectAtIndex:SelectedPack]valueForKey:@"ticket_id" ]] forKey:@"ticket_id"];
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
    
    availibilityconnection = [NSURLConnection connectionWithRequest:request delegate:self];
    if (availibilityconnection)
    {
        availibilityData = [[NSMutableData alloc]init];
    }
    
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
