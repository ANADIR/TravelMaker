//
//  TrafficController.m
//  Travel Maker
//
//  Created by developer on 12/8/15.
//  Copyright © 2015 developer. All rights reserved.
//

#import "TrafficController.h"
#import "TrafficViewCell.h"

@interface TrafficViewCell ()

@end

@implementation TrafficController

@synthesize btnRequest, btnOffer, btnAreaOrDest;
@synthesize lblRequest, lblOffer;
@synthesize tblTraffic;
@synthesize HeaderAreaWidth;


BOOL isOpenedMenu = NO;
BOOL isSelectedRequest = YES;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    isSelectedRequest = YES;
    [self switchRequest:isSelectedRequest];
    
    self.arrayTrafficData = [[NSMutableArray alloc] init];
    self.arrayOfferTrip = [[NSMutableArray alloc] init];
    self.arrayRequestTrip = [[NSMutableArray alloc] init];
    
    
    [self loadTrafficData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    HeaderAreaWidth.constant = (SCREEN_WIDTH - 160 - 16) / 2.0f;
    [self updateViewConstraints];
}

- (void)switchRequest:(BOOL)isRequest
{
    if (isRequest)
    {
        [btnRequest setImage:[UIImage imageNamed:@"AvailableInEnable"] forState:UIControlStateNormal];
        [lblRequest setTextColor:[UIColor whiteColor]];
        
        [btnOffer setImage:[UIImage imageNamed:@"RideGiveDisable"] forState:UIControlStateNormal];
        [lblOffer setTextColor:[UIColor colorWithRed:150.0/255.0 green:185.0/255.0 blue:219.0/255.0 alpha:1.0]];
        
        [btnAreaOrDest setTitle:@"לאזור" forState:UIControlStateNormal];
    }
    else
    {
        [btnOffer setImage:[UIImage imageNamed:@"RideGiveEnable"] forState:UIControlStateNormal];
        [lblOffer setTextColor:[UIColor whiteColor]];
        
        [btnRequest setImage:[UIImage imageNamed:@"AvailableInDisable"] forState:UIControlStateNormal];
        [lblRequest setTextColor:[UIColor colorWithRed:150.0/255.0 green:185.0/255.0 blue:219.0/255.0 alpha:1.0]];
        
        [btnAreaOrDest setTitle:@"יעד" forState:UIControlStateNormal];
    }
}

- (void)loadTrafficData
{
    NSString * getTrafficUrl = @"http://travelmakerdata.co.nf/server/index.php?action=getAllTrafficData";
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [DCDefines getHttpAsyncResponse:getTrafficUrl :^(NSData *data, NSError *connectionError) {
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
        self.arrayTrafficData = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.arrayTrafficData != nil)
            {
                for (id traffic in self.arrayTrafficData)
                {
                    NSString *type = [traffic objectForKey:@"traffic_type"];
                    if ([type isEqualToString:@"requested"] == YES)
                        [self.arrayRequestTrip addObject:traffic];
                    else
                        [self.arrayOfferTrip addObject:traffic];
                }
                
                [tblTraffic reloadData];
            }
        });
    }];

}

#pragma mark - IBAction

- (IBAction)clickMenu:(id)sender
{
    if (isOpenedMenu == NO)
    {
        [self.menuController setMenuState:MFSideMenuStateLeftMenuOpen completion:^{
            isOpenedMenu = YES;
        }];
    }
    else
    {
        [self.menuController setMenuState:MFSideMenuStateClosed completion:^{
            isOpenedMenu = NO;
        }];
    }
}

- (IBAction)clickAddNew:(id)sender
{
    
}

- (IBAction)clickRequest:(id)sender
{
    isSelectedRequest = YES;
    [self switchRequest:isSelectedRequest];
    
    [tblTraffic reloadData];
}

- (IBAction)clickOffer:(id)sender
{
    isSelectedRequest = NO;
    [self switchRequest:isSelectedRequest];
    
    [tblTraffic reloadData];
}


- (IBAction)clickPassenger:(id)sender
{
    if (isSelectedRequest == YES)
    {
        [self.arrayRequestTrip sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            NSString *value1 = (NSString *)[obj1 objectForKey:@"num_passengers"];
            NSString *value2 = (NSString *)[obj2 objectForKey:@"num_passengers"];
            return [value1 compare:value2];
        }];
        
        [tblTraffic reloadData];
    }
    else
    {
        [self.arrayOfferTrip sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            NSString *value1 = (NSString *)[obj1 objectForKey:@"num_passengers"];
            NSString *value2 = (NSString *)[obj2 objectForKey:@"num_passengers"];
            return [value1 compare:value2];
        }];
        
        [tblTraffic reloadData];
    }
}

