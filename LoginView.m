//
//  LoginView.m
//  WOOFR
//
//  Created by dipen  narola on 17/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import "LoginView.h"
#import "UserRegistrationView.h"
#import "ReferalcodeView.h"
#import "ForgetPasswordView.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.6;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@interface LoginView ()
{
    NSMutableDictionary *FBDetaildict;
}
@end

@implementation LoginView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    usernameIMG.layer.borderWidth=1.0;
    usernameIMG.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    
    PasswordIMG.layer.borderWidth=1.0;
    PasswordIMG.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    
    
    FacebookIMG.layer.borderWidth=1.0;
    FacebookIMG.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    
    registerBTN.layer.borderWidth=1.0;
    registerBTN.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    
    LoginBTN.layer.borderWidth=1.0;
    LoginBTN.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    
    [userNameTF setValue:[UIColor whiteColor]
              forKeyPath:@"_placeholderLabel.textColor"];
    [passwordTF setValue:[UIColor whiteColor]
              forKeyPath:@"_placeholderLabel.textColor"];
    
    HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUD];
    [self.view bringSubviewToFront:HUD];
    [HUD setDelegate:self];
    [HUD setLabelText:@"Loading...."];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    NSUserDefaults *login = [NSUserDefaults standardUserDefaults];
    [login setBool:NO forKey:@"WoofrLOGIN"];
}
/*****************************************/
#pragma mark - Set Status Bar Style
/*****************************************/
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
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

- (IBAction)RegisterBTnclick:(id)sender
{
    [self ResignResponder];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    UserRegistrationView *dealVC1 = (UserRegistrationView *)[storyboard instantiateViewControllerWithIdentifier:@"UserRegistrationView"];
    [self.navigationController pushViewController:dealVC1 animated:YES];
}

- (IBAction)LoginBTnclick:(id)sender
{
    [self ResignResponder];
    
    if(userNameTF.text.length<1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"User Name Must Be Required"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if (passwordTF.text.length<1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"User Password Must Be Required"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        NSString *regExPattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
        NSUInteger regExMatches = [regEx numberOfMatchesInString:userNameTF.text options:0 range:NSMakeRange(0, [userNameTF.text length])];
        // NSLog(@"%i", regExMatches);
        if (regExMatches == 0)
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please Enter your valid Email Address"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
        }
        else
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
            
            //admin.vasundharavision.com/woofr/api/?action=user_login&user_email=jeet@gmail.com&password=123456&user_token=Abctu583bajf8t
            
            
            NSMutableDictionary *sendData = [[NSMutableDictionary alloc]init];
            
            
            NSUserDefaults *fetchDefaultslogin = [NSUserDefaults standardUserDefaults];
            NSString *deviceTokan=[NSString stringWithFormat:@"%@",[fetchDefaultslogin valueForKey:@"deviceToken"]];
            
            
            [sendData setObject:@"user_login" forKey:@"action"];
            
            [sendData setObject:[NSString stringWithFormat:@"%@",passwordTF.text] forKey:@"password"];
            [sendData setObject:[NSString stringWithFormat:@"%@",userNameTF.text] forKey:@"user_email"];
            [sendData setObject:/*deviceTokan*/@"123456789" forKey:@"user_token"];
            
            
            
            
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
            
            LoginUserconnection = [NSURLConnection connectionWithRequest:request delegate:self];
            if (LoginUserconnection)
            {
                LoginUserData = [[NSMutableData alloc]init];
            }
            
            
        }
        
    }
    
}

