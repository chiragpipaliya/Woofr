//
//  FoodDetailVC.m
//  WOOFR
//
//  Created by dipen  narola on 07/12/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import "FoodDetailVC.h"
#import "BillDeatilVC.h"

@interface FoodDetailVC ()
{
    NSMutableDictionary *FooddetailDict,*OrderDetailDict;
    
    NSMutableArray *FeaturedARY,*BeerARY,*champagneARY;
    
    NSMutableArray *FoodnameARY,*priceARY,*fidARY;
    
}

@end

@implementation FoodDetailVC

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
    
    FooddetailDict=[[NSMutableDictionary alloc]init];
    OrderDetailDict=[[NSMutableDictionary alloc]init];
    
    FoodnameARY=[[NSMutableArray alloc]init];
    priceARY=[[NSMutableArray alloc]init];
    fidARY=[[NSMutableArray alloc]init];
    FooddetailDict=[[NSUserDefaults standardUserDefaults]valueForKey:@"WooferTBLfoodvalues"];
    
    
     self.title=[NSString stringWithFormat:@"%@SGD",[FooddetailDict valueForKey:@"price"]];
    
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(donePressed)];
    doneBtn.tintColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
    self.navigationItem.rightBarButtonItem=doneBtn;
    
    
    [self loadSCRL];

}
-(void)donePressed
{
    [[NSUserDefaults standardUserDefaults] setValue:OrderDetailDict forKey:@"FoodOrderDictWoofr"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    BillDeatilVC *dealVC1 = (BillDeatilVC *)[storyboard instantiateViewControllerWithIdentifier:@"BillDeatilVC"];
    [self.navigationController pushViewController:dealVC1 animated:YES];

}
-(void)loadSCRL
{
    float SCRLheighT;
    
    SCRLheighT=0;
    NSLog(@"%@",FooddetailDict);
    
    
    FeaturedARY=[[NSMutableArray alloc]init];
    FeaturedARY=[FooddetailDict valueForKey:@"featured"];
    
    if([NSString stringWithFormat:@"%@",FeaturedARY].length>5)
    {
        UILabel *FetureLBL=[[UILabel alloc]initWithFrame:CGRectMake(0, SCRLheighT, ViewWIdth, 40)];
        FetureLBL.text=@"  Featured";
        FetureLBL.textColor=[UIColor whiteColor];
        FetureLBL.font=[UIFont systemFontOfSize:15.0];
        FetureLBL.backgroundColor=[UIColor colorWithRed:201/255.0 green:177.0/255.0 blue:114.0/255.0 alpha:1.0];
        [FoodSCRl addSubview:FetureLBL];
        
        SCRLheighT=FetureLBL.frame.size.height;;
        
        for(int i=0;i<FeaturedARY.count;i++)
        {
            
            float Heightv = SCRLheighT;
            
            
            SCRLheighT=SCRLheighT+10;
            
            UILabel *fnameLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, SCRLheighT, ViewWIdth-120, 500)];
            fnameLBL.numberOfLines=5;
            fnameLBL.font=[UIFont systemFontOfSize:17.0];
            fnameLBL.textColor=[UIColor whiteColor];
            fnameLBL.text=[NSString stringWithFormat:@"%@",[[FeaturedARY objectAtIndex:i]valueForKey:@"food_name"]];
            [fnameLBL sizeToFit];
            [FoodSCRl addSubview:fnameLBL];
            [FoodnameARY addObject:[NSString stringWithFormat:@"%@",[[FeaturedARY objectAtIndex:i]valueForKey:@"food_name"]]];
            
            SCRLheighT=SCRLheighT+3+fnameLBL.frame.size.height;
            
            UILabel *priceLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, SCRLheighT, ViewWIdth-120, 20)];
            priceLBL.numberOfLines=2;
            priceLBL.font=[UIFont systemFontOfSize:12.0];
            priceLBL.textColor=[UIColor whiteColor];
            priceLBL.text=[NSString stringWithFormat:@"$%@",[[FeaturedARY objectAtIndex:i]valueForKey:@"food_price"]];
            [priceARY addObject:[NSString stringWithFormat:@"%@",[[FeaturedARY objectAtIndex:i]valueForKey:@"food_price"]]];
            [fidARY addObject:[NSString stringWithFormat:@"%@",[[FeaturedARY objectAtIndex:i]valueForKey:@"food_id"]]];
            
            [priceLBL sizeToFit];
            [FoodSCRl addSubview:priceLBL];
            
            SCRLheighT=SCRLheighT+10+priceLBL.frame.size.height;
            
            UIImageView *LineIMG=[[UIImageView alloc]initWithFrame:CGRectMake(0, SCRLheighT, ViewWIdth, 1)];
            LineIMG.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
            [FoodSCRl addSubview:LineIMG];
            
            UIImageView *MinImg=[[UIImageView alloc]initWithFrame:CGRectMake(ViewWIdth-105, Heightv+(((SCRLheighT-Heightv)/2)-10), 20, 20)];
            MinImg.image=[UIImage imageNamed:@"ic_select_extra_minus.png"];
            MinImg.tag=1000+i;
            MinImg.userInteractionEnabled=YES;
            [FoodSCRl addSubview:MinImg];
            
            
            UIButton *MinBTN=[[UIButton alloc]initWithFrame:CGRectMake(ViewWIdth-110, Heightv, 30, SCRLheighT-Heightv)];
            [MinBTN addTarget:self action:@selector(Fminbtnclick:) forControlEvents:UIControlEventTouchUpInside];
            MinBTN.tag=i+2000;
            [FoodSCRl addSubview:MinBTN];
            
            UILabel *CounterLBL=[[UILabel alloc]initWithFrame:CGRectMake(ViewWIdth-75, MinBTN.frame.origin.y, 30, MinBTN.frame.size.height)];
            CounterLBL.textAlignment=NSTextAlignmentCenter;
            CounterLBL.text=@"0";
            CounterLBL.font=[UIFont systemFontOfSize:15.0];
            CounterLBL.tag=3000+i;
            CounterLBL.textColor=[UIColor whiteColor];
            [FoodSCRl addSubview:CounterLBL];
            
            
            UIImageView *MAXImg=[[UIImageView alloc]initWithFrame:CGRectMake(ViewWIdth-35, Heightv+(((SCRLheighT-Heightv)/2)-10), 20, 20)];
            MAXImg.image=[UIImage imageNamed:@"ic_select_extra_plus.png"];
            MAXImg.tag=4000+i;
            MAXImg.userInteractionEnabled=YES;
            [FoodSCRl addSubview:MAXImg];
            
            
            UIButton *MAXBTN=[[UIButton alloc]initWithFrame:CGRectMake(ViewWIdth-40, Heightv, 30, SCRLheighT-Heightv)];
            [MAXBTN addTarget:self action:@selector(FMAXBTNclick:) forControlEvents:UIControlEventTouchUpInside];
            MAXBTN.tag=i+5000;
            [FoodSCRl addSubview:MAXBTN];
            
            
            
        }
    }
    
    BeerARY=[[NSMutableArray alloc]init];
    BeerARY=[FooddetailDict valueForKey:@"beer"];
    
    if([NSString stringWithFormat:@"%@",BeerARY].length>5)
    {
        
        UILabel *BeerLBL=[[UILabel alloc]initWithFrame:CGRectMake(0, SCRLheighT, ViewWIdth, 40)];
        BeerLBL.text=@"  Beer";
        BeerLBL.textColor=[UIColor whiteColor];
        BeerLBL.font=[UIFont systemFontOfSize:15.0];
        BeerLBL.backgroundColor=[UIColor colorWithRed:201/255.0 green:177.0/255.0 blue:114.0/255.0 alpha:1.0];
        [FoodSCRl addSubview:BeerLBL];
        
        SCRLheighT=BeerLBL.frame.size.height+SCRLheighT;
        
        for(int i=0;i<BeerARY.count;i++)
        {
            
            float Heightv = SCRLheighT;
            
            
            SCRLheighT=SCRLheighT+10;
            
            UILabel *BnameLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, SCRLheighT, ViewWIdth-120, 500)];
            BnameLBL.numberOfLines=5;
            BnameLBL.font=[UIFont systemFontOfSize:17.0];
            BnameLBL.textColor=[UIColor whiteColor];
            BnameLBL.text=[NSString stringWithFormat:@"%@",[[BeerARY objectAtIndex:i]valueForKey:@"food_name"]];
            [FoodnameARY addObject:[NSString stringWithFormat:@"%@",[[BeerARY objectAtIndex:i]valueForKey:@"food_name"]]];
            [BnameLBL sizeToFit];
            [FoodSCRl addSubview:BnameLBL];
            
            
            SCRLheighT=SCRLheighT+3+BnameLBL.frame.size.height;
            
            UILabel *BpriceLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, SCRLheighT, ViewWIdth-120, 20)];
            BpriceLBL.numberOfLines=2;
            BpriceLBL.font=[UIFont systemFontOfSize:12.0];
            BpriceLBL.textColor=[UIColor whiteColor];
            BpriceLBL.text=[NSString stringWithFormat:@"$%@",[[BeerARY objectAtIndex:i]valueForKey:@"food_price"]];
            [priceARY addObject:[NSString stringWithFormat:@"%@",[[BeerARY objectAtIndex:i]valueForKey:@"food_price"]]];
            [fidARY addObject:[NSString stringWithFormat:@"%@",[[BeerARY objectAtIndex:i]valueForKey:@"food_id"]]];
            [BpriceLBL sizeToFit];
            [FoodSCRl addSubview:BpriceLBL];
            
            SCRLheighT=SCRLheighT+10+BpriceLBL.frame.size.height;
            
            UIImageView *LineIMG=[[UIImageView alloc]initWithFrame:CGRectMake(0, SCRLheighT, ViewWIdth, 1)];
            LineIMG.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
            [FoodSCRl addSubview:LineIMG];
            
            UIImageView *MinImg=[[UIImageView alloc]initWithFrame:CGRectMake(ViewWIdth-105, Heightv+(((SCRLheighT-Heightv)/2)-10), 20, 20)];
            MinImg.image=[UIImage imageNamed:@"ic_select_extra_minus.png"];
            MinImg.tag=11000+i;
            MinImg.userInteractionEnabled=YES;
            [FoodSCRl addSubview:MinImg];
            
            
            UIButton *MinBTN=[[UIButton alloc]initWithFrame:CGRectMake(ViewWIdth-110, Heightv, 30, SCRLheighT-Heightv)];
            [MinBTN addTarget:self action:@selector(Bminbtnclick:) forControlEvents:UIControlEventTouchUpInside];
            MinBTN.tag=i+12000;
            [FoodSCRl addSubview:MinBTN];
            
            UILabel *CounterLBL=[[UILabel alloc]initWithFrame:CGRectMake(ViewWIdth-75, MinBTN.frame.origin.y, 30, MinBTN.frame.size.height)];
            CounterLBL.textAlignment=NSTextAlignmentCenter;
            CounterLBL.text=@"0";
            CounterLBL.font=[UIFont systemFontOfSize:15.0];
            CounterLBL.tag=13000+i;
            CounterLBL.textColor=[UIColor whiteColor];
            [FoodSCRl addSubview:CounterLBL];
            
            
            UIImageView *MAXImg=[[UIImageView alloc]initWithFrame:CGRectMake(ViewWIdth-35, Heightv+(((SCRLheighT-Heightv)/2)-10), 20, 20)];
            MAXImg.image=[UIImage imageNamed:@"ic_select_extra_plus.png"];
            MAXImg.tag=14000+i;
            MAXImg.userInteractionEnabled=YES;
            [FoodSCRl addSubview:MAXImg];
            
            
            UIButton *MAXBTN=[[UIButton alloc]initWithFrame:CGRectMake(ViewWIdth-40, Heightv, 30, SCRLheighT-Heightv)];
            [MAXBTN addTarget:self action:@selector(BMAXBTNclick:) forControlEvents:UIControlEventTouchUpInside];
            MAXBTN.tag=i+15000;
            [FoodSCRl addSubview:MAXBTN];
            
        }
    }
    
    champagneARY=[[NSMutableArray alloc]init];
    champagneARY=[FooddetailDict valueForKey:@"champagne"];
    
    if([NSString stringWithFormat:@"%@",champagneARY].length>5)
    {
        UILabel *ChampagneLBL=[[UILabel alloc]initWithFrame:CGRectMake(0, SCRLheighT, ViewWIdth, 40)];
        ChampagneLBL.text=@"  Champagne";
        ChampagneLBL.textColor=[UIColor whiteColor];
        ChampagneLBL.font=[UIFont systemFontOfSize:15.0];
        ChampagneLBL.backgroundColor=[UIColor colorWithRed:201/255.0 green:177.0/255.0 blue:114.0/255.0 alpha:1.0];
        [FoodSCRl addSubview:ChampagneLBL];
        
        SCRLheighT=ChampagneLBL.frame.size.height+SCRLheighT;
        
        for(int i=0;i<champagneARY.count;i++)
        {
            
            float Heightv = SCRLheighT;
            
            
            SCRLheighT=SCRLheighT+10;
            
            UILabel *CnameLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, SCRLheighT, ViewWIdth-120, 500)];
            CnameLBL.numberOfLines=5;
            CnameLBL.font=[UIFont systemFontOfSize:17.0];
            CnameLBL.textColor=[UIColor whiteColor];
            CnameLBL.text=[NSString stringWithFormat:@"%@",[[champagneARY objectAtIndex:i]valueForKey:@"food_name"]];
            [FoodnameARY addObject:[NSString stringWithFormat:@"%@",[[champagneARY objectAtIndex:i]valueForKey:@"food_name"]]];
            [CnameLBL sizeToFit];
            [FoodSCRl addSubview:CnameLBL];
            
            SCRLheighT=SCRLheighT+3+CnameLBL.frame.size.height;
            
            UILabel *CpriceLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, SCRLheighT, ViewWIdth-120, 20)];
            CpriceLBL.numberOfLines=2;
            CpriceLBL.font=[UIFont systemFontOfSize:12.0];
            CpriceLBL.textColor=[UIColor whiteColor];
            CpriceLBL.text=[NSString stringWithFormat:@"$%@",[[champagneARY objectAtIndex:i]valueForKey:@"food_price"]];
            [priceARY addObject:[NSString stringWithFormat:@"%@",[[champagneARY objectAtIndex:i]valueForKey:@"food_price"]]];
            [fidARY addObject:[NSString stringWithFormat:@"%@",[[champagneARY objectAtIndex:i]valueForKey:@"food_id"]]];
            [CpriceLBL sizeToFit];
            [FoodSCRl addSubview:CpriceLBL];
            
            SCRLheighT=SCRLheighT+10+CpriceLBL.frame.size.height;
            
            UIImageView *LineIMG=[[UIImageView alloc]initWithFrame:CGRectMake(0, SCRLheighT, ViewWIdth, 1)];
            LineIMG.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
            [FoodSCRl addSubview:LineIMG];
            
            UIImageView *MinImg=[[UIImageView alloc]initWithFrame:CGRectMake(ViewWIdth-105, Heightv+(((SCRLheighT-Heightv)/2)-10), 20, 20)];
            MinImg.image=[UIImage imageNamed:@"ic_select_extra_minus.png"];
            MinImg.tag=21000+i;
            MinImg.userInteractionEnabled=YES;
            [FoodSCRl addSubview:MinImg];
            
            
            UIButton *MinBTN=[[UIButton alloc]initWithFrame:CGRectMake(ViewWIdth-110, Heightv, 30, SCRLheighT-Heightv)];
            [MinBTN addTarget:self action:@selector(Cminbtnclick:) forControlEvents:UIControlEventTouchUpInside];
            MinBTN.tag=i+22000;
            [FoodSCRl addSubview:MinBTN];
            
            UILabel *CounterLBL=[[UILabel alloc]initWithFrame:CGRectMake(ViewWIdth-75, MinBTN.frame.origin.y, 30, MinBTN.frame.size.height)];
            CounterLBL.textAlignment=NSTextAlignmentCenter;
            CounterLBL.text=@"0";
            CounterLBL.font=[UIFont systemFontOfSize:15.0];
            CounterLBL.tag=23000+i;
            CounterLBL.textColor=[UIColor whiteColor];
            [FoodSCRl addSubview:CounterLBL];
            
            
            UIImageView *MAXImg=[[UIImageView alloc]initWithFrame:CGRectMake(ViewWIdth-35, Heightv+(((SCRLheighT-Heightv)/2)-10), 20, 20)];
            MAXImg.image=[UIImage imageNamed:@"ic_select_extra_plus.png"];
            MAXImg.tag=24000+i;
            MAXImg.userInteractionEnabled=YES;
            [FoodSCRl addSubview:MAXImg];
            
            
            UIButton *MAXBTN=[[UIButton alloc]initWithFrame:CGRectMake(ViewWIdth-40, Heightv, 30, SCRLheighT-Heightv)];
            [MAXBTN addTarget:self action:@selector(CMAXBTNclick:) forControlEvents:UIControlEventTouchUpInside];
            MAXBTN.tag=i+25000;
            [FoodSCRl addSubview:MAXBTN];
        }
    }
    
    [[NSUserDefaults standardUserDefaults]setValue:FoodnameARY forKey:@"WoofrFoodname"];
    [[NSUserDefaults standardUserDefaults]setValue:priceARY forKey:@"WoofrFoodprice"];
    [[NSUserDefaults standardUserDefaults]setValue:fidARY forKey:@"WoofrFoodid"];
    
