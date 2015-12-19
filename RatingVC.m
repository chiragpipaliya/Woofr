//
//  RatingVC.m
//  WOOFR
//
//  Created by dipen  narola on 02/12/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import "RatingVC.h"

@interface RatingVC ()
{
    int long RatingValue;
}

@end

@implementation RatingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUD];
    [self.view bringSubviewToFront:HUD];
    [HUD setDelegate:self];
    [HUD setLabelText:@"Loading...."];
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor]];
    
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc]
                                     initWithImage:[UIImage imageNamed:@"ic_header_close.png"]
                                     style:UIBarButtonItemStylePlain
                                     target:self action:@selector(CloseView)];
    logoutButton.tintColor=[UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = logoutButton;
    
    
    NSInteger detect=[[NSUserDefaults standardUserDefaults]integerForKey:@"woofrrating"];
    RatingValue=detect;
    for(int i=0;i<5;i++)
    {
        if(i<detect)
        {
            UIButton *BTN = (UIButton *)[self.view viewWithTag:(5030+i)];
            [BTN setBackgroundImage:[UIImage imageNamed:@"ic_rating_star_gold.png"] forState:UIControlStateNormal];
        }
        else
        {
            UIButton *BTN = (UIButton *)[self.view viewWithTag:(5030+i)];
            [BTN setBackgroundImage:[UIImage imageNamed:@"ic_rating_star_white.png"] forState:UIControlStateNormal];
        }
        
    }
    
    self.title=@"GIVE RATINGS";
    
    
    
}
-(void)CloseView
{
    [self dismissViewControllerAnimated:YES completion:Nil];
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

- (IBAction)Star1BTNclick:(id)sender
{
    UIButton *temp = (UIButton *)sender;
    NSLog(@"%ld",(long)temp.tag);
    
    int long clickindex = temp.tag-5030;
    
    RatingValue =clickindex;
    
    for(int i=0;i<5;i++)
    {
        if(i<=clickindex)
        {
            UIButton *BTN = (UIButton *)[self.view viewWithTag:(5030+i)];
            [BTN setBackgroundImage:[UIImage imageNamed:@"ic_rating_star_gold.png"] forState:UIControlStateNormal];
        }
        else
        {
            UIButton *BTN = (UIButton *)[self.view viewWithTag:(5030+i)];
            [BTN setBackgroundImage:[UIImage imageNamed:@"ic_rating_star_white.png"] forState:UIControlStateNormal];
        }
    }
    
}

- (IBAction)Star2BTNclick:(id)sender
{
    UIButton *temp = (UIButton *)sender;
    NSLog(@"%ld",(long)temp.tag);
    
    int long clickindex = temp.tag-5030;
    
    RatingValue =clickindex;
    
    for(int i=0;i<5;i++)
    {
        if(i<=clickindex)
        {
            UIButton *BTN = (UIButton *)[self.view viewWithTag:(5030+i)];
            [BTN setBackgroundImage:[UIImage imageNamed:@"ic_rating_star_gold.png"] forState:UIControlStateNormal];
        }
        else
        {
            UIButton *BTN = (UIButton *)[self.view viewWithTag:(5030+i)];
            [BTN setBackgroundImage:[UIImage imageNamed:@"ic_rating_star_white.png"] forState:UIControlStateNormal];
        }
    }
    
}

- (IBAction)Star3BTNclick:(id)sender
{
    UIButton *temp = (UIButton *)sender;
    NSLog(@"%ld",(long)temp.tag);
    
    int long clickindex = temp.tag-5030;
    
    RatingValue =clickindex;
    
    for(int i=0;i<5;i++)
    {
        if(i<=clickindex)
        {
            UIButton *BTN = (UIButton *)[self.view viewWithTag:(5030+i)];
            [BTN setBackgroundImage:[UIImage imageNamed:@"ic_rating_star_gold.png"] forState:UIControlStateNormal];
        }
        else
        {
            UIButton *BTN = (UIButton *)[self.view viewWithTag:(5030+i)];
            [BTN setBackgroundImage:[UIImage imageNamed:@"ic_rating_star_white.png"] forState:UIControlStateNormal];
        }
    }
    
}

- (IBAction)Star4BTNclick:(id)sender
{
    UIButton *temp = (UIButton *)sender;
    NSLog(@"%ld",(long)temp.tag);
    
    int long clickindex = temp.tag-5030;
    
    RatingValue =clickindex;
    
    for(int i=0;i<5;i++)
    {
        if(i<=clickindex)
        {
            UIButton *BTN = (UIButton *)[self.view viewWithTag:(5030+i)];
            [BTN setBackgroundImage:[UIImage imageNamed:@"ic_rating_star_gold.png"] forState:UIControlStateNormal];
        }
        else
        {
            UIButton *BTN = (UIButton *)[self.view viewWithTag:(5030+i)];
            [BTN setBackgroundImage:[UIImage imageNamed:@"ic_rating_star_white.png"] forState:UIControlStateNormal];
        }
    }
    
}

- (IBAction)Star5BTNclick:(id)sender
{
    UIButton *temp = (UIButton *)sender;
    NSLog(@"%ld",(long)temp.tag);
    
    int long clickindex = temp.tag-5030;
    
    RatingValue =clickindex;
    
    for(int i=0;i<5;i++)
    {
        if(i<=clickindex)
        {
            UIButton *BTN = (UIButton *)[self.view viewWithTag:(5030+i)];
            [BTN setBackgroundImage:[UIImage imageNamed:@"ic_rating_star_gold.png"] forState:UIControlStateNormal];
        }
        else
        {
            UIButton *BTN = (UIButton *)[self.view viewWithTag:(5030+i)];
            [BTN setBackgroundImage:[UIImage imageNamed:@"ic_rating_star_white.png"] forState:UIControlStateNormal];
        }
    }
    
}

- (IBAction)DoneBTNclick:(id)sender
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
    
    

    
    NSString *uIDSTR= [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"WoofruserID"]];
    
    //event rating = admin.vasundharavision.com/woofr/api/?action=rating&user_id=1&event_id=1&rat=3
    //club rating = admin.vasundharavision.com/woofr/api/?action=rating&user_id=1&club_id=1&rat=5
    //disco rating =  admin.vasundharavision.com/woofr/api/?action=rating&user_id=1&disco_id=1&rat=5
    //pramotion rating = admin.vasundharavision.com/woofr/api/?action=rating&user_id=1&promotion_id=1&rat=5
    
    // 1 club
    // 2 event
    // 3 Pramotion
    // 4 desco
    
    NSString *detectSTR=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"WooFrclubDetetct"]];
    
    NSString *favIDSTR=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"woofrIDforRat"]];
    
    [sendData setObject:@"rating" forKey:@"action"];
    [sendData setObject:[NSString stringWithFormat:@"%li",RatingValue] forKey:@"rat"];
    
    if([detectSTR isEqualToString:@"1"])
    {
        [sendData setObject:favIDSTR forKey:@"club_id"];
    }
    else if ([detectSTR isEqualToString:@"2"])
    {
        [sendData setObject:favIDSTR forKey:@"event_id"];
    }
    else if ([detectSTR isEqualToString:@"3"])
    {
        [sendData setObject:favIDSTR forKey:@"promotion_id"];
    }
    else if ([detectSTR isEqualToString:@"4"])
    {
        [sendData setObject:favIDSTR forKey:@"disco_id"];
    }
    
    [sendData setObject:uIDSTR forKey:@"user_id"];
    
    
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
    
    Ratingconnection = [NSURLConnection connectionWithRequest:request delegate:self];
    if (Ratingconnection)
    {
        RatingData = [[NSMutableData alloc]init];
    }
    
}
//********************************************
#pragma mark - Connection Delegate Methods
//********************************************

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection == Ratingconnection)
    {
        [RatingData appendData:data];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (connection == Ratingconnection)
    {
        [RatingData setLength:0];
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
    if (connection == Ratingconnection)
    {
        NSMutableString *responceversionStr = [[NSMutableString alloc]initWithBytes:[RatingData mutableBytes] length:[RatingData length] encoding:NSUTF8StringEncoding];
        NSMutableDictionary *gat_dic = [[NSMutableDictionary alloc]init];
        [gat_dic setDictionary:[responceversionStr JSONValue]];
        
        [HUD hide:YES];
        
        NSLog(@"%@",gat_dic);
        
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
        vc.view.backgroundColor = [UIColor clearColor];
        //  [vc setTransitioningDelegate:transitionController];
        vc.modalPresentationStyle= UIModalPresentationCustom;
        [self presentViewController:vc animated:YES completion:nil];
        
    }
}
@end
