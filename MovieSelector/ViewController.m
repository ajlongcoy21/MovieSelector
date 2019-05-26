//
//  ViewController.m
//  MovieSelector
//
//  Created by Alan Longcoy on 5/26/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Create a flash animation to help the user see and want to click the button
    
    CABasicAnimation *flash = [CABasicAnimation animationWithKeyPath:@"opacity"];
    flash.duration = 0.75;
    flash.fromValue = @1.0;
    flash.toValue = @0.1;
    flash.autoreverses = true;
    flash.repeatCount = 1000;
    flash.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    
    // Add flash animaiton to the button
    
    [_movieSelectorButton.layer addAnimation:flash forKey:nil];

}

- (IBAction)startMovieSelection:(id)sender
{
    
}


@end
