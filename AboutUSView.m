//
//  AboutUSView.m
//  WOOFR
//
//  Created by dipen  narola on 20/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#import "AboutUSView.h"

@interface AboutUSView ()

@end

@implementation AboutUSView

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
    
    self.title=@"ABOUT";
    
    
    
    if(self.view.frame.size.height<500)
    {
        CGRect TextViewFRM = AboutUSText.frame;
        TextViewFRM.origin.y=AboutUSText.frame.origin.y-60;
        TextViewFRM.size.height=AboutUSText.frame.size.height+60;
        AboutUSText.frame=TextViewFRM;
    }
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    UITextView *tv = object;
    CGFloat topCorrect = ([tv bounds].size.height - [tv contentSize].height * [tv zoomScale])/2.0;
    topCorrect = ( topCorrect < 0.0 ? 0.0 : topCorrect );
    tv.contentOffset = (CGPoint){.x = 0, .y = -topCorrect};
}
-(void)viewWillDisappear:(BOOL)animated
{
    [ AboutUSText removeObserver:self forKeyPath:@"contentSize" context:NULL];
}
-(void)viewWillAppear:(BOOL)animated
{
    AboutUSText.frame=CGRectMake(10, FBBTN.frame.origin.y+FBBTN.frame.size.height+10, ViewWIdth-20, ViewHEight-(BOTTOMVIEW.frame.size.height+FBBTN.frame.origin.y+FBBTN.frame.size.height+20));
     [AboutUSText addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew) context:NULL];
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

- (IBAction)writereviewBTN:(id)sender
{
    
}

- (IBAction)rateUSBTNclick:(id)sender {
}

- (IBAction)WebsiteBTNclick:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.google.com"]];
}

- (IBAction)FBBtnclick:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/dipennarola"]];
}

- (IBAction)TWtBTNclick:(id)sender
{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/DipenNarola"]];
}
@end
