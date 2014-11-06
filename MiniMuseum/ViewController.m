#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _locationManager = [[CLLocationManager alloc] init];
    NSUUID *uuid = [NSUUID UUID]; // Definitely need to change this when beacons arrive
    _beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                       identifier:@"com.substrakt.minimuseum"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
