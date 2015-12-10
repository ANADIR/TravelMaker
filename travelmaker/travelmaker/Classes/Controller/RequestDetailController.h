//
//  RequestDetailController.h
//  Travel Maker
//
//  Created by developer on 12/10/15.
//  Copyright © 2015 developer. All rights reserved.
//

#import "SuperViewController.h"

@interface RequestDetailController : SuperViewController <UITableViewDataSource, UITableViewDelegate>

@property (copy, nonatomic) NSDictionary *trafficData;

@property (nonatomic, weak) IBOutlet UITableView *tblTraffic;
@property (nonatomic, weak) IBOutlet UILabel *lblTrip;
@property (nonatomic, weak) IBOutlet UILabel *lblDescription;

@property (nonatomic, weak) IBOutlet UIView *vwCompany;
@property (nonatomic, weak) IBOutlet UILabel *lblCompany;

@property (nonatomic, weak) IBOutlet UIView *vwWhatsapp;
@property (nonatomic, weak) IBOutlet UIView *vwTelephone;

- (IBAction)clickBack:(id)sender;
- (IBAction)clickAddNew:(id)sender;
- (IBAction)clickWhatsapp:(id)sender;
- (IBAction)clickTelephone:(id)sender;

@end
