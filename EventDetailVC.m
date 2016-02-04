//
//  EventDetailVC.m
//  WOOFR
//
//  Created by dipen  narola on 27/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import "EventDetailVC.h"
#import "RatingVC.h"
#import "BookEventAvailibilityVC.h"

@interface EventDetailVC ()
{
    NSMutableDictionary *EventDetailDict;
    
    BOOL didLayoutSubviews;
}
@end

@implementation EventDetailVC

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
    
    NSString *stringDetect = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"WooFrclubDetetct"]];
    
    if([stringDetect isEqualToString:@"2"])
    {
        self.title=@"Event Details";
    }
    else
    {
        self.title=@"Pramotion Details";
    }
    
    
    EventDetailDict=[[NSMutableDictionary alloc]init];
    
    EventDetailDict=[[NSUserDefaults standardUserDefaults]valueForKey:@"WoofrEventDetail"];
    
    NSLog(@"%@",EventDetailDict);
    
    
    
//    eventPic.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:urllinksTR]];

    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    

}
-(void)viewDidLayoutSubviews{
    if (didLayoutSubviews == NO){
        didLayoutSubviews = YES;
        // perform code that was in viewWillAppear
        
        CGRect EimageFRm=eventPic.frame;
        
        EimageFRm.size.height=(ViewWIdth-40)*1.25;
        
        eventPic.frame=EimageFRm;
        NSURL *urllinksTR;
        NSMutableArray *aryTempImageList = [EventDetailDict valueForKey:@"event_images"];
        if(aryTempImageList.count == 0){
            urllinksTR= [[NSBundle mainBundle] URLForResource:@"ic_login_logo@3x" withExtension:@".png"];
        }else{
            urllinksTR= [NSURL URLWithString:[[NSString stringWithFormat:@"%@",[[[EventDetailDict valueForKey:@"event_images"] objectAtIndex:0] valueForKey:@"filename"]]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }
//        NSURL *urllinksTR= [NSURL URLWithString:[[NSString stringWithFormat:@"%@",[[[EventDetailDict valueForKey:@"event_images"] objectAtIndex:0] valueForKey:@"filename"]]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        AsyncImageView *beerImage = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, eventPic.frame.size.width, eventPic.frame.size.height)];
        [beerImage loadImageFromURL:urllinksTR imageName:@""];
        [eventPic addSubview:beerImage];
        
        eventPic.layer.borderWidth=1.5;
        eventPic.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
        eventPic.clipsToBounds=YES;
        
        CGRect BTNfrm=BTNbuyTicket.frame;
        
        BTNfrm.origin.y=eventPic.frame.size.height+15;
        BTNbuyTicket.frame=BTNfrm;
        
        CGRect nameFRM = LBLeventNAMe.frame;
        
        nameFRM.origin.y=BTNbuyTicket.frame.origin.y+BTNbuyTicket.frame.size.height+15;
        LBLeventNAMe.frame=nameFRM;
        
        LBLeventNAMe.text=[NSString stringWithFormat:@"%@",[EventDetailDict valueForKey:@"name"]];
        [LBLeventNAMe sizeToFit];
        
        CGRect timeimgFRM = EventTimePic.frame;
        timeimgFRM.origin.y=LBLeventNAMe.frame.size.height+LBLeventNAMe.frame.origin.y+13;
        EventTimePic.frame=timeimgFRM;
        
        EventTimePic.image = [EventTimePic.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [EventTimePic setTintColor:[UIColor colorWithRed:186.0/255.0 green:159.0/255.0 blue:104.0/255.0 alpha:1.0]];
        
        CGRect timeLBLFRM = EventTimeLBL.frame;
        timeLBLFRM.origin.y=LBLeventNAMe.frame.size.height+LBLeventNAMe.frame.origin.y+11;
        EventTimeLBL.frame=timeLBLFRM;
        
        CGRect locationimgFRM = EventLocPic.frame;
        locationimgFRM.origin.y=timeimgFRM.size.height+timeimgFRM.origin.y+13;
        EventLocPic.frame=locationimgFRM;
        
        CGRect locationlblFRM = LocationLBL.frame;
        locationlblFRM.origin.y=EventTimeLBL.frame.size.height+EventTimeLBL.frame.origin.y+8;
        LocationLBL.frame=locationlblFRM;
        
        EventTimeLBL.text=[NSString stringWithFormat:@"%@ - %@",[NSString stringWithFormat:@"%@",[EventDetailDict valueForKey:@"start_time"]],[NSString stringWithFormat:@"%@",[EventDetailDict valueForKey:@"end_time"]]];
        LocationLBL.text=[NSString stringWithFormat:@"%@",[EventDetailDict valueForKey:@"club_name"]];
        
        CGRect lineimgFRM = lineIMg.frame;
        lineimgFRM.origin.y=LocationLBL.frame.size.height+20+LocationLBL.frame.origin.y;
        lineIMg.frame=lineimgFRM;
        
        UILabel *descripLBL=[[UILabel alloc]initWithFrame:CGRectMake(locationimgFRM.origin.x, lineimgFRM.origin.y+lineimgFRM.size.height+10, 180, 20)];
        descripLBL.text=@"Description:";
        descripLBL.font=[UIFont boldSystemFontOfSize:18.0];
        descripLBL.textColor=[UIColor colorWithRed:186.0/255.0 green:159.0/255.0 blue:104.0/255.0 alpha:1.0];
        [EventDetailSCR addSubview:descripLBL];
        
        UILabel *detaildiscLBL=[[UILabel alloc]initWithFrame:CGRectMake(descripLBL.frame.origin.x, descripLBL.frame.size.height+descripLBL.frame.origin.y+8, self.view.frame.size.width-(2*descripLBL.frame.origin.x), 5000)];
        detaildiscLBL.textColor=[UIColor whiteColor];
        detaildiscLBL.font=[UIFont systemFontOfSize:15.0];
        
        NSString *strData=[NSString stringWithFormat:@"%@",[EventDetailDict valueForKey:@"description"]];
        NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:strData options:0];
        NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
        
        
        detaildiscLBL.text=decodedString;
        detaildiscLBL.numberOfLines=500;
        [detaildiscLBL sizeToFit];
        [EventDetailSCR addSubview:detaildiscLBL];
        
        CGRect ratingFRm = GIVERATINGSBTN.frame;
        ratingFRm.origin.y= detaildiscLBL.frame.origin.y+detaildiscLBL.frame.size.height+15;
        GIVERATINGSBTN.frame=ratingFRm;
        
        //    EventDetailSCR.contentSize=CGSizeMake(self.view.frame.size.width, GIVERATINGSBTN.frame.size.height+10+GIVERATINGSBTN.frame.origin.y);
        
        
        
        EventDetailSCR.contentSize=CGSizeMake(self.view.frame.size.width,  detaildiscLBL.frame.origin.y+detaildiscLBL.frame.size.height+15);
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

- (IBAction)BTNBuyticketclick:(id)sender
{
    
    
    [[NSUserDefaults standardUserDefaults]setValue:EventDetailDict forKey:@"EventWoofrBookDetail"];
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    BookEventAvailibilityVC *dealVC1 = (BookEventAvailibilityVC *)[storyboard instantiateViewControllerWithIdentifier:@"BookEventAvailibilityVC"];
    [self.navigationController pushViewController:dealVC1 animated:YES];
}

- (IBAction)giveRatingBTnclick:(id)sender
{
    
   
    
    [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%@",[EventDetailDict valueForKey:@"event_id"]] forKey:@"woofrIDforRat"];
    
    int STRRate=[[NSString stringWithFormat:@"%@",[EventDetailDict valueForKey:@"rating"]] intValue];
    
    [[NSUserDefaults standardUserDefaults]setInteger:STRRate forKey:@"woofrrating"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"RatingVC"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navigationController animated:YES completion:nil];

    
}
@end
