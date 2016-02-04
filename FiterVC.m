//
//  FiterVC.m
//  WOOFR
//
//  Created by Hemal Kachhadiya on 12/21/15.
//  Copyright (c) 2015 dipen. All rights reserved.
//

#import "FiterVC.h"

@interface FiterVC ()
{
    NSInteger detectfilter;
    NSMutableArray *filterary;
    
    NSUserDefaults *detect;

}
@end

@implementation FiterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    
    
    self.navigationItem.hidesBackButton = YES;
    
    
    UIBarButtonItem *CLOSEButton = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(CloseView)];
    
    CLOSEButton.tintColor=[UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = CLOSEButton;
    
    
    UIBarButtonItem *DoneButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(DoneClick)];
    DoneButton.tintColor=[UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = DoneButton;
    
    
    
    filterary=[[NSMutableArray alloc]initWithObjects:@"Popular",@"Nearest",@"Recent",@"Location", nil];
    
    detect=[NSUserDefaults standardUserDefaults];
    
    detectfilter=[detect integerForKey:@"FilterWoofr"];
    
    self.title=@"FILTER";
    

}
-(void)DoneClick
{
    [detect setInteger:detectfilter forKey:@"FilterWoofr"];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)CloseView
{
    [self.navigationController popViewControllerAnimated:YES];
}
//********************************
#pragma mark - Table View Methods
//********************************

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [filterary count];    //count number of row from counting array hear cataGorry is An Array
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID =@"cellID";
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    UILabel *nameLBL=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, ViewWIdth-20, 44)];
    nameLBL.font=[UIFont fontWithName:@"ProximaNova-Semibold" size:15.0];
    nameLBL.userInteractionEnabled=YES;
    nameLBL.text=[NSString stringWithFormat:@"%@",[filterary objectAtIndex:indexPath.row]];
          [cell addSubview:nameLBL];
    
    UIImageView *lineIMG=[[UIImageView alloc]initWithFrame:CGRectMake(0, 43, ViewWIdth, 1)];
    lineIMG.backgroundColor=[UIColor colorWithRed:147.0/255.0 green:129.0/255.0 blue:99.0/255.0 alpha:1.0];
    lineIMG.userInteractionEnabled=YES;
    [cell addSubview:lineIMG];
    
    UIImageView *trueimage=[[UIImageView alloc]initWithFrame:CGRectMake(ViewWIdth-35, 15, 25, 15)];
    if(detectfilter==indexPath.row)
    {
        nameLBL.textColor=[UIColor colorWithRed:147.0/255.0 green:129.0/255.0 blue:99.0/255.0 alpha:1.0];
        trueimage.image=[UIImage imageNamed:@"ic_alert_right.png"];
    }
    else
    {
        nameLBL.textColor=[UIColor whiteColor];
        trueimage.image=[UIImage imageNamed:@""];
    }
    trueimage.userInteractionEnabled=YES;
    trueimage.tag=5000+indexPath.row;
    [cell addSubview:trueimage];
    
    UIButton *clickBTN=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, ViewWIdth, 44)];
    [clickBTN addTarget:self action:@selector(ClickBTNclick:) forControlEvents:UIControlEventTouchUpInside];
    clickBTN.tag=5020+indexPath.row;
    [cell addSubview:clickBTN];
    
    
    

    
    
    return cell;
    
}

-(void)ClickBTNclick:(id)sender
{
    UIButton *temp = (UIButton *)sender;
    NSLog(@"%ld",(long)temp.tag);
    
    int long clickindex = temp.tag-5020;
    
    detectfilter = clickindex;
    
//    for(int i=0; i<filterary.count;i++)
//    {
//        UIImageView *temp=(UIImageView *)[FilterTypeTBL viewWithTag:5000+i];
//        if(i==detectfilter)
//        {
//            temp.image=[UIImage imageNamed:@"ic_alert_right.png"];
//        }
//        else
//        {
//             temp.image=[UIImage imageNamed:@""];
//        }
//    }
    [FilterTypeTBL reloadData];
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

@end
