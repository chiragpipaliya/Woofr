//
//  UserRegistrationView.m
//  WOOFR
//
//  Created by dipen  narola on 17/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import "UserRegistrationView.h"

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.6;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@interface UserRegistrationView ()
{
    BOOL Is_changed;
    
    UIImageView *profilePIc;
}

@end

@implementation UserRegistrationView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NAmeIMG.layer.borderWidth=1.0;
    NAmeIMG.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    
    EmailIMG.layer.borderWidth=1.0;
    EmailIMG.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    
    [NameTF setValue:[UIColor whiteColor]
              forKeyPath:@"_placeholderLabel.textColor"];
    [EmailTF setValue:[UIColor whiteColor]
              forKeyPath:@"_placeholderLabel.textColor"];
    
    
    PasswordIMG.layer.borderWidth=1.0;
    PasswordIMG.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    
    ConfirmPasswordIMG.layer.borderWidth=1.0;
    ConfirmPasswordIMG.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    
    [PasswordTF setValue:[UIColor whiteColor]
              forKeyPath:@"_placeholderLabel.textColor"];
    [ConfirmPasswordTF setValue:[UIColor whiteColor]
              forKeyPath:@"_placeholderLabel.textColor"];
    
    
    selectcountryIMG.layer.borderWidth=1.0;
    selectcountryIMG.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    
    MobileNumberIMG.layer.borderWidth=1.0;
    MobileNumberIMG.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    
    [selectcountryTF setValue:[UIColor whiteColor]
              forKeyPath:@"_placeholderLabel.textColor"];
    [MobileNumberTF setValue:[UIColor whiteColor]
              forKeyPath:@"_placeholderLabel.textColor"];
    
    
    RegisSCR.contentSize=CGSizeMake(self.view.frame.size.width, LoginLBL.frame.origin.y+LoginLBL.frame.size.height+10);
    
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:@"Have an account? Login here..."];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:173.0/255.0 green:153.0/255.0 blue:91.0/255.0 alpha:1.0] range:NSMakeRange(16,14)];
    LoginLBL.attributedText=string;
    
    HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUD];
    [self.view bringSubviewToFront:HUD];
    [HUD setDelegate:self];
    [HUD setLabelText:@"Loading...."];


    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    MobileNumberTF.inputAccessoryView = numberToolbar;
    
    profilePIc=[[UIImageView alloc]initWithFrame:CGRectMake(4, 4, PhotoIMG.frame.size.width-8, PhotoIMG.frame.size.height-8)];
    profilePIc.userInteractionEnabled=YES;
    profilePIc.layer.cornerRadius=profilePIc.frame.size.width/2;
    profilePIc.clipsToBounds=YES;
    [PhotoIMG addSubview:profilePIc];
    
    Is_changed=NO;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self setNeedsStatusBarAppearanceUpdate];
}
/*****************************************/
#pragma mark - Set Status Bar Style
/*****************************************/
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)cancelNumberPad{
    [MobileNumberTF resignFirstResponder];
    MobileNumberTF.text = @"";
}

