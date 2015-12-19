//
//  BillDeatilVC.m
//  WOOFR
//
//  Created by dipen  narola on 08/12/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import "BillDeatilVC.h"
#import "PaymentVC.h"

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.6;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@interface BillDeatilVC ()
{
    NSMutableDictionary *clubDetailDict,*Foodorderdict;
    
    NSMutableArray *foodPriceARY,*FoodnameARY;
    
    float foodAmount,NetAMount,GlobalHeight;
    int promocoDeID;
    
    UITextField *PromoTF;
    UIButton *CBoOkNowbTN;
    
    UILabel *congratsLBL,*DiscountLBL,*NetPALBL,*DiscALBL,*FPAmountLBL,*NFPAmountLBL;
    
    BOOL is_promocode;
}

@end

@implementation BillDeatilVC

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
    
    
    
    //    self.navigationItem.backBarButtonItem.image=[UIImage imageNamed:@"ic_header_back.png"];
    //    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"back-button-image"]];
    //    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back-button-image"]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor]];
    
    self.title=@"Are you ready?";
    
    clubDetailDict=[[NSMutableDictionary alloc]init];
    clubDetailDict=[[NSUserDefaults standardUserDefaults]valueForKey:@"WoofrclubDetail"];
    
    NSLog(@"%@",clubDetailDict);
    
    is_promocode=NO;
    
    [self LoadvIEWbill];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
   
}

