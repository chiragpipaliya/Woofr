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
    

    
    NSURL *urllinksTR= [NSURL URLWithString:[[NSString stringWithFormat:@"%@",[UserInfo valueForKey:@"user_image"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    AsyncImageView *beerImage = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, ProfileIMG.frame.size.width, ProfileIMG.frame.size.height)];
    beerImage.layer.cornerRadius=beerImage.frame.size.width/2;
    beerImage.clipsToBounds=YES;
    [beerImage loadImageFromURL:urllinksTR imageName:@""];
    [ProfileIMG addSubview:beerImage];
    
    NameTF.text=[NSString stringWithFormat:@"%@",[UserInfo valueForKey:@"user_name"]];
    SelectCountryCodeTF.text=[NSString stringWithFormat:@"%@",[UserInfo valueForKey:@"country_code"]];
    MobileTF.text=[NSString stringWithFormat:@"%@",[UserInfo valueForKey:@"mobile_no"]];
    
//    ProfileIMGBTN.frame=CGRectMake(0, 0, ProfileIMG.frame.size.width, ProfileIMG.frame.size.height);
//    [ProfileIMG addSubview:ProfileIMGBTN];
    
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
    
    NSLog(@"HI");
}

- (IBAction)SaveBTNclick:(id)sender
{
    [self ResignResponder];
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

@end
