//
//  PaymentVC.m
//  WOOFR
//
//  Created by dipen  narola on 10/12/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import "PaymentVC.h"
#import "VoucherVC.h"

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.6;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@interface PaymentVC ()
{
    NSMutableArray *MnthARY,*YearARY;
    int PickerMonth;
    BOOL isHide;
    float amount;
}
@end

@implementation PaymentVC

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
    
    
    amount=[[NSUserDefaults standardUserDefaults]floatForKey:@"PayableAMountRoof"];
    TotalLBL.text=[NSString stringWithFormat:@"%.01fSGD",amount];
    
    //    self.navigationItem.backBarButtonItem.image=[UIImage imageNamed:@"ic_header_back.png"];
    //    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"back-button-image"]];
    //    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back-button-image"]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor]];
    
    self.title=@"Payment";
    
    CardNAMETF.placeholder=@"Your name";
    CardNAMETF.layer.cornerRadius=5.0;
    CardNAMETF.layer.borderWidth=1.0;
    CardNAMETF.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    [CardNAMETF setValue:[UIColor whiteColor]
              forKeyPath:@"_placeholderLabel.textColor"];
    
    CardNAMETF.leftView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    CardNAMETF.leftViewMode = UITextFieldViewModeAlways;
    
    containerVIEW.layer.cornerRadius=10.0;
    containerVIEW.layer.borderWidth=1.0;
    containerVIEW.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    
    
    cardNumTF.placeholder=@"Card Number";
    cardNumTF.layer.cornerRadius=5.0;
    cardNumTF.layer.borderWidth=1.0;
    cardNumTF.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    [cardNumTF setValue:[UIColor whiteColor]
             forKeyPath:@"_placeholderLabel.textColor"];
    
    cardNumTF.leftView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    cardNumTF.leftViewMode = UITextFieldViewModeAlways;
    
    
    //cardMnthTF.placeholder=@"Month";
    MonthBTN.layer.cornerRadius=5.0;
    MonthBTN.layer.borderWidth=1.0;
    MonthBTN.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    
    
