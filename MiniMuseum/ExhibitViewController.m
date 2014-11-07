//
//  ExhibitViewController.m
//  MiniMuseum
//
//  Created by Max Woolf on 06/11/2014.
//  Copyright (c) 2014 maxwoolf. All rights reserved.
//

#import "ExhibitViewController.h"

@interface ExhibitViewController ()

@end

@implementation ExhibitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"New view congtroller");
    NSLog(@"%@", _beacon.description);
    // Do any additional setup after loading the view.
    _exhibit = [Exhibit new];
    if ([_beacon.major isEqual: @1] && [_beacon.minor isEqual: @5]) {
        _exhibit.name = @"Max's Desk";
        _exhibit.blurb = @"This is where Max Woolf sits. He is a developer at Substrakt.";
    } else if ([_beacon.major isEqual: @1] && [_beacon.minor isEqual: @1]) {
        _exhibit.name = @"Andy's Desk";
    }  else if ([_beacon.major isEqual: @1] && [_beacon.minor isEqual: @2]) {
        _exhibit.name = @"The Kitchen";
    }  else if ([_beacon.major isEqual: @1] && [_beacon.minor isEqual: @2]) {
        _exhibit.name = @"The Meeting Desk";
    }
    _nameLabel.text = _exhibit.name;
    _blurbLabel.text = _exhibit.blurb;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)didPressDone:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
