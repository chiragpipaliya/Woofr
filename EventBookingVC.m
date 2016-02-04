//
//  EventBookingVC.m
//  WOOFR
//
//  Created by Hemal Kachhadiya on 12/19/15.
//  Copyright (c) 2015 dipen. All rights reserved.
//

#import "EventBookingVC.h"
#import "PaymentVC.h"

@interface EventBookingVC ()
{
    NSMutableDictionary *EventDetailDict,*PackDetailDict;
    
    float GlobalHeight;
}

@end

@implementation EventBookingVC

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
    
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor]];
    
    self.title=@"Are you ready?";
    
    EventDetailDict=[[NSMutableDictionary alloc]init];
    EventDetailDict=[[NSUserDefaults standardUserDefaults]valueForKey:@"EventWoofrBookDetail"];
    PackDetailDict=[[NSMutableDictionary alloc]init];
    PackDetailDict=[[NSUserDefaults standardUserDefaults]valueForKey:@"WoofrEventPCk"];
    
    NSLog(@"%@",PackDetailDict);
    
    [self LoadvIEWbill];
    
  
}
-(void)LoadvIEWbill
{
    float scrlHeight;
    
    scrlHeight=0;
    
   
    GlobalHeight=0;
    
    NSMutableArray *tempIMgary=[[NSMutableArray alloc]init];
    tempIMgary=[EventDetailDict valueForKey:@"event_images"];
    
   
    
    for(int i=0;i<tempIMgary.count;i++)
    {
        UIImageView *IMG=[[UIImageView alloc]initWithFrame:CGRectMake(ViewWIdth*i, 0, ViewWIdth, CLubIMGCSCRL.frame.size.height)];
        
        NSURL *urllinksTR= [NSURL URLWithString:[[NSString stringWithFormat:@"%@",[[tempIMgary objectAtIndex:i] valueForKey:@"filename"]]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        AsyncImageView *beerImage = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, IMG.frame.size.width, IMG.frame.size.height)];
        [beerImage loadImageFromURL:urllinksTR imageName:@""];
        [IMG addSubview:beerImage];
        
        [CLubIMGCSCRL addSubview:IMG];
        
    }
    
    //    CLubIMGCSCRL.contentSize=CGSizeMake(ViewWIdth*(tempIMgary.count), CLubIMGCSCRL.frame.size.height);
    CLubIMGCSCRL.contentSize=CGSizeMake(ViewWIdth, CLubIMGCSCRL.frame.size.height);
    CLubIMGCSCRL.layer.borderColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0].CGColor;
    CLubIMGCSCRL.layer.borderWidth=1.0;
    
    scrlHeight=scrlHeight+CLubIMGCSCRL.frame.size.height;
    
    CGRect frm=ProfilePicIMg.frame;
    if(frm.size.height!=frm.size.width)
    {
        frm.size.height=frm.size.width;
        ProfilePicIMg.frame =frm;
    }
    frm.origin.y=scrlHeight-(ProfilePicIMg.frame.size.height/2);
    frm.origin.x=(ViewWIdth/2)-(ProfilePicIMg.frame.size.height/2);
    ProfilePicIMg.frame=frm;
    
    ProfilePicIMg.layer.borderWidth=1.0;
    ProfilePicIMg.layer.cornerRadius=(ProfilePicIMg.frame.size.height/2);
    ProfilePicIMg.layer.borderColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0].CGColor;
    ProfilePicIMg.clipsToBounds=YES;
    
    
    NSMutableDictionary *UserInfo=[[NSMutableDictionary alloc]init];
    
    NSUserDefaults *user=[[NSUserDefaults alloc]init];
    
    UserInfo=[user valueForKey:@"WoofrUSer"];
    NSURL *urllinksTR= [NSURL URLWithString:[[NSString stringWithFormat:@"%@",[UserInfo valueForKey:@"user_image"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"%@",UserInfo);
    
    AsyncImageView *beerImage1 = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, ProfilePicIMg.frame.size.width, ProfilePicIMg.frame.size.height)];
    [beerImage1 loadImageFromURL:urllinksTR imageName:@""];
    beerImage1.layer.cornerRadius=(ProfilePicIMg.frame.size.height/2);
    beerImage1.clipsToBounds=YES;
    
    [ProfilePicIMg addSubview:beerImage1];
    
    
    scrlHeight=scrlHeight+(ProfilePicIMg.frame.size.height/2)+8;
    
    UserNAmeLBL.text=[NSString stringWithFormat:@"%@'s Table",[UserInfo valueForKey:@"user_name"]];
    [UserNAmeLBL sizeToFit];
    
    CGRect nameLBLFrm=UserNAmeLBL.frame;
    nameLBLFrm.origin.y=scrlHeight;
    nameLBLFrm.size.width=ViewWIdth-16;
    UserNAmeLBL.frame=nameLBLFrm;
    
    scrlHeight=scrlHeight+UserNAmeLBL.frame.size.height+5;
    
    NSDictionary *DateVDict=[[NSDictionary alloc]init];
    NSDictionary *TimeVDict=[[NSDictionary alloc]init];
    DateVDict=[[NSUserDefaults standardUserDefaults]valueForKey:@"WoofrEBOOkingDate"];
    TimeVDict=[[NSUserDefaults standardUserDefaults]valueForKey:@"WoofrBOOkingETime"];
    
    NSLog(@"%@",DateVDict);
    NSLog(@"%@",TimeVDict);
    
    NSString *datestr=[DateVDict valueForKey:@"FullDate"];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *fdate=[dateFormatter dateFromString:datestr];
    [dateFormatter setDateFormat:@"dd/MM/yy"];
    
    NSString *ffdatestr=[dateFormatter stringFromDate:fdate];
    
    
    
    DateLBL.text=[NSString stringWithFormat:@"%@,%@ On %@ @%@",ffdatestr,[DateVDict valueForKey:@"WeekDay"],[TimeVDict valueForKey:@"time"],[EventDetailDict valueForKey:@"club_name"]];
    
    [DateLBL sizeToFit];
    
    CGRect datLBLFrm=DateLBL.frame;
    datLBLFrm.origin.y=scrlHeight;
    datLBLFrm.size.width=ViewWIdth-16;
    DateLBL.frame=datLBLFrm;
    
    
    scrlHeight=scrlHeight+DateLBL.frame.size.height+5;
    
    scrlHeight=scrlHeight+15;
    
    UILabel *IandPLBL=[[UILabel alloc]initWithFrame:CGRectMake(12, scrlHeight, ViewWIdth-24, 20)];
    IandPLBL.text=@"Items and Price";
    IandPLBL.textColor=[UIColor whiteColor];
    IandPLBL.font=[UIFont fontWithName:@"ProximaNova-Bold" size:16.0];
    [BillCSCRL addSubview:IandPLBL];
    
    scrlHeight=scrlHeight+IandPLBL.frame.size.height+5;
    
    UIImageView *line1IMG=[[UIImageView alloc]initWithFrame:CGRectMake(0, scrlHeight, ViewWIdth, 1)];
    line1IMG.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
    [BillCSCRL addSubview:line1IMG];
    
    scrlHeight=scrlHeight+6;
    
   
    UILabel *EventPckTYP=[[UILabel alloc]initWithFrame:CGRectMake(16, scrlHeight, ViewWIdth-32, 20)];
    EventPckTYP.text=[NSString stringWithFormat:@"%@",[PackDetailDict valueForKey:@"title"]];
    EventPckTYP.textColor=[UIColor whiteColor];
    EventPckTYP.font=[UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
    [BillCSCRL addSubview:EventPckTYP];
    
    scrlHeight=scrlHeight+6+EventPckTYP.frame.size.height;
    
    UILabel *PAmountLBL=[[UILabel alloc]initWithFrame:CGRectMake(16, scrlHeight, ViewWIdth-32, 20)];
    PAmountLBL.text=[NSString stringWithFormat:@"%@SGD",[PackDetailDict valueForKey:@"price"]];
    PAmountLBL.textColor=[UIColor whiteColor];
    PAmountLBL.font=[UIFont fontWithName:@"ProximaNova-Bold" size:17.0];
    [BillCSCRL addSubview:PAmountLBL];
    

    scrlHeight=scrlHeight+PAmountLBL.frame.size.height+5;
    
    UIImageView *line2IMG=[[UIImageView alloc]initWithFrame:CGRectMake(0, scrlHeight, ViewWIdth, 1)];
    line2IMG.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
    [BillCSCRL addSubview:line2IMG];
    
    scrlHeight=scrlHeight+12;
    
    UILabel *TotalLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, scrlHeight, 60, 20)];
    TotalLBL.text=@"Total";
    TotalLBL.textColor=[UIColor whiteColor];
    TotalLBL.font=[UIFont fontWithName:@"ProximaNova-Semibold" size:14.0];
    [BillCSCRL addSubview:TotalLBL];
    
    UILabel *Tlbl=[[UILabel alloc]initWithFrame:CGRectMake(10+TotalLBL.frame.size.width+5, scrlHeight, ViewWIdth-(TotalLBL.frame.size.width+25), 20)];
    Tlbl.text=[NSString stringWithFormat:@"$ %@",[PackDetailDict valueForKey:@"price"]];
    Tlbl.textColor=[UIColor whiteColor];
    Tlbl.font=[UIFont fontWithName:@"ProximaNova-Bold" size:16.0];
    Tlbl.textAlignment=NSTextAlignmentRight;
    [BillCSCRL addSubview:Tlbl];

    scrlHeight=scrlHeight+TotalLBL.frame.size.height;
    
    UILabel *pChargeLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, scrlHeight, 120, 20)];
    pChargeLBL.text=@"Processing Fees - $3.50";
    pChargeLBL.textColor=[UIColor whiteColor];
    pChargeLBL.font=[UIFont fontWithName:@"ProximaNova-Regular" size:11.0];
    [BillCSCRL addSubview:pChargeLBL];
    
    UILabel *GTLBL=[[UILabel alloc]initWithFrame:CGRectMake(10+pChargeLBL.frame.size.width+5, scrlHeight+3, ViewWIdth-(pChargeLBL.frame.size.width+25), 20)];
    GTLBL.text=[NSString stringWithFormat:@"$ %.02f",(float)([[NSString stringWithFormat:@"%@",[PackDetailDict valueForKey:@"price"]] floatValue]+3.5)];
    GTLBL.textColor=[UIColor whiteColor];
    GTLBL.font=[UIFont fontWithName:@"ProximaNova-Bold" size:16.0];
    GTLBL.textAlignment=NSTextAlignmentRight;
    [BillCSCRL addSubview:GTLBL];
    
    
    scrlHeight=scrlHeight+GTLBL.frame.size.height+3+10;
    
    UIImageView *line3IMG=[[UIImageView alloc]initWithFrame:CGRectMake(0, scrlHeight, ViewWIdth, 1)];
    line3IMG.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
    [BillCSCRL addSubview:line3IMG];

    scrlHeight=scrlHeight+11;
    
    UIButton *BookNWBTN=[[UIButton alloc]initWithFrame:CGRectMake(16, scrlHeight, ViewWIdth-32, 50)];
    BookNWBTN.titleLabel.font=[UIFont fontWithName:@"ProximaNova-Bold" size:19.0];
    [BookNWBTN setTitle:@"BOOK NOW" forState:UIControlStateNormal];
    [BookNWBTN setBackgroundImage:[UIImage imageNamed:@"btn_big_login_general.png"] forState:UIControlStateNormal];
    [BookNWBTN addTarget:self action:@selector(BookNOWBTNCLick) forControlEvents:UIControlEventTouchUpInside];
    [BillCSCRL addSubview:BookNWBTN];
    
    scrlHeight=scrlHeight+BookNWBTN.frame.size.height+10;
    
    BillCSCRL.contentSize=CGSizeMake(ViewWIdth, scrlHeight);
}
-(void)BookNOWBTNCLick
{
    [[NSUserDefaults standardUserDefaults]setFloat:(float)([[NSString stringWithFormat:@"%@",[PackDetailDict valueForKey:@"price"]] floatValue]+3.5) forKey:@"PayableAMountRoof"];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"woofrPROMOcodeUsed"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    PaymentVC *dealVC1 = (PaymentVC *)[storyboard instantiateViewControllerWithIdentifier:@"PaymentVC"];
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