//    cardMnthTF.rightView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
//    cardMnthTF.rightViewMode = UITextFieldViewModeAlways;
    
    /*
    cardYearTF.placeholder=@"Year";
    cardYearTF.layer.cornerRadius=5.0;
    cardYearTF.layer.borderWidth=1.0;
    cardYearTF.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    [cardYearTF setValue:[UIColor whiteColor]
              forKeyPath:@"_placeholderLabel.textColor"];
    cardYearTF.rightView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    cardYearTF.rightViewMode = UITextFieldViewModeAlways;
     
     */
    
    YearBTN.layer.cornerRadius=5.0;
    YearBTN.layer.borderWidth=1.0;
    YearBTN.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    
    
    CardCVCTF.placeholder=@"CVC";
    CardCVCTF.layer.cornerRadius=5.0;
    CardCVCTF.layer.borderWidth=1.0;
    CardCVCTF.layer .borderColor=[UIColor colorWithRed:155.0/255.0 green:130.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    [CardCVCTF setValue:[UIColor whiteColor]
             forKeyPath:@"_placeholderLabel.textColor"];
    
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    cardNumTF.inputAccessoryView = numberToolbar;
    
    
    UIToolbar* numberToolbar1 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar1.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar1.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad1)]];
    [numberToolbar1 sizeToFit];
    CardCVCTF.inputAccessoryView = numberToolbar1;
    
    
    MnthARY=[[NSMutableArray alloc]initWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12", nil];
    
    YearARY=[[NSMutableArray alloc]init];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *yearString = [formatter stringFromDate:[NSDate date]];
    int Year=[yearString intValue];
    
    for(int i=0;i<20;i++)
    {
        [YearARY addObject:[NSString stringWithFormat:@"%i",Year]];
        Year++;
    }
    
    PickerMonth=0;
    
    if(paynowBTN.frame.origin.y+paynowBTN.frame.size.height<scrl.frame.size.height)
    {
        CGRect payFrm = paynowBTN.frame;
        payFrm.origin.y=scrl.frame.size.height-(paynowBTN.frame.size.height+10);
        paynowBTN.frame=payFrm;
    }
    
    scrl.contentSize=CGSizeMake(ViewWIdth, paynowBTN.frame.origin.y+paynowBTN.frame.size.height+10);
    
    
    
}
-(void)doneWithNumberPad
{
    [cardNumTF resignFirstResponder];
}
-(void)doneWithNumberPad1
{
    [CardCVCTF resignFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [CardNAMETF resignFirstResponder];
    [cardNumTF resignFirstResponder];
    [CardCVCTF resignFirstResponder];
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y = 0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    PickerMonth=0;
    
    if(paynowBTN.frame.origin.y+paynowBTN.frame.size.height<scrl.frame.size.height)
    {
        CGRect payFrm = paynowBTN.frame;
        payFrm.origin.y=scrl.frame.size.height-(paynowBTN.frame.size.height+10);
        paynowBTN.frame=payFrm;
    }
    
    scrl.contentSize=CGSizeMake(ViewWIdth, paynowBTN.frame.origin.y+paynowBTN.frame.size.height+10);
//    UIImageView *Image=[[UIImageView alloc]initWithFrame:CGRectMake(cardMnthTF.frame.size.width-20, 10, 10, 10)];
//    Image.image=[UIImage imageNamed:@"ic_header_select_country.png"];
//    
//    [cardMnthTF addSubview:Image];
//    
//    UIImageView *Image1=[[UIImageView alloc]initWithFrame:CGRectMake(cardYearTF.frame.size.width-20, 10, 10, 10)];
//    Image1.image=[UIImage imageNamed:@"ic_header_select_country.png"];
//    
//    [cardYearTF addSubview:Image1];
}

//**********************************
#pragma mark - Auto scroll view
//**********************************

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    [datePicker removeFromSuperview];
    [datepickerkeyboard removeFromSuperview];
    
    CGRect Frm=scrl.frame;
    Frm.origin.y=0;
    scrl.frame=Frm;
    
    
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
    
    if( textField == cardMnthTF )
    {
        isHide=NO;
        [cardMnthTF resignFirstResponder];
    }
    else if(textField == cardYearTF)
    {
        isHide=NO;
        [cardYearTF resignFirstResponder];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if(textField ==cardMnthTF || textField == cardYearTF)
    {
        if(isHide==YES)
        {
            CGRect viewFrame = self.view.frame;
            viewFrame.origin.y += animatedDistance;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
            [self.view setFrame:viewFrame];
            
            [UIView commitAnimations];
        }
    }
    else
    {
        if(textField == cardNumTF)
        {
            [cardNumTF resignFirstResponder];
        }
        CGRect viewFrame = self.view.frame;
        viewFrame.origin.y += animatedDistance;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
        [self.view setFrame:viewFrame];
        
        [UIView commitAnimations];
    }
}

//****************************************
#pragma mark - textfield delegate set
//****************************************

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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //    NSString *changedText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    //    NSArray* items = [changedText componentsSeparatedByString:@"@"];
    
    
    
    if(textField == cardNumTF)
    {
        
        __block NSString *text = [textField text];
        
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
            return NO;
        }
        
        text = [text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *newString = @"";
        while (text.length > 0) {
            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4) {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 4)];
        }
        
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        
        if (newString.length >= 20) {
            return NO;
        }
        
        [textField setText:newString];
        
        return NO;
        
    }
    else if(textField == CardCVCTF)
    {
        NSUInteger newLength = [CardCVCTF.text length] + [string length] - range.length;
        return (newLength > 3) ? NO : YES;

    }
    else
    {
        return YES;
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

- (IBAction)ScanCardBTNclick:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
    VoucherVC *dealVC1 = (VoucherVC *)[storyboard instantiateViewControllerWithIdentifier:@"VoucherVC"];
    [self.navigationController pushViewController:dealVC1 animated:YES];

}

- (IBAction)MonthBTnclick:(id)sender
{
    [datePicker removeFromSuperview];
    [datepickerkeyboard removeFromSuperview];
    
    PickerMonth=1;
    
    [CardNAMETF resignFirstResponder];
    [cardNumTF resignFirstResponder];
    [CardCVCTF resignFirstResponder];
    
    
    self.view.frame=CGRectMake(0, 0, ViewWIdth, ViewHEight);
    CGRect ViewFRM=self.view.frame;
    scrl.frame=ViewFRM;
    
    CGRect frm=scrl.frame;
    if(((self.view.frame.size.height+64-280-44)-492)<0)
    {
        frm.origin.y=(self.view.frame.size.height+64-280-44)-492;
    }
    scrl.frame=frm;
   
    
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    datePicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    datePicker.showsSelectionIndicator = YES;
    // breed_picker.backgroundColor=[UIColor grayColor];
    datePicker.dataSource = self;
    datePicker.delegate = self;
    MonthLBL.text=@"01";
    datePicker.frame = CGRectMake(0, self.view.frame.size.height+64-280, self.view.frame.size.width, 350);
    datepickerkeyboard = [[UIToolbar alloc] initWithFrame:CGRectMake(0, datePicker.frame.origin.y-44,self.view.frame.size.width , 44)];
    [datePicker setBackgroundColor:[UIColor lightGrayColor]];
    
    datepickerkeyboard.barStyle     = UIBarStyleDefault;
    [datepickerkeyboard sizeToFit];
    
    NSMutableArray *cat_barItems = [[NSMutableArray alloc] init];
    
    //        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(BreedCancelbtnPressed)];
    //        [cat_barItems addObject:cancelBtn];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [cat_barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(catdoneButton_click)];
    [cat_barItems addObject:doneBtn];
    
    
    [datepickerkeyboard setItems:cat_barItems animated:YES];
    [self.view addSubview:datePicker];
    [self.view addSubview:datepickerkeyboard];
    
    
}

