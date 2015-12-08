//
//  RegisterEmailController.m
//  Travel Maker
//
//  Created by developer on 12/7/15.
//  Copyright © 2015 developer. All rights reserved.
//

#import "RegisterEmailController.h"

@interface RegisterEmailController ()

@end

@implementation RegisterEmailController

@synthesize vwEmail, vwPasswd;
@synthesize txtEmail, txtPasswd;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIGraphicsBeginImageContext(vwEmail.frame.size);
    [[UIImage imageNamed:@"FieldEmail"] drawInRect:vwEmail.bounds];
    UIImage *imgEmail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [vwEmail setBackgroundColor:[UIColor colorWithPatternImage:imgEmail]];
    
    UIGraphicsBeginImageContext(vwPasswd.frame.size);
    [[UIImage imageNamed:@"FieldPassword"] drawInRect:vwPasswd.bounds];
    UIImage *imgPasswd = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [vwPasswd setBackgroundColor:[UIColor colorWithPatternImage:imgPasswd]];

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


- (IBAction)clickBack:(UIButton *)sender
{
    
}

- (IBAction)clickContinue:(UIButton *)sender
{
    
}
@end
