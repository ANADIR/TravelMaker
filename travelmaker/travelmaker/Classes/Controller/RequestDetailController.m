//
//  RequestDetailController.m
//  Travel Maker
//
//  Created by developer on 12/10/15.
//  Copyright © 2015 developer. All rights reserved.
//

#import "RequestDetailController.h"
#import "DetailViewCell.h"
#import <DYRateView.h>
#import "UIViewController+MJPopupViewController.h"
#import "NewTripController.h"

@implementation RequestDetailController

@synthesize trafficData;
@synthesize lblDescription, lblTrip, lblCompany;
@synthesize tblTraffic;
@synthesize vwCompany, vwTelephone, vwWhatsapp;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *start_location = [trafficData objectForKey:@"start_location"];
    NSString *exit_location = [trafficData objectForKey:@"area"];
    NSString *txtTrip = [NSString stringWithFormat:@"%@ - %@", exit_location, start_location];
    [lblTrip setText:txtTrip];
    
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
    NewTripController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"newTripVC"];
    [controller.view setFrame:CGRectMake(0, 100, 320, 320)];
    [self presentPopupViewController:controller animationType:MJPopupViewAnimationFade];
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView  cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"requestDetailCell"];
    
    if (cell == nil) {
        
        cell = [[DetailViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"requestDetailCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    NSString *date = nil;
    
    switch (indexPath.row) {
        case 0:
            [cell.lblValue setText:[trafficData objectForKey:@"num_passengers"]];
            [cell.lblKey setText:@"סוג רכב"];
            break;
        case 1:
            [cell.lblValue setText:[trafficData objectForKey:@"time_start"]];
            [cell.lblKey setText:@"שעת פינוי"];
            break;
        case 2:
            [cell.lblValue setText:[trafficData objectForKey:@"start_location"]];
            [cell.lblKey setText:@"מוצא"];
            break;
        case 3:
            [cell.lblValue setText:[trafficData objectForKey:@"area"]];
            [cell.lblKey setText:@"לאזור"];
            break;
        case 4:
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


@end
