//
//  MovieSelectorViewController.m
//  MovieSelector
//
//  Created by Alan Longcoy on 5/26/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import "MovieSelectorViewController.h"


@interface MovieSelectorViewController ()

@end

@implementation MovieSelectorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // add tag ids to the buttons to be able to identify which button was clicked by the user
    
    _movieLoverOneButton.tag = 1;
    _movieLoverTwoButton.tag = 2;
    
}

- (IBAction)movieLoverInput:(id)sender
{
    if ([sender isKindOfClass:[UIButton class]])
    {
        if (((UIButton *) sender).tag == 1)
        {
            NSLog(@"button 1\n");
            
            [((UIButton *) sender) setImage:[UIImage imageNamed:@"BubbleSelected"] forState:UIControlStateNormal];
        }
        else if (((UIButton *) sender).tag == 2)
        {
            NSLog(@"button 2\n");
            [((UIButton *) sender) setImage:[UIImage imageNamed:@"BubbleSelected"] forState:UIControlStateNormal];
        }
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
