#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _locationManager = [[CLLocationManager alloc] init];
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"]; // Definitely need to change this when beacons arrive
    _beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                       identifier:@"com.substrakt.minimuseum"];
    [_locationManager setDelegate:self];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [_locationManager startMonitoringForRegion:_beaconRegion];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region {
    switch (state) {
        case CLRegionStateInside:
            [self locationManager:manager didEnterRegion:region];
            break;
            
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"Entered region");
    [manager startRangingBeaconsInRegion:_beaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    NSLog(@"Found some beacons");
    for (CLBeacon *beacon in beacons) {
        if (beacon.proximity == CLProximityImmediate) {
            _closestBeacon = beacon;
            [_locationManager stopMonitoringForRegion:_beaconRegion];
            [_locationManager stopRangingBeaconsInRegion:_beaconRegion];
            [self performSegueWithIdentifier:@"toExhibit" sender:_closestBeacon];
            NSLog(@"%@", _closestBeacon);
        }
    }
    if (_closestBeacon == nil) {
        NSLog(@"No beacons are within immediate proximity");
    }
    
}



@end
