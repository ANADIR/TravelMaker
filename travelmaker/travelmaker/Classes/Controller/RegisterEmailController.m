//
//  RegisterEmailController.m
//  Travel Maker
//
//  Created by developer on 12/7/15.
//  Copyright © 2015 developer. All rights reserved.
//

#import "RegisterEmailController.h"
#import "AppDelegate.h"

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
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickContinue:(UIButton *)sender
{
    NSString *email = [txtEmail text];
    if ([Common checkEmailValidation:email] == NO)
    {
        [Common showAlert:@"error" Message:@"Please input a valid email address." ButtonName:@"Ok"];
        return;
    }
    
    NSString *passwd = [txtPasswd text];
    if ([Common checkPasswordValidation:passwd] == NO)
    {
        [Common showAlert:@"error" Message:@"Password is no less than 6 characters." ButtonName:@"Ok"];
        return;
    }
    
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSString *deviceId = delegate.deviceId;
    
    NSString * registerUrl = @"http://travelmakerdata.co.nf/server/index.php?action=register_user";
    registerUrl = [NSString stringWithFormat:@"%@&device_id=%@",registerUrl, deviceId];
    registerUrl = [NSString stringWithFormat:@"%@&FB_id=%@",    registerUrl, @""];
    registerUrl = [NSString stringWithFormat:@"%@&fullname=%@", registerUrl, @""];
    registerUrl = [NSString stringWithFormat:@"%@&cellphone=%@",registerUrl, self.cellPhone];
    registerUrl = [NSString stringWithFormat:@"%@&image_url=%@",registerUrl, @"none"];
    registerUrl = [NSString stringWithFormat:@"%@&email=%@",    registerUrl, email];
    registerUrl = [NSString stringWithFormat:@"%@&password=%@", registerUrl, passwd];


    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [DCDefines getHttpAsyncResponse:registerUrl :^(NSData *data, NSError *connectionError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        
        NSData *responseData = data;
        if (responseData == nil) {
            return;
        }
        NSString *string = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSLog(@"result string: %@", string);
        
        NSError *error;
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
        NSString * status = [jsonDict objectForKey:@"status"];
//        NSString * returnerror = [jsonDict objectForKey:@"error"];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([status isEqualToString:@"done"] == NO) {
                [Common showAlert:@"Error" Message:@"Failed on registering user." ButtonName:@"Ok"];
            }
        });
    }];

}
@end
