//
//  ContactController.m
//  Travel Maker
//
//  Created by developer on 1/5/16.
//  Copyright © 2016 developer. All rights reserved.
//

#import "ContactController.h"

@implementation ContactController

@synthesize txtDescription, txtEmail, txtFullName, txtPhone;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [txtDescription setPlaceholder:@"נושא"];
    [txtDescription setPlaceholderColor:[UIColor colorWithRed:50.0/255.0 green:152.0/255.0 blue:219.0/255.0 alpha:1.0f]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIGraphicsBeginImageContext(txtDescription.frame.size);
    [[UIImage imageNamed:@"NewFieldFreetext"] drawInRect:txtDescription.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    txtDescription.backgroundColor = [UIColor colorWithPatternImage:image];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - IBAction
- (IBAction)clickBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickSubmit:(id)sender
{
    NSString *fullname = [txtFullName text];
    if (fullname == nil || [fullname isEqualToString:@""] == YES)
    {
        [Common showAlert:@"Error" Message:@"Please input a full name." ButtonName:@"OK"];
        return;
    }
    
    NSString *email = [txtEmail text];
    if ([Common checkEmailValidation:email] == NO)
    {
        [Common showAlert:@"Error" Message:@"Please input a valid email address." ButtonName:@"Ok"];
        return;
    }
    
    NSString *phone = [txtPhone text];
    if (phone == nil || [phone isEqualToString:@""] == YES)
    {
        [Common showAlert:@"Error" Message:@"Please input a phone number" ButtonName:@"OK"];
        return;
    }
    
    NSString *description = [txtDescription text];
    if (description == nil || [description isEqualToString:@""] == YES)
    {
        [Common showAlert:@"Error" Message:@"Please input a description" ButtonName:@"OK"];
        return;
    }
    
    NSString * contactUrl = @"http://travelmakerdata.co.nf/server/index.php?action=contact_us";
    contactUrl = [NSString stringWithFormat:@"%@&fullname=%@",contactUrl, fullname];
    contactUrl = [NSString stringWithFormat:@"%@&email=%@",contactUrl, email];
    contactUrl = [NSString stringWithFormat:@"%@&phone=%@",contactUrl, phone];
    contactUrl = [NSString stringWithFormat:@"%@&text=%@",contactUrl, description];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [DCDefines getHttpAsyncResponse:contactUrl :^(NSData *data, NSError *connectionError) {
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
        dispatch_async(dispatch_get_main_queue(), ^{
            if([status isEqualToString:@"done"] == YES) {
                [Common showAlert:@"Success" Message:@"message was sent successfully" ButtonName:@"Ok"];
            }
            else
            {
                [Common showAlert:@"Error" Message:@"Error on sending message" ButtonName:@"Ok"];
            }
        });
    }];

}

@end