//    SCRLheighT=SCRLheighT+20;
    
//    UIButton *CBoOkNowbTN = [[UIButton alloc]initWithFrame:CGRectMake(10, SCRLheighT, ViewWIdth-20, 50)];
//    [CBoOkNowbTN setBackgroundImage:[UIImage imageNamed:@"btn_small_login_general.png"] forState:UIControlStateNormal];
//    [CBoOkNowbTN setTitle:@"BOOK NOW" forState:UIControlStateNormal];
//    [CBoOkNowbTN addTarget:self action:@selector(CBoOkNowbTNclick) forControlEvents:UIControlEventTouchUpInside];
//    [CBoOkNowbTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    CBoOkNowbTN.titleLabel.font=[UIFont systemFontOfSize:15.0];
//    
//    [FoodSCRl addSubview:CBoOkNowbTN];
//    
//    SCRLheighT=SCRLheighT+10+CBoOkNowbTN.frame.size.height;
    
    SCRLheighT=SCRLheighT+10;
    
    FoodSCRl.contentSize=CGSizeMake(ViewWIdth, SCRLheighT);
    
    NSLog(@"%@",FoodnameARY);
    NSLog(@"%@",priceARY);
}

-(void)CBoOkNowbTNclick
{

    
    [[NSUserDefaults standardUserDefaults] setValue:OrderDetailDict forKey:@"FoodOrderDictWoofr"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    BillDeatilVC *dealVC1 = (BillDeatilVC *)[storyboard instantiateViewControllerWithIdentifier:@"BillDeatilVC"];
    [self.navigationController pushViewController:dealVC1 animated:YES];
}
//**********************************************************
#pragma mark - Featured Section Plus Minus Button click
//**********************************************************
- (void)Fminbtnclick:(id)sender
{
    UIButton *temp = (UIButton *)sender;
    NSLog(@"%ld",(long)temp.tag);
    
   int long clickindex = temp.tag-2000;
    
    UILabel *FminLBL=(UILabel *)[FoodSCRl viewWithTag:clickindex+3000];
    if([FminLBL.text intValue]>0)
    {
        FminLBL.text=[NSString stringWithFormat:@"%d",([FminLBL.text intValue]-1)];
        FminLBL.textColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        [OrderDetailDict setValue:[NSString stringWithFormat:@"%@",FminLBL.text] forKey:[NSString stringWithFormat:@"%@",[[FeaturedARY objectAtIndex:clickindex]valueForKey:@"food_name"]]];
        
        UIImageView *FMinIMG=(UIImageView *)[FoodSCRl viewWithTag:clickindex+1000];
        FMinIMG.image=[UIImage imageNamed:@"ic_select_extra_minus_selected.png"];
        
    }
    if([FminLBL.text intValue]==0)
    {
        UIImageView *FmAXIMG=(UIImageView *)[FoodSCRl viewWithTag:clickindex+4000];
        FmAXIMG.image=[UIImage imageNamed:@"ic_select_extra_plus.png"];
        
        UIImageView *FMinIMG=(UIImageView *)[FoodSCRl viewWithTag:clickindex+1000];
        FMinIMG.image=[UIImage imageNamed:@"ic_select_extra_minus.png"];
        
        FminLBL.textColor=[UIColor whiteColor];

    }
    NSLog(@"%@",OrderDetailDict);
    
    
}
- (void)FMAXBTNclick:(id)sender
{
    UIButton *temp = (UIButton *)sender;
    NSLog(@"%ld",(long)temp.tag);
    

    int long clickindex = temp.tag-5000;
    
    UILabel *FminLBL=(UILabel *)[FoodSCRl viewWithTag:clickindex+3000];
    if([FminLBL.text intValue]<100)
    {
        FminLBL.text=[NSString stringWithFormat:@"%d",([FminLBL.text intValue]+1)];
        FminLBL.textColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        [OrderDetailDict setValue:[NSString stringWithFormat:@"%@",FminLBL.text] forKey:[NSString stringWithFormat:@"%@",[[FeaturedARY objectAtIndex:clickindex]valueForKey:@"food_name"]]];
        
        UIImageView *FmAXIMG=(UIImageView *)[FoodSCRl viewWithTag:clickindex+4000];
        FmAXIMG.image=[UIImage imageNamed:@"ic_select_extra_plus_selected.png"];
        
    }
    NSLog(@"%@",OrderDetailDict);
}

//**********************************************************
#pragma mark - Beer Section Plus Minus Button click
//**********************************************************
- (void)Bminbtnclick:(id)sender
{
    UIButton *temp = (UIButton *)sender;
    NSLog(@"%ld",(long)temp.tag);
    
    int long clickindex = temp.tag-12000;
    
   
    
    UILabel *FminLBL=(UILabel *)[FoodSCRl viewWithTag:clickindex+13000];
    if([FminLBL.text intValue]>0)
    {
        FminLBL.text=[NSString stringWithFormat:@"%d",([FminLBL.text intValue]-1)];
        FminLBL.textColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        [OrderDetailDict setValue:[NSString stringWithFormat:@"%@",FminLBL.text] forKey:[NSString stringWithFormat:@"%@",[[BeerARY objectAtIndex:clickindex]valueForKey:@"food_name"]]];
        
        UIImageView *FMinIMG=(UIImageView *)[FoodSCRl viewWithTag:clickindex+11000];
        FMinIMG.image=[UIImage imageNamed:@"ic_select_extra_minus_selected.png"];
        
    }
    if([FminLBL.text intValue]==0)
    {
        UIImageView *FmAXIMG=(UIImageView *)[FoodSCRl viewWithTag:clickindex+14000];
        FmAXIMG.image=[UIImage imageNamed:@"ic_select_extra_plus.png"];
        
        UIImageView *FMinIMG=(UIImageView *)[FoodSCRl viewWithTag:clickindex+11000];
        FMinIMG.image=[UIImage imageNamed:@"ic_select_extra_minus.png"];
        
        FminLBL.textColor=[UIColor whiteColor];
        
    }
    NSLog(@"%@",OrderDetailDict);
    
    
}

- (void)BMAXBTNclick:(id)sender
{
    UIButton *temp = (UIButton *)sender;
    NSLog(@"%ld",(long)temp.tag);
    
    int long clickindex = temp.tag-15000;
    
    UILabel *FminLBL=(UILabel *)[FoodSCRl viewWithTag:clickindex+13000];
    if([FminLBL.text intValue]<100)
    {
        FminLBL.text=[NSString stringWithFormat:@"%d",([FminLBL.text intValue]+1)];
        FminLBL.textColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        [OrderDetailDict setValue:[NSString stringWithFormat:@"%@",FminLBL.text] forKey:[NSString stringWithFormat:@"%@",[[BeerARY objectAtIndex:clickindex]valueForKey:@"food_name"]]];
        
        UIImageView *FmAXIMG=(UIImageView *)[FoodSCRl viewWithTag:clickindex+14000];
        FmAXIMG.image=[UIImage imageNamed:@"ic_select_extra_plus_selected.png"];
        
    }
    NSLog(@"%@",OrderDetailDict);
}
//**********************************************************
#pragma mark - Champagne Section Plus Minus Button click
//**********************************************************
- (void)Cminbtnclick:(id)sender
{
    UIButton *temp = (UIButton *)sender;
    NSLog(@"%ld",(long)temp.tag);
    
    int long clickindex = temp.tag-22000;
    
    
    UILabel *FminLBL=(UILabel *)[FoodSCRl viewWithTag:clickindex+23000];
    if([FminLBL.text intValue]>0)
    {
        FminLBL.text=[NSString stringWithFormat:@"%d",([FminLBL.text intValue]-1)];
        FminLBL.textColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        [OrderDetailDict setValue:[NSString stringWithFormat:@"%@",FminLBL.text] forKey:[NSString stringWithFormat:@"%@",[[champagneARY objectAtIndex:clickindex]valueForKey:@"food_name"]]];
        
        UIImageView *FMinIMG=(UIImageView *)[FoodSCRl viewWithTag:clickindex+21000];
        FMinIMG.image=[UIImage imageNamed:@"ic_select_extra_minus_selected.png"];
        
    }
    if([FminLBL.text intValue]==0)
    {
        UIImageView *FmAXIMG=(UIImageView *)[FoodSCRl viewWithTag:clickindex+24000];
        FmAXIMG.image=[UIImage imageNamed:@"ic_select_extra_plus.png"];
        
        UIImageView *FMinIMG=(UIImageView *)[FoodSCRl viewWithTag:clickindex+21000];
        FMinIMG.image=[UIImage imageNamed:@"ic_select_extra_minus.png"];
        
        FminLBL.textColor=[UIColor whiteColor];
        
    }
    NSLog(@"%@",OrderDetailDict);

}

- (void)CMAXBTNclick:(id)sender
{
    UIButton *temp = (UIButton *)sender;
    NSLog(@"%ld",(long)temp.tag);
    
    int long clickindex = temp.tag-25000;
    
    
    UILabel *FminLBL=(UILabel *)[FoodSCRl viewWithTag:clickindex+23000];
    if([FminLBL.text intValue]<100)
    {
        FminLBL.text=[NSString stringWithFormat:@"%d",([FminLBL.text intValue]+1)];
        FminLBL.textColor=[UIColor colorWithRed:153.0/255.0 green:132.0/255.0 blue:98.0/255.0 alpha:1.0];
        [OrderDetailDict setValue:[NSString stringWithFormat:@"%@",FminLBL.text] forKey:[NSString stringWithFormat:@"%@",[[champagneARY objectAtIndex:clickindex]valueForKey:@"food_name"]]];
        
        UIImageView *FmAXIMG=(UIImageView *)[FoodSCRl viewWithTag:clickindex+24000];
        FmAXIMG.image=[UIImage imageNamed:@"ic_select_extra_plus_selected.png"];
        
    }
    NSLog(@"%@",OrderDetailDict);
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