- (IBAction)YearBTNclick:(id)sender
{
    [datePicker removeFromSuperview];
    [datepickerkeyboard removeFromSuperview];
    
    [CardNAMETF resignFirstResponder];
    [cardNumTF resignFirstResponder];
    [CardCVCTF resignFirstResponder];
   // [cardYearTF becomeFirstResponder];
    
    self.view.frame=CGRectMake(0, 0, ViewWIdth, ViewHEight);
    CGRect ViewFRM=self.view.frame;
    scrl.frame=ViewFRM;
    
    CGRect frm=scrl.frame;
    if(((self.view.frame.size.height+64-280-44)-492)<0)
    {
        frm.origin.y=(self.view.frame.size.height+64-280-44)-492;
    }
    scrl.frame=frm;
    
    
    
    
    PickerMonth=0;
    
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    datePicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    datePicker.showsSelectionIndicator = YES;
    // breed_picker.backgroundColor=[UIColor grayColor];
    datePicker.dataSource = self;
    datePicker.delegate = self;
    YearLBL.text=[NSString stringWithFormat:@"%@",[YearARY objectAtIndex:0]];
    datePicker.frame = CGRectMake(0, self.view.frame.size.height+64-280, self.view.frame.size.width, 350);
    datepickerkeyboard = [[UIToolbar alloc] initWithFrame:CGRectMake(0, datePicker.frame.origin.y-44,self.view.frame.size.width , 44)];
    [datePicker setBackgroundColor:[UIColor lightGrayColor]];
    
    datepickerkeyboard.barStyle     = UIBarStyleDefault;
    [datepickerkeyboard sizeToFit];
    
    NSMutableArray *cat_barItems = [[NSMutableArray alloc] init];
    
    //        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(BreedCancelbtnPressed)];
    //        [cat_barItems addObject:cancelBtn];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [cat_barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(catdoneButton_click)];
    [cat_barItems addObject:doneBtn];
    
    
    [datepickerkeyboard setItems:cat_barItems animated:YES];
    [self.view addSubview:datePicker];
    [self.view addSubview:datepickerkeyboard];
}
//****************************************
#pragma mark - PayNow Button click
//****************************************
- (IBAction)paynwBTNclick:(id)sender
{
    
    [CardNAMETF resignFirstResponder];
    [cardNumTF resignFirstResponder];
    [CardCVCTF resignFirstResponder];
    [datePicker removeFromSuperview];
    [datepickerkeyboard removeFromSuperview];
    
    BOOL whitespace1 = false;
    
    
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    if ([[CardNAMETF.text stringByTrimmingCharactersInSet: set] length] == 0)
    {
        // String contains only whitespace.
        whitespace1=YES;
    }
    
    if(CardNAMETF.text.length<1 || whitespace1==YES)
    {
        UIAlertView *connectionlert = [[UIAlertView alloc]initWithTitle:nil message:@"Please Insert Card holder Name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [connectionlert show];
    }
    else if (cardNumTF.text.length<19)
    {
        UIAlertView *connectionlert = [[UIAlertView alloc]initWithTitle:nil message:@"Please Insert Valid Card Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [connectionlert show];
    }
    else if ([MonthLBL.text isEqualToString:@"Month"])
    {
        UIAlertView *connectionlert = [[UIAlertView alloc]initWithTitle:nil message:@"Please Insert Card Expiration Month" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [connectionlert show];
    }
    else if ([YearLBL.text isEqualToString:@"Year"])
    {
        UIAlertView *connectionlert = [[UIAlertView alloc]initWithTitle:nil message:@"Please Insert Card Expiration Year" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [connectionlert show];
    }
    else if (CardCVCTF.text.length<3)
    {
        UIAlertView *connectionlert = [[UIAlertView alloc]initWithTitle:nil message:@"Please Insert Valid Card CVC Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [connectionlert show];
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
        
        
        
        NSMutableDictionary *sendDataDict=[[NSMutableDictionary alloc]init];
     
        
        NSMutableDictionary *sendData = [[NSMutableDictionary alloc]init];
        //admin.vasundharavision.com/woofr/api/?action=stripe_payment&amount=200&currency=USD&card_number=4242424242424242&exp_month=08&exp_year=2016&cvc=123&email=jitendra.dumaraliya@gmail.com&book_data=dummyarr
     
        NSString *secondString = [cardNumTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *typeSTR = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"WooFrclubDetetct"]];
        
        
        NSMutableDictionary *UserInfo=[[NSMutableDictionary alloc]init];
        
        NSUserDefaults *user=[[NSUserDefaults alloc]init];
        
        UserInfo=[user valueForKey:@"WoofrUSer"];
        
        
        
       
        [sendData setObject:@"stripe_payment" forKey:@"action"];
        [sendData setObject:[NSString stringWithFormat:@"%f",amount] forKey:@"amount"];
        [sendData setObject:@"USD" forKey:@"currency"];
        [sendData setObject:secondString forKey:@"card_number"];
        [sendData setObject:[NSString stringWithFormat:@"%@",MonthLBL.text] forKey:@"exp_month"];
        [sendData setObject:[NSString stringWithFormat:@"%@",YearLBL.text] forKey:@"exp_year"];
        [sendData setObject:[NSString stringWithFormat:@"%@",CardCVCTF.text] forKey:@"cvc"];
        [sendData setObject:[NSString stringWithFormat:@"%@",[UserInfo valueForKey:@"user_email"]] forKey:@"email"];
        if([typeSTR isEqualToString:@"1"])
        {
            
            NSMutableDictionary *Foodorderdict1,*clubDetailDict1,*tblDetailDict1;
            Foodorderdict1=[[NSMutableDictionary alloc]init];
            Foodorderdict1=[[NSUserDefaults standardUserDefaults] valueForKey:@"FoodOrderDictWoofr"];
            NSLog(@"OREDEr Value%@",Foodorderdict1);
            
            NSMutableArray *FoodnameARY1,*foodidARY1;
            FoodnameARY1=[[NSMutableArray alloc]init];
            FoodnameARY1=[[NSUserDefaults standardUserDefaults]valueForKey:@"WoofrFoodname"];
            
            
            foodidARY1=[[NSMutableArray alloc]init];
            foodidARY1=[[NSUserDefaults standardUserDefaults]valueForKey:@"WoofrFoodid"];
            
            clubDetailDict1=[[NSMutableDictionary alloc]init];
            clubDetailDict1=[[NSUserDefaults standardUserDefaults]valueForKey:@"WoofrclubDetail"];
            
            tblDetailDict1=[[NSMutableDictionary alloc]init];
            
            tblDetailDict1=[[NSUserDefaults standardUserDefaults]valueForKey:@"WooferTBLfoodvalues"];
             NSLog(@"Food ID Value%@",tblDetailDict1);
            
 
            BOOL PromoUSed=[[NSUserDefaults standardUserDefaults]boolForKey:@"woofrPROMOcodeUsed"];
            
            [sendDataDict setValue:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"WoofruserID"]] forKey:@"user_id"];
            [sendDataDict setValue:[NSString stringWithFormat:@"%@",[clubDetailDict1 valueForKey:@"club_id"]] forKey:@"club_id"];
            [sendDataDict setValue:[NSString stringWithFormat:@"%@",[tblDetailDict1 valueForKey:@"package_id"]] forKey:@"package_id"];
            if(PromoUSed==YES)
            {
                [sendDataDict setValue:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"woofereventPromocode"]] forKey:@"promocode_id"];
            }
            else
            {
                [sendDataDict setValue:@"" forKey:@"promocode_id"];
            }
            [sendDataDict setValue:[NSString stringWithFormat:@"%f",amount] forKey:@"amount"];
            
            
            NSDictionary *DateVDict=[[NSDictionary alloc]init];
            NSDictionary *TimeVDict=[[NSDictionary alloc]init];
            DateVDict=[[NSUserDefaults standardUserDefaults]valueForKey:@"WoofrBOOkingDate"];
            TimeVDict=[[NSUserDefaults standardUserDefaults]valueForKey:@"WoofrBOOkingTime"];
            
            NSString *datestr=[DateVDict valueForKey:@"FullDate"];
            
            [sendDataDict setValue:datestr forKey:@"book_date"];
            [sendDataDict setValue:[NSString stringWithFormat:@"%@",[TimeVDict valueForKey:@"time"]] forKey:@"book_time"];
            
            [sendDataDict setValue:@"1" forKey:@"is_type"];
            
            
            
            NSMutableArray *foodordERARY=[[NSMutableArray alloc]init];
            
            for(int i=0;i<FoodnameARY1.count;i++)
            {
                NSString *Foodnmstr =[NSString stringWithFormat:@"%@",[FoodnameARY1 objectAtIndex:i]];
                
                if ([Foodorderdict1 objectForKey:Foodnmstr])
                {
                    int Quantity;
                    Quantity=[[NSString stringWithFormat:@"%@",[Foodorderdict1 valueForKey:Foodnmstr]] intValue];
                    
                    if(Quantity>0)
                    {
                        NSMutableDictionary *temp=[[NSMutableDictionary alloc]init];
                        [temp setValue:[NSString stringWithFormat:@"%@",[foodidARY1 objectAtIndex:i]] forKey:@"food_id"];
                        [temp setValue:[NSString stringWithFormat:@"%i",Quantity] forKey:@"qty"];
                        
                        [foodordERARY addObject:temp];
                    }
                }
            }
            
             [sendDataDict setObject:foodordERARY forKey:@"food"];
            
            NSString *Jsonstr = [sendDataDict JSONRepresentation];
            
             [sendData setObject:Jsonstr forKey:@"book_data"];
        }
        else
        {
            
        }
     
        
        
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
        
        bookingconnection = [NSURLConnection connectionWithRequest:request delegate:self];
        if (bookingconnection)
        {
            bookingData = [[NSMutableData alloc]init];
        }

    }
}
//********************************************
#pragma mark - Connection Delegate Methods
//********************************************

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection == bookingconnection)
    {
        [bookingData appendData:data];
    }
 
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (connection == bookingconnection)
    {
        [bookingData setLength:0];
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
    if (connection == bookingconnection)
    {
        NSMutableString *responceversionStr = [[NSMutableString alloc]initWithBytes:[bookingData mutableBytes] length:[bookingData length] encoding:NSUTF8StringEncoding];
        NSMutableDictionary *gat_dic = [[NSMutableDictionary alloc]init];
        [gat_dic setDictionary:[responceversionStr JSONValue]];
        
        [HUD hide:YES];
        
        NSLog(@"%@",gat_dic);
        
        NSString *sucSTR=[NSString stringWithFormat:@"%@",[gat_dic valueForKey:@"status"]];
        
        if([sucSTR isEqualToString:@"1"])
        {
            [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%@",[gat_dic valueForKey:@"booking_id"]] forKey:@"WOOFRBOOKINGID"];
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:STORYBOARD_TYPE bundle:nil];
            VoucherVC *dealVC1 = (VoucherVC *)[storyboard instantiateViewControllerWithIdentifier:@"VoucherVC"];
            [self.navigationController pushViewController:dealVC1 animated:YES];
            
        }
        else
        {
            UIAlertView *connectionAlert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"%@",[gat_dic valueForKey:@"message"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [connectionAlert show];
        }
            
        
        
    }
}

-(void)catdoneButton_click
{
    isHide=YES;
    
    if(PickerMonth==1)
    {
        
        
        CGRect frm=scrl.frame;
        frm.origin.y=0;
        scrl.frame=frm;
        
        
        [datePicker removeFromSuperview];
        [datepickerkeyboard removeFromSuperview];
    }
    else
    {
        CGRect frm=scrl.frame;
        frm.origin.y=0;
        scrl.frame=frm;
        
        [cardYearTF resignFirstResponder];
        [datePicker removeFromSuperview];
        [datepickerkeyboard removeFromSuperview];
    }
}


//*******************************************
#pragma mark - Set Picker frame for category
//*******************************************
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    if(PickerMonth == 1)
    {
        return MnthARY.count;
    }
    else
    {
        return YearARY.count;
    }
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component
{
    
    
    if(PickerMonth == 1)
    {
        MonthLBL.text=[NSString stringWithFormat:@"%@",[MnthARY objectAtIndex:row]];
    }
    else
    {
        YearLBL.text=[NSString stringWithFormat:@"%@",[YearARY objectAtIndex:row]];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if(PickerMonth == 1)
    {
        return [MnthARY objectAtIndex:row];
    }
    else
    {
        return [YearARY objectAtIndex:row];
    }

}

@end