-(void)doneWithNumberPad{
   
    [MobileNumberTF resignFirstResponder];
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

- (IBAction)RegisterBTNclick:(id)sender
{
    [self ResignResponder];
    
    
    
//    NSRange whiteSpaceRange = [NameTF.text rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
//    
//    NSRange whiteSpaceRange1 = [PasswordTF.text rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
//    
//    NSRange whiteSpaceRange2 = [selectcountryTF.text rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
//    
//        NSRange whiteSpaceRange3 = [MobileNumberTF.text rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
//    
//    if (whiteSpaceRange.location != NSNotFound)
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Remove Space from UserName"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//    }
//    else if (whiteSpaceRange1.location != NSNotFound)
//    {
//        
//    }
//    else if (whiteSpaceRange2.location != NSNotFound)
//    {
//        
//    }
//    else if (whiteSpaceRange2.location != NSNotFound)
//    {
//        
//    }
//    else
//    {
        if(NameTF.text.length<1)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"User Name Must Be Required"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else if(PasswordTF.text.length<1)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Create Account Password Atleast Six digite "  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else if(ConfirmPasswordTF.text.length<6)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Create Account Password Atleast Six digite "  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else if (![ConfirmPasswordTF.text isEqualToString:PasswordTF.text])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Password and confirmpassword does not match"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else if (EmailTF.text.length<1)
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please Imnsert Your Email ID "  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
        }
        else
        {
            NSString *regExPattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
            NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
            NSUInteger regExMatches = [regEx numberOfMatchesInString:EmailTF.text options:0 range:NSMakeRange(0, [EmailTF.text length])];
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
                
                
                
                
                
                
                if(Is_changed==YES)
                {
                    
                    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
                    
                    NSNumber *timeStampObj = [NSNumber numberWithDouble: timeStamp];
                    
                    NSString *photoID = [NSString stringWithFormat:@"%@",timeStampObj];
                    NSLog(@"%@",photoID);
                    
                    
                    
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: attachment; name=\"user_image\"; filename=\"%@.png\"\r\n",photoID] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    [body appendData:[NSData dataWithData:UIImageJPEGRepresentation(profilePIc.image,1)]];
                    
                    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    
                }
                
                
                
               //admin.vasundharavision.com/woofr/api/?action=user_register&user_name=jeet&user_email=jeet@gmail.com&password=123456&country_code=+91&mobile_no=8866828980&user_token=Abctu583bajf8t&fb_id=123456
                
                
                NSMutableDictionary *sendData = [[NSMutableDictionary alloc]init];
                
                
                NSUserDefaults *fetchDefaultslogin = [NSUserDefaults standardUserDefaults];
                NSString *deviceTokan=[NSString stringWithFormat:@"%@",[fetchDefaultslogin valueForKey:@"deviceToken"]];
                
                
                [sendData setObject:@"user_register" forKey:@"action"];
                [sendData setObject:[NSString stringWithFormat:@"%@",NameTF.text] forKey:@"user_name"];
                [sendData setObject:[NSString stringWithFormat:@"%@",PasswordTF.text] forKey:@"password"];
                [sendData setObject:[NSString stringWithFormat:@"%@",EmailTF.text] forKey:@"user_email"];
                [sendData setObject:/*deviceTokan*/@"123456789" forKey:@"user_token"];
                [sendData setObject:[NSString stringWithFormat:@"%@",MobileNumberTF.text] forKey:@"mobile_no"];
                [sendData setObject:[NSString stringWithFormat:@"%@",selectcountryTF.text] forKey:@"country_code"];
               
                
                
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
                
                registerUDIDConnectionRegister = [NSURLConnection connectionWithRequest:request delegate:self];
                if (registerUDIDConnectionRegister)
                {
                    registerUDIDDataRegister = [[NSMutableData alloc]init];
                }
                
                
            }
        }
  //  }

    
    
   // http://admin.vasundharavision.com/woofr/api/?action=user_register&user_name=jeet&user_email=jeet@gmail.com&password=123456&country_code=+91&mobile_no=8866828980&user_token=Abctu583bajf8t&fb_id=123456
}
//********************************************
#pragma mark - Connection Delegate Methods
//********************************************

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection == registerUDIDConnectionRegister)
    {
        [registerUDIDDataRegister appendData:data];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (connection == registerUDIDConnectionRegister)
    {
        [registerUDIDDataRegister setLength:0];
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
    if (connection == registerUDIDConnectionRegister)
    {
        NSMutableString *responceversionStr = [[NSMutableString alloc]initWithBytes:[registerUDIDDataRegister mutableBytes] length:[registerUDIDDataRegister length] encoding:NSUTF8StringEncoding];
        NSMutableDictionary *gat_dic = [[NSMutableDictionary alloc]init];
        [gat_dic setDictionary:[responceversionStr JSONValue]];
        
        [HUD hide:YES];
        
        NSLog(@"%@",gat_dic);
        
        NSString *statusSTR=[NSString stringWithFormat:@"%@",[gat_dic valueForKey:@"status"]];
        
        if([statusSTR isEqualToString:@"1"])
        {
            UIAlertView *connectionAlert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"%@",[gat_dic valueForKey:@"message"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [connectionAlert show];
            
            
        }
        else
        {
            UIAlertView *connectionAlert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"%@",[gat_dic valueForKey:@"message"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [connectionAlert show];
        }
    }
}
- (IBAction)PhotoBTNclick:(id)sender
{
    [self ResignResponder];
    
    UIAlertView  *imagealert = [[UIAlertView alloc] initWithTitle:@"Pick Photo Using:" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    [imagealert addButtonWithTitle:@"Camera roll"];
    [imagealert addButtonWithTitle:@"Take Photo"];
    imagealert.tag=223;
    [imagealert show];

}


-(void)cameraroll
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker
                           animated:YES completion:nil];
    }
    else
    {
        UIAlertView *cameraalert = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"No comera found in this device" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [cameraalert show];
        
    }
    
}
-(void)photos
{
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.allowsEditing=NO;
    
    [self presentModalViewController:imagePickerController animated:YES];
    
}
//****************************************
#pragma mark - ImagePicker or caera method
//****************************************
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
    // Dismiss the image selection, hide the picker and
    
    //show the image view with the picked image
    
    UIImage *newImage = image;
    //UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 150, 150)];
    //img.image=newImage;
    
    CGRect rect = CGRectMake(0,0,400,400);
    //    UIGraphicsBeginImageContext( rect.size );
    UIGraphicsBeginImageContextWithOptions(rect.size,NO,0.0);
    [newImage drawInRect:rect];
    UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //    NSData *imageData = UIImagePNGRepresentation(picture1);
    
    
    NSData *imageData = UIImageJPEGRepresentation(picture1,1);
    UIImage *imgfinal=[UIImage imageWithData:imageData];
    
    if([imageData length]<-700000)
    {
        profilePIc.image=nil;
        profilePIc.image=imgfinal;
        
        Is_changed=YES;
    }
    else
    {
        Is_changed=NO;
        
        UIAlertView *connectionAlert = [[UIAlertView alloc]initWithTitle:nil message:@"Your image size is big." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [connectionAlert show];
        
    }
    
    
    
    //[self.view addSubview:img];
    
    // NSData *imagedata = UIImagePNGRepresentation(newImage);
    [picker dismissModalViewControllerAnimated:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //Stop portarit mode here
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
     [self setNeedsStatusBarAppearanceUpdate];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==223)
    {
        NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
        
        if([title isEqualToString:@"Camera roll"])
        {
            [self photos];
        }
        else if ([title isEqualToString:@"Take Photo"])
        {
            
            UIImagePickerController *imagePicker =
            [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType =
            UIImagePickerControllerSourceTypeCamera;
            imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
            imagePicker.allowsEditing = NO;
            [self presentViewController:imagePicker
                               animated:YES completion:nil];
        }
    }
}






- (IBAction)LoginBtnclick:(id)sender
{
    [self ResignResponder];
    [self.navigationController popViewControllerAnimated:YES];
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
    [NameTF resignFirstResponder];
    [EmailTF resignFirstResponder];
    [PasswordTF resignFirstResponder];
    [ConfirmPasswordTF resignFirstResponder];
    [selectcountryTF resignFirstResponder];
    [MobileNumberTF resignFirstResponder];
}
@end
