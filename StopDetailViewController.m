//
//  StopDetailViewController.m
//  GetOnThatBus
//
//  Created by Steven Sickler on 8/5/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "StopDetailViewController.h"

@interface StopDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *busStopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *busStopAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *busStopRouteLabel;
@property (weak, nonatomic) IBOutlet UILabel *busStopTranfersLabel;

@end

@implementation StopDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.busStopNameLabel.text = [NSString stringWithFormat:@"Stop Name: %@",[self.currentStopDictionary objectForKey:@"cta_stop_name"]];
    self.busStopAddressLabel.text = [NSString stringWithFormat:@"Latitude: %@ Longitude: %@", [NSString stringWithFormat:@"Bus Routes: %@", self.currentStopDictionary[@"latitude"]], [NSString stringWithFormat:@"Bus Routes: %@", self.currentStopDictionary[@"longitude"]]];
    self.busStopRouteLabel.text = [NSString stringWithFormat:@"Bus Routes: %@", self.currentStopDictionary[@"routes"]];
    self.busStopTranfersLabel.text = [NSString stringWithFormat:@"Position: %@", self.currentStopDictionary[@"_id"]];
    NSLog(@"DICTIONARY %@", self.currentStopDictionary);
}



@end
