//
//  OfferDetailController.m
//  Travel Maker
//
//  Created by developer on 12/10/15.
//  Copyright © 2015 developer. All rights reserved.
//

#import "OfferDetailController.h"
#import "DetailViewCell.h"
#import <DYRateView.h>
#import "UIViewController+MJPopupViewController.h"
#import "NewTripController.h"
#import "RegisterController.h"
#import "NewRequestController.h"
#import "NewOfferController.h"

@implementation OfferDetailController

@synthesize trafficData;
@synthesize lblDescription, lblTrip, lblCompany, lblTitle, lblPrice;
@synthesize tblTraffic;
@synthesize vwCompany, vwTelephone, vwWhatsapp;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *start_location = [trafficData objectForKey:@"start_location"];
    NSString *exit_location = [trafficData objectForKey:@"destination"];
    NSString *txtTrip = [NSString stringWithFormat:@"%@ - %@", exit_location, start_location];
    [lblTrip setText:txtTrip];
    [lblTitle setText:txtTrip];

    
    NSString *txtFreeText = [trafficData objectForKey:@"free_text"];
    [lblDescription setText:txtFreeText];
    
    CGRect frame = lblCompany.frame;
    CGRect rateFrame = CGRectMake(frame.origin.x, frame.origin.y + 30, frame.size.width, 30);
    DYRateView *rateView = [[DYRateView alloc] initWithFrame:rateFrame];
    [rateView setRate:4.2];
    [rateView setAlignment:RateViewAlignmentLeft];
    [vwCompany addSubview:rateView];
    
    UITapGestureRecognizer *tapWhatsapp = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapWhatsapp:)];
    [vwWhatsapp addGestureRecognizer:tapWhatsapp];
    
    UITapGestureRecognizer *tapTelephone = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapTelephone:)];
    [vwTelephone addGestureRecognizer:tapTelephone];
    
    [lblPrice setText:[trafficData objectForKey:@"price"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (IBAction)clickBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickAddNew:(id)sender
{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSString *user_id = [preferences objectForKey:@"user_id"];
    if (user_id == nil || [user_id isEqualToString:@""])
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                         message:@"You're not registered yet. \nDo you want to register now?"
                                                        delegate:self
                                               cancelButtonTitle:@"NO"
                                               otherButtonTitles:@"YES", nil];
        [alert show];
        return;
    }

    NewTripController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"newTripVC"];
    controller.delegate = self;
    [controller.view setFrame:CGRectMake(0, 100, 320, 320)];
    [self presentPopupViewController:controller animationType:MJPopupViewAnimationFade];
}

- (IBAction)clickClose:(id)sender
{
    
}


- (IBAction)clickWhatsapp:(id)sender
{
    [self handleWhatsapp];
}

- (IBAction)clickTelephone:(id)sender
{
    [self handleTelephone];
}

- (void)handleTapWhatsapp:(UITapGestureRecognizer *)recognizer
{
    [self handleWhatsapp];
}

- (void)handleTapTelephone:(UITapGestureRecognizer *)recognizer
{
    [self handleTelephone];
}


- (void)handleWhatsapp
{
    [Common showAlert:@"Alert" Message:@"Clicked WhatsApp" ButtonName:@"OK"];
}

- (void)handleTelephone
{
    [Common showAlert:@"Alert" Message:@"Clicked Telephone" ButtonName:@"Ok"];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView  cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"offerDetailCell"];
    
    if (cell == nil) {
        
        cell = [[DetailViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"offerDetailCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    NSString *date = nil;
    
    switch (indexPath.row) {
        case 0:
            [cell.lblValue setText:@"הקפצה"];
            [cell.lblKey setText:@"סוג נסיעה"];
            break;
        case 1:
            [cell.lblValue setText:[trafficData objectForKey:@"num_passengers"]];
            [cell.lblKey setText:@"סוג רכב"];
            break;
        case 2:
            [cell.lblValue setText:[trafficData objectForKey:@"time_start"]];
            [cell.lblKey setText:@"שעת פינוי"];
            break;
        case 3:
            [cell.lblValue setText:[trafficData objectForKey:@"time_start"]];
            [cell.lblKey setText:@"שעת סיוםי"];
            break;
        case 4:
            [cell.lblValue setText:[trafficData objectForKey:@"start_location"]];
            [cell.lblKey setText:@"מוצא"];
            break;
        case 5:
            [cell.lblValue setText:[trafficData objectForKey:@"destination"]];
            [cell.lblKey setText:@"יעד"];
            break;
        case 6:
            date = [trafficData objectForKey:@"date_start"];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"ddMMyyyy"];
            NSDate *dateFromString = [dateFormatter dateFromString:date];
            [dateFormatter setDateFormat:@"dd.MM.yyyy"];
            NSString *displayDate = [dateFormatter stringFromDate:dateFromString];
            
            [cell.lblValue setText:displayDate];
            [cell.lblKey setText:@"תאריך"];
            break;
    }
    
    return cell;
}

#pragma mark -UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        // cancel
    }
    else
    {
        // Ok
        RegisterController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"registerVC"];
        controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:controller animated:YES completion:nil];
    }
}

#pragma mark - NewTripDelegate
- (void)gotoNewOfferTrip
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    
    NewOfferController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"newOfferVC"];
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)gotoNewRequestTrip
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    
    NewRequestController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"newRequestVC"];
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:controller animated:YES completion:nil];
}

@end