- (IBAction)clickHour:(id)sender;
{
    if (isSelectedRequest == YES)
    {
        [self.arrayRequestTrip sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            NSString *value1 = (NSString *)[obj1 objectForKey:@"time_start"];
            NSString *value2 = (NSString *)[obj2 objectForKey:@"time_start"];
            return [value1 compare:value2];
        }];
        
        [tblTraffic reloadData];
    }
    else
    {
        [self.arrayOfferTrip sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            NSString *value1 = (NSString *)[obj1 objectForKey:@"time_start"];
            NSString *value2 = (NSString *)[obj2 objectForKey:@"time_start"];
            return [value1 compare:value2];
        }];
        
        [tblTraffic reloadData];
    }
}

- (IBAction)clickDate:(id)sender
{
    if (isSelectedRequest == YES)
    {
        [self.arrayRequestTrip sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            NSString *value1 = (NSString *)[obj1 objectForKey:@"date_start"];
            NSString *value2 = (NSString *)[obj2 objectForKey:@"date_start"];
            return [value1 compare:value2];
        }];
        
        [tblTraffic reloadData];
    }
    else
    {
        [self.arrayOfferTrip sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            NSString *value1 = (NSString *)[obj1 objectForKey:@"date_start"];
            NSString *value2 = (NSString *)[obj2 objectForKey:@"date_start"];
            return [value1 compare:value2];
        }];
        
        [tblTraffic reloadData];
    }
}

- (IBAction)clickAreaOrDest:(id)sender
{
    if (isSelectedRequest == YES)
    {
        [self.arrayRequestTrip sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            NSString *value1 = (NSString *)[obj1 objectForKey:@"area"];
            NSString *value2 = (NSString *)[obj2 objectForKey:@"area"];
            return [value1 compare:value2];
        }];
        
        [tblTraffic reloadData];
    }
    else
    {
        [self.arrayOfferTrip sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            NSString *value1 = (NSString *)[obj1 objectForKey:@"destination"];
            NSString *value2 = (NSString *)[obj2 objectForKey:@"destination"];
            return [value1 compare:value2];
        }];
        
        [tblTraffic reloadData];
    }
}

- (IBAction)clickStart:(id)sender
{
    if (isSelectedRequest == YES)
    {
        [self.arrayRequestTrip sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            NSString *value1 = (NSString *)[obj1 objectForKey:@"start_location"];
            NSString *value2 = (NSString *)[obj2 objectForKey:@"start_location"];
            return [value1 compare:value2];
        }];
        
        [tblTraffic reloadData];
    }
    else
    {
        [self.arrayOfferTrip sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            NSString *value1 = (NSString *)[obj1 objectForKey:@"start_location"];
            NSString *value2 = (NSString *)[obj2 objectForKey:@"start_location"];
            return [value1 compare:value2];
        }];
        
        [tblTraffic reloadData];
    }
}

#pragma mark - UITableDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isSelectedRequest == YES)
        return [self.arrayRequestTrip count];
    else
        return [self.arrayOfferTrip count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView  cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TrafficViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"trafficCell"];
    
    if (cell == nil) {
        
        cell = [[TrafficViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"trafficCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    NSDictionary *trafficData = nil;
    
    if (isSelectedRequest == YES)
    {
        trafficData = [self.arrayRequestTrip objectAtIndex:indexPath.row];
        [cell.lblAreaOrDest setText:[trafficData objectForKey:@"area"]];
    }
    else
    {
        trafficData = [self.arrayOfferTrip objectAtIndex:indexPath.row];
        [cell.lblAreaOrDest setText:[trafficData objectForKey:@"destination"]];
    }
    
    NSString *date = [trafficData objectForKey:@"date_start"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"ddMMyyyy"];
    NSDate *dateFromString = [dateFormatter dateFromString:date];
    [dateFormatter setDateFormat:@"dd.MM"];
    NSString *displayDate = [dateFormatter stringFromDate:dateFromString];

    [cell.lblDate setText:displayDate];
    [cell.lblPassenger setText:[trafficData objectForKey:@"num_passengers"]];
    [cell.lblHour setText:[trafficData objectForKey:@"time_start"]];
    [cell.lblPlaceStart setText:[trafficData objectForKey:@"start_location"]];


    [cell.layer setCornerRadius:5.0f];
    [cell.layer setMasksToBounds:YES];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
