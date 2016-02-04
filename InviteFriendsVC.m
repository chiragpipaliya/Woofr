//
//  InviteFriendsVC.m
//  WOOFR
//
//  Created by dipen  narola on 20/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import "InviteFriendsVC.h"
#import <Social/Social.h>
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>

@interface InviteFriendsVC ()

@end

@implementation InviteFriendsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _menubtn.tintColor = [UIColor whiteColor];
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    NSMutableDictionary *UserInfo=[[NSMutableDictionary alloc]init];
    
    NSUserDefaults *user=[[NSUserDefaults alloc]init];
    
    UserInfo=[user valueForKey:@"WoofrUSer"];
    
    PromoLBL.text=[NSString stringWithFormat:@"%@",[UserInfo valueForKey:@"referral_code"]];
    

    
    
    self.title=@"Invite";// Friends";
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

- (IBAction)EmailBTNclick:(id)sender
{
    [self emailshare];
}

- (IBAction)TextBTnclick:(id)sender
{
    [self sendMessage];
}

-(void)emailshare
{
    NSString * subject = @"Win Or Loss application Share";
    //email body
    // NSString * body = @"How did you find the Android-IOS-Tutorials Website ?";
    //recipient(s)
    // NSArray * recipients = [NSArray arrayWithObjects:@"info@vasundhravision.com", nil];
    MFMailComposeViewController * composer = [[MFMailComposeViewController alloc] init];
    
    if ([MFMailComposeViewController canSendMail]) {
        composer.mailComposeDelegate = self;
        [composer setSubject:subject];
        //[composer setMessageBody:@"here is link for Love Frame application" isHTML:NO];
        //[composer setMessageBody:body isHTML:YES]; //if you want to send an HTML message
        // [composer setToRecipients:recipients];
        
        [composer setMessageBody:@"Download amazing application Win Or Loss from app store : https://itunes.apple.com/us/app/win-or-loss/id985170419?ls=1&mt=8" isHTML:NO];
        
        //get the filepath from resources
        //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"logo" ofType:@"png"];
        
        //read the file using NSData
        // NSData * fileData = [NSData dataWithContentsOfFile:filePath];
        // Set the MIME type
        /*you can use :
         - @"application/msword" for MS Word
         - @"application/vnd.ms-powerpoint" for PowerPoint
         - @"text/html" for HTML file
         - @"application/pdf" for PDF document
         - @"image/jpeg" for JPEG/JPG images
         */
        //NSString *mimeType = @"image/png";
        
        //add attachement
        //[composer addAttachmentData:fileData mimeType:mimeType fileName:filePath];
        
        //present it on the screen
        [self presentViewController:composer animated:YES completion:NULL];
    }
    
    
    
    
    
}

//**************************************************
#pragma mark - Mail composer Controll
//**************************************************
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled"); break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved"); break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent"); break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]); break;
        default:
            break;
    }
    
    // close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}
//************************************************
#pragma mark - Send Message
//************************************************
-(void)sendMessage
{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        NSString *share_str=[NSString stringWithFormat:@"Download amazing application Win Or Loss from app store : https://itunes.apple.com/us/app/win-or-loss/id985170419?ls=1&mt=8"];
        
        controller.body = share_str;
        //controller.recipients = [NSArray arrayWithObjects:@"1(234)567-8910", nil];
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    }
    
    
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultCancelled:
            NSLog(@"Cancelled");
            break;
        case MessageComposeResultFailed:
            
            break;
        case MessageComposeResultSent:
            
            break;
        default:
            break;
    }
    
    [self dismissModalViewControllerAnimated:YES];
}

@end