-(void)LoadvIEWbill
{
    float scrlHeight;
    
    scrlHeight=0;
    
    NetAMount=0;
    GlobalHeight=0;
    
    NSMutableArray *tempIMgary=[[NSMutableArray alloc]init];
    tempIMgary=[clubDetailDict valueForKey:@"club_images"];
    
    NSLog(@"%@",clubDetailDict);
    
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
    DateVDict=[[NSUserDefaults standardUserDefaults]valueForKey:@"WoofrBOOkingDate"];
    TimeVDict=[[NSUserDefaults standardUserDefaults]valueForKey:@"WoofrBOOkingTime"];
    
    NSLog(@"%@",DateVDict);
    NSLog(@"%@",TimeVDict);
    
    NSString *datestr=[DateVDict valueForKey:@"FullDate"];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *fdate=[dateFormatter dateFromString:datestr];
    [dateFormatter setDateFormat:@"dd/MM/yy"];
    
    NSString *ffdatestr=[dateFormatter stringFromDate:fdate];
    
    
    
    DateLBL.text=[NSString stringWithFormat:@"%@,%@ On %@ @%@",ffdatestr,[DateVDict valueForKey:@"WeekDay"],[TimeVDict valueForKey:@"time"],[clubDetailDict valueForKey:@"club_name"]];
    
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
    IandPLBL.font=[UIFont boldSystemFontOfSize:16.0];
    [BillCSCRL addSubview:IandPLBL];
    
    scrlHeight=scrlHeight+IandPLBL.frame.size.height+5;
    
    UIImageView *line1IMG=[[UIImageView alloc]initWithFrame:CGRectMake(0, scrlHeight, ViewWIdth, 1)];
    line1IMG.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
    [BillCSCRL addSubview:line1IMG];
    
    scrlHeight=scrlHeight+6;
    
    NSDictionary *tblDetailDict=[[NSDictionary alloc]init];
    
    tblDetailDict=[[NSUserDefaults standardUserDefaults]valueForKey:@"WooferTBLfoodvalues"];
    
    NSLog(@"%@",tblDetailDict);
    
    NSString *TBLType=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"WoofrTBLType"]];
    
    UILabel *TBLTYPElbl=[[UILabel alloc]initWithFrame:CGRectMake(5, scrlHeight, (ViewWIdth-15)/2, 30)];
    TBLTYPElbl.numberOfLines=4;
    TBLTYPElbl.font=[UIFont systemFontOfSize:11.0];
    TBLTYPElbl.textColor=[UIColor whiteColor];
    if([TBLType isEqualToString:@"1"])
    {
        TBLTYPElbl.text=@"VIP Table Packages";
    }
    else
    {
        TBLTYPElbl.text=@"Normal Table Packages";
    }
    [TBLTYPElbl sizeToFit];
    [BillCSCRL addSubview:TBLTYPElbl];
    
    
    
    UILabel *packTypeLBL=[[UILabel alloc]initWithFrame:CGRectMake((ViewWIdth/2)+2.5, scrlHeight, (ViewWIdth-15)/2, 30)];
    packTypeLBL.numberOfLines=4;
    packTypeLBL.textAlignment=NSTextAlignmentRight;
    packTypeLBL.text=[NSString stringWithFormat:@"%@",[tblDetailDict valueForKey:@"package_name"]];
    packTypeLBL.font=[UIFont systemFontOfSize:11.0];
    packTypeLBL.textColor=[UIColor whiteColor];
    [packTypeLBL sizeToFit];
    
    CGRect pckfrm = packTypeLBL.frame;
    pckfrm.size.width=(ViewWIdth-15)/2;
    packTypeLBL.frame=pckfrm;
    
    [BillCSCRL addSubview:packTypeLBL];
    
    
    
    UILabel *PriceLBL=[[UILabel alloc]initWithFrame:CGRectMake(5, scrlHeight+TBLTYPElbl.frame.size.height+3, (ViewWIdth-15)/2, 30)];
    PriceLBL.numberOfLines=4;
    PriceLBL.font=[UIFont boldSystemFontOfSize:15.0];
    PriceLBL.textColor=[UIColor whiteColor];
    PriceLBL.text=[NSString stringWithFormat:@"%@SGD",[tblDetailDict valueForKey:@"price"]];
    [PriceLBL sizeToFit];
    [BillCSCRL addSubview:PriceLBL];
    
    
    
    UILabel *GoersTypeLBL=[[UILabel alloc]initWithFrame:CGRectMake((ViewWIdth/2)+2.5, scrlHeight+3+packTypeLBL.frame.size.height, (ViewWIdth-15)/2, 30)];
    GoersTypeLBL.numberOfLines=4;
    GoersTypeLBL.textAlignment=NSTextAlignmentRight;
    GoersTypeLBL.text=[NSString stringWithFormat:@" 1 to %@ goers",[tblDetailDict valueForKey:@"total_seat"]];
    GoersTypeLBL.font=[UIFont systemFontOfSize:11.0];
    GoersTypeLBL.textColor=[UIColor whiteColor];
    [GoersTypeLBL sizeToFit];
    
    CGRect Goersfrm = GoersTypeLBL.frame;
    Goersfrm.size.width=(ViewWIdth-15)/2;
    GoersTypeLBL.frame=Goersfrm;
    
    [BillCSCRL addSubview:GoersTypeLBL];
    
    
    if(PriceLBL.frame.size.height+PriceLBL.frame.origin.y>GoersTypeLBL.frame.origin.y+GoersTypeLBL.frame.size.height)
    {
        scrlHeight= PriceLBL.frame.size.height+PriceLBL.frame.origin.y+15;
    }
    else
    {
        scrlHeight= GoersTypeLBL.frame.origin.y+GoersTypeLBL.frame.size.height+15;
    }
    
    Foodorderdict=[[NSMutableDictionary alloc]init];
    Foodorderdict=[[NSUserDefaults standardUserDefaults] valueForKey:@"FoodOrderDictWoofr"];
    
    FoodnameARY=[[NSMutableArray alloc]init];
    FoodnameARY=[[NSUserDefaults standardUserDefaults]valueForKey:@"WoofrFoodname"];
    
    
    foodPriceARY=[[NSMutableArray alloc]init];
    foodPriceARY=[[NSUserDefaults standardUserDefaults]valueForKey:@"WoofrFoodprice"];
    
    
    foodAmount=0;
    
    BOOL is_foodorder=NO;
    
    for(int i=0;i<FoodnameARY.count;i++)
    {
        NSString *Foodnmstr =[NSString stringWithFormat:@"%@",[FoodnameARY objectAtIndex:i]];
        
        if ([Foodorderdict objectForKey:Foodnmstr])
        {
            int Quantity;
            Quantity=[[NSString stringWithFormat:@"%@",[Foodorderdict valueForKey:Foodnmstr]] intValue];
            
            if(Quantity>0)
            {
                is_foodorder=YES;
                scrlHeight = scrlHeight+10;
                
                UILabel *FoodnameLBL=[[UILabel alloc]initWithFrame:CGRectMake(8, scrlHeight, ViewWIdth-155, 500)];
                FoodnameLBL.numberOfLines=10;
                FoodnameLBL.text=Foodnmstr;
                FoodnameLBL.textColor=[UIColor whiteColor];
                FoodnameLBL.font=[UIFont systemFontOfSize:15.0];
                [FoodnameLBL sizeToFit];
                [BillCSCRL addSubview:FoodnameLBL];
                
                
                UILabel *PriceLBL=[[UILabel alloc]initWithFrame:CGRectMake(ViewWIdth-145, scrlHeight, 40, FoodnameLBL.frame.size.height)];
                PriceLBL.text=[NSString stringWithFormat:@"$%@",[foodPriceARY objectAtIndex:i]];
                PriceLBL.textColor=[UIColor whiteColor];
                PriceLBL.textAlignment=NSTextAlignmentCenter;
                PriceLBL.font=[UIFont systemFontOfSize:13.0];
                [BillCSCRL addSubview:PriceLBL];
                
                UILabel *QuantiLBL=[[UILabel alloc]initWithFrame:CGRectMake(PriceLBL.frame.size.width+PriceLBL.frame.origin.x+2, scrlHeight, 30, FoodnameLBL.frame.size.height)];
                QuantiLBL.text=[NSString stringWithFormat:@"x%i",Quantity];
                //              QuantiLBL.text=[NSString stringWithFormat:@"x100"];
                QuantiLBL.textColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
                QuantiLBL.textAlignment=NSTextAlignmentCenter;
                QuantiLBL.font=[UIFont systemFontOfSize:13.0];
                [BillCSCRL addSubview:QuantiLBL];
                
                UILabel *TLBL=[[UILabel alloc]initWithFrame:CGRectMake(QuantiLBL.frame.origin.x+QuantiLBL.frame.size.width+2, scrlHeight,(ViewWIdth-(QuantiLBL.frame.origin.x+QuantiLBL.frame.size.width+7)),FoodnameLBL.frame.size.height)];
                TLBL.textAlignment=NSTextAlignmentRight;
                float Tvalue;
                Tvalue=[[NSString stringWithFormat:@"%@",[foodPriceARY objectAtIndex:i]] floatValue]*Quantity;
                TLBL.text=[NSString stringWithFormat:@"$%.02f",Tvalue];
                TLBL.textColor=[UIColor whiteColor];
                TLBL.font=[UIFont systemFontOfSize:13.0];
                [BillCSCRL addSubview:TLBL];
                
                foodAmount=foodAmount+Tvalue;
                
                scrlHeight=scrlHeight+FoodnameLBL.frame.size.height+10;
                
                UIImageView *LineImg=[[UIImageView alloc]initWithFrame:CGRectMake(8, scrlHeight-1, ViewWIdth-13, 1)];
                LineImg.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
                [BillCSCRL addSubview:LineImg];
                
            }
        }
        
    }
    
    if(is_foodorder==YES)
    {
        scrlHeight=scrlHeight+10;
        
        UIImageView *Line4Img=[[UIImageView alloc]initWithFrame:CGRectMake(0, scrlHeight-1, ViewWIdth, 1)];
        Line4Img.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        [BillCSCRL addSubview:Line4Img];
        
        scrlHeight=scrlHeight+10;
        
        UILabel *TBLPLBL=[[UILabel alloc]initWithFrame:CGRectMake(8, scrlHeight, ViewWIdth/2, 20)];
        TBLPLBL.text=@"Food & Drinks Total";
        TBLPLBL.font=[UIFont systemFontOfSize:15.0];
        TBLPLBL.textColor=[UIColor whiteColor];
        [BillCSCRL addSubview:TBLPLBL];
        
        
        UILabel *TBLCLBL=[[UILabel alloc]initWithFrame:CGRectMake(ViewWIdth/2, scrlHeight, ViewWIdth/2-5, 20)];
        TBLCLBL.text=[NSString stringWithFormat:@"$%.02f",foodAmount];
        TBLCLBL.font=[UIFont systemFontOfSize:15.0];
        TBLCLBL.textAlignment=NSTextAlignmentRight;
        TBLCLBL.textColor=[UIColor whiteColor];
        
        [BillCSCRL addSubview:TBLCLBL];
        
        scrlHeight=scrlHeight+TBLPLBL.frame.size.height;
    }
    
    
    
    scrlHeight=scrlHeight+10;
    
    UIImageView *Line3Img=[[UIImageView alloc]initWithFrame:CGRectMake(0, scrlHeight-1, ViewWIdth, 1)];
    Line3Img.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
    [BillCSCRL addSubview:Line3Img];
    
    scrlHeight=scrlHeight+10;
    
    UILabel *TBLPLBL=[[UILabel alloc]initWithFrame:CGRectMake(8, scrlHeight, ViewWIdth/2, 20)];
    TBLPLBL.text=@"Table Price";
    TBLPLBL.font=[UIFont systemFontOfSize:15.0];
    TBLPLBL.textColor=[UIColor whiteColor];
    [BillCSCRL addSubview:TBLPLBL];
    
    
    UILabel *TBLCLBL=[[UILabel alloc]initWithFrame:CGRectMake(ViewWIdth/2, scrlHeight, ViewWIdth/2-5, 20)];
    TBLCLBL.text=[NSString stringWithFormat:@"+ $%.02f",[[tblDetailDict valueForKey:@"price"] floatValue]];
    TBLCLBL.font=[UIFont systemFontOfSize:15.0];
    TBLCLBL.textAlignment=NSTextAlignmentRight;
    TBLCLBL.textColor=[UIColor whiteColor];
    
    [BillCSCRL addSubview:TBLCLBL];
    
    scrlHeight=scrlHeight+10+TBLPLBL.frame.size.height;
    
    foodAmount=foodAmount+[[NSString stringWithFormat:@"%@",[tblDetailDict valueForKey:@"price"]] floatValue];
    
    
    //    UIImageView *LinetotalIMG=[[UIImageView alloc]initWithFrame:CGRectMake(0, scrlHeight, ViewWIdth, 1)];
    //    LinetotalIMG.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
    //    [BillCSCRL addSubview:LinetotalIMG];
    
    scrlHeight=scrlHeight+10;
    
    UILabel *FCLBL=[[UILabel alloc]initWithFrame:CGRectMake(ViewWIdth/2, scrlHeight, ViewWIdth/2-5, 20)];
    FCLBL.text=[NSString stringWithFormat:@"$%.02f",foodAmount];
    FCLBL.font=[UIFont systemFontOfSize:15.0];
    FCLBL.textAlignment=NSTextAlignmentRight;
    FCLBL.textColor=[UIColor whiteColor];
    [BillCSCRL addSubview:FCLBL];
    
    
    scrlHeight=scrlHeight+10+FCLBL.frame.size.height;
    
    //    UIImageView *Line5IMG=[[UIImageView alloc]initWithFrame:CGRectMake(0, scrlHeight, ViewWIdth, 1)];
    //    Line5IMG.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
    //    [BillCSCRL addSubview:Line5IMG];
    
    scrlHeight=scrlHeight+10;
    
    
    
    UILabel *AdminLBL=[[UILabel alloc]initWithFrame:CGRectMake(8, scrlHeight, ViewWIdth/2, 20)];
    AdminLBL.text=@"Admin Fee : 10% ";
    AdminLBL.font=[UIFont systemFontOfSize:15.0];
    AdminLBL.textColor=[UIColor whiteColor];
    [BillCSCRL addSubview:AdminLBL];
    
    
    UILabel *AdminCLBL=[[UILabel alloc]initWithFrame:CGRectMake(ViewWIdth/2, scrlHeight, ViewWIdth/2-5, 20)];
    AdminCLBL.text=[NSString stringWithFormat:@"+ $%.02f",((foodAmount*10)/100)];
    AdminCLBL.font=[UIFont systemFontOfSize:15.0];
    AdminCLBL.textAlignment=NSTextAlignmentRight;
    AdminCLBL.textColor=[UIColor whiteColor];
    
    [BillCSCRL addSubview:AdminCLBL];
    
    scrlHeight=scrlHeight+AdminCLBL.frame.size.height+10;
    
    //    UIImageView *Line6Img=[[UIImageView alloc]initWithFrame:CGRectMake(0, scrlHeight-1, ViewWIdth, 1)];
    //    Line6Img.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
    //    [BillCSCRL addSubview:Line6Img];
    
    scrlHeight=scrlHeight+10;
    
    foodAmount=foodAmount+((foodAmount*10)/100);
    
    
    UILabel *netPLBL=[[UILabel alloc]initWithFrame:CGRectMake(8, scrlHeight, ViewWIdth/2, 20)];
    netPLBL.text=@"Net Payable Amount";
    netPLBL.font=[UIFont systemFontOfSize:15.0];
    netPLBL.textColor=[UIColor whiteColor];
    [BillCSCRL addSubview:netPLBL];
    
    
    UILabel *TnetpayLBL=[[UILabel alloc]initWithFrame:CGRectMake(ViewWIdth/2, scrlHeight, ViewWIdth/2-5, 20)];
    TnetpayLBL.text=[NSString stringWithFormat:@"%.02fSGD",foodAmount];
    NetAMount=foodAmount;
    TnetpayLBL.font=[UIFont systemFontOfSize:15.0];
    TnetpayLBL.textAlignment=NSTextAlignmentRight;
    TnetpayLBL.textColor=[UIColor whiteColor];
    
    [BillCSCRL addSubview:TnetpayLBL];
    
    scrlHeight=scrlHeight+10+TnetpayLBL.frame.size.height;
    
    UIImageView *Line6Img=[[UIImageView alloc]initWithFrame:CGRectMake(0, scrlHeight-1, ViewWIdth, 1)];
    Line6Img.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
    [BillCSCRL addSubview:Line6Img];
    
    
    [[NSUserDefaults standardUserDefaults]setFloat:foodAmount forKey:@"WoofrPayAMount"];
    
    
    scrlHeight=scrlHeight+15;
    
    UIView *TFBackView=[[UIView alloc]initWithFrame:CGRectMake((ViewWIdth/2)-125, scrlHeight, 250, 30)];
    TFBackView.userInteractionEnabled=YES;
    TFBackView.backgroundColor=[UIColor clearColor];
    
    PromoTF=[[UITextField alloc]initWithFrame:CGRectMake(0, 1, 163, 28)];
    //    PromoTF.textAlignment=NSTextAlignmentCenter;
    PromoTF.delegate=self;
    PromoTF.textColor=[UIColor whiteColor];
    PromoTF.font=[UIFont systemFontOfSize:14.0];
    PromoTF.placeholder=@"Promo code";
    PromoTF.layer.borderWidth=1.0;
    PromoTF.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    [PromoTF setValue:[UIColor whiteColor]
           forKeyPath:@"_placeholderLabel.textColor"];
    
    PromoTF.leftView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    PromoTF.leftViewMode = UITextFieldViewModeAlways;
    
    [TFBackView addSubview:PromoTF];
    
    UIButton *applyBTN=[[UIButton alloc]initWithFrame:CGRectMake(168, 2, 82, 25)];
    [applyBTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [applyBTN setBackgroundImage:[UIImage imageNamed:@"btn_small_login_general.png"] forState:UIControlStateNormal];
    [applyBTN setTitle:@"APPLY" forState:UIControlStateNormal];
    [applyBTN addTarget:self action:@selector(Applyclick) forControlEvents:UIControlEventTouchUpInside];
    applyBTN.titleLabel.font=[UIFont systemFontOfSize:12.0];
    [TFBackView addSubview:applyBTN];
    
    [BillCSCRL addSubview:TFBackView];
    
    
    scrlHeight=scrlHeight+15+TFBackView.frame.size.height;
    
    GlobalHeight=scrlHeight;
    
    CBoOkNowbTN = [[UIButton alloc]initWithFrame:CGRectMake(10, scrlHeight, ViewWIdth-20, 50)];
    [CBoOkNowbTN setBackgroundImage:[UIImage imageNamed:@"btn_small_login_general.png"] forState:UIControlStateNormal];
    [CBoOkNowbTN setTitle:@"BOOK NOW" forState:UIControlStateNormal];
    [CBoOkNowbTN addTarget:self action:@selector(CBoOkNowbTNclick) forControlEvents:UIControlEventTouchUpInside];
    [CBoOkNowbTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CBoOkNowbTN.titleLabel.font=[UIFont boldSystemFontOfSize:16.0];
    
    [BillCSCRL addSubview:CBoOkNowbTN];
    
    scrlHeight=scrlHeight+10+CBoOkNowbTN.frame.size.height;
    
    
    BillCSCRL.contentSize=CGSizeMake(ViewWIdth, scrlHeight);
}
-(void)Applyclick
{
    [PromoTF resignFirstResponder];
    
    if(PromoTF.text.length>0)
    {
        [HUD show:YES];
        NSString *urlStr =FIND_URL;
        
        //admin.vasundharavision.com/woofr/api/?action=promo_code&code=CLUB10&user_id=1
        
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
        [sendData setObject:@"promo_code" forKey:@"action"];
        [sendData setObject:[NSString stringWithFormat:@"%@",PromoTF.text] forKey:@"code"];
        [sendData setObject:uIDSTR forKey:@"user_id"];
        [sendData setObject:[NSString stringWithFormat:@"%@",[clubDetailDict valueForKey:@"club_id"]] forKey:@"club_id"];
        
        
        
        
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
        
        Promoconnection = [NSURLConnection connectionWithRequest:request delegate:self];
        if (Promoconnection)
        {
            PromoData = [[NSMutableData alloc]init];
        }

    }
    
}
//********************************************
#pragma mark - Connection Delegate Methods
//********************************************

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection == Promoconnection)
    {
        [PromoData appendData:data];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (connection == Promoconnection)
    {
        [PromoData setLength:0];
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
    if (connection == Promoconnection)
    {
        NSMutableString *responceversionStr = [[NSMutableString alloc]initWithBytes:[PromoData mutableBytes] length:[PromoData length] encoding:NSUTF8StringEncoding];
        NSMutableDictionary *gat_dic = [[NSMutableDictionary alloc]init];
        [gat_dic setDictionary:[responceversionStr JSONValue]];
        
        [HUD hide:YES];
        
        NSLog(@"%@",gat_dic);
        
        NSString *statusSTR=[NSString stringWithFormat:@"%@",[gat_dic valueForKey:@"status"]];
        
        if([statusSTR isEqualToString:@"1"])
        {
            float heightv;
            
            is_promocode=YES;
            
            promocoDeID = [[NSString stringWithFormat:@"%@",[gat_dic valueForKey:@"promocode_id"]] intValue];
            
            heightv=GlobalHeight;
            [congratsLBL removeFromSuperview];
            [DiscountLBL removeFromSuperview];
            [DiscALBL removeFromSuperview];
            [FPAmountLBL removeFromSuperview];
            [NFPAmountLBL removeFromSuperview];
            
            congratsLBL=[[UILabel alloc]initWithFrame:CGRectMake(8, heightv, ViewWIdth-16, 500)];
            congratsLBL.text=[NSString stringWithFormat:@"Congratulations! You have successfuly added Promocode for Woofr.You will get %@%% Discount on total amount",[gat_dic valueForKey:@"discount"]];
            congratsLBL.textColor=[UIColor whiteColor];
            congratsLBL.numberOfLines=50;
            congratsLBL.textAlignment=NSTextAlignmentCenter;
            congratsLBL.font=[UIFont systemFontOfSize:15.0];
            [congratsLBL sizeToFit];
            [BillCSCRL addSubview:congratsLBL];
            
            heightv=heightv+10+congratsLBL.frame.size.height;
            
            
            
            DiscountLBL=[[UILabel alloc]initWithFrame:CGRectMake(8, heightv, ViewWIdth/2, 20)];
            DiscountLBL.text=@"Total Discount :";
            DiscountLBL.font=[UIFont systemFontOfSize:15.0];
            DiscountLBL.textColor=[UIColor whiteColor];
            [BillCSCRL addSubview:DiscountLBL];
            
            
            DiscALBL=[[UILabel alloc]initWithFrame:CGRectMake(ViewWIdth/2, heightv, ViewWIdth/2-5, 20)];
            DiscALBL.text=[NSString stringWithFormat:@"- $%.02f",(foodAmount*([[NSString stringWithFormat:@"%@",[gat_dic valueForKey:@"discount"]] floatValue])/100)];
            DiscALBL.font=[UIFont systemFontOfSize:15.0];
            DiscALBL.textAlignment=NSTextAlignmentRight;
            DiscALBL.textColor=[UIColor whiteColor];
            
            [BillCSCRL addSubview:DiscALBL];
            
            heightv=heightv+10+DiscALBL.frame.size.height;
            
            
            FPAmountLBL=[[UILabel alloc]initWithFrame:CGRectMake(8, heightv, ViewWIdth/2, 20)];
            FPAmountLBL.text=@"Total Amount :";
            FPAmountLBL.font=[UIFont systemFontOfSize:15.0];
            FPAmountLBL.textColor=[UIColor whiteColor];
            [BillCSCRL addSubview:FPAmountLBL];
            
            
            NetAMount=foodAmount-(foodAmount*([[NSString stringWithFormat:@"%@",[gat_dic valueForKey:@"discount"]] floatValue])/100);
            
            NFPAmountLBL=[[UILabel alloc]initWithFrame:CGRectMake(ViewWIdth/2, heightv, ViewWIdth/2-5, 20)];
            NFPAmountLBL.text=[NSString stringWithFormat:@"$%.02f",NetAMount];
            NFPAmountLBL.font=[UIFont systemFontOfSize:15.0];
            NFPAmountLBL.textAlignment=NSTextAlignmentRight;
            NFPAmountLBL.textColor=[UIColor whiteColor];
            [BillCSCRL addSubview:NFPAmountLBL];

             heightv=heightv+15+NFPAmountLBL.frame.size.height;
            
            CGRect BTNFRM = CBoOkNowbTN.frame;
            BTNFRM.origin.y=heightv;
            CBoOkNowbTN.frame=BTNFRM;
            
            heightv=heightv+BTNFRM.size.height+15;
            
            BillCSCRL.contentSize=CGSizeMake(ViewWIdth, heightv);
            
        }
        else
        {
            PromoTF.text=@"";
            
            is_promocode=NO;
            
            float heightv;
            
            heightv=GlobalHeight;
            
            [congratsLBL removeFromSuperview];
            [DiscountLBL removeFromSuperview];
            [DiscALBL removeFromSuperview];
            [FPAmountLBL removeFromSuperview];
            [NFPAmountLBL removeFromSuperview];
            
           
            NetAMount=foodAmount;
            
            //heightv=heightv+15;
            
            CGRect BTNFRM = CBoOkNowbTN.frame;
            BTNFRM.origin.y=heightv;
            CBoOkNowbTN.frame=BTNFRM;
            
            heightv=heightv+BTNFRM.size.height+15;
            
            BillCSCRL.contentSize=CGSizeMake(ViewWIdth, heightv);
            
            
            
            UIAlertView *connectionlert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"%@",[gat_dic valueForKey:@"message"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [connectionlert show];
        }
    }
}
-(void)CBoOkNowbTNclick
{
    
    [[NSUserDefaults standardUserDefaults]setFloat:NetAMount forKey:@"PayableAMountRoof"];
    
    if(is_promocode==YES)
    {
        [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%i",promocoDeID] forKey:@"woofereventPromocode"];
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"woofrPROMOcodeUsed"];
        
    }
    else
    {
         [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"woofrPROMOcodeUsed"];
    }
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    PaymentVC *dealVC1 = (PaymentVC *)[storyboard instantiateViewControllerWithIdentifier:@"PaymentVC"];
    [self.navigationController pushViewController:dealVC1 animated:YES];
}
//**********************************
#pragma mark - Auto scroll view
//**********************************

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    self.view.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    CGRect textFieldRect =[self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect = CGRectMake(0, 45, 320, 600);
    [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

//**********************************
#pragma mark - textfield delegate set
//**********************************

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    NSInteger nextTag = textField.tag;
    
    nextTag=nextTag+1;
    
    NSLog(@"%li",(long)nextTag);
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    
    if (nextResponder)
    {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else
    {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    
    return YES;
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
