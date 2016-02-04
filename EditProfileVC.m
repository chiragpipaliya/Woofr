//
//  EditProfileVC.m
//  WOOFR
//
//  Created by dipen  narola on 21/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import "EditProfileVC.h"

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.6;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@interface EditProfileVC ()
{
    BOOL Is_changed;
    AsyncImageView *beerImage;
    
    NSString *oldPassSTR;
    
    NSString *UserID;
}
@end

@implementation EditProfileVC

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
    
    self.title=@"EDIT PROFILE";
    
    
    
    
    NamebackIMG.layer.borderWidth=1.0;
    NamebackIMG.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    
    PreBackimge.layer.borderWidth=1.0;
    PreBackimge.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    
    [NameTF setValue:[UIColor whiteColor]
          forKeyPath:@"_placeholderLabel.textColor"];
    [PrePAssTF setValue:[UIColor whiteColor]
           forKeyPath:@"_placeholderLabel.textColor"];
    
    
    Newpassbackimg.layer.borderWidth=1.0;
    Newpassbackimg.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    
    Confpassbackimg.layer.borderWidth=1.0;
    Confpassbackimg.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    
    [PassNewTF setValue:[UIColor whiteColor]
              forKeyPath:@"_placeholderLabel.textColor"];
    [ReEnterPassTF setValue:[UIColor whiteColor]
                     forKeyPath:@"_placeholderLabel.textColor"];
    
    
    countrycodebackImg.layer.borderWidth=1.0;
    countrycodebackImg.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    
    MobilebackImg.layer.borderWidth=1.0;
    MobilebackImg.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    
    [SelectCountryCodeTF setValue:[UIColor whiteColor]
                   forKeyPath:@"_placeholderLabel.textColor"];
    [MobileTF setValue:[UIColor whiteColor]
                  forKeyPath:@"_placeholderLabel.textColor"];
    
    
    EditPSCR.contentSize=CGSizeMake(self.view.frame.size.width, SaveBTN.frame.origin.y+SaveBTN.frame.size.height+10);
    
    NSMutableDictionary *UserInfo=[[NSMutableDictionary alloc]init];
    
    NSUserDefaults *user=[[NSUserDefaults alloc]init];
    
    UserInfo=[user valueForKey:@"WoofrUSer"];
    

    oldPassSTR=[NSString stringWithFormat:@"%@",[UserInfo valueForKey:@"password"]];
    UserID=[NSString stringWithFormat:@"%@",[UserInfo valueForKey:@"user_id"]];
    
    NSURL *urllinksTR= [NSURL URLWithString:[[NSString stringWithFormat:@"%@",[UserInfo valueForKey:@"user_image"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    beerImage = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, ProfileIMG.frame.size.width, ProfileIMG.frame.size.height)];
    beerImage.layer.cornerRadius=beerImage.frame.size.width/2;
    beerImage.clipsToBounds=YES;
    [beerImage loadImageFromURL:urllinksTR imageName:@""];
    [ProfileIMG addSubview:beerImage];
    
    ProfileIMG.layer.cornerRadius=ProfileIMG.frame.size.width/2;
    ProfileIMG.clipsToBounds=YES;
    
    NameTF.text=[NSString stringWithFormat:@"%@",[UserInfo valueForKey:@"user_name"]];
    SelectCountryCodeTF.text=[NSString stringWithFormat:@"%@",[UserInfo valueForKey:@"country_code"]];
    MobileTF.text=[NSString stringWithFormat:@"%@",[UserInfo valueForKey:@"mobile_no"]];
    
//    ProfileIMGBTN.frame=CGRectMake(0, 0, ProfileIMG.frame.size.width, ProfileIMG.frame.size.height);
//    [ProfileIMG addSubview:ProfileIMGBTN];
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    MobileTF.inputAccessoryView = numberToolbar;
    
    HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUD];
    [self.view bringSubviewToFront:HUD];
    [HUD setDelegate:self];
    [HUD setLabelText:@"Loading...."];

    
}
-(void)cancelNumberPad
{
    [MobileTF resignFirstResponder];
}
-(void)doneWithNumberPad
{
    [MobileTF resignFirstResponder];
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

- (IBAction)ProfileImgbtnclick:(id)sender
{
    [self ResignResponder];
    UIAlertView  *imagealert = [[UIAlertView alloc] initWithTitle:@"Pick Photo Using:" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    [imagealert addButtonWithTitle:@"Camera roll"];
    [imagealert addButtonWithTitle:@"Take Photo"];
    imagealert.tag=223;
    [imagealert show];

}

- (IBAction)SaveBTNclick:(id)sender
{
    [self ResignResponder];
    
    if(NameTF)
    
    if(PrePAssTF.text.length>0)
    {
        if([PrePAssTF.text isEqualToString:oldPassSTR])
        {
            if(PassNewTF.text.length>0)
            {
                if([PassNewTF.text isEqualToString:ReEnterPassTF.text])
                {
                    [self UpdateAPI];
                }
                else
                {
                    UIAlertView *cameraalert = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Confirm Password is not matching with your New Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [cameraalert show];
                }
            }
            else
            {
                [self UpdateAPI];
            }
        }
        else
        {
            UIAlertView *cameraalert = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Insert Your correct Previous Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [cameraalert show];
        }
    }
    else
    {
        [self UpdateAPI];
    }
}
-(void)UpdateAPI
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
        
        [body appendData:[NSData dataWithData:UIImageJPEGRepresentation(ProfileIMG.image,1)]];
        
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    
    
    
    
    NSMutableDictionary *sendData = [[NSMutableDictionary alloc]init];
    
    
    [sendData setObject:@"update_user_profile" forKey:@"action"];
    if(NameTF.text.length>0)
    {
        [sendData setObject:[NSString stringWithFormat:@"%@",NameTF.text] forKey:@"user_name"];
    }
    if(PassNewTF.text.length>1)
    {
        [sendData setObject:[NSString stringWithFormat:@"%@",PassNewTF.text] forKey:@"password"];
    }
    
    [sendData setObject:UserID forKey:@"user_id"];
    [sendData setObject:[NSString stringWithFormat:@"%@",MobileTF.text] forKey:@"mobile_no"];
    [sendData setObject:[NSString stringWithFormat:@"%@",SelectCountryCodeTF.text] forKey:@"country_code"];
    
    
    
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
    
    UpdatePConnection = [NSURLConnection connectionWithRequest:request delegate:self];
    if (UpdatePConnection)
    {
        UpdatePData = [[NSMutableData alloc]init];
    }

}
//********************************************
#pragma mark - Connection Delegate Methods
//********************************************

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection == UpdatePConnection)
    {
        [UpdatePData appendData:data];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (connection == UpdatePConnection)
    {
        [UpdatePData setLength:0];
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
    if (connection == UpdatePConnection)
    {
        NSMutableString *responceversionStr = [[NSMutableString alloc]initWithBytes:[UpdatePData mutableBytes] length:[UpdatePData length] encoding:NSUTF8StringEncoding];
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
        }
        else
        {
            UIAlertView *connectionAlert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"%@",[gat_dic valueForKey:@"message"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [connectionAlert show];
        }
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
    [NameTF resignFirstResponder];
    [PrePAssTF resignFirstResponder];
    [PassNewTF resignFirstResponder];
    [ReEnterPassTF resignFirstResponder];
    [SelectCountryCodeTF resignFirstResponder];
    [MobileTF resignFirstResponder];
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
        imagePicker.allowsEditing = YES;
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
    imagePickerController.allowsEditing=YES;
    
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
    
    [beerImage removeFromSuperview];
    
    if([imageData length]<-700000)
    {
        ProfileIMG.image=nil;
        ProfileIMG.image=imgfinal;
        
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


@end
