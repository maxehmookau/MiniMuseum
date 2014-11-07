#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Exhibit.h"

@interface ExhibitViewController : UIViewController
@property (nonatomic, strong) CLBeacon *beacon;
@property (nonatomic) Exhibit *exhibit;

@property (nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic) IBOutlet UITextView *blurbLabel;
- (IBAction)didPressDone:(id)sender;
@end
