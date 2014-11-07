#import "ViewController.h"
#import "ExhibitViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _locationManager = [[CLLocationManager alloc] init];
    
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"74278bda-b644-4520-8f0c-720eaf059935"]; // Definitely need to change this when beacons arrive
    _beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                       identifier:@"com.substrakt.minimuseum"];
    _beaconRegion.notifyEntryStateOnDisplay = YES;
    _beaconRegion.notifyOnEntry = YES;
    [_locationManager setDelegate:self];
    [_locationManager requestAlwaysAuthorization];
    [_locationManager startMonitoringForRegion:_beaconRegion];
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = @"You are stood right by an exhibit";
    notification.alertAction = @"learn more";
    notification.regionTriggersOnce = NO;
    notification.region = _beaconRegion;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [_locationManager startRangingBeaconsInRegion:_beaconRegion];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toExhibit"]) {
        ExhibitViewController *vc = [segue destinationViewController];
        vc.beacon = sender;
    }
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
    _nearbyLabel.text = [NSString stringWithFormat:@"There are %lu exhibits nearby", (unsigned long)beacons.count];
    for (CLBeacon *beacon in beacons) {
        if (beacon.proximity == CLProximityImmediate) {
            _closestBeacon = beacon;
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
