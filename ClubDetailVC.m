//
//  ClubDetailVC.m
//  WOOFR
//
//  Created by dipen  narola on 28/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import "ClubDetailVC.h"
#import "TableAvailibilityVC.h"

@interface ClubDetailVC ()
{
    NSMutableDictionary *ClubDetailDict;
    
    NSString *clubnameSTR;
    
    MKMapView *mapView;
}

@end

@implementation ClubDetailVC

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
    
    [self SetViewAtLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor]];
    
    [self performSelector:@selector(zoomInToMyLocation)
               withObject:nil
               afterDelay:2];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
   
}
-(void)SetViewAtLoad{
    ClubDetailDict=[[NSMutableDictionary alloc]init];
    
    ClubDetailDict=[[NSUserDefaults standardUserDefaults]valueForKey:@"WoofrclubDetail"];
    
    clubnameSTR=[[NSString stringWithFormat:@"%@",[ClubDetailDict valueForKey:@"club_name"]] uppercaseString];
    
    self.title=[NSString stringWithFormat:@"%@",clubnameSTR];
    
    NSLog(@"%@",ClubDetailDict);
    
    
    
    ClubIMGSCRL.layer.borderWidth=1.5;
    ClubIMGSCRL.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    
    NSMutableArray *ImgARY=[[NSMutableArray alloc]init];
    ImgARY=[ClubDetailDict valueForKey:@"club_images"];
    
    for(int i=0;i<ImgARY.count;i++)
    {
        UIImageView *Image=[[UIImageView alloc]initWithFrame:CGRectMake(i*ClubIMGSCRL.frame.size.width, 0, ClubIMGSCRL.frame.size.width, ClubIMGSCRL.frame.size.height)];
        
        NSURL *urllinksTR= [NSURL URLWithString:[[NSString stringWithFormat:@"%@",[[ImgARY objectAtIndex:i] valueForKey:@"filename"]]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        AsyncImageView *beerImage = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, Image.frame.size.width, Image.frame.size.height)];
        [beerImage loadImageFromURL:urllinksTR imageName:@""];
        [Image addSubview:beerImage];
        
        [ClubIMGSCRL addSubview:Image];
        
    }
    
    ClubIMGSCRL.contentSize=CGSizeMake(ClubIMGSCRL.frame.size.width*(ImgARY.count), ClubIMGSCRL.frame.size.height);
    
    
    
    //Calculate main scroll content Height from here
    
    float ScrlHEight = ClubIMGSCRL.frame.origin.y+ClubIMGSCRL.frame.size.height+15;
    
    
    //WHy Section
    
    UILabel *WHYLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, ScrlHEight, ViewWIdth-20, 5000)];
    WHYLBL.text=[NSString stringWithFormat:@"WHY WE LOVE %@",clubnameSTR];
    WHYLBL.textColor=[UIColor colorWithRed:186.0/255.0 green:159.0/255.0 blue:104.0/255.0 alpha:1.0];
    WHYLBL.font=[UIFont boldSystemFontOfSize:16.0];
    WHYLBL.numberOfLines=15;
    [WHYLBL sizeToFit];
    [ClubBackSCRL addSubview:WHYLBL];
    
    ScrlHEight=ScrlHEight+WHYLBL.frame.size.height+10;
    
    UILabel *WHYRLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, ScrlHEight, ViewWIdth-20, 5000)];
    
    NSString *strData=[NSString stringWithFormat:@"%@",[ClubDetailDict valueForKey:@"description"]];
    
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:strData options:0];
    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    //    NSLog(@"Decode String Value: %@", decodedString);
    //    [discriptionTEXT loadHTMLString:[decodedString description] baseURL:nil];
    
    WHYRLBL.text=decodedString;
    WHYRLBL.textColor=[UIColor whiteColor]; //colorWithRed:186.0/255.0 green:159.0/255.0 blue:104.0/255.0 alpha:1.0];
    WHYRLBL.font=[UIFont systemFontOfSize:14.0];
    WHYRLBL.numberOfLines=100;
    [WHYRLBL sizeToFit];
    [ClubBackSCRL addSubview:WHYRLBL];
    
    ScrlHEight=ScrlHEight+WHYRLBL.frame.size.height+10;
    
    UIImageView *LineIMG1=[[UIImageView alloc]initWithFrame:CGRectMake(0, ScrlHEight, ViewWIdth, 1)];
    LineIMG1.backgroundColor=[UIColor colorWithRed:186.0/255.0 green:159.0/255.0 blue:104.0/255.0 alpha:1.0];
    [ClubBackSCRL addSubview:LineIMG1];
    
    ScrlHEight=ScrlHEight+LineIMG1.frame.size.height+10;
    
    
    //Music Section
    
    
    UILabel *MUSICLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, ScrlHEight, ViewWIdth-20, 5000)];
    MUSICLBL.text=@"MUSIC";
    MUSICLBL.textColor=[UIColor colorWithRed:186.0/255.0 green:159.0/255.0 blue:104.0/255.0 alpha:1.0];
    MUSICLBL.font=[UIFont boldSystemFontOfSize:16.0];
    MUSICLBL.numberOfLines=15;
    [MUSICLBL sizeToFit];
    [ClubBackSCRL addSubview:MUSICLBL];
    
    ScrlHEight=ScrlHEight+MUSICLBL.frame.size.height+10;
    
    UILabel *MUSICDLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, ScrlHEight, ViewWIdth-20, 5000)];
    MUSICDLBL.text=[NSString stringWithFormat:@"%@",[ClubDetailDict valueForKey:@"music"]];
    MUSICDLBL.textColor=[UIColor whiteColor]; //colorWithRed:186.0/255.0 green:159.0/255.0 blue:104.0/255.0 alpha:1.0];
    MUSICDLBL.font=[UIFont systemFontOfSize:14.0];
    MUSICDLBL.numberOfLines=100;
    [MUSICDLBL sizeToFit];
    [ClubBackSCRL addSubview:MUSICDLBL];
    
    ScrlHEight=ScrlHEight+MUSICDLBL.frame.size.height+10;
    
    UIImageView *LineIMG2=[[UIImageView alloc]initWithFrame:CGRectMake(0, ScrlHEight, ViewWIdth, 1)];
    LineIMG2.backgroundColor=[UIColor colorWithRed:186.0/255.0 green:159.0/255.0 blue:104.0/255.0 alpha:1.0];
    [ClubBackSCRL addSubview:LineIMG2];
    
    ScrlHEight=ScrlHEight+LineIMG2.frame.size.height+10;
    
    
    
    //Peak Night Section
    
    
    UILabel *PickNightLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, ScrlHEight, ViewWIdth-20, 5000)];
    PickNightLBL.text=@"PEAK NIGHTS";
    PickNightLBL.textColor=[UIColor colorWithRed:186.0/255.0 green:159.0/255.0 blue:104.0/255.0 alpha:1.0];
    PickNightLBL.font=[UIFont boldSystemFontOfSize:16.0];
    PickNightLBL.numberOfLines=15;
    [PickNightLBL sizeToFit];
    [ClubBackSCRL addSubview:PickNightLBL];
    
    ScrlHEight=ScrlHEight+PickNightLBL.frame.size.height+10;
    
    UILabel *PickNightDLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, ScrlHEight, ViewWIdth-20, 5000)];
    PickNightDLBL.text=[NSString stringWithFormat:@"%@",[ClubDetailDict valueForKey:@"peak_nights"]];
    PickNightDLBL.textColor=[UIColor whiteColor]; //colorWithRed:186.0/255.0 green:159.0/255.0 blue:104.0/255.0 alpha:1.0];
    PickNightDLBL.font=[UIFont systemFontOfSize:14.0];
    PickNightDLBL.numberOfLines=100;
    [PickNightDLBL sizeToFit];
    [ClubBackSCRL addSubview:PickNightDLBL];
    
    ScrlHEight=ScrlHEight+PickNightDLBL.frame.size.height+10;
    
    UIImageView *LineIMG3=[[UIImageView alloc]initWithFrame:CGRectMake(0, ScrlHEight, ViewWIdth, 1)];
    LineIMG3.backgroundColor=[UIColor colorWithRed:186.0/255.0 green:159.0/255.0 blue:104.0/255.0 alpha:1.0];
    [ClubBackSCRL addSubview:LineIMG3];
    
    ScrlHEight=ScrlHEight+LineIMG3.frame.size.height+10;
    
    
    
    //PARTYGOERS SECTION
    
    
    
    UILabel *PARTYGOERSLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, ScrlHEight, ViewWIdth-20, 5000)];
    PARTYGOERSLBL.text=@"PARTYGOERS";
    PARTYGOERSLBL.textColor=[UIColor colorWithRed:186.0/255.0 green:159.0/255.0 blue:104.0/255.0 alpha:1.0];
    PARTYGOERSLBL.font=[UIFont boldSystemFontOfSize:16.0];
    PARTYGOERSLBL.numberOfLines=15;
    [PARTYGOERSLBL sizeToFit];
    [ClubBackSCRL addSubview:PARTYGOERSLBL];
    
    ScrlHEight=ScrlHEight+PARTYGOERSLBL.frame.size.height+10;
    
    UILabel *PARTYGOERSLBLDLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, ScrlHEight, ViewWIdth-20, 5000)];
    PARTYGOERSLBLDLBL.text=[NSString stringWithFormat:@"%@",[ClubDetailDict valueForKey:@"partygoers"]];
    PARTYGOERSLBLDLBL.textColor=[UIColor whiteColor]; //colorWithRed:186.0/255.0 green:159.0/255.0 blue:104.0/255.0 alpha:1.0];
    PARTYGOERSLBLDLBL.font=[UIFont systemFontOfSize:14.0];
    PARTYGOERSLBLDLBL.numberOfLines=100;
    [PARTYGOERSLBLDLBL sizeToFit];
    [ClubBackSCRL addSubview:PARTYGOERSLBLDLBL];
    
    ScrlHEight=ScrlHEight+PARTYGOERSLBLDLBL.frame.size.height+10;
    
    UIImageView *LineIMG4=[[UIImageView alloc]initWithFrame:CGRectMake(0, ScrlHEight, ViewWIdth, 1)];
    LineIMG4.backgroundColor=[UIColor colorWithRed:186.0/255.0 green:159.0/255.0 blue:104.0/255.0 alpha:1.0];
    [ClubBackSCRL addSubview:LineIMG4];
    
    ScrlHEight=ScrlHEight+LineIMG4.frame.size.height+10;
    
    
    //PARTYGOERS SECTION
    
    
    
    UILabel *LOCATIONLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, ScrlHEight, ViewWIdth-20, 5000)];
    LOCATIONLBL.text=@"LOCATION";
    LOCATIONLBL.textColor=[UIColor colorWithRed:186.0/255.0 green:159.0/255.0 blue:104.0/255.0 alpha:1.0];
    LOCATIONLBL.font=[UIFont boldSystemFontOfSize:16.0];
    LOCATIONLBL.numberOfLines=15;
    [LOCATIONLBL sizeToFit];
    [ClubBackSCRL addSubview:LOCATIONLBL];
    
    ScrlHEight=ScrlHEight+LOCATIONLBL.frame.size.height+10;
    
    
    UIImageView *locationIMNSG=[[UIImageView alloc]initWithFrame:CGRectMake(12, ScrlHEight, 12, 16)];
    locationIMNSG.image=[UIImage imageNamed:@"ic_home_location_white.png"];
    [ClubBackSCRL addSubview:locationIMNSG];
    
    UILabel *LOCATIONDLBL=[[UILabel alloc]initWithFrame:CGRectMake(36, ScrlHEight, ViewWIdth-44, 5000)];
    LOCATIONDLBL.text=[NSString stringWithFormat:@"%@",[ClubDetailDict valueForKey:@"address"]];
    LOCATIONDLBL.textColor=[UIColor whiteColor]; //colorWithRed:186.0/255.0 green:159.0/255.0 blue:104.0/255.0 alpha:1.0];
    LOCATIONDLBL.font=[UIFont systemFontOfSize:14.0];
    LOCATIONDLBL.numberOfLines=100;
    [LOCATIONDLBL sizeToFit];
    [ClubBackSCRL addSubview:LOCATIONDLBL];
    
    ScrlHEight=ScrlHEight+LOCATIONDLBL.frame.size.height+10;
    
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(10, ScrlHEight, ViewWIdth-20, (ViewWIdth-20)/2)];
    mapView.delegate=self;
    [ClubBackSCRL addSubview:mapView];
    
    
    ScrlHEight=ScrlHEight+mapView.frame.size.height+10;
    
    UIImageView *LineIMG5=[[UIImageView alloc]initWithFrame:CGRectMake(0, ScrlHEight, ViewWIdth, 1)];
    LineIMG5.backgroundColor=[UIColor colorWithRed:186.0/255.0 green:159.0/255.0 blue:104.0/255.0 alpha:1.0];
    [ClubBackSCRL addSubview:LineIMG5];
    
    ScrlHEight=ScrlHEight+LineIMG5.frame.size.height+10;
    
    
    // opening section
    
    UILabel *OPENINGHRSLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, ScrlHEight, ViewWIdth-20, 5000)];
    OPENINGHRSLBL.text=@"OPENING HOURS";
    OPENINGHRSLBL.textColor=[UIColor colorWithRed:186.0/255.0 green:159.0/255.0 blue:104.0/255.0 alpha:1.0];
    OPENINGHRSLBL.font=[UIFont boldSystemFontOfSize:16.0];
    OPENINGHRSLBL.numberOfLines=15;
    [OPENINGHRSLBL sizeToFit];
    [ClubBackSCRL addSubview:OPENINGHRSLBL];
    
    ScrlHEight=ScrlHEight+OPENINGHRSLBL.frame.size.height+10;
    
    UIImageView *timeIMNSG=[[UIImageView alloc]initWithFrame:CGRectMake(10, ScrlHEight, 16, 16)];
    timeIMNSG.image=[UIImage imageNamed:@"ic_home_opening_time.png"];
    [ClubBackSCRL addSubview:timeIMNSG];
    
    UILabel *OPENINGHRSDLBL=[[UILabel alloc]initWithFrame:CGRectMake(36, ScrlHEight, ViewWIdth-44, 5000)];
    OPENINGHRSDLBL.text=[NSString stringWithFormat:@"%@ - %@",[ClubDetailDict valueForKey:@"start_time"],[ClubDetailDict valueForKey:@"end_time"]];
    OPENINGHRSDLBL.textColor=[UIColor whiteColor]; //colorWithRed:186.0/255.0 green:159.0/255.0 blue:104.0/255.0 alpha:1.0];
    OPENINGHRSDLBL.font=[UIFont systemFontOfSize:14.0];
    OPENINGHRSDLBL.numberOfLines=100;
    [OPENINGHRSDLBL sizeToFit];
    [ClubBackSCRL addSubview:OPENINGHRSDLBL];
    
    ScrlHEight=ScrlHEight+OPENINGHRSDLBL.frame.size.height+10;
    
    UIImageView *LineIMG6=[[UIImageView alloc]initWithFrame:CGRectMake(0, ScrlHEight, ViewWIdth, 1)];
    LineIMG6.backgroundColor=[UIColor colorWithRed:186.0/255.0 green:159.0/255.0 blue:104.0/255.0 alpha:1.0];
    [ClubBackSCRL addSubview:LineIMG6];
    
    ScrlHEight=ScrlHEight+LineIMG6.frame.size.height+10;
    
    //    UIButton *ratingBTN=[[UIButton alloc]initWithFrame:CGRectMake(10, ScrlHEight, ViewWIdth-20, 60)];
    //    [ratingBTN setBackgroundImage:[UIImage imageNamed:@"btn_big_login_general.png"] forState:UIControlStateNormal];
    //    [ratingBTN setTitle:@"GIVE RATINGS" forState:UIControlStateNormal];
    //    [ratingBTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    ratingBTN.titleLabel.font=[UIFont boldSystemFontOfSize:18.0];
    //    [ratingBTN addTarget:self action:@selector(RatingBTNclick) forControlEvents:UIControlEventTouchUpInside];
    //    [ClubBackSCRL addSubview:ratingBTN];
    //
    //     ScrlHEight=ScrlHEight+ratingBTN.frame.size.height+10;
    
    ClubBackSCRL.contentSize=CGSizeMake(ViewWIdth, ScrlHEight);
    
    CLLocationCoordinate2D  ctrpoint;
    ctrpoint.latitude = [[NSString stringWithFormat:@"%@",[ClubDetailDict valueForKey:@"latitude"]] floatValue];
    ctrpoint.longitude =[[NSString stringWithFormat:@"%@",[ClubDetailDict valueForKey:@"longitude"]] floatValue];
    
    MKPlacemark* marker = [[MKPlacemark alloc] initWithCoordinate:ctrpoint addressDictionary:nil];
    [mapView addAnnotation:marker];
    
    //    MKPointAnnotation *addAnnotation = [[MKPointAnnotation alloc] init];//:ctrpoint];
    //    addAnnotation.coordinate=ctrpoint;
    //    //[[mapView viewForAnnotation:addAnnotation]setImage:[UIImage imageNamed:@"ic_home_location.png"]];
    //    [mapView viewForAnnotation:addAnnotation];
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation;
{
    MKAnnotationView *newAnnotation = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotation1"];
    UIImage *img=[UIImage imageNamed:@"ic_map_pin_gold.png"];
    newAnnotation.canShowCallout = NO;
    newAnnotation.image=img;//[UIImage imageNamed:@"ic_home_location.png"];
    [newAnnotation setSelected:YES animated:YES];
    return newAnnotation;
}
-(void)zoomInToMyLocation
{
    MKCoordinateRegion region = { {0.0, 0.0}, {0.0, 0.0} };
    region.center.latitude = [[NSString stringWithFormat:@"%@",[ClubDetailDict valueForKey:@"latitude"]] floatValue];
    region.center.longitude =[[NSString stringWithFormat:@"%@",[ClubDetailDict valueForKey:@"longitude"]] floatValue];
    region.span.longitudeDelta = 0.15f;
    region.span.latitudeDelta = 0.15f;
    [mapView setRegion:region animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)RatingBTNclick
{
    [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%@",[ClubDetailDict valueForKey:@"club_id"]] forKey:@"woofrIDforRat"];
    
    int STRRate=[[NSString stringWithFormat:@"%@",[ClubDetailDict valueForKey:@"rating"]] intValue];
    
    [[NSUserDefaults standardUserDefaults]setInteger:STRRate forKey:@"woofrrating"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"RatingVC"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navigationController animated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)ButTicketBTN:(id)sender
{
    // 1 club
    // 2 event
    // 3 Pramotion
    // 4 desco
    
    [[NSUserDefaults standardUserDefaults]setValue:@"1" forKey:@"WooFrclubDetetct"];
    
    NSString *clubID=[NSString stringWithFormat:@"%@",[ClubDetailDict valueForKey:@"club_id" ]];
    
   
    [[NSUserDefaults standardUserDefaults]setValue:ClubDetailDict forKey:@"WoofrclubDetail"];
    
    
    [[NSUserDefaults standardUserDefaults]setValue:clubID forKey:@"bookCLUBIDWoofer"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    TableAvailibilityVC *dealVC1 = (TableAvailibilityVC *)[storyboard instantiateViewControllerWithIdentifier:@"TableAvailibilityVC"];
    [self.navigationController pushViewController:dealVC1 animated:YES];

}
@end