//********************************************
#pragma mark - Connection Delegate Methods
//********************************************

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection == LoginUserconnection)
    {
        [LoginUserData appendData:data];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (connection == LoginUserconnection)
    {
        [LoginUserData setLength:0];
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
    if (connection == LoginUserconnection)
    {
        NSMutableString *responceversionStr = [[NSMutableString alloc]initWithBytes:[LoginUserData mutableBytes] length:[LoginUserData length] encoding:NSUTF8StringEncoding];
        NSMutableDictionary *gat_dic = [[NSMutableDictionary alloc]init];
        [gat_dic setDictionary:[responceversionStr JSONValue]];
        
        [HUD hide:YES];
        
        NSLog(@"%@",gat_dic);
        
        NSString *statusSTR=[NSString stringWithFormat:@"%@",[gat_dic valueForKey:@"status"]];
        
        if([statusSTR isEqualToString:@"1"])
        {
            
            NSMutableDictionary *dataUser=[[NSMutableDictionary alloc]init];
            dataUser=[gat_dic valueForKey:@"user_detail"];
            
            NSUserDefaults *SaveINFo=[[NSUserDefaults alloc]init];
            [SaveINFo setValue:dataUser forKey:@"WoofrUSer"];
            
            //            UIAlertView *connectionAlert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"%@",[gat_dic valueForKey:@"message"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            //            [connectionAlert show];
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
            ReferalcodeView *dealVC1 = (ReferalcodeView *)[storyboard instantiateViewControllerWithIdentifier:@"ReferalcodeView"];
            [self.navigationController pushViewController:dealVC1 animated:YES];
            
            
        }
        else
        {
            UIAlertView *connectionAlert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"%@",[gat_dic valueForKey:@"message"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [connectionAlert show];
        }
    }
}


- (IBAction)LoginwithFBclick:(id)sender
{
    [self ResignResponder];
    
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    if ([FBSDKAccessToken currentAccessToken])
    {
        NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
        [self fetchUserInfo];
    }
    else
    {
        [login logInWithReadPermissions:@[@"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
         {
             if (error)
             {
                 UIAlertView *connectionAlert = [[UIAlertView alloc]initWithTitle:nil message:@"Login process error" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [connectionAlert show];
             }
             else if (result.isCancelled)
             {
                 NSLog(@"User cancelled login");
                 UIAlertView *connectionAlert = [[UIAlertView alloc]initWithTitle:nil message:@"User cancelled login" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [connectionAlert show];
             }
             else
             {
                 NSLog(@"Login Success");
                 
                 if ([result.grantedPermissions containsObject:@"email"])
                 {
                     NSLog(@"result is:%@",result);
                     [self fetchUserInfo];
                 }
                 else
                 {
                     
                     
                 }
             }
         }];
    }
    
    //    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    //    ReferalcodeView *dealVC1 = (ReferalcodeView *)[storyboard instantiateViewControllerWithIdentifier:@"ReferalcodeView"];
    //    [self.navigationController pushViewController:dealVC1 animated:YES];
}

- (IBAction)ForgetPasswordBTNclick:(id)sender
{
    [self ResignResponder];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    ForgetPasswordView *dealVC1 = (ForgetPasswordView *)[storyboard instantiateViewControllerWithIdentifier:@"ForgetPasswordView"];
    [self.navigationController pushViewController:dealVC1 animated:YES];
}

-(void)fetchUserInfo
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, email, picture.type(normal)"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
                 NSLog(@"results:%@",result);
                 
                 NSString *email = [result objectForKey:@"email"];
                 NSString *userId = [result objectForKey:@"id"];
                 
                // Here start Working Facebook Login
                 
                 if (email.length >0 )
                 {
                     //Start you app Todo
                     
                     FBDetaildict=[[NSMutableDictionary alloc]init];
                     FBDetaildict=result;
                     
                     [self callLoginAPI];
                     
                 }
                 else
                 {
                     //NSLog(@"Facebook email is not verified");
                     
                     UIAlertView *connectionAlert = [[UIAlertView alloc]initWithTitle:nil message:@"Facebook email is not verified" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [connectionAlert show];
                 }
             }
             else
             {
                 NSLog(@"Error %@",error);
             }
         }];
    }
}



-(void)callLoginAPI
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
    
    //admin.vasundharavision.com/woofr/api/?action=user_login&user_email=jeet@gmail.com&password=123456&user_token=Abctu583bajf8t
    
    
    
    NSData * imagedata = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [NSString stringWithFormat:@"%@",[[[FBDetaildict valueForKey:@"picture"]valueForKey:@"data" ]valueForKey:@"url" ]]]];
    
    
    
    
    
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    
    NSNumber *timeStampObj = [NSNumber numberWithDouble: timeStamp];
    
    NSString *photoID = [NSString stringWithFormat:@"%@",timeStampObj];
    NSLog(@"%@",photoID);
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: attachment; name=\"user_image\"; filename=\"%@.png\"\r\n",photoID] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[NSData dataWithData:UIImageJPEGRepresentation([UIImage imageWithData:imagedata],1)]];
    
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    

    
    
    
    NSMutableDictionary *sendData = [[NSMutableDictionary alloc]init];
    
    
    NSUserDefaults *fetchDefaultslogin = [NSUserDefaults standardUserDefaults];
    NSString *deviceTokan=[NSString stringWithFormat:@"%@",[fetchDefaultslogin valueForKey:@"deviceToken"]];
    
    
    [sendData setObject:@"user_register" forKey:@"action"];
    
    [sendData setObject:[NSString stringWithFormat:@"%@",[FBDetaildict valueForKey:@"name"]] forKey:@"user_name"];
    [sendData setObject:[NSString stringWithFormat:@"%@",[FBDetaildict valueForKey:@"email"]] forKey:@"user_email"];
    [sendData setObject:/*deviceTokan*/@"123456789" forKey:@"user_token"];
    [sendData setObject:[NSString stringWithFormat:@"%@",[FBDetaildict valueForKey:@"id"]] forKey:@"fb_id"];
    
    
    
    
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
    
    LoginUserconnection = [NSURLConnection connectionWithRequest:request delegate:self];
    if (LoginUserconnection)
    {
        LoginUserData = [[NSMutableData alloc]init];
    }

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
-(void)ResignResponder
{
    [userNameTF resignFirstResponder];
    [passwordTF resignFirstResponder];
}

@end
