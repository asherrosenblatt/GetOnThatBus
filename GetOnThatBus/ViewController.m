//
//  ViewController.m
//  GetOnThatBus
//
//  Created by Steven Sickler on 8/5/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "StopDetailViewController.h"

@interface ViewController ()<MKMapViewDelegate>
@property NSArray *transitStopArray;
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;
@property NSDictionary *busStopDictionary;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self pullTransitStops];
    [self zoomed];

 }



-(void)pullTransitStops
{
    //Below Code is to grab the json data from the internet and display it in the tableView
    NSURL *url=[NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/bus.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *rsp, NSData *data, NSError *connectionError)
     {
         // review json file prior to creating NSJSONSerialization below in Chrome.  It may be a an array or dictionary.

         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

         self.transitStopArray = [json objectForKey:@"row"];

         [self addPins];
         
     }];
}

-(void)addPins
{
    for (NSDictionary *singleStop in self.transitStopArray) {
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = [[[singleStop objectForKey:@"location"] objectForKey:@"latitude"] doubleValue];
        coordinate.longitude= [[[singleStop objectForKey:@"location"] objectForKey:@"longitude"] doubleValue];

        MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
        annotation.coordinate = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);
        annotation.title = [singleStop objectForKey:@"cta_stop_name"];
        annotation.subtitle = [singleStop objectForKey:@"routes"];
        [self.myMapView addAnnotation:annotation];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if (annotation != self.myMapView.userLocation) {
        MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
        pin.canShowCallout =YES;
        pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        return pin;
    } else {
        return nil;
    }
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"CLICKED!");
    CLLocationCoordinate2D centerCoordinate = view.annotation.coordinate;
    for (NSDictionary *dic in self.transitStopArray) {
        double longi = [[dic objectForKey:@"longitude"] doubleValue];
        double lati = [[dic objectForKey:@"latitude"] doubleValue];
        if (centerCoordinate.latitude == lati && centerCoordinate.longitude == longi) {
            self.busStopDictionary = [[NSDictionary alloc] init];
            self.busStopDictionary = dic;
        }
    }
    NSLog(@"ehbeulcvebireiuwiehdi");
    [self performSegueWithIdentifier:@"StopDetailSeque" sender:view];
}

-(void)zoomed
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 41.8819;
    coordinate.longitude= -87.6278;

    MKCoordinateSpan coordinateSpan;
    coordinateSpan.latitudeDelta = 0.5;
    coordinateSpan.longitudeDelta = 0.5;
    MKCoordinateRegion region;
    region.center = coordinate;
    region.span = coordinateSpan;
    [self.myMapView setRegion:region animated:YES];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    StopDetailViewController *vc = segue.destinationViewController;
    vc.currentStopDictionary = self.busStopDictionary;
}









@end
